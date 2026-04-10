import json

data = [
    {"key": "wheel_cat_fruity", "color": "#E31B23", "sub": [
        {"key": "wheel_sub_berry", "color": "#A6192E", "notes": ["wheel_note_blackberry", "wheel_note_raspberry", "wheel_note_blueberry", "wheel_note_strawberry"]},
        {"key": "wheel_sub_dried_fruit", "color": "#C76F16", "notes": ["wheel_note_raisin", "wheel_note_prune"]},
        {"key": "wheel_sub_other_fruit", "color": "#DA291C", "notes": ["wheel_note_coconut", "wheel_note_cherry", "wheel_note_pomegranate", "wheel_note_pineapple", "wheel_note_grape", "wheel_note_apple", "wheel_note_peach", "wheel_note_pear"]},
        {"key": "wheel_sub_citrus", "color": "#FDB913", "notes": ["wheel_note_grapefruit", "wheel_note_orange", "wheel_note_lemon", "wheel_note_lime"]}
    ]},
    {"key": "wheel_cat_floral", "color": "#E5007D", "sub": [
        {"key": "wheel_sub_tea", "color": "#634D2E", "notes": ["wheel_note_black_tea", "wheel_note_green_tea"]},
        {"key": "wheel_sub_floral", "color": "#E5007D", "notes": ["wheel_note_chamomile", "wheel_note_rose", "wheel_note_jasmine"]}
    ]},
    {"key": "wheel_cat_sweet", "color": "#D3A13B", "sub": [
        {"key": "wheel_sub_sweet_aromatics", "color": "#EBD89D", "notes": ["wheel_note_vanilla", "wheel_note_vanilla_bean"]},
        {"key": "wheel_sub_sugar_brown", "color": "#9E6532", "notes": ["wheel_note_molasses", "wheel_note_maple_syrup", "wheel_note_caramel", "wheel_note_honey"]}
    ]},
    {"key": "wheel_cat_nutty_cocoa", "color": "#6B4226", "sub": [
        {"key": "wheel_sub_nutty", "color": "#9E6532", "notes": ["wheel_note_peanuts", "wheel_note_hazelnut", "wheel_note_almond"]},
        {"key": "wheel_sub_cocoa", "color": "#332014", "notes": ["wheel_note_chocolate", "wheel_note_dark_chocolate"]}
    ]},
    {"key": "wheel_cat_spices", "color": "#C44031", "sub": [
        {"key": "wheel_sub_brown_spice", "color": "#7B3026", "notes": ["wheel_note_clove", "wheel_note_cinnamon", "wheel_note_nutmeg", "wheel_note_anise"]}
    ]},
    {"key": "wheel_cat_roasted", "color": "#967D65", "sub": [
        {"key": "wheel_sub_cereal", "color": "#D4B08C", "notes": ["wheel_note_malt", "wheel_note_grain"]},
        {"key": "wheel_sub_burnt", "color": "#423C35", "notes": ["wheel_note_smoky", "wheel_note_ashy"]}
    ]},
    {"key": "wheel_cat_green_veg", "color": "#008D4C", "sub": [
        {"key": "wheel_sub_green_vegetative", "color": "#00563B", "notes": ["wheel_note_olive_oil", "wheel_note_raw", "wheel_note_under_ripe", "wheel_note_peapod", "wheel_note_fresh", "wheel_note_vegetative", "wheel_note_hay_like", "wheel_note_herb_like"]}
    ]},
    {"key": "wheel_cat_sour_fermented", "color": "#E9A000", "sub": [
        {"key": "wheel_sub_sour", "color": "#C76F16", "notes": ["wheel_note_sour_aromatics", "wheel_note_acetic_acid", "wheel_note_butyric_acid", "wheel_note_isovaleric_acid", "wheel_note_citric_acid", "wheel_note_malic_acid"]},
        {"key": "wheel_sub_alcohol_fermented", "color": "#93278F", "notes": ["wheel_note_winey", "wheel_note_whiskey", "wheel_note_over_ripe"]}
    ]},
    {"key": "wheel_cat_others", "color": "#6C6E71", "sub": [
        {"key": "wheel_sub_chemical", "color": "#939598", "notes": ["wheel_note_rubber", "wheel_note_petroleum", "wheel_note_medicinal"]},
        {"key": "wheel_sub_papery", "color": "#BCBEC0", "notes": ["wheel_note_stale", "wheel_note_musty", "wheel_note_dusty"]}
    ]}
]

translations = {
    "uk": {
        "wheel_cat_fruity": "Фруктовий", "wheel_cat_floral": "Квітковий", "wheel_cat_sweet": "Солодкий",
        "wheel_cat_nutty_cocoa": "Горіх/Какао", "wheel_cat_spices": "Спеції", "wheel_cat_roasted": "Обсмажений",
        "wheel_cat_green_veg": "Зелень/Овочі", "wheel_cat_sour_fermented": "Кислий/Фермент", "wheel_cat_others": "Інше",
    }
}

languages = ["en", "uk", "ru", "pl", "de", "fr", "it", "es", "ja"]

def humanize(key):
    base = key.replace("wheel_note_", "").replace("wheel_sub_", "").replace("wheel_cat_", "").replace("_", " ")
    return " ".join([word.capitalize() for word in base.split(" ")])

sql = []
sql.append("DELETE FROM flavor_node_translations;")
sql.append("DELETE FROM flavor_nodes;")

for cat in data:
    sql.append(f"INSERT INTO flavor_nodes (key, parent_key, depth, color_hex) VALUES ('{cat['key']}', NULL, 0, '{cat['color']}');")
    for lang in languages:
        name = translations.get(lang, {}).get(cat['key']) or humanize(cat['key'])
        safe_name = name.replace("'", "''")
        sql.append(f"INSERT INTO flavor_node_translations (node_key, language_code, name) VALUES ('{cat['key']}', '{lang}', '{safe_name}');")
    
    for sub in cat["sub"]:
        sql.append(f"INSERT INTO flavor_nodes (key, parent_key, depth, color_hex) VALUES ('{sub['key']}', '{cat['key']}', 1, '{sub['color']}');")
        for lang in languages:
            name = translations.get(lang, {}).get(sub['key']) or humanize(sub['key'])
            safe_name = name.replace("'", "''")
            sql.append(f"INSERT INTO flavor_node_translations (node_key, language_code, name) VALUES ('{sub['key']}', '{lang}', '{safe_name}');")
            
        for note in sub["notes"]:
            sql.append(f"INSERT INTO flavor_nodes (key, parent_key, depth, color_hex) VALUES ('{note}', '{sub['key']}', 2, '{sub['color']}');")
            for lang in languages:
                name = translations.get(lang, {}).get(note) or humanize(note)
                safe_name = name.replace("'", "''")
                sql.append(f"INSERT INTO flavor_node_translations (node_key, language_code, name) VALUES ('{note}', '{lang}', '{safe_name}');")

with open("scripts/seed_flavor_wheel.sql", "w", encoding="utf-8") as f:
    f.write("\n".join(sql))

print(f"Generated {len(sql)} SQL statements to scripts/seed_flavor_wheel.sql")
