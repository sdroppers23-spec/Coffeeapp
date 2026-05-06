# -*- coding: utf-8 -*-
import re
import os

FLAVOR_FILE = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

# High-fidelity translations for Fruity and Floral categories/subcategories
EXPANSION_DATA = {
    'wheel_cat_fruity': {
        'en': 'A broad range of sweet, tart, and juicy fruit characteristics. Indicates vibrant acidity and a clean processing method.',
        'uk': 'Широкий спектр солодких, терпких та соковитих фруктових характеристик. Вказує на яскраву кислотність та чистий метод обробки.',
        'de': 'Ein breites Spektrum an süßen, säuerlichen und saftigen Fruchtnoten. Deutet auf lebhafte Säure und eine saubere Aufbereitungsmethode hin.',
        'fr': 'Une large gamme de caractéristiques de fruits sucrés, acidulés et juteux. Indique une acidité vibrante et une méthode de traitement propre.',
        'es': 'Una amplia gama de características de frutas dulces, ácidas y jugosas. Indica una acidez vibrante y un método de procesamiento limpio.',
        'it': 'Un\'ampia gamma di caratteristiche di frutta dolce, aspra e succosa. Indica un\'acidità vibrante e un metodo di lavorazione pulito.',
        'pt': 'Uma ampla gama de características de frutas doces, ácidas e suculentas. Indica uma acidez vibrante e um método de processamento limpo.',
        'pl': 'Szeroka gama słodkich, cierpkich i soczystych cech owocowych. Wskazuje na żywą kwasowość i czystą metodę obróbki.',
        'nl': 'Een breed scala aan zoete, zure en sappige fruitkenmerken. Wijst op een levendige aciditeit en een zuivere verwerkingsmethode.',
        'sv': 'Ett brett utbud av söta, syrliga och saftiga fruktoner. Indikerar livlig syra och en ren bearbetningsmetod.',
        'tr': 'Tatlı, mayhoş ve sulu meyve özelliklerinin geniş bir yelpazesi. Canlı asiditeyi ve temiz bir işleme yöntemini gösterir.',
        'ja': '甘み、酸味、ジューシーな果実味の幅広い特徴。鮮やかな酸味とクリーンな精製方法を示します。',
        'ko': '달콤하고 새콤하며 과즙이 풍부한 광범위한 과일 특성입니다. 활기찬 산미와 깔끔한 가공 방식을 나타냅니다.',
        'zh': '涵盖甜、酸、多汁的水果特征。表现出明亮的酸度和干净的处理工艺。',
        'ar': 'مجموعة واسعة من خصائص الفاكهة الحلوة واللاذعة والعصارية. تشير إلى حموضة نابضة بالحياة وطريقة معالجة نظيفة.',
    },
    'wheel_cat_floral': {
        'en': 'Delicate and aromatic notes reminiscent of blossoms and flowers. Often characteristic of high-altitude coffees and light roasts.',
        'uk': 'Делікатні та ароматні ноти, що нагадують цвітіння та квіти. Часто характерно для високогірної кави та світлого обсмажування.',
        'de': 'Zarte und aromatische Noten, die an Blüten und Blumen erinnern. Oft charakteristisch für Hochlandkaffees und helle Röstungen.',
        'fr': 'Notes délicates et aromatiques rappelant les fleurs et les bourgeons. Souvent caractéristique des cafés d\'altitude et des torréfactions légères.',
        'es': 'Notas delicadas y aromáticas que recuerdan a capullos y flores. A menudo características de cafés de altura y tuestes ligeros.',
        'it': 'Note delicate e aromatiche che ricordano boccioli e fiori. Spesso caratteristiche di caffè d\'alta quota e tostature chiare.',
        'pt': 'Notas delicadas e aromáticas que lembram botões e flores. Frequentemente características de cafés de altitude e torras claras.',
        'pl': 'Delikatne i aromatyczne nuty przypominające pąki i kwiaty. Często charakterystyczne dla kaw wysokogórskich i jasnych wypałów.',
        'nl': 'Verfijnde en aromatische tonen die doen denken aan bloesems en bloemen. Vaak kenmerkend voor hooglandkoffie en lichte brandingen.',
        'sv': 'Delikata och aromatiska toner som påminner om blommor och blomning. Ofta karaktäristiskt för kaffe från hög höjd och ljusrost.',
        'tr': 'Çiçekleri ve tomurcukları anımsatan narin ve aromatik notalar. Genellikle yüksek rakımlı kahvelerin ve hafif kavurmaların özelliğidir.',
        'ja': '花や開花を思わせる繊細で芳醇な香り。標高の高い場所で栽培されたコーヒーや浅煎りの豆によく見られる特徴です。',
        'ko': '꽃과 개화를 연상시키는 섬세하고 향긋한 노트입니다. 고지대 커피와 약배전 커피에서 흔히 발견되는 특징입니다.',
        'zh': '令人联想到花朵的精致芳香。通常是高海拔咖啡和浅度烘焙的特征。',
        'ar': 'نوتات رقيقة وعطرية تذكرنا بالزهور والبراعم. غالبًا ما تكون مميزة للقهوة المزروعة على ارتفاعات عالية والتحميص الفاتح.',
    },
    'wheel_sub_floral': {
        'en': 'Distinct and clear floral aromas. Foundational sensory characteristics of very fresh or lightly roasted specialty lots.',
        'uk': 'Виразні та чіткі квіткові аромати. Основоположні сенсорні характеристики дуже свіжих або світло обсмажених лотів спешелті.',
        'de': 'Ausgeprägte und klare blumige Aromen. Grundlegende sensorische Merkmale von sehr frischen oder hell gerösteten Spezialitätenkaffees.',
        'fr': 'Arômes floraux distincts et clairs. Caractéristiques sensorielles fondamentales des lots de spécialité très frais ou légèrement torréfiés.',
        'es': 'Aromas florales distintos y claros. Características sensoriales fundamentales de lotes de especialidad muy frescos o ligeramente tostados.',
        'it': 'Aromi floreali distinti e chiari. Caratteristiche sensoriali fondamentali dei lotti specialty molto freschi o tostati leggermente.',
        'pt': 'Aromas florais distintos e claros. Características sensoriais fundamentais de lotes de especialidade muito frescos ou levemente torrados.',
        'pl': 'Wyraźne i jasne aromaty kwiatowe. Podstawowe cechy sensoryczne bardzo świeżych lub jasnych partii specialty.',
        'nl': 'Duidelijke en heldere bloemige aroma\'s. Fundamentele sensorische kenmerken van zeer verse of licht gebrande specialty koffie.',
        'sv': 'Tydliga och klara blommiga aromer. Grundläggande sensoriska egenskaper hos mycket färskt eller ljusrostat specialkaffe.',
        'tr': 'Belirgin ve net çiçeksi aromalar. Çok taze veya hafif kavrulmuş nitelikli kahvelerin temel duyusal özellikleridir.',
        'ja': 'はっきりとした明確なフローラルな香り。非常に新鮮な、または浅煎りのスペシャルティコーヒーの基礎的な感覚的特徴です。',
        'ko': '뚜렷하고 선명한 꽃향기입니다. 매우 신선하거나 약배전된 스페셜티 커피의 기본적인 감각적 특징입니다.',
        'zh': '独特而清晰的花香。非常新鲜或浅度烘焙精品咖啡的基础感官特征。',
        'ar': 'روائح زهرية متميزة وواضحة. الخصائص الحسية الأساسية لمحاصيل القهوة المختصة الطازجة جداً أو المحمصة بشكل فاتح.',
    },
    'wheel_sub_berry': {
        'en': 'Tart and sweet notes of berries like blackberry or strawberry. Often indicates natural processing or high-altitude African origins.',
        'uk': 'Терпкі та солодкі ноти ягід, таких як ожина або полуниця. Часто вказує на натуральну обробку або високогірне африканське походження.',
        'de': 'Herbe und süße Noten von Beeren wie Brombeere oder Erdbeere. Deutet oft auf natürliche Aufbereitung oder afrikanische Herkunft hin.',
        'fr': 'Notes acidulées et sucrées de baies comme la mûre ou la fraise. Indique souvent un traitement naturel ou des origines africaines.',
        'es': 'Notas ácidas y dulces de bayas como la mora o la fresa. A menudo indica procesamiento natural u orígenes africanos.',
        'it': 'Note aspre e dolci di frutti di bosco come mora o fragola. Spesso indica lavorazione naturale o origini africane d\'alta quota.',
        'pt': 'Notas ácidas e doces de bagas como amora ou morango. Frequentemente indica processamento natural ou origens africanas.',
        'pl': 'Cierpkie i słodkie nuty jagód, takich jak jeżyna czy truskawka. Często wskazuje na obróbkę naturalną lub afrykańskie pochodzenie.',
        'nl': 'Zure en zoete tonen van bessen zoals braam of aardbei. Wijst vaak op natuurlijke verwerking of Afrikaanse herkomst.',
        'sv': 'Syrliga och söta toner av bär som björnbär eller jordgubbar. Indikerar ofta naturlig process eller afrikanskt ursprung.',
        'tr': 'Böğürtlen veya çilek gibi meyvelerin mayhoş ve tatlı notaları. Genellikle doğal işlemeyi veya yüksek rakımlı Afrika kökenlerini gösterir.',
        'ja': 'ブラックベリーやイチゴのようなベリー系の甘酸っぱい香り。ナチュラル精製や、標高の高いアフリカ産の豆によく見られます。',
        'ko': '블랙베리나 딸기와 같은 베리류의 새콤달콤한 노트입니다. 주로 내추럴 가공이나 고지대 아프리카 산지를 나타냅니다.',
        'zh': '黑莓或草莓等浆果的酸甜风味。通常代表日晒处理或高海拔非洲产区。',
        'ar': 'نوتات لاذعة وحلوة من التوت مثل التوت الأسود أو الفراولة. غالبًا ما تشير إلى المعالجة الطبيعية أو الأصول الأفريقية العالية.',
    },
}

def update_file(data):
    with open(FLAVOR_FILE, 'r', encoding='utf-8') as f:
        content = f.read()
    
    for key, val in data.items():
        pattern = re.compile(rf"'{key}':\s*\{{.*?\}}", re.DOTALL)
        replacement = f"'{key}': {{\n"
        # We use a specific order to match the style
        langs = ['en', 'uk', 'de', 'fr', 'es', 'it', 'pt', 'pl', 'nl', 'sv', 'tr', 'ja', 'ko', 'zh', 'ar']
        for lang in langs:
            if lang in val:
                text = val[lang].replace("'", "\\'")
                replacement += f"        '{lang}': '{text}',\n"
        replacement += "      }"
        content = pattern.sub(replacement, content)
    
    with open(FLAVOR_FILE, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f"Updated {len(data)} keys with full detail.")

if __name__ == '__main__':
    update_file(EXPANSION_DATA)
    # Also run the escaping fix script to be absolutely sure
    os.system(f'python scripts/fix_flavor_escaping.py')
