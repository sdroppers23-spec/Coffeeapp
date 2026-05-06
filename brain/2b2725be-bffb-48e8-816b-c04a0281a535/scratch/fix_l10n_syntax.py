
import re

file_path = r'd:\Games\Coffeeapp\lib\core\l10n\app_localizations.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Pattern to match the broken template and the 3 new keys
# We want to move '}"?,' back to the template string and fix the quotes/commas.
# The broken pattern looks like:
# 'unlink_lot_confirm_desc_template':\s+'([^'\n]+)\s+'unknown': '([^'\n]+)',\s+'not_available': '([^'\n]+)',\s+'method_name_placeholder': '([^'\n]+)',\}"\?',

# Actually, it's simpler to match the specific sequence of lines.
# Example:
#       'unlink_lot_confirm_desc_template':
#           'Are you sure you want to unlink "{name
#       'unknown': 'Unknown',
#       'not_available': 'N/A',
#       'method_name_placeholder': 'Method name (e.g. Hario Switch)',}"?',

def fix_match(match):
    key_template = match.group(1)
    template_start = match.group(2)
    unknown_val = match.group(3)
    na_val = match.group(4)
    method_val = match.group(5)
    
    return f"      '{key_template}':\n          '{template_start}\"{{name}}\"?',\n      'unknown': '{unknown_val}',\n      'not_available': '{na_val}',\n      'method_name_placeholder': '{method_val}',"

# Regex to find the broken block
pattern = re.compile(
    r"      '(unlink_lot_confirm_desc_template)':\n\s+'([^'\n]+)\n\s+'unknown': '([^'\n]+)',\n\s+'not_available': '([^'\n]+)',\n\s+'method_name_placeholder': '([^'\n]+)',\}\"\?',",
    re.MULTILINE
)

new_content = pattern.sub(fix_match, content)

# Check if replacements were made
count = len(re.findall(pattern, content))
print(f"Found {count} matches to fix.")

if count > 0:
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(new_content)
    print("File fixed successfully.")
else:
    print("No matches found. Check the regex or file content.")
