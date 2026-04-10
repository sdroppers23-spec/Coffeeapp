import json
import os

langs = ['en', 'uk', 'de', 'es', 'fr', 'it', 'ja', 'pl', 'pt', 'ro', 'ru', 'tr', 'zh']
l10n_dir = 'lib/l10n'

def verify():
    print("=== Specialty Coffee L10N Audit ===")
    en_path = os.path.join(l10n_dir, 'app_en.arb')
    with open(en_path, 'r', encoding='utf-8') as f:
        en_data = json.load(f)
    
    base_count = len(en_data)
    print(f"Reference (EN): {base_count} keys\n")

    all_ok = True
    for lang in langs:
        path = os.path.join(l10n_dir, f'app_{lang}.arb')
        if not os.path.exists(path):
            print(f"❌ {lang}: MISSING FILE")
            all_ok = False
            continue
            
        with open(path, 'r', encoding='utf-8') as f:
            data = json.load(f)
            count = len(data)
            status = "✅ OK" if count == base_count else f"⚠️ MISMATCH ({count} keys)"
            print(f"{lang.upper():<4}: {count:<4} keys | {status}")
            if count != base_count: all_ok = False
            
    if all_ok:
        print("\n🏆 Result: 100% Synced across all 13 languages.")
    else:
        print("\n❌ Result: Sync errors detected.")

if __name__ == "__main__":
    verify()
