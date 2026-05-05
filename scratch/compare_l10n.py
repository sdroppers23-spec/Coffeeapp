import re

def extract_map_with_values(content, lang):
    pattern = rf"'{lang}': \{{(.*?)\}},"
    match = re.search(pattern, content, re.DOTALL)
    if not match:
        return {}
    map_content = match.group(1)
    # Match 'key': 'value' or 'key':\n      'value'
    entries = re.findall(rf"'([^']+)':\s*(?:'([^']*)'|\n\s*'([^']*)')", map_content)
    result = {}
    for entry in entries:
        key = entry[0]
        value = entry[1] if entry[1] else entry[2]
        result[key] = value
    return result

with open('lib/core/l10n/app_localizations.dart', 'r', encoding='utf-8') as f:
    content = f.read()

en_map = extract_map_with_values(content, 'en')
uk_map = extract_map_with_values(content, 'uk')

missing_in_en = set(uk_map.keys()) - set(en_map.keys())
missing_in_uk = set(en_map.keys()) - set(uk_map.keys())

print("=== Missing in EN (UK values) ===")
for key in sorted(missing_in_en):
    print(f"'{key}': '{uk_map[key]}',")

print("\n=== Missing in UK (EN values) ===")
for key in sorted(missing_in_uk):
    print(f"'{key}': '{en_map[key]}',")
