
import re

file_path = r'd:\Games\Coffeeapp\lib\core\l10n\app_localizations.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Fix the structural error where the string was split and keys inserted inside
# The pattern:
# 'unlink_lot_confirm_desc_template':
#     'Some text {name
# 'unknown': '...',
# 'not_available': '...',
# 'method_name_placeholder': '...',}" some tail',

def fix_structural(match):
    key_template = match.group(1)
    template_start = match.group(2).strip()
    unknown_val = match.group(3)
    na_val = match.group(4)
    method_val = match.group(5)
    tail = match.group(6)
    
    # Clean up template_start if it has extra quotes
    template_start = template_start.rstrip("'")
    
    # The tail is something like ' trennen möchten?'
    # We want: '{template_start}"{name}"{tail}'
    
    # If template_start already contains {name, we need to be careful
    if "{name" in template_start:
        base = template_start.split("{name")[0]
        fixed_template = f'{base}"{{name}}"{tail}'
    else:
        fixed_template = f'{template_start}"{{name}}"{tail}'
        
    return f"      '{key_template}':\n          '{fixed_template}',\n      'unknown': '{unknown_val}',\n      'not_available': '{na_val}',\n      'method_name_placeholder': '{method_val}',"

# Flexible regex to catch the tail
# Note: we use \s+ to handle different indentations if any
pattern = re.compile(
    r"      '(unlink_lot_confirm_desc_template)':\n\s+'([^'\n]+)\n\s+'unknown': '([^'\n]+)',\n\s+'not_available': '([^'\n]+)',\n\s+'method_name_placeholder': '([^'\n]+)',\}\"([^\n']*)',",
    re.MULTILINE
)

new_content = pattern.sub(fix_structural, content)

# 2. Fix the case where it was partially fixed but left double {name}
# Example: 'Are you sure you want to unlink "{name"{name}"?'
new_content = new_content.replace('"{name"{name}"?', '"{name}"?')
new_content = new_content.replace('"{name"{name}"', '"{name}"') # just in case

# 3. Check for any other weirdness
# Sometimes it might have "{name}"? directly or something.

count = len(re.findall(pattern, content))
print(f"Fixed {count} structural matches.")

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(new_content)

print("Cleanup complete.")
