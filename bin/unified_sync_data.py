import json
import csv
import os

def unified_sync():
    print("🚀 UNIFYING SPECIALTY DATA (JSON + CSV)...")
    
    # 1. Load original farmers from JSON (for stories)
    farmers_json_path = 'd:/Games/Coffeeapp/Img/Farmers.json'
    farmers_list = []
    if os.path.exists(farmers_json_path):
        with open(farmers_json_path, 'r', encoding='utf-8') as f:
            raw = f.read().strip()
            # Handle potential concatenated objects (simple approach)
            import re
            pattern = r'\{[^{}]*(?:\{[^{}]*\}[^{}]*)*\}'
            blocks = re.findall(pattern, raw, re.DOTALL)
            for block in blocks:
                try:
                    obj = json.loads(block)
                    if 'id' in obj:
                        farmers_list.append(obj)
                except: pass
    
    # 2. Load legends from CSV (Wilton Benitez, etc.)
    csv_path = 'd:/Games/Coffeeapp/Img/top_10_coffee_farmers.csv'
    csv_farmers = []
    if os.path.exists(csv_path):
        with open(csv_path, 'r', encoding='utf-8-sig') as f:
            reader = csv.DictReader(f)
            for row in reader:
                # Map CSV to JSON structure
                fid = f"f_{row['id'].zfill(3)}"
                f_obj = {
                    "id": fid,
                    "farmer_name_en": row['name_en'],
                    "farmer_name_uk": row['name_uk'],
                    "farm_name": row['farm_name'],
                    "country_en": row['country_en'],
                    "country_uk": row['country_uk'],
                    "specialization_uk": row['specialization_uk'],
                    "biography_uk": row['bio_uk'],
                    "image_url": row['image_url_farm'],
                    "processing_methods": row['specialization_en'], # using spec as methods for now
                    "achievements_uk": "Видатний виробник спешелті кави.",
                    "region_uk": row.get('region_uk', 'Високогір\'я')
                }
                csv_farmers.append(f_obj)

    # 3. Merge: If CSV farmer ID exists in JSON, update or keep CSV?
    # Usually CSV has the 'Legends' we want.
    final_farmers = {f['id']: f for f in farmers_list}
    for cf in csv_farmers:
        # Overwrite or add
        final_farmers[cf['id']] = cf

    with open('d:/Games/Coffeeapp/Img/unified_farmers.json', 'w', encoding='utf-8') as f:
        json.dump(list(final_farmers.values()), f, ensure_ascii=False, indent=2)
    
    print(f"✅ UNIFIED: {len(final_farmers)} farmers ready for sync.")

if __name__ == "__main__":
    unified_sync()
