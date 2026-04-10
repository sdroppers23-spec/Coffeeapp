-- ============================================================
-- Migration: i18n Translation Table Pattern
-- Version   : 3  (schema v11 in Drift)
-- Date      : 2026-04-03
-- Description:
--   Removes per-language columns from all main tables.
--   Adds *_translations tables with (entity_id, language_code) PK.
--   All 13 languages supported: en, uk, de, es, fr, it, ja, pl, pt, ro, ru, tr, zh
-- ============================================================

-- ─── 1. localized_beans (stripped) ─────────────────────────────────────────
-- Keep: id, brand_id, country_emoji, altitude_min/max, lot_number,
--       sca_score, sensory_json, price_json, plantation_photos_url,
--       is_premium, detailed_process_markdown, url, created_at
-- Drop all lang-specific columns via table recreation:

ALTER TABLE localized_beans RENAME TO localized_beans_old;

CREATE TABLE localized_beans (
  id                       INTEGER PRIMARY KEY AUTOINCREMENT,
  brand_id                 INTEGER REFERENCES localized_brands(id),
  country_emoji            TEXT,
  altitude_min             INTEGER,
  altitude_max             INTEGER,
  lot_number               TEXT NOT NULL DEFAULT '',
  sca_score                TEXT NOT NULL DEFAULT '80-84',
  sensory_json             TEXT NOT NULL DEFAULT '{}',
  price_json               TEXT NOT NULL DEFAULT '{}',
  plantation_photos_url    TEXT NOT NULL DEFAULT '[]',
  is_premium               INTEGER NOT NULL DEFAULT 0,
  detailed_process_markdown TEXT NOT NULL DEFAULT '',
  url                      TEXT NOT NULL DEFAULT '',
  created_at               TEXT
);

INSERT INTO localized_beans
  (id, brand_id, country_emoji, altitude_min, altitude_max,
   lot_number, sca_score, sensory_json, price_json,
   plantation_photos_url, is_premium, detailed_process_markdown, url, created_at)
SELECT
  id, brand_id, country_emoji, altitude_min, altitude_max,
  lot_number, sca_score, sensory_json, price_json,
  plantation_photos_url, is_premium, detailed_process_markdown, url, created_at
FROM localized_beans_old;

-- ─── 2. localized_bean_translations (new) ──────────────────────────────────
CREATE TABLE localized_bean_translations (
  id              INTEGER PRIMARY KEY AUTOINCREMENT,
  bean_id         INTEGER NOT NULL REFERENCES localized_beans(id) ON DELETE CASCADE,
  language_code   TEXT NOT NULL,
  country         TEXT,
  region          TEXT,
  varieties       TEXT,
  flavor_notes    TEXT NOT NULL DEFAULT '[]',
  process_method  TEXT,
  description     TEXT,
  roast_level     TEXT,
  UNIQUE (bean_id, language_code)
);

-- Migrate EN data from old table
INSERT INTO localized_bean_translations
  (bean_id, language_code, country, region, varieties, flavor_notes, process_method, description, roast_level)
SELECT id, 'en', country_en, region_en, varieties_en, flavor_notes_en, process_method_en, description_en, roast_level_en
FROM localized_beans_old WHERE country_en IS NOT NULL;

-- Migrate UK data
INSERT INTO localized_bean_translations
  (bean_id, language_code, country, region, varieties, flavor_notes, process_method, description, roast_level)
SELECT id, 'uk', country_uk, region_uk, varieties_uk, flavor_notes_uk, process_method_uk, description_uk, roast_level_uk
FROM localized_beans_old WHERE country_uk IS NOT NULL
ON CONFLICT(bean_id, language_code) DO UPDATE SET
  country=excluded.country, region=excluded.region, varieties=excluded.varieties,
  flavor_notes=excluded.flavor_notes, process_method=excluded.process_method,
  description=excluded.description, roast_level=excluded.roast_level;

-- Migrate PL data
INSERT OR IGNORE INTO localized_bean_translations
  (bean_id, language_code, country, region, varieties, flavor_notes, process_method, description, roast_level)
SELECT id, 'pl', country_pl, region_pl, varieties_pl, flavor_notes_pl, process_method_pl, description_pl, roast_level_pl
FROM localized_beans_old WHERE country_pl IS NOT NULL;

-- Migrate DE data
INSERT OR IGNORE INTO localized_bean_translations
  (bean_id, language_code, country, region, varieties, flavor_notes, process_method, description, roast_level)
SELECT id, 'de', country_de, region_de, varieties_de, flavor_notes_de, process_method_de, description_de, roast_level_de
FROM localized_beans_old WHERE country_de IS NOT NULL;

-- Migrate FR data
INSERT OR IGNORE INTO localized_bean_translations
  (bean_id, language_code, country, region, varieties, flavor_notes, process_method, description, roast_level)
SELECT id, 'fr', country_fr, region_fr, varieties_fr, flavor_notes_fr, process_method_fr, description_fr, roast_level_fr
FROM localized_beans_old WHERE country_fr IS NOT NULL;

-- Migrate ES, IT, PT, RO, TR similarly
INSERT OR IGNORE INTO localized_bean_translations
  (bean_id, language_code, country, region, varieties, flavor_notes, process_method, description, roast_level)
SELECT id, 'es', country_es, region_es, varieties_es, flavor_notes_es, process_method_es, description_es, roast_level_es
FROM localized_beans_old WHERE country_es IS NOT NULL;

INSERT OR IGNORE INTO localized_bean_translations
  (bean_id, language_code, country, region, varieties, flavor_notes, process_method, description, roast_level)
SELECT id, 'it', country_it, region_it, varieties_it, flavor_notes_it, process_method_it, description_it, roast_level_it
FROM localized_beans_old WHERE country_it IS NOT NULL;

INSERT OR IGNORE INTO localized_bean_translations
  (bean_id, language_code, country, region, varieties, flavor_notes, process_method, description, roast_level)
SELECT id, 'pt', country_pt, region_pt, varieties_pt, flavor_notes_pt, process_method_pt, description_pt, roast_level_pt
FROM localized_beans_old WHERE country_pt IS NOT NULL;

INSERT OR IGNORE INTO localized_bean_translations
  (bean_id, language_code, country, region, varieties, flavor_notes, process_method, description, roast_level)
SELECT id, 'ro', country_ro, region_ro, varieties_ro, flavor_notes_ro, process_method_ro, description_ro, roast_level_ro
FROM localized_beans_old WHERE country_ro IS NOT NULL;

INSERT OR IGNORE INTO localized_bean_translations
  (bean_id, language_code, country, region, varieties, flavor_notes, process_method, description, roast_level)
SELECT id, 'tr', country_tr, region_tr, varieties_tr, flavor_notes_tr, process_method_tr, description_tr, roast_level_tr
FROM localized_beans_old WHERE country_tr IS NOT NULL;

DROP TABLE localized_beans_old;

-- ─── 3. localized_brands (stripped) ────────────────────────────────────────
ALTER TABLE localized_brands RENAME TO localized_brands_old;

CREATE TABLE localized_brands (
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  name        TEXT NOT NULL,
  logo_url    TEXT,
  site_url    TEXT,
  created_at  TEXT
);

INSERT INTO localized_brands (id, name, logo_url, site_url, created_at)
SELECT id, name, logo_url, site_url, created_at FROM localized_brands_old;

CREATE TABLE localized_brand_translations (
  id              INTEGER PRIMARY KEY AUTOINCREMENT,
  brand_id        INTEGER NOT NULL REFERENCES localized_brands(id) ON DELETE CASCADE,
  language_code   TEXT NOT NULL,
  short_desc      TEXT,
  full_desc       TEXT,
  location        TEXT,
  UNIQUE (brand_id, language_code)
);

INSERT OR IGNORE INTO localized_brand_translations (brand_id, language_code, short_desc, full_desc, location)
SELECT id, 'en', short_desc_en, full_desc_en, location_en FROM localized_brands_old WHERE short_desc_en IS NOT NULL;
INSERT OR IGNORE INTO localized_brand_translations (brand_id, language_code, short_desc, full_desc, location)
SELECT id, 'uk', short_desc_uk, full_desc_uk, location_uk FROM localized_brands_old WHERE short_desc_uk IS NOT NULL;
INSERT OR IGNORE INTO localized_brand_translations (brand_id, language_code, short_desc, full_desc, location)
SELECT id, 'pl', short_desc_pl, full_desc_pl, location_pl FROM localized_brands_old WHERE short_desc_pl IS NOT NULL;
INSERT OR IGNORE INTO localized_brand_translations (brand_id, language_code, short_desc, full_desc, location)
SELECT id, 'de', short_desc_de, full_desc_de, location_de FROM localized_brands_old WHERE short_desc_de IS NOT NULL;
INSERT OR IGNORE INTO localized_brand_translations (brand_id, language_code, short_desc, full_desc, location)
SELECT id, 'fr', short_desc_fr, full_desc_fr, location_fr FROM localized_brands_old WHERE short_desc_fr IS NOT NULL;
INSERT OR IGNORE INTO localized_brand_translations (brand_id, language_code, short_desc, full_desc, location)
SELECT id, 'es', short_desc_es, full_desc_es, location_es FROM localized_brands_old WHERE short_desc_es IS NOT NULL;
INSERT OR IGNORE INTO localized_brand_translations (brand_id, language_code, short_desc, full_desc, location)
SELECT id, 'it', short_desc_it, full_desc_it, location_it FROM localized_brands_old WHERE short_desc_it IS NOT NULL;
INSERT OR IGNORE INTO localized_brand_translations (brand_id, language_code, short_desc, full_desc, location)
SELECT id, 'pt', short_desc_pt, full_desc_pt, location_pt FROM localized_brands_old WHERE short_desc_pt IS NOT NULL;
INSERT OR IGNORE INTO localized_brand_translations (brand_id, language_code, short_desc, full_desc, location)
SELECT id, 'ro', short_desc_ro, full_desc_ro, location_ro FROM localized_brands_old WHERE short_desc_ro IS NOT NULL;
INSERT OR IGNORE INTO localized_brand_translations (brand_id, language_code, short_desc, full_desc, location)
SELECT id, 'tr', short_desc_tr, full_desc_tr, location_tr FROM localized_brands_old WHERE short_desc_tr IS NOT NULL;

DROP TABLE localized_brands_old;

-- ─── 4. localized_farmers (stripped) ────────────────────────────────────────
ALTER TABLE localized_farmers RENAME TO localized_farmers_old;

CREATE TABLE localized_farmers (
  id             INTEGER PRIMARY KEY AUTOINCREMENT,
  image_url      TEXT,
  country_emoji  TEXT,
  latitude       REAL,
  longitude      REAL,
  created_at     TEXT
);

INSERT INTO localized_farmers (id, image_url, country_emoji, created_at)
SELECT id, image_url, country_emoji, created_at FROM localized_farmers_old;

CREATE TABLE localized_farmer_translations (
  id              INTEGER PRIMARY KEY AUTOINCREMENT,
  farmer_id       INTEGER NOT NULL REFERENCES localized_farmers(id) ON DELETE CASCADE,
  language_code   TEXT NOT NULL,
  name            TEXT,
  region          TEXT,
  description     TEXT,
  story           TEXT,
  country         TEXT,
  UNIQUE (farmer_id, language_code)
);

INSERT OR IGNORE INTO localized_farmer_translations (farmer_id, language_code, name, region, description, story, country)
SELECT id, 'en', name_en, region_en, description_en, story_en, country_en FROM localized_farmers_old WHERE name_en IS NOT NULL;
INSERT OR IGNORE INTO localized_farmer_translations (farmer_id, language_code, name, region, description, story, country)
SELECT id, 'uk', name_uk, region_uk, description_uk, story_uk, country_uk FROM localized_farmers_old WHERE name_uk IS NOT NULL;
INSERT OR IGNORE INTO localized_farmer_translations (farmer_id, language_code, name, region, description, story, country)
SELECT id, 'pl', name_pl, region_pl, description_pl, story_pl, country_pl FROM localized_farmers_old WHERE name_pl IS NOT NULL;
INSERT OR IGNORE INTO localized_farmer_translations (farmer_id, language_code, name, region, description, story, country)
SELECT id, 'de', name_de, region_de, description_de, story_de, country_de FROM localized_farmers_old WHERE name_de IS NOT NULL;
INSERT OR IGNORE INTO localized_farmer_translations (farmer_id, language_code, name, region, description, story, country)
SELECT id, 'fr', name_fr, region_fr, description_fr, story_fr, country_fr FROM localized_farmers_old WHERE name_fr IS NOT NULL;
INSERT OR IGNORE INTO localized_farmer_translations (farmer_id, language_code, name, region, description, story, country)
SELECT id, 'es', name_es, region_es, description_es, story_es, country_es FROM localized_farmers_old WHERE name_es IS NOT NULL;
INSERT OR IGNORE INTO localized_farmer_translations (farmer_id, language_code, name, region, description, story, country)
SELECT id, 'it', name_it, region_it, description_it, story_it, country_it FROM localized_farmers_old WHERE name_it IS NOT NULL;
INSERT OR IGNORE INTO localized_farmer_translations (farmer_id, language_code, name, region, description, story, country)
SELECT id, 'pt', name_pt, region_pt, description_pt, story_pt, country_pt FROM localized_farmers_old WHERE name_pt IS NOT NULL;
INSERT OR IGNORE INTO localized_farmer_translations (farmer_id, language_code, name, region, description, story, country)
SELECT id, 'ro', name_ro, region_ro, description_ro, story_ro, country_ro FROM localized_farmers_old WHERE name_ro IS NOT NULL;
INSERT OR IGNORE INTO localized_farmer_translations (farmer_id, language_code, name, region, description, story, country)
SELECT id, 'tr', name_tr, region_tr, description_tr, story_tr, country_tr FROM localized_farmers_old WHERE name_tr IS NOT NULL;

DROP TABLE localized_farmers_old;

-- ─── 5. sphere_regions (stripped) ───────────────────────────────────────────
ALTER TABLE sphere_regions RENAME TO sphere_regions_old;

CREATE TABLE sphere_regions (
  id            TEXT PRIMARY KEY,
  key           TEXT NOT NULL UNIQUE,
  latitude      REAL NOT NULL,
  longitude     REAL NOT NULL,
  marker_color  TEXT NOT NULL DEFAULT '#C8A96E',
  is_active     INTEGER NOT NULL DEFAULT 1,
  created_at    TEXT
);

INSERT INTO sphere_regions (id, key, latitude, longitude, marker_color, is_active, created_at)
SELECT id, key, latitude, longitude, marker_color, is_active, created_at FROM sphere_regions_old;

CREATE TABLE sphere_region_translations (
  id              INTEGER PRIMARY KEY AUTOINCREMENT,
  region_id       TEXT NOT NULL REFERENCES sphere_regions(id) ON DELETE CASCADE,
  language_code   TEXT NOT NULL,
  name            TEXT NOT NULL,
  description     TEXT,
  flavor_profile  TEXT NOT NULL DEFAULT '[]',
  UNIQUE (region_id, language_code)
);

INSERT OR IGNORE INTO sphere_region_translations (region_id, language_code, name, description, flavor_profile)
SELECT id, 'en', name_en, description_en, flavor_profile_en FROM sphere_regions_old WHERE name_en IS NOT NULL;
INSERT OR IGNORE INTO sphere_region_translations (region_id, language_code, name, description, flavor_profile)
SELECT id, 'uk', name_uk, description_uk, flavor_profile_uk FROM sphere_regions_old WHERE name_uk IS NOT NULL;

DROP TABLE sphere_regions_old;

-- ─── 6. specialty_articles (stripped) ──────────────────────────────────────
ALTER TABLE specialty_articles RENAME TO specialty_articles_old;

CREATE TABLE specialty_articles (
  id            INTEGER PRIMARY KEY AUTOINCREMENT,
  image_url     TEXT NOT NULL,
  read_time_min INTEGER NOT NULL
);

INSERT INTO specialty_articles (id, image_url, read_time_min)
SELECT id, image_url, read_time_min FROM specialty_articles_old;

CREATE TABLE specialty_article_translations (
  id              INTEGER PRIMARY KEY AUTOINCREMENT,
  article_id      INTEGER NOT NULL REFERENCES specialty_articles(id) ON DELETE CASCADE,
  language_code   TEXT NOT NULL,
  title           TEXT NOT NULL,
  subtitle        TEXT NOT NULL,
  content_html    TEXT NOT NULL,
  UNIQUE (article_id, language_code)
);

INSERT OR IGNORE INTO specialty_article_translations (article_id, language_code, title, subtitle, content_html)
SELECT id, 'en', title_en, subtitle_en, content_html_en FROM specialty_articles_old WHERE title_en IS NOT NULL;
INSERT OR IGNORE INTO specialty_article_translations (article_id, language_code, title, subtitle, content_html)
SELECT id, 'uk', title_uk, subtitle_uk, content_html_uk FROM specialty_articles_old WHERE title_uk IS NOT NULL;
INSERT OR IGNORE INTO specialty_article_translations (article_id, language_code, title, subtitle, content_html)
SELECT id, 'pl', title_pl, subtitle_pl, content_html_pl FROM specialty_articles_old WHERE title_pl IS NOT NULL;
INSERT OR IGNORE INTO specialty_article_translations (article_id, language_code, title, subtitle, content_html)
SELECT id, 'de', title_de, subtitle_de, content_html_de FROM specialty_articles_old WHERE title_de IS NOT NULL;
INSERT OR IGNORE INTO specialty_article_translations (article_id, language_code, title, subtitle, content_html)
SELECT id, 'fr', title_fr, subtitle_fr, content_html_fr FROM specialty_articles_old WHERE title_fr IS NOT NULL;
INSERT OR IGNORE INTO specialty_article_translations (article_id, language_code, title, subtitle, content_html)
SELECT id, 'es', title_es, subtitle_es, content_html_es FROM specialty_articles_old WHERE title_es IS NOT NULL;
INSERT OR IGNORE INTO specialty_article_translations (article_id, language_code, title, subtitle, content_html)
SELECT id, 'it', title_it, subtitle_it, content_html_it FROM specialty_articles_old WHERE title_it IS NOT NULL;
INSERT OR IGNORE INTO specialty_article_translations (article_id, language_code, title, subtitle, content_html)
SELECT id, 'pt', title_pt, subtitle_pt, content_html_pt FROM specialty_articles_old WHERE title_pt IS NOT NULL;
INSERT OR IGNORE INTO specialty_article_translations (article_id, language_code, title, subtitle, content_html)
SELECT id, 'ro', title_ro, subtitle_ro, content_html_ro FROM specialty_articles_old WHERE title_ro IS NOT NULL;
INSERT OR IGNORE INTO specialty_article_translations (article_id, language_code, title, subtitle, content_html)
SELECT id, 'tr', title_tr, subtitle_tr, content_html_tr FROM specialty_articles_old WHERE title_tr IS NOT NULL;

DROP TABLE specialty_articles_old;

-- ─── 7. latte_art_patterns (stripped) ──────────────────────────────────────
ALTER TABLE latte_art_patterns RENAME TO latte_art_patterns_old;

CREATE TABLE latte_art_patterns (
  id               INTEGER PRIMARY KEY AUTOINCREMENT,
  difficulty       INTEGER NOT NULL,
  steps_json       TEXT NOT NULL,
  is_favorite      INTEGER NOT NULL DEFAULT 0,
  user_best_score  INTEGER NOT NULL DEFAULT 0
);

INSERT INTO latte_art_patterns (id, difficulty, steps_json, is_favorite, user_best_score)
SELECT id, difficulty, steps_json, is_favorite, user_best_score FROM latte_art_patterns_old;

CREATE TABLE latte_art_pattern_translations (
  id              INTEGER PRIMARY KEY AUTOINCREMENT,
  pattern_id      INTEGER NOT NULL REFERENCES latte_art_patterns(id) ON DELETE CASCADE,
  language_code   TEXT NOT NULL,
  name            TEXT NOT NULL,
  description     TEXT NOT NULL,
  tip_text        TEXT NOT NULL,
  UNIQUE (pattern_id, language_code)
);

INSERT OR IGNORE INTO latte_art_pattern_translations (pattern_id, language_code, name, description, tip_text)
SELECT id, 'en', name_en, description_en, tip_text_en FROM latte_art_patterns_old WHERE name_en IS NOT NULL;
INSERT OR IGNORE INTO latte_art_pattern_translations (pattern_id, language_code, name, description, tip_text)
SELECT id, 'uk', name_uk, description_uk, tip_text_uk FROM latte_art_patterns_old WHERE name_uk IS NOT NULL;

DROP TABLE latte_art_patterns_old;

-- ─── Done ────────────────────────────────────────────────────────────────────
-- To add a new language in the future, simply INSERT rows into the *_translations
-- tables with the new language_code — no schema changes needed.
