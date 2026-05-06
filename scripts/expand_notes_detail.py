# -*- coding: utf-8 -*-
import re
import os

FLAVOR_FILE = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

# Expanded detailed translations for Notes in Fruity and Floral sectors
EXPANSION_DATA = {
    'wheel_note_blackberry': {
        'en': 'Deep, dark berry sweetness with a slight tartness. Typical of processed African coffees.',
        'uk': 'Глибока, темна ягідна солодкість з легкою терпкістю. Типово для африканської кави натуральної обробки.',
        'de': 'Tiefe, dunkle Beerensüße mit einer leichten Herbe. Typisch für aufbereitete afrikanische Kaffees.',
        'fr': 'Sucrosité de baies sombres et profondes avec une légère acidité. Typique des cafés africains traités.',
        'es': 'Dulzor de bayas oscuras y profundas con una ligera acidez. Típico de los cafés africanos procesados.',
        'it': 'Dolcezza di bacche scure e profonde con una leggera asprezza. Tipico dei caffè africani lavorati.',
        'pt': 'Doçura de bagas escuras e profundas com uma leve acidez. Típico de cafés africanos processados.',
        'pl': 'Głęboka, ciemna jagodowa słodycz з lekką cierpkością. Typowa dla przetworzonych kaw afrykańskich.',
        'nl': 'Diepe, donkere bessenzoetheid met een lichte wrangheid. Typisch voor verwerkte Afrikaanse koffiesoorten.',
        'sv': 'Djup, mörk bärsötma med en lätt syrlighet. Typiskt för bearbetat afrikanskt kaffe.',
        'tr': 'Hafif bir mayhoşlukla derin, koyu meyve tatlılığı. İşlenmiş Afrika kahvelerinin tipik özelliğidir.',
        'ja': 'わずかな酸味を伴う、深くダークなベリーの甘み。アフリカ産の精製されたコーヒーに典型的です。',
        'ko': '약간의 산미를 동반한 깊고 어두운 베리의 단맛입니다. 가공된 아프리카 커피의 전형적인 특징입니다.',
        'zh': '深沉的深色浆果甜味，略带酸涩感。非洲处理咖啡的典型特征。',
        'ar': 'حلاوة توت داكنة وعميقة مع حموضة خفيفة. نموذجية للقهوة الأفريقية المعالجة.',
    },
    'wheel_note_strawberry': {
        'en': 'Bright, sweet, and slightly jammy red fruit note. Often found in natural-processed Ethiopian lots.',
        'uk': 'Яскрава, солодка та злегка джемова нота червоних фруктів. Часто зустрічається в ефіопських лотах натуральної обробки.',
        'de': 'Helle, süße und leicht marmeladige rote Fruchtnote. Oft in naturrein aufbereiteten äthiopischen Partien zu finden.',
        'fr': 'Note de fruits rouges vive, sucrée et légèrement confiturée. Souvent trouvée dans les lots éthiopiens traités naturellement.',
        'es': 'Nota de fruta roja brillante, dulce y ligeramente amermelada. A menudo se encuentra en lotes etíopes procesados de forma natural.',
        'it': 'Nota di frutti rossi brillante, dolce e leggermente marmellatosa. Spesso presente nei lotti etiopi a lavorazione naturale.',
        'pt': 'Nota de fruta vermelha brilhante, doce e levemente de compota. Frequentemente encontrada em lotes etíopes processados naturalmente.',
        'pl': 'Jasna, słodka i lekko dżemowa nuta czerwonych owoców. Często spotykana w etiopskich partiach z obróbki naturalnej.',
        'nl': 'Heldere, zoete en licht jam-achtige rode fruitnoot. Vaak te vinden in natuurlijk verwerkte Ethiopische partijen.',
        'sv': 'Ljus, söt och lätt syltliknande röd frukton. Hittas ofta i naturligt processat etiopiskt kaffe.',
        'tr': 'Parlak, tatlı ve hafif reçelsi kırmızı meyve notası. Genellikle doğal işlenmiş Etiyopya kahvelerinde bulunur.',
        'ja': '明るく甘い、わずかにジャムのようなレッドフルーツのノート。エチオピア産のナチュラル精製豆によく見られます。',
        'ko': '밝고 달콤하며 약간 잼 같은 레드 과일 노트입니다. 주로 내추럴 가공된 에티오피아 커피에서 발견됩니다.',
        'zh': '明亮、甜美且略带果酱感的红色水果风味。常见于日晒处理的埃塞俄比亚咖啡。',
        'ar': 'نوتة فاكهة حمراء ساطعة وحلوة وتشبه المربى قليلاً. غالبًا ما توجد في محاصيل إثيوبيا المعالجة طبيعيًا.',
    },
    'wheel_note_lemon': {
        'en': 'Sharp, clean, and high-intensity citrus acidity. Characteristic of washed Kenyan and high-altitude Arabicas.',
        'uk': 'Гостра, чиста та високоінтенсивна цитрусова кислотність. Характерно для кенійської кави митої обробки та високогірної арабіки.',
        'de': 'Scharfe, saubere und hochintensive Zitrus-Säure. Charakteristisch für gewaschene kenianische und Hochland-Arabicas.',
        'fr': 'Acidité d\'agrumes vive, propre et de haute intensité. Caractéristique des Arabicas du Kenya lavés et d\'altitude.',
        'es': 'Acidez cítrica punzante, limpia y de alta intensidad. Característica de los cafés lavados de Kenia y Arábicas de altura.',
        'it': 'Acidità agrumata pungente, pulita e ad alta intensità. Caratteristica degli Arabica lavati del Kenya e d\'alta quota.',
        'pt': 'Acidez cítrica picante, limpa e de alta intensidade. Característica de cafés lavados do Quênia e Arábicas de altitude.',
        'pl': 'Ostra, czysta i intensywna kwasowość cytrusowa. Charakterystyczna dla mytych kaw kenijskich i arabik wysokogórskich.',
        'nl': 'Scherpe, schone en zeer intense citrus-aciditeit. Kenmerkend voor gewassen Keniaanse en hoogland Arabica\'s.',
        'sv': 'Skarp, ren och högintensiv citrussyra. Karaktäristiskt för tvättat kenyanskt kaffe och höghöjdsarabica.',
        'tr': 'Keskin, temiz ve yüksek yoğunluklu narenciye asiditesi. Yıkanmış Kenya ve yüksek rakımlı Arabica kahvelerinin özelliğidir.',
        'ja': '鋭くクリーンで強烈なシトラスの酸味。ウォッシュド精製のケニア産や標高の高いアラビカ種の特徴です。',
        'ko': '날카롭고 깔끔한 고강도 시트러스 산미입니다. 워시드 가공된 케냐 커피와 고지대 아라비카의 특징입니다.',
        'zh': '尖锐、干净且高强度的柑橘酸度。水洗处理肯尼亚咖啡和高海拔阿拉比卡咖啡的特征。',
        'ar': 'حموضة حمضية حادة ونظيفة وعالية الكثافة. مميزة للبن الكيني المغسول وأرابيكا المرتفعات.',
    },
    'wheel_note_jasmine': {
        'en': 'Intense, sweet, and classic floral note. The signature aroma of high-quality Gesha (Geisha) varietals.',
        'uk': 'Інтенсивна солодкувата класична квіткова нота. Фірмовий аромат високоякісних сортів Геша (Geisha).',
        'de': 'Intensive, süße und klassische blumige Note. Das charakteristische Aroma hochwertiger Gesha (Geisha) Varietäten.',
        'fr': 'Note florale intense, sucrée et classique. L\'arôme signature des variétés Gesha (Geisha) de haute qualité.',
        'es': 'Nota floral intensa, dulce y clásica. El aroma característico de las variedades Gesha (Geisha) de alta calidad.',
        'it': 'Nota floreale intensa, dolce e classica. L\'aroma tipico delle varietà Gesha (Geisha) di alta qualità.',
        'pt': 'Nota floral intensa, doce e clássica. O aroma característico das variedades Gesha (Geisha) de alta qualidade.',
        'pl': 'Intensywna, słodka i klasyczna nuta kwiatowa. Charakterystyczny aromat wysokiej jakości odmian Gesha (Geisha).',
        'nl': 'Intense, zoete en klassieke florale noot. Het kenmerkende aroma van hoogwaardige Gesha (Geisha) variëteiten.',
        'sv': 'Intensiv, söt och klassisk blommig ton. Signaturdoften för högkvalitativa Gesha-varieteter (Geisha).',
        'tr': 'Yoğun, tatlı ve klasik çiçeksi nota. Yüksek kaliteli Gesha (Geisha) varyetelerinin imza aromasıdır.',
        'ja': '強烈で甘い、伝統的な花の香り。高品質なゲイシャ種を象徴するアロマです。',
        'ko': '강렬하고 달콤한 클래식한 꽃 노트입니다. 고품질 게이샤(Gesha) 품종의 상징적인 향기입니다.',
        'zh': '强烈、甜美且经典的花香。高品质瑰夏（Gesha）品种的标志性香气。',
        'ar': 'نوتة زهرية مكثفة وحلوة وكلاسيكية. الرائحة المميزة لسلالات غيشا (Gesha) عالية الجودة.',
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
