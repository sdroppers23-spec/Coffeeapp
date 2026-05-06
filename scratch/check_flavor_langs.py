import re

path = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

# Check wheel_cat_floral
match = re.search(r"'wheel_cat_floral': \{(.*?)\},", content, re.DOTALL)
if match:
    block = match.group(1)
    langs = re.findall(r"'([a-z]{2})':", block)
    print(f"Flavor wheel languages: {len(langs)}")
    print(f"Languages: {', '.join(langs)}")
else:
    print("Could not find wheel_cat_floral")
