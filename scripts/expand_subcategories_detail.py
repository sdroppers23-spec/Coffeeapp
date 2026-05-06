# -*- coding: utf-8 -*-
import re
import os

FLAVOR_FILE = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

EXPANSION_DATA = {
    'wheel_sub_sugar_brown': {
        'en': 'Rich, caramelized sweetness ranging from light cane sugar to deep molasses. Key component of a balanced cup that provides body and weight.',
        'uk': 'Насичена карамелізована солодкість, від світлого тростинного цукру до глибокої патоки. Ключовий компонент збалансованої чашки, що додає тіла та ваги.',
        'de': 'Reiche, karamellisierte Süße von hellem Rohrzucker bis zu dunkler Melasse. Schlüsselkomponente einer ausgewogenen Tasse.',
        'fr': 'Sucrosité riche et caramélisée allant du sucre de canne clair à la mélasse profonde. Composant clé d\'une tasse équilibrée.',
        'es': 'Dulzor rico y caramelizado que va desde el azúcar de caña claro hasta la melaza profunda. Componente clave de una taza equilibrada.',
        'it': 'Ricca dolcezza caramellata che va dallo zucchero di canna chiaro alla melassa profonda. Componente chiave di una tazza equilibrata.',
        'pt': 'Doçura rica e caramelizada, variando de açúcar de cana claro a melaço profundo. Componente essencial de uma chávena equilibrada.',
        'pl': 'Bogata, skarmelizowana słodycz od jasnego cukru trzcinowego po gęstą melasę. Kluczowy składnik zrównoważonej filiżanki.',
        'nl': 'Rijke, gekaramelliseerde zoetheid variërend van lichte rietsuiker tot diepe melasse. Cruciaal voor een uitgebalanceerde kop.',
        'sv': 'Rik, karamelliserad sötma från ljust rörsocker till mörk melass. En nyckelkomponent för en balanserad kopp.',
        'tr': 'Açık kamış şekerinden koyu pekmeze kadar uzanan zengin, karamelize tatlılık. Dengeli bir fincanın ana bileşenidir.',
        'ja': 'ライトなサトウキビ糖から深い糖蜜まで、豊かなキャラメル状の甘み。ボディと重みを与える、バランスの取れたカップの重要な要素です。',
        'ko': '연한 사탕수수 설탕부터 깊은 당밀까지 아우르는 풍부한 캐러멜 단맛입니다. 바디감과 무게감을 주는 균형 잡힌 커피의 핵심 요소입니다.',
        'zh': '浓郁的焦糖味，从浅色蔗糖到深色糖蜜。是平衡口感、提供醇厚度的关键成分。',
        'ar': 'حلاوة كراميل غنية تتراوح من سكر القصب الفاتح إلى الدبس العميق. مكون رئيسي للكوب المتوازن الذي يعطي قواماً وثقلاً.',
    },
    'wheel_sub_earthy': {
        'en': 'Grounding, soil-like, or musty aromas. Can be a positive trait in certain origins like Sumatra, or a defect in others.',
        'uk': 'Заземлюючі, ґрунтові або мускусні аромати. Може бути позитивною рисою в певних походженнях, як Суматра, або дефектом в інших.',
        'de': 'Erdige, bodenartige oder modrige Aromen. Kann in bestimmten Herkünften wie Sumatra ein positives Merkmal sein.',
        'fr': 'Arômes terreux, de sol ou de moisi. Peut être un trait positif dans certaines origines comme Sumatra.',
        'es': 'Aromas terrosos, a suelo أو a moho. Puede ser un rasgo positivo en ciertos orígenes como Sumatra.',
        'it': 'Aromi terrosi, di suolo o di muffa. Può essere un tratto positivo in alcune origini come Sumatra.',
        'pt': 'Aromas terrosos, de solo ou de mofo. Pode ser um traço positivo em certas origens como Sumatra.',
        'pl': 'Ziemiste, glebowe lub zatęchłe aromaty. Mogą być cechą pozytywną w kawach z Sumatry lub wadą w innych.',
        'nl': 'Aardse, grondachtige of muffe aroma\'s. Kan een positieve eigenschap zijn in bepaalde herkomsten zoals Sumatra.',
        'sv': 'Jordiga eller mustiga aromer. Kan vara en positiv egenskap i vissa ursprung som Sumatra, eller en defekt i andra.',
        'tr': 'Topraksı veya küfümsü aromalar. Sumatra gibi bazı kökenlerde olumlu bir özellik, diğerlerinde ise kusur olabilir.',
        'ja': '土や大地、あるいはカビのような香り。スマトラ産など特定の産地ではポジティブな特徴となりますが、他では欠陥とされることもあります。',
        'ko': '흙이나 대지, 또는 곰팡이 같은 향기입니다. 수마트라와 같은 특정 산지에서는 긍정적인 특징일 수 있으나, 다른 곳에서는 결점으로 간주될 수 있습니다.',
        'zh': '土地、土壤或霉味。在苏门答腊等特定产区可能是正面特征，在其他产区则可能是缺陷。',
        'ar': 'روائح ترابية أو طينية. يمكن أن تكون سمة إيجابية في بعض الأصول مثل سومطرة، أو عيباً في أصول أخرى.',
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
    print(f"Updated {len(data)} subcategories with full detail.")

if __name__ == '__main__':
    update_file(EXPANSION_DATA)
    os.system(f'python scripts/fix_flavor_escaping.py')
