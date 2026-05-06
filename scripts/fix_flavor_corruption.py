import re
import os

def fix_corrupted_flavor_descriptions(file_path):
    if not os.path.exists(file_path):
        print(f"File not found: {file_path}")
        return

    with open(file_path, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    fixed_lines = []
    corruption_count = 0
    
    for i, line in enumerate(lines):
        # Pattern 1: 'lang': 'text', extra stuff',
        # Usually for short entries
        match1 = re.search(r"^(\s+'\w+':\s+)'((?:\\.|[^'])*)'(.*),$", line)
        
        # Pattern 2: 'text', extra stuff', (on a line by itself under 'lang':)
        # Usually for multiline formatted entries
        match2 = re.search(r"^(\s+)'((?:\\.|[^'])*)'(.*),$", line)
        
        # Priority to match1 if it's a full line, otherwise match2
        match = match1 if match1 else match2
        
        if match:
            prefix_or_indent = match.group(1)
            text = match.group(2)
            extra = match.group(3)
            
            # If extra contains a quote, it's likely a concatenation error
            if "'" in extra:
                # Clean the line by keeping only the first quoted part
                fixed_lines.append(f"{prefix_or_indent}'{text}',\n")
                corruption_count += 1
                # print(f"Fixed line {i+1}: {line.strip()[:50]}...")
            else:
                fixed_lines.append(line)
        else:
            fixed_lines.append(line)

    if corruption_count > 0:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.writelines(fixed_lines)
        print(f"Fixed {corruption_count} corrupted lines in {file_path}")
    else:
        print("No corruption found.")

if __name__ == "__main__":
    file_path = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'
    fix_corrupted_flavor_descriptions(file_path)
