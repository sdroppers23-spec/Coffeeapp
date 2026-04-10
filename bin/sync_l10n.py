import json
import os

langs = ['en', 'uk', 'de', 'es', 'fr', 'it', 'ja', 'pl', 'pt', 'ro', 'ru', 'tr', 'zh']
l10n_dir = 'lib/l10n'

def sync_arb():
    # 1. Load English as template
    en_path = os.path.join(l10n_dir, 'app_en.arb')
    with open(en_path, 'r', encoding='utf-8') as f:
        en_data = json.load(f)
    
    en_keys = set(en_data.keys())
    print(f"Found {len(en_keys)} keys in app_en.arb")

    for lang in langs:
        if lang == 'en': continue
        
        arb_name = f'app_{lang}.arb'
        arb_path = os.path.join(l10n_dir, arb_name)
        
        # Load existing or create empty
        if os.path.exists(arb_path):
            with open(arb_path, 'r', encoding='utf-8') as f:
                try:
                    lang_data = json.load(f)
                except:
                    lang_data = {"@@locale": lang}
        else:
            lang_data = {"@@locale": lang}

        # Sync keys
        changes = 0
        for key, value in en_data.items():
            if key == "@@locale":
                lang_data[key] = lang
                continue
            
            if key not in lang_data:
                # If key missing, add it (using EN value as fallback for now, or placeholder)
                lang_data[key] = value
                changes += 1
        
        # Save back
        with open(arb_path, 'w', encoding='utf-8') as f:
            json.dump(lang_data, f, ensure_ascii=False, indent=2)
        
        if changes > 0:
            print(f"✅ Sync {lang}: Added {changes} missing keys.")
        else:
            print(f"✅ Sync {lang}: Already up to date.")

if __name__ == "__main__":
    sync_arb()
