
import re
import os

data_file = r'd:\Games\Coffeeapp\lib\features\flavor_map\sca_flavor_wheel_data.dart'
l10n_file = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

with open(data_file, 'r', encoding='utf-8') as f:
    data_content = f.read()

with open(l10n_file, 'r', encoding='utf-8') as f:
    l10n_content = f.read()

# Extract keys from data file
# Keys look like: key: 'wheel_cat_floral'
# Also look for noteKeys: ['...', '...']
data_keys = set(re.findall(r"key:\s*\'([a-z0-9_]+)\'", data_content))
note_keys = re.findall(r"\'(wheel_note_[a-z0-9_]+)\'", data_content)
data_keys.update(note_keys)

# Extract keys from l10n file
# Keys look like: 'wheel_cat_floral': {
l10n_keys = set(re.findall(r"\'([a-z0-9_]+)\':\s*\{", l10n_content))

missing_keys = data_keys - l10n_keys

print(f"Keys in data: {len(data_keys)}")
print(f"Keys in l10n: {len(l10n_keys)}")

if missing_keys:
    print(f"Missing keys in l10n ({len(missing_keys)}):")
    for key in sorted(missing_keys):
        print(f"  - {key}")
else:
    print("All keys from data are present in l10n!")

# Check for specific keys we were worried about
for key in ['wheel_note_jasmine', 'wheel_note_vanilla', 'wheel_cat_floral']:
    if key in l10n_keys:
        print(f"Confirmed: {key} is present.")
    else:
        print(f"WARNING: {key} is MISSING!")
