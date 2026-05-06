import re

path = r'd:\Games\Coffeeapp\lib\core\l10n\app_localizations.dart'

with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

# Find the _translations map
match = re.search(r'static const Map<String, Map<String, String>> _translations = \{(.*?)\};', content, re.DOTALL)
if not match:
    print("Could not find _translations map")
    exit()

translations_content = match.group(1)

# Find all language blocks
lang_blocks = re.findall(r"    '([a-z]{2})': \{(.*?)\n    \},", translations_content, re.DOTALL)

print(f"Total languages found: {len(lang_blocks)}")
langs = [lang for lang, _ in lang_blocks]
print(f"Languages: {', '.join(langs)}")

# Check for specific keys in each language
keys_to_check = [
    'roast_light',
    'roast_medium',
    'roast_dark',
    'grinder_comandante',
    'personal_roastery_label',
    'specialty_roaster_label',
    'unnamed_label'
]

for lang, block in lang_blocks:
    missing = [key for key in keys_to_check if f"'{key}':" not in block]
    if missing:
        print(f"Language '{lang}' is missing keys: {', '.join(missing)}")
    else:
        print(f"Language '{lang}' has all checked keys.")
