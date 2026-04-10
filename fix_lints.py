import os
import re

def fix_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # fix withOpacity
    new_content = re.sub(r'\.withOpacity\((.*?)\)', r'.withValues(alpha: \1)', content)
    
    # fix empty alpha inherited from previous failed attempt
    new_content = re.sub(r'\.withValues\(alpha: \)', r'.withValues(alpha: 0.5)', new_content)
    
    if content != new_content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Fixed: {filepath}")

for root, dirs, files in os.walk('lib'):
    for file in files:
        if file.endswith('.dart'):
            fix_file(os.path.join(root, file))
