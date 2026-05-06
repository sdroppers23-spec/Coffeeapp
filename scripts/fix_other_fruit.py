import re
import os

translations = {
    'wheel_sub_other_fruit': {
        'en': 'Tropical or temperate fruit notes like apple, pear, or mango. Represents intermediate acidity levels. Characteristic of Costa Rican and Salvadoran coffees.',
        'uk': 'Ноти тропічних або фруктів помірного клімату, таких як яблуко, груша або манго. Представляє середні рівні кислотності. Характерно для кави з Коста-Ріки та Сальвадору.',
        'de': 'Tropische oder gemäßigte Fruchtnoten wie Apfel, Birne oder Mango. Repräsentiert mittlere Säuregrade. Charakteristisch für Kaffees aus Costa Rica und El Salvador.',
        'fr': 'Notes de fruits tropicaux ou tempérés comme la pomme, la poire ou la mangue. Représente des niveaux d\'acidité intermédiaires. Caractéristique des cafés du Costa Rica et du Salvador.',
        'es': 'Notas de frutas tropicales o templadas como manzana, pera o mango. Representa niveles de acidez intermedios. Característico de los cafés de Costa Rica y El Salvador.',
        'it': 'Note di frutta tropicale o temperata come mela, pera o mango. Rappresenta livelli di acidità intermedi. Caratteristico dei caffè della Costa Rica e di El Salvador.',
        'pt': 'Notas de frutas tropicais ou temperadas como maçã, pera ou manga. Representa níveis de acidez intermédios. Característico de cafés da Costa Rica e de El Salvador.',
        'pl': 'Tropikalne lub umiarkowane nuty owocowe, takie як jabłko, gruszka lub mango. Reprezentuje pośrednie poziomy kwasowości. Charakterystyczne dla kaw z Kostaryki i Salwadoru.',
        'nl': 'Tropische of gematigde fruittonen zoals appel, peer of mango. Vertegenwoordigt gemiddelde zuurgraden. Kenmerkend voor koffiesoorten uit Costa Rica en El Salvador.',
        'sv': 'Tropiska eller tempererade fruktnoter som äpple, päron eller mango. Representerar medelhöga syranivåer. Karaktäristiskt för kaffe från Costa Rica och El Salvador.',
        'tr': 'Elma, armut veya mango gibi tropikal veya ılıman meyve notaları. Orta düzeyde asidite seviyelerini temsil eder. Kosta Rika ve El Salvador kahvelerinin özelliğidir.',
        'ja': 'リンゴ、梨、マンゴーのような、熱帯または温帯の果実のノート。中程度の酸味を示します。コスタリカ産やエルサルバドル産コーヒーの特徴です。',
        'ko': '사과, 배 또는 망고와 같은 열대 또는 온대 과일 노트입니다. 중간 정도의 산미를 나타냅니다. 코스타리카 및 엘살바도르 커피의 특징입니다.',
        'zh': '热带或温带水果风味，如苹果、梨或芒果。代表中等酸度水平。是哥斯达黎加和萨尔瓦多咖啡的特征。',
        'ar': 'نكهات فواكه استوائية أو معتدلة مثل التفاح أو الكمثرى أو المانجو. تمثل مستويات حموضة متوسطة. مميزة لأنواع القهوة من كوستاريكا والسلفادور.'
    }
}

file_path = 'lib/core/l10n/flavor_descriptions.dart'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

def replace_entry(key, lang_map):
    pattern = re.compile(rf"('{key}':\s*\{{[^}}]*\}})", re.DOTALL)
    
    new_entry = f"'{key}': {{\n"
    for lang in ['en', 'uk', 'de', 'fr', 'es', 'it', 'pt', 'pl', 'nl', 'sv', 'tr', 'ja', 'ko', 'zh', 'ar']:
        val = lang_map.get(lang, lang_map['en']).replace("'", "\\'")
        new_entry += f"        '{lang}':\n            '{val}',\n"
    new_entry += "      }"
    
    return pattern.sub(new_entry, content)

for key, lang_map in translations.items():
    if f"'{key}':" in content:
        content = replace_entry(key, lang_map)
    else:
        print(f"Warning: Key {key} not found in {file_path}")

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print("Successfully updated missing Other Fruit sub-category.")
