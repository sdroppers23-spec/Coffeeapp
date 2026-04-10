import requests
import json

# --- CONFIG ---
URL = "https://lylnnqojnytndybhuicr.supabase.co"
KEY = "sb_publishable_d_gdrnpNa7gFwgqEb5VteQ_y3UKhjS-"
HEADERS = {
    "apikey": KEY,
    "Authorization": f"Bearer {KEY}",
    "Content-Type": "application/json",
    "Prefer": "resolution=merge-duplicates"
}

LANGS = ['en', 'uk', 'de', 'fr', 'es', 'it', 'pt', 'pl', 'ro', 'ar', 'tr', 'ja', 'ko']

def upsert(table, data):
    print(f"Upserting to {table}...")
    resp = requests.post(f"{URL}/rest/v1/{table}", headers=HEADERS, json=data)
    if resp.status_code not in [200, 201, 204]:
        print(f"ERROR {table}: {resp.text}")
    else:
        print(f"SUCCESS {table}")

# --- DATA ---

# 1. BRANDS
brands = [
    {"id": 1, "name": "3 Champs Roastery", "site_url": "https://3champsroastery.com.ua/", "logo_url": "assets/images/3Champslogo.jpg"},
    {"id": 2, "name": "Mad Heads", "site_url": "https://madheadscoffee.com/", "logo_url": "assets/images/mad_headslogo.png"}
]

brand_trs = []
for b in brands:
    for l in LANGS:
        brand_trs.append({
            "brand_id": b["id"],
            "language_code": l,
            "short_desc": "Преміальна обсмажка." if l == 'uk' else "Specialty roaster.",
            "full_desc": "Kyiv-based professional roastery focus on high SCA lots.",
            "location": "Ukraine, Kyiv"
        })

# 2. ARTICLES (Simplified for script, but including keys)
articles = []
article_trs = []
for i in range(1, 17):
    articles.append({"id": i, "image_url": "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085", "read_time_min": 5})
    for l in LANGS:
        article_trs.append({
            "article_id": i,
            "language_code": l,
            "title": f"Specialty Topic {i} [{l}]",
            "subtitle": "Standard Topic",
            "content_html": "<p>Content seeded via Python uploader.</p>"
        })

# 3. FARMERS
farmers = []
farmer_trs = []
for i in range(1, 11):
    farmers.append({"id": i, "image_url": "https://placehold.co/600x400", "country_emoji": "☕"})
    for l in LANGS:
        farmer_trs.append({
            "farmer_id": i,
            "language_code": l,
            "name": f"Farmer {i}",
            "region": "Specialty Farm",
            "description": "High quality producer",
            "story": "History of innovation",
            "country": "Origin"
        })

# 4. BREWING RECIPES
brewing = []
for m in ['v60', 'chemex', 'aeropress', 'french_press', 'espresso', 'cold_brew']:
    brewing.append({
        "method_key": m,
        "name": m.upper(),
        "description": f"Standard {m} recipe.",
        "ratio_grams_per_ml": 0.06,
        "temp_c": 94.0,
        "total_time_sec": 180,
        "difficulty": "Intermediate",
        "flavor_profile": "Balanced",
        "icon_name": m,
        "steps_json": "[]"
    })

# --- EXECUTE ---
upsert("localized_brands", brands)
upsert("localized_brand_translations", brand_trs)
upsert("specialty_articles", articles)
upsert("specialty_article_translations", article_trs)
upsert("localized_farmers", farmers)
upsert("localized_farmer_translations", farmer_trs)
upsert("brewing_recipes", brewing)

print("UPLOAD COMPLETE")
