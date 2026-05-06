import re

def find_unlocalized(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Find all blocks like 'key': { ... }
    # Using a more robust regex for multiline blocks
    blocks = re.findall(r"'(\w+)':\s+\{([\s\S]+?)\s+\},", content)
    
    results = []
    for key, block in blocks:
        # Extract individual languages
        # Handle both single line and multiline values
        langs = re.findall(r"'(\w+)':\s+'((?:\\.|[^'])*)'", block)
        if not langs:
            # Try matching multiline values where the quote is on the next line
            langs = re.findall(r"'(\w+)':\s+\n\s+'((?:\\.|[^'])*)'", block)
            
        lang_dict = dict(langs)
        
        if 'en' not in lang_dict or 'uk' not in lang_dict:
            continue
            
        en_val = lang_dict['en'].strip()
        uk_val = lang_dict['uk'].strip()
        
        # If uk is different from en (localized), check others
        if en_val == uk_val:
             continue # Probably not localized in UK either or intentionally same
             
        unlocalized_langs = []
        for l, v in lang_dict.items():
            if l != 'en' and v.strip() == en_val:
                unlocalized_langs.append(l)
        
        if unlocalized_langs:
            results.append((key, unlocalized_langs))
            
    for key, langs in results:
        print(f"{key}: {', '.join(langs)}")

if __name__ == "__main__":
    find_unlocalized(r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart')
