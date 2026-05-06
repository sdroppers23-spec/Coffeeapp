# -*- coding: utf-8 -*-
import re
import os

FLAVOR_FILE = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

EXPANSION_DATA = {
    'wheel_note_raisin': {
        'en': 'Concentrated sweetness with a slight vinegary tang. Typical of sun-dried natural coffees and extended fermentation lots.',
        'uk': 'Концентрована солодкість з легким оцтовим присмаком. Типово для висушеної на сонці кави натуральної обробки та лотів з тривалою ферментацією.',
        'de': 'Konzentrierte Süße mit einem leichten essigartigen Beigeschmack. Typisch für sonnengetrocknete Naturbelassene Kaffees.',
        'fr': 'Sucrosité concentrée avec une légère pointe vinaigrée. Typique des cafés naturels séchés au soleil.',
        'es': 'Dulzor concentrado con un ligero toque avinagrado. Típico de cafés naturales secados al sol.',
        'it': 'Dolcezza concentrata con una leggera nota acetosa. Tipico dei caffè naturali essiccati al sole.',
        'pt': 'Doçura concentrada com um leve toque vinagrado. Típico de cafés naturais secos ao sol.',
        'pl': 'Skoncentrowana słodycz z lekką octową nutą. Typowa dla kaw z obróbki naturalnej suszonych na słońcu.',
        'nl': 'Geconcentreerde zoetheid met een lichte azijnachtige bijsmaak. Typisch voor zongedroogde natuurlijke koffies.',
        'sv': 'Koncentrerad sötma med en lätt vinägrig touch. Typiskt för soltorkat naturligt kaffe.',
        'tr': 'Hafif sirkemsi bir tatla konsantre tatlılık. Güneşte kurutulmuş doğal kahvelerin tipik özelliğidir.',
        'ja': 'わずかに酢のような酸味を伴う、濃縮された甘み。天日干しのナチュラル精製豆や長時間発酵ロットに典型的な風味です。',
        'ko': '약간의 식초 같은 산미를 동반한 농축된 단맛입니다. 햇볕에 말린 내추럴 커피와 연장 발효된 커피의 전형적인 특징입니다.',
        'zh': '带有微弱醋酸味的浓缩甜味。日晒处理和延长发酵咖啡豆的典型风味。',
        'ar': 'حلاوة مركزة مع نكهة خلية خفيفة. نموذجية للقهوة المجففة بالشمس والمعالجة طبيعيًا.',
    },
    'wheel_note_cherry': {
        'en': 'Sweet and slightly tart stone fruit note. Represents the balanced acidity of well-ripe coffee cherries. Common in Central American lots.',
        'uk': 'Солодка і злегка терпка нота кісточкових фруктів. Представляє збалансовану кислотність добре стиглих кавових ягід. Поширена в центральноамериканських лотах.',
        'de': 'Süße und leicht herbe Steinobstnote. Repräsentiert die ausgewogene Säure reifer Kaffeekirschen.',
        'fr': 'Note de fruit à noyau sucrée et légèrement acidulée. Représente l\'acidité équilibrée des cerises de café mûres.',
        'es': 'Nota de fruta de hueso dulce y ligeramente ácida. Representa la acidez equilibrada de las cerezas de café maduras.',
        'it': 'Nota di drupacee dolce e leggermente aspra. Rappresenta l\'acidità bilanciata delle ciliegie di caffè mature.',
        'pt': 'Nota de fruta de caroço doce e levemente ácida. Representa a acidez equilibrada das cerejas de café maduras.',
        'pl': 'Słodka i lekko cierpka nuta owoców pestkowych. Reprezentuje zrównoważoną kwasowość dojrzałych owoców kawowca.',
        'nl': 'Zoete en licht zure steenvruchtnoot. Staat voor de evenwichtige aciditeit van goed gerijpte koffiebessen.',
        'sv': 'Söt och lätt syrlig stenfruktston. Representerar den balanserade syran hos väl mogna kaffebär.',
        'tr': 'Tatlı ve hafif mayhoş çekirdekli meyve notası. Olgun kahve meyvelerinin dengeli asiditesini temsil eder.',
        'ja': '甘く、わずかに酸味のある核果のノート。完熟したコーヒーチェリーのバランスの取れた酸味を表現しています。',
        'ko': '달콤하고 약간 새콤한 핵과류의 노트입니다. 잘 익은 커피 체리의 균형 잡힌 산미를 나타냅니다.',
        'zh': '甜中带酸的核果风味。代表了完全成熟咖啡樱桃的平衡酸度。',
        'ar': 'نوتة فاكهة ذات نواة حلوة ولاذعة قليلاً. تمثل الحموضة المتوازنة لكرز القهوة الناضج.',
    },
    'wheel_note_pineapple': {
        'en': 'Intense tropical sweetness and acidity. Often signals advanced fermentation techniques or specific yeast processing.',
        'uk': 'Інтенсивна тропічна солодкість і кислотність. Часто свідчить про передові техніки ферментації або специфічну обробку дріжджами.',
        'de': 'Intensive tropische Süße und Säure. Signalisiert oft fortschrittliche Fermentations-Techniken.',
        'fr': 'Sucrosité et acidité tropicales intenses. Signale souvent des techniques de fermentation avancées.',
        'es': 'Dulzor y acidez tropicales intensos. A menudo señala técnicas de fermentación avanzadas.',
        'it': 'Intensa dolcezza e acidità tropicale. Spesso segnala tecniche di fermentazione avanzate.',
        'pt': 'Doçura e acidez tropicais intensas. Frequentemente sinaliza técnicas avançadas de fermentação.',
        'pl': 'Intensywna tropikalna słodycz i kwasowość. Często sygnalizuje zaawansowane techniki fermentacji.',
        'nl': 'Intense tropische zoetheid en aciditeit. Signaleert vaak geavanceerde fermentatietechnieken.',
        'sv': 'Intensiv tropisk sötma och syrlighet. Tyder ofta på avancerade fermenteringstekniker.',
        'tr': 'Yoğun tropikal tatlılık ve asidite. Genellikle gelişmiş fermantasyon tekniklerinin göstergesidir.',
        'ja': '強烈なトロピカルな甘みと酸味。高度な発酵技術や特定の酵母精製が行われたことを示すことが多いです。',
        'ko': '강렬한 열대적인 단맛과 산미입니다. 종종 고도의 발효 기술이나 특정 효모 가공을 의미합니다.',
        'zh': '强烈的热带甜味和酸度。通常预示着先进的发酵技术或特定的酵母处理工艺。',
        'ar': 'حلاوة وحموضة استوائية مكثفة. غالبًا ما تشير إلى تقنيات تخمير متقدمة أو معالجة بخميرة معينة.',
    },
}

def update_file(data):
    with open(FLAVOR_FILE, 'r', encoding='utf-8') as f:
        content = f.read()
    
    for key, val in data.items():
        pattern = re.compile(rf"'{key}':\s*\{{.*?\}}", re.DOTALL)
        replacement = f"'{key}': {{\n"
        langs = ['en', 'uk', 'de', 'fr', 'es', 'it', 'pt', 'pl', 'nl', 'sv', 'tr', 'ja', 'ko', 'zh', 'ar']
        for lang in langs:
            if lang in val:
                text = val[lang].replace("'", "\\'")
                replacement += f"        '{lang}': '{text}',\n"
        replacement += "      }"
        content = pattern.sub(replacement, content)
    
    with open(FLAVOR_FILE, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f"Updated {len(data)} notes with full detail.")

if __name__ == '__main__':
    update_file(EXPANSION_DATA)
    os.system(f'python scripts/fix_flavor_escaping.py')
