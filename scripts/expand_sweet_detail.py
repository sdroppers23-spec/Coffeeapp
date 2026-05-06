# -*- coding: utf-8 -*-
import re
import os

FLAVOR_FILE = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

EXPANSION_DATA = {
    'wheel_cat_sweet': {
        'en': 'The foundational sweetness of coffee, ranging from white sugar to complex molasses. It results from the breakdown of carbohydrates during roasting. Present in almost all balanced specialty coffees.',
        'uk': 'Основна солодкість кави, від білого цукру до складних патокових відтінків. Вона походить від розпаду вуглеводів під час обсмажування. Присутня майже у всій збалансованій спешелті-каві.',
        'de': 'Die grundlegende Süße von Kaffee, die von weißem Zucker bis hin zu komplexer Melasse reicht. Sie entsteht durch den Abbau von Kohlenhydraten während des Röstens.',
        'fr': 'La sucrosité fondamentale du café, allant du sucre blanc à la mélasse complexe. Elle résulte de la dégradation des glucides pendant la torréfaction.',
        'es': 'El dulzor fundamental del café, que va desde el azúcar blanco hasta la melaza compleja. Resulta de la descomposición de los carbohidratos durante el tueste.',
        'it': 'La dolcezza fondamentale del caffè, che va dallo zucchero bianco alla melassa complessa. Deriva dalla scomposizione dei carboidrati durante la tostatura.',
        'pt': 'A doçura fundamental do café, variando do açúcar branco ao melaço complexo. Resulta da decomposição de carboidratos durante a torra.',
        'pl': 'Podstawowa słodycz kawy, od białego cukru po złożoną melasę. Wynika z rozpadu węglowodanów podczas palenia.',
        'nl': 'De fundamentele zoetheid van koffie, variërend van witte suiker tot complexe melasse. Het is het resultaat van de afbraak van koolhydraten tijdens het branden.',
        'sv': 'Den grundläggande sötman i kaffe, från vitt socker till komplex melass. Det är ett resultat av nedbrytningen av kolhydrater under rostningen.',
        'tr': 'Beyaz şekerden karmaşık pekmeze kadar kahvenin temel tatlılığı. Kavurma sırasında karbonhidratların parçalanmasıyla oluşur.',
        'ja': '白砂糖から複雑な糖蜜まで、コーヒーの基礎的な甘み。焙煎中の炭水化物の分解によって生じます。ほぼすべてのバランスの取れたスペシャルティコーヒーに含まれます。',
        'ko': '백설탕부터 복합적인 당밀까지 아우르는 커피의 기본적인 단맛입니다. 로스팅 중 탄수화물이 분해되면서 발생합니다. 대부분의 균형 잡힌 스페셜티 커피에 존재합니다.',
        'zh': '咖啡的基础甜感，从白糖到复杂的糖蜜。由烘焙过程中碳水化合物的分解产生。几乎存在于所有平衡的精品咖啡中。',
        'ar': 'الحلاوة الأساسية للقهوة، تتراوح من السكر الأبيض إلى الدبس المعقد. تنتج عن تكسر الكربوهيدرات أثناء التحميص.',
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
    print(f"Updated {len(data)} entries with full detail.")

if __name__ == '__main__':
    update_file(EXPANSION_DATA)
    os.system(f'python scripts/fix_flavor_escaping.py')
