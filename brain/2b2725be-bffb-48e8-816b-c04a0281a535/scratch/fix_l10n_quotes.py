
import re

file_path = r'd:\Games\Coffeeapp\lib\core\l10n\app_localizations.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Fix double double quotes around {name}
new_content = content.replace('""{name}"', '"{name}"')

# Also check for any other variations like "{name}"" or similar
new_content = new_content.replace('"{name}""', '"{name}"')

# Ensure the values are syntactically correct Dart strings
# Sometimes there might be a trailing ' after the colon if I messed up.

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(new_content)

print("Double quote cleanup complete.")
