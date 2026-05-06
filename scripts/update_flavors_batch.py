# -*- coding: utf-8 -*-
import re
import os
import sys

# Ensure we can import from the same directory
sys.path.append(os.path.dirname(__file__))
from flavor_translations_data import DATA

FLAVOR_FILE = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

def run():
    if not os.path.exists(FLAVOR_FILE):
        print(f"Error: {FLAVOR_FILE} not found")
        return

    with open(FLAVOR_FILE, 'r', encoding='utf-8') as f:
        content = f.read()
    
    updated_count = 0
    for key, val in DATA.items():
        # Pattern to match the existing key and its map
        # We look for 'key': { ... }
        pattern = re.compile(rf"'{key}':\s*\{{.*?\}}", re.DOTALL)
        
        # Check if key exists in file
        if key not in content:
            print(f"Warning: {key} not found in {FLAVOR_FILE}")
            continue

        replacement = f"'{key}': {{\n"
        # Sort languages for consistency
        langs = sorted(val.keys())
        for lang in langs:
            text = val[lang].replace("'", "\\'")
            replacement += f"        '{lang}': '{text}',\n"
        replacement += "      }"
        
        new_content, count = pattern.subn(replacement, content)
        if count > 0:
            content = new_content
            updated_count += 1
            print(f"Updated {key}")
        else:
            print(f"Failed to update {key} - pattern match failed")

    with open(FLAVOR_FILE, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print(f"\nSuccessfully updated {updated_count} keys in {FLAVOR_FILE}")

if __name__ == '__main__':
    run()
