
import re

def find_duplicate_keys(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Find the maps
    en_match = re.search(r"'en': \{(.*?)\s+'uk':", content, re.DOTALL)
    uk_match = re.search(r"'uk': \{(.*?)\s+\},", content, re.DOTALL)

    def get_keys_with_lines(text, start_line):
        keys = []
        lines = text.split('\n')
        for i, line in enumerate(lines):
            match = re.search(r"'([a-zA-Z0-9_]+)':", line)
            if match:
                keys.append((match.group(1), start_line + i))
        return keys

    # Estimate start lines
    en_start = content[:content.find("'en':")].count('\n') + 2
    uk_start = content[:content.find("'uk':")].count('\n') + 2

    if en_match:
        en_keys = get_keys_with_lines(en_match.group(1), en_start)
        en_only_keys = [k for k, l in en_keys]
        en_dupes = [k for k in set(en_only_keys) if en_only_keys.count(k) > 1]
        print(f"EN Duplicates: {en_dupes}")
        for k in en_dupes:
            locs = [l for name, l in en_keys if name == k]
            print(f"  Key '{k}' found at lines: {locs}")

    if uk_match:
        uk_keys = get_keys_with_lines(uk_match.group(1), uk_start)
        uk_only_keys = [k for k, l in uk_keys]
        uk_dupes = [k for k in set(uk_only_keys) if uk_only_keys.count(k) > 1]
        print(f"UK Duplicates: {uk_dupes}")
        for k in uk_dupes:
            locs = [l for name, l in uk_keys if name == k]
            print(f"  Key '{k}' found at lines: {locs}")

find_duplicate_keys(r'd:\Games\Coffeeapp\lib\core\l10n\app_localizations.dart')
