# -*- coding: utf-8 -*-
import re

FLAVOR_FILE = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

def fix_escaping():
    with open(FLAVOR_FILE, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    
    new_lines = []
    # Pattern to match: 'lang': 'text',
    # We want to escape ' inside the text
    pattern = re.compile(r"(\s*)'([a-z]{2})':\s*'(.*)',$")
    
    for line in lines:
        match = pattern.match(line)
        if match:
            indent = match.group(1)
            lang = match.group(2)
            content = match.group(3)
            # Escape single quotes that are not already escaped
            # We look for ' not preceded by \
            fixed_content = re.sub(r"(?<!\\)'", r"\'", content)
            new_lines.append(f"{indent}'{lang}': '{fixed_content}',\n")
        else:
            new_lines.append(line)
            
    with open(FLAVOR_FILE, 'w', encoding='utf-8') as f:
        f.writelines(new_lines)
    print("Fixed escaping for all lines.")

if __name__ == '__main__':
    fix_escaping()
