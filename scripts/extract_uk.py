import re

def extract_uk_descriptions(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Match wheel_note_... followed by UK description
    pattern = r"'wheel_note_([^']+)': \{.*? 'uk':\s+'([^']+)',"
    matches = re.findall(pattern, content, re.DOTALL)
    
    for note, desc in matches:
        # Check if it has English placeholders in other languages
        # (This is just a heuristic)
        print(f"Note: {note}")
        print(f"UK: {desc}")
        print("-" * 20)

extract_uk_descriptions(r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart')
