#!/usr/bin/env python3
"""Push specialty_encyclopedia.json to Supabase specialty_* tables.

Requires .env: SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY
Run: python scripts/push_specialty_encyclopedia_supabase.py
     python scripts/push_specialty_encyclopedia_supabase.py --dry-run
"""
from __future__ import annotations

import argparse
import html
import json
import os
import re
import sys
import urllib.error
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
JSON_PATH = ROOT / "assets" / "data" / "specialty_encyclopedia.json"

SECTION_TITLE_UK: dict[str, str] = {
    "altitude_and_stress": "ВИСОТА ТА СТРЕС",
    "app_categories": "КАТЕГОРІЇ ЗАСТОСУНКУ",
    "botanical_context": "БОТАНІЧНИЙ КОНТЕКСТ",
    "burr_types": "ТИПИ ЖОРНІВ",
    "carbon_footprint": "ВУГЛЕЦЬОВИЙ СЛІД",
    "categories": "КАТЕГОРІЇ",
    "climate_resilient_hybrids": "КЛІМАТОСТІЙКІ ГІБРИДИ",
    "common_defects": "ПОШИРЕНІ ДЕФЕКТИ",
    "cup_profile": "СМАКОВИЙ ПРОФІЛЬ",
    "cupping_parameters": "ПАРАМЕТРИ КАПІНГУ",
    "definition": "ВИЗНАЧЕННЯ",
    "elite_varieties": "ЕЛІТНІ РІЗНОВИДИ",
    "extraction_errors": "ПОМИЛКИ ЕКСТРАКЦІЇ",
    "extraction_stages": "ЕТАПИ ЕКСТРАКЦІЇ",
    "farm_management": "УПРАВЛІННЯ ФЕРМОЮ",
    "flavor_categories": "КАТЕГОРІЇ СМАКУ",
    "foundational_varieties": "БАЗОВІ РІЗНОВИДИ",
    "fundamental_attributes": "ФУНДАМЕНТАЛЬНІ АТРИБУТИ",
    "harvesting_protocols": "ПРОТОКОЛИ ЗБОРУ",
    "heat_transfer_types": "ТИПИ ПЕРЕДАЧІ ТЕПЛА",
    "honey_categories": "КАТЕГОРІЇ HONEY",
    "implementation": "РЕАЛІЗАЦІЯ",
    "industry_controversy": "ДИСКУСІЇ В ІНДУСТРІЇ",
    "key_metrics": "КЛЮЧОВІ МЕТРИКИ",
    "mechanics": "МЕХАНІКА",
    "methods": "МЕТОДИ",
    "milk_components": "КОМПОНЕНТИ МОЛОКА",
    "milling_stages": "ЕТАПИ ОБРОБКИ ЗЕРНА",
    "models": "МОДЕЛІ",
    "organizations": "ОРГАНІЗАЦІЇ",
    "packaging_standards": "СТАНДАРТИ ПАКУВАННЯ",
    "phases": "ФАЗИ",
    "pouring_mechanics": "МЕХАНІКА ПОУРУ",
    "precision_agriculture": "ТОЧНЕ ЗЕМЛЕРОБСТВО",
    "pressure_profiling": "ПРОФІЛЮВАННЯ ТИСКУ",
    "process_description": "ОПИС ПРОЦЕСУ",
    "profiles": "ПРОФІЛІ",
    "puck_preparation_steps": "ПІДГОТОВКА ПАЙКА",
    "sca_water_standards": "СТАНДАРТИ ВОДИ SCA",
    "scoring_system": "СИСТЕМА ОЦІНЮВАННЯ",
    "sensory_profile": "СЕНСОРНИЙ ПРОФІЛЬ",
    "shade_grown_canopy": "ТІНЬОВЕ ВИРОЩУВАННЯ",
    "shipping_risks": "РИЗИКИ ПЕРЕВЕЗЕННЯ",
    "smart_hardware": "РОЗУМНЕ ЗАЛІЗО",
    "software_ecosystem": "ПРОГРАМНА ЕКОСИСТЕМА",
    "soil_chemistry": "ХІМІЯ ҐРУНТУ",
    "specialty_profiles": "СПЕШЕЛТІ-ПРОФІЛІ",
    "steps_and_chemistry": "ЕТАПИ ТА ХІМІЯ",
    "sub_method": "ПІДМЕТОД",
    "sustainability": "СТАЛІСТЬ",
    "technical_parameters": "ТЕХНІЧНІ ПАРАМЕТРИ",
    "terms": "ТЕРМІНИ",
    "variables": "ЗМІННІ",
    "water_activity": "АКТИВНІСТЬ ВОДИ",
}

LANGS = ("en", "uk", "de", "es", "fr", "it", "ja", "pl", "pt", "ro", "ru", "tr", "zh")
BASE_ID = 501
PLACEHOLDER_IMG = "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?q=80&w=800"


def section_title(key: str) -> str:
    return SECTION_TITLE_UK.get(key) or key.replace("_", " ").upper()


def estimate_minutes(item: dict) -> int:
    buf: list[str] = []

    def walk(v):
        if isinstance(v, str):
            buf.append(v)
        elif isinstance(v, dict):
            for x in v.values():
                walk(x)
        elif isinstance(v, list):
            for x in v:
                walk(x)

    walk(item)
    words = [w for w in re.split(r"\s+", " ".join(buf)) if w]
    return max(1, min(120, (len(words) + 199) // 200))


def esc(s: str) -> str:
    return html.escape(s, quote=True)


def value_to_html(v) -> str:
    if v is None:
        return ""
    if isinstance(v, (int, float, bool)):
        return f"<p>{esc(str(v))}</p>"
    if isinstance(v, str):
        return f"<p>{esc(v)}</p>"
    if isinstance(v, list):
        if not v:
            return ""
        if all(isinstance(x, str) for x in v):
            items = "".join(f"<li>{esc(str(x))}</li>" for x in v)
            return f"<ul>{items}</ul>"
        parts = []
        for x in v:
            parts.append(f'<div class="block">{value_to_html(x)}</div>')
        return "".join(parts)
    if isinstance(v, dict):
        m = dict(v)
        if "attribute" in m and "details" in m:
            a, d = m["attribute"], m["details"]
            return f"<p><strong>{esc(str(a))}</strong> {esc(str(d))}</p>"
        if "term" in m and "definition" in m:
            t = esc(str(m["term"]))
            d = esc(str(m["definition"]))
            return f'<p class="term"><strong>{t}</strong></p><p class="def">{d}</p>'
        if "name" in m and any(k in m for k in ("recipe", "role", "description")):
            body = m.get("recipe") or m.get("role") or m.get("description")
            parts = [f'<p class="name"><strong>{esc(str(m["name"]))}</strong></p>']
            if body:
                parts.append(f"<p>{esc(str(body))}</p>")
            skip = {"name", "recipe", "role", "description"}
            for k in sorted(m.keys()):
                if k in skip:
                    continue
                parts.append(f"<h4>{esc(section_title(k))}</h4>")
                parts.append(value_to_html(m[k]))
            return "".join(parts)
        if "category" in m and "drinks" in m:
            inner = value_to_html(m["drinks"])
            c = esc(str(m["category"]))
            return f'<p class="category"><strong>{c}</strong></p>{inner}'
        if "type" in m and "description" in m:
            return (
                f'<p><strong>{esc(str(m["type"]))}</strong> '
                f'{esc(str(m["description"]))}</p>'
            )
        if "step" in m and "action" in m:
            return (
                f'<p><strong>{esc(str(m["step"]))}</strong></p>'
                f"<p>{esc(str(m['action']))}</p>"
            )
        parts = []
        for k in sorted(m.keys()):
            parts.append(f"<h4>{esc(section_title(k))}</h4>")
            parts.append(value_to_html(m[k]))
        return "".join(parts)
    return f"<p>{esc(str(v))}</p>"


def item_to_html(item: dict) -> str:
    chunks: list[str] = []
    for k, v in item.items():
        if k == "topic":
            continue
        chunks.append(f'<h3 class="section">{esc(section_title(k))}</h3>')
        chunks.append(value_to_html(v))
    return "".join(chunks)


def load_dotenv():
    env_path = ROOT / ".env"
    if not env_path.is_file():
        return
    for line in env_path.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        a, b = line.split("=", 1)
        os.environ.setdefault(a.strip(), b.strip().strip('"').strip("'"))


def post_json(url: str, key: str, table: str, rows: list[dict]) -> None:
    if not rows:
        return
    payload = json.dumps(rows, ensure_ascii=False).encode("utf-8")
    endpoint = f"{url.rstrip('/')}/rest/v1/{table}"
    req = urllib.request.Request(
        endpoint,
        data=payload,
        method="POST",
        headers={
            "apikey": key,
            "Authorization": f"Bearer {key}",
            "Content-Type": "application/json",
            "Prefer": "resolution=merge-duplicates,return=minimal",
        },
    )
    try:
        with urllib.request.urlopen(req, timeout=120) as resp:
            if resp.status not in (200, 201, 204):
                raise RuntimeError(f"{table}: HTTP {resp.status}")
    except urllib.error.HTTPError as e:
        body = e.read().decode("utf-8", errors="replace")
        raise RuntimeError(f"{table}: {e.code} {body}") from e


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()

    load_dotenv()

    data = json.loads(JSON_PATH.read_text(encoding="utf-8"))
    modules = data["modules"]

    articles: list[dict] = []
    translations: list[dict] = []
    aid = BASE_ID

    for mod in modules:
        meta = mod["module_metadata"]
        part = int(meta.get("current_part") or 0)
        subtitle = str(meta.get("module_name") or "")
        idx = 0
        for item in mod["content"]:
            idx += 1
            topic = str(item.get("topic") or "")
            title = f"{part}.{idx} {topic}"
            body_html = item_to_html(dict(item))
            minutes = estimate_minutes(dict(item))

            articles.append(
                {
                    "id": aid,
                    "image_url": PLACEHOLDER_IMG,
                    "read_time_min": minutes,
                }
            )
            for lang in LANGS:
                translations.append(
                    {
                        "article_id": aid,
                        "language_code": lang,
                        "title": title,
                        "subtitle": subtitle,
                        "content_html": body_html,
                    }
                )
            aid += 1

    print(f"Articles: {len(articles)} (ids {BASE_ID}–{aid - 1})")
    print(f"Translation rows: {len(translations)}")

    if args.dry_run:
        return 0

    url = os.environ.get("SUPABASE_URL", "").strip()
    key = (os.environ.get("SUPABASE_SERVICE_ROLE_KEY") or "").strip()
    if not key:
        key = (os.environ.get("SERVICE_ROLE_KEY") or "").strip()
    if not key:
        key = (os.environ.get("SUPABASE_ANON_KEY") or "").strip()
        if key:
            print(
                "Note: using SUPABASE_ANON_KEY; RLS may block writes. "
                "Prefer SUPABASE_SERVICE_ROLE_KEY (Dashboard -> Settings -> API).",
                file=sys.stderr,
            )

    if not url or not key:
        print(
            "Set SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY (or SUPABASE_ANON_KEY) in .env",
            file=sys.stderr,
        )
        return 1

    for i in range(0, len(articles), 15):
        post_json(url, key, "specialty_articles", articles[i : i + 15])
    for i in range(0, len(translations), 40):
        post_json(url, key, "specialty_article_translations", translations[i : i + 40])

    print("Upsert finished OK.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
