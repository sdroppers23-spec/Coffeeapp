# -*- coding: utf-8 -*-
import re
import os

FLAVOR_FILE = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

# BATCH 1: Keys 1-30
BATCH1 = {
    'wheel_sub_floral': {
        'en': 'Distinct and clear floral aromas. Foundational sensory characteristics of very fresh or lightly roasted specialty lots.',
        'uk': 'Виразні та чіткі квіткові аромати. Основоположні сенсорні характеристики дуже свіжих або світло обсмажених лотів спешелті.',
        'de': 'Ausgeprägte und klare blumige Aromen. Grundlegende sensorische Merkmale von sehr frischen Spezialitätenkaffees.',
        'fr': 'Arômes floraux distincts et clairs. Caractéristiques sensorielles fondamentales des lots de spécialité.',
        'es': 'Aromas florales distintos y claros. Características sensoriales fundamentales de los lotes de especialidad.',
        'it': 'Aromi floreali distinti e chiari. Caratteristiche sensoriali fondamentali dei lotti specialty.',
        'pt': 'Aromas florais distintos e claros. Características sensoriais fundamentais de lotes de especialidade.',
        'pl': 'Wyraźne i jasne aromaty kwiatowe. Podstawowe cechy sensoryczne świeżych kaw specialty.',
        'nl': 'Duidelijke en heldere bloemige aroma\'s. Fundamentele sensorische kenmerken van verse specialty koffie.',
        'sv': 'Tydliga och klara blommiga aromer. Grundläggande sensoriska egenskaper hos färskt specialkaffe.',
        'tr': 'Belirgin ve net çiçeksi aromalar. Çok taze veya hafif kavrulmuş nitelikli kahvelerin temel özelliği.',
        'ja': 'はっきりとした明確なフローラルな香り。非常に新鮮な、または浅煎りのスペシャルティコーヒーの特徴。',
        'ko': '뚜렷하고 선명한 꽃향기입니다. 매우 신선하거나 약배전된 스페셜티 커피의 기본적인 특징입니다.',
        'zh': '独特而清晰的花香。非常新鲜或极浅度烘焙精品咖啡的基础感官特征。',
        'ar': 'روائح زهرية متميزة وواضحة. خصائص حسية أساسية لمحاصيل القهوة المختصة الطازجة جداً.',
    },
    'wheel_cat_sour_fermented': {
        'en': 'Complex notes ranging from pleasant tangy acids to intense fermented funk. Result of microbial activity.',
        'uk': 'Комплексні ноти, що варіюються від приємних гострих кислот до інтенсивного ферментованого "фанку". Результат мікробної активності.',
        'de': 'Komplexe Noten, die von angenehm spritzigen Säuren bis hin zu intensivem Fermentations-Funk reichen.',
        'fr': 'Notes complexes allant d\'acides acidulés agréables à un funk fermenté intense.',
        'es': 'Notas complejas que van desde ácidos agradables hasta un toque fermentado intenso.',
        'it': 'Note complesse che vanno da piacevoli acidi pungenti a un intenso funk fermentato.',
        'pt': 'Notas complexas que variam de ácidos picantes agradáveis a um toque fermentado intenso.',
        'pl': 'Złożone nuty, od przyjemnych, ostrych kwasów po intensywne aromaty fermentacji.',
        'nl': 'Complexet tonen variërend van aangename frisse zuren tot intens gefermenteerde funk.',
        'sv': 'Komplexa toner som sträcker sig från behagligt syrliga syror till intensiv fermenterad funk.',
        'tr': 'Hoş mayhoş asitlerden yoğun fermente notalara kadar uzanan karmaşık özellikler.',
        'ja': '心地よい酸味から強烈な発酵感まで、複雑なノート。微生物の活動による結果です。strip',
        'ko': '기분 좋은 산미부터 강렬한 발효 풍미까지 아우르는 복합적인 노트입니다.',
        'zh': '从愉悦的酸爽到强烈的发酵风味，风味复杂。微生物活动的结果。',
        'ar': 'نوتات معقدة تتراوح من الأحماض اللاذعة الممتعة إلى روائح التخمير المكثفة.',
    },
    'wheel_cat_green_veg': {
        'en': 'Herbal or vegetal notes that evoke fresh-cut grass or raw vegetables. Indicates light roast or processing.',
        'uk': 'Трав\'янисті або овочеві ноти, що нагадують свіжоскошену траву або сирі овочі. Вказує на світле обсмажування або обробку.',
        'de': 'Kräuterige oder pflanzliche Noten, die an frisch gemähtes Gras erinnern.',
        'fr': 'Notes herbacées ou végétales évoquant l\'herbe fraîchement coupée.',
        'es': 'Notas herbáceas o vegetales que evocan hierba recién cortada.',
        'it': 'Note erbacee o vegetali che evocano l\'erba appena tagliata.',
        'pt': 'Notas herbáceas ou vegetais que evocam relva recém-cortada.',
        'pl': 'Ziołowe lub roślinne nuty przypominające świeżo ściętą trawę.',
        'nl': 'Kruidige of plantaardige tonen die doen denken aan vers gemaaid gras.',
        'sv': 'Örtiga eller vegetabiliska toner som för tankarna till nyklippt gräs.',
        'tr': 'Taze kesilmiş çimen veya çiğ sebzeleri anımsatan bitkisel veya otsu notalar.',
        'ja': '刈りたての芝生や生野菜を思わせる、ハーブや植物的なノート。',
        'ko': '갓 자른 풀이나 생채소를 연상시키는 허브 또는 식물적인 노트입니다.',
        'zh': '令人联想到鲜切青草或生蔬菜的草本或植物风味。',
        'ar': 'نوتات عشبية أو نباتية تذكرنا بالعشب المقصوص حديثاً أو الخضروات النيئة.',
    },
}

def update_file(data):
    with open(FLAVOR_FILE, 'r', encoding='utf-8') as f:
        content = f.read()
    
    for key, val in data.items():
        pattern = re.compile(rf"'{key}':\s*\{{.*?\}}", re.DOTALL)
        replacement = f"'{key}': {{\n"
        for lang in sorted(val.keys()):
            text = val[lang].replace("'", "\\'")
            replacement += f"        '{lang}': '{text}',\n"
        replacement += "      }"
        content = pattern.sub(replacement, content)
    
    with open(FLAVOR_FILE, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f"Updated {len(data)} keys.")

if __name__ == '__main__':
    update_file(BATCH1)
