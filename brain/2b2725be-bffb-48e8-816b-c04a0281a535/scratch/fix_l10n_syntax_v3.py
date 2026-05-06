
import re

file_path = r'd:\Games\Coffeeapp\lib\core\l10n\app_localizations.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

def fix_structural(match):
    key_template = match.group(1)
    template_start = match.group(2).strip()
    unknown_val = match.group(3)
    na_val = match.group(4)
    method_val = match.group(5)
    tail = match.group(6)
    
    template_start = template_start.rstrip("'")
    
    if "{name" in template_start:
        base = template_start.split("{name")[0]
        fixed_template = f'{base}"{{name}}"{tail}'
    else:
        fixed_template = f'{template_start}"{{name}}"{tail}'
        
    return f"      '{key_template}':\n          '{fixed_template}',\n      'unknown': '{unknown_val}',\n      'not_available': '{na_val}',\n      'method_name_placeholder': '{method_val}',"

# More flexible regex using \s+ to bridge across lines
pattern = re.compile(
    r"'(unlink_lot_confirm_desc_template)':\s+'([^'\n]+)\s+'unknown': '([^'\n]+)',\s+'not_available': '([^'\n]+)',\s+'method_name_placeholder': '([^'\n]+)',\}\"([^\n']*)',",
    re.MULTILINE
)

# Debug: check how many matches we find before replacement
matches = re.findall(pattern, content)
print(f"Found {len(matches)} matches to fix.")

new_content = pattern.sub(fix_structural, content)

# Post-fix for double {name} which might have been missed
new_content = new_content.replace('"{name"{name}"?', '"{name}"?')
new_content = new_content.replace('"{name"{name}"', '"{name}"')

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(new_content)

print("Final cleanup complete.")
