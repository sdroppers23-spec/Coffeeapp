
import re
import os

target_file = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

with open(target_file, 'r', encoding='utf-8') as f:
    content = f.read()

# Find the start and end of the descriptions map
start_marker = 'final Map<String, Map<String, String>> descriptions = {'
end_marker = '    };'

start_idx = content.find(start_marker)
if start_idx == -1:
    print("Could not find start of descriptions")
    exit(1)

# Find the closing brace of the map
# We look for the }; that is not inside another brace
brace_count = 0
map_end_idx = -1
for i in range(start_idx + len(start_marker) - 1, len(content)):
    if content[i] == '{':
        brace_count += 1
    elif content[i] == '}':
        brace_count -= 1
        if brace_count == 0:
            map_end_idx = i + 1
            break

if map_end_idx == -1:
    print("Could not find end of _descriptions")
    exit(1)

map_content = content[start_idx + len(start_marker) : map_end_idx - 1]

# Extract all blocks like 'key': { ... },
# Using a regex that handles nested braces
blocks = re.findall(r"(\'[a-z0-9_]+\':\s*\{.*?\})", map_content, re.DOTALL)

seen_keys = {}
unique_blocks = []

for block in blocks:
    key_match = re.search(r"\'([a-z0-9_]+)\':", block)
    if key_match:
        key = key_match.group(1)
        seen_keys[key] = block # Overwrite with latest

# Reconstruct the map content
new_map_content = "\n"
for key in sorted(seen_keys.keys()):
    new_map_content += f"    {seen_keys[key]},\n"

# Replace the old map with the new one
new_content = content[:start_idx + len(start_marker)] + new_map_content + "    " + content[map_end_idx - 1:]

with open(target_file, 'w', encoding='utf-8', newline='\n') as f:
    f.write(new_content)

print(f'Deduplicated. Total unique keys: {len(seen_keys)}')
