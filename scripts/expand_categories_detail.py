# -*- coding: utf-8 -*-
import re
import os

FLAVOR_FILE = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

EXPANSION_DATA = {
    'wheel_cat_roasted': {
        'en': 'Savory and deep notes resulting from the Maillard reaction and caramelization during roasting. These range from toasted bread to smoky accents. Typically associated with medium to dark roast profiles.',
        'uk': 'Пікантні та глибокі ноти, що виникають внаслідок реакції Майяра та карамелізації під час обсмажування. Вони варіюються від підсмаженого хліба до димних акцентів. Зазвичай асоціюються з профілями середнього та темного обсмаження.',
        'de': 'Herzhafte und tiefe Noten, die durch die Maillard-Reaktion und Karamellisierung während des Röstens entstehen. Diese reichen von getoastetem Brot bis hin zu rauchigen Akzenten.',
        'fr': 'Notes savoureuses et profondes résultant de la réaction de Maillard et de la caramélisation pendant la torréfaction. Celles-ci vont du pain grillé aux accents fumés.',
        'es': 'Notas sabrosas y profundas resultantes de la reacción de Maillard y la caramelización durante el tueste. Estas van desde el pan tostado hasta acentos ahumados.',
        'it': 'Note sapide e profonde derivanti dalla reazione di Maillard e dalla caramellizzazione durante la tostatura. Queste vanno dal pane tostato agli accenti affumicati.',
        'pt': 'Notas saborosas e profundas resultantes da reação de Maillard e da caramelização durante a torra. Estas variam desde pão torrado até acentos defumados.',
        'pl': 'Wytrawne i głębokie nuty wynikające z reakcji Maillarda i karmelizacji podczas palenia. Obejmują one smaki od grzanki po akcenty dymne.',
        'nl': 'Hartige en diepe tonen die het resultaat zijn van de Maillard-reactie en karamelisatie tijdens het branden. Deze variëren van geroosterd brood tot rokerige accenten.',
        'sv': 'Fylliga och djupa toner som uppstår genom Maillard-reaktionen och karamellisering under rostningen. Dessa sträcker sig från rostat bröd till rökiga accenter.',
        'tr': 'Kavurma sırasında Maillard reaksiyonu ve karamelizasyon sonucu oluşan derin notalar. Bunlar kızarmış ekmekten isli vurgulara kadar uzanır.',
        'ja': '焙煎中のメイラード反応とキャラメル化によって生じる、芳醇で深いノート。トーストしたパンからスモーキーなアクセントまで多岐にわたります。',
        'ko': '로스팅 과정 중 마야르 반응과 캐러멜화로 인해 발생하는 깊고 풍부한 노트입니다. 구운 빵부터 스모키한 느낌까지 다양합니다.',
        'zh': '烘焙过程中梅拉德反应和焦糖化产生的深沉风味。范围从烤面包到烟熏气息。',
        'ar': 'نوتات عميقة ناتجة عن تفاعل مايار والكرملة أثناء التحميص. تتراوح هذه النوتات من الخبز المحمص إلى لمسات دخانية.',
    },
    'wheel_cat_spices': {
        'en': 'Aromatic and pungent sensory notes, often associated with processing or the natural chemistry of the bean. Ranges from sweet brown spices like cinnamon to spicy pepper.',
        'uk': 'Ароматні та гострі сенсорні ноти, часто пов’язані з обробкою або природною хімією зерна. Варіюються від солодких темних спецій, таких як кориця, до гострого перцю.',
        'de': 'Aromatische und scharfe sensorische Noten, oft verbunden mit der Aufbereitung. Reicht von süßen braunen Gewürzen wie Zimt bis zu scharfem Pfeffer.',
        'fr': 'Notes sensorielles aromatiques et piquantes, souvent associées au traitement. Allant des épices brunes sucrées comme la cannelle au poivre épicé.',
        'es': 'Notas sensoriales aromáticas y picantes, a menudo asociadas con el procesamiento. Varía desde especias marrones dulces como la canela hasta la pimienta picante.',
        'it': 'Note sensoriali aromatiche e pungenti, spesso associate alla lavorazione. Spazia dalle dolci spezie scure come la cannella al pepe piccante.',
        'pt': 'Notas sensoriais aromáticas e picantes, frequentemente associadas ao processamento. Varia de especiarias marrons doces, como canela, a pimenta picante.',
        'pl': 'Aromatyczne i ostre nuty sensoryczne, często związane z obróbką. Obejmują od słodkich brązowych przypraw, takich jak cynamon, po ostry pieprz.',
        'nl': 'Aromatische en pittige sensorische tonen, vaak geassocieerd met de verwerking. Varieert van zoete bruine kruiden zoals kaneel tot pittige peper.',
        'sv': 'Aromatiska och stickande sensoriska toner, ofta förknippade med bearbetningen. Sträcker sig från söta bruna kryddor som kanel till stark peppar.',
        'tr': 'Genellikle işleme ile ilişkili aromatik ve keskin duyusal notalar. Tarçın gibi tatlı kahverengi baharatlardan acı bibere kadar uzanır.',
        'ja': '精製過程に関連することが多い、芳醇で刺激的なノート。シナモンのような甘いスパイスから、スパイシーなペッパーまで含まれます。',
        'ko': '가공 방식과 관련된 향긋하고 톡 쏘는 감각적 노트입니다. 시나몬 같은 달콤한 브라운 스파이스부터 매콤한 후추까지 다양합니다.',
        'zh': '芳香且辛辣的感官风味，通常与处理工艺有关。从肉桂等甜香料到辛辣的胡椒。',
        'ar': 'نوتات حسية عطرية ولاذعة، غالبًا ما ترتبط بالمعالجة. تتراوح من التوابل البنية الحلوة مثل القرفة إلى الفلفل الحار.',
    },
    'wheel_cat_nutty_cocoa': {
        'en': 'Deep, comforting notes of toasted nuts and chocolate. These are fundamental to many classic coffee profiles and often represent high sweetness and low acidity.',
        'uk': 'Глибокі, затишні ноти смажених горіхів та шоколаду. Вони є основоположними для багатьох класичних профілів кави і часто представляють високу солодкість та низьку кислотність.',
        'de': 'Tiefe, wohlige Noten von gerösteten Nüssen und Schokolade. Diese sind grundlegend für viele klassische Kaffeeprofile.',
        'fr': 'Notes profondes et réconfortantes de noix grillées et de chocolat. Celles-ci sont fondamentales pour de nombreux profils de café classiques.',
        'es': 'Notas profundas y reconfortantes de frutos secos tostados y chocolate. Estas son fundamentales para muchos perfiles de café clásicos.',
        'it': 'Note profonde e confortevoli di frutta secca tostata e cioccolato. Fondamentali per molti profili di caffè classici.',
        'pt': 'Notas profundas e confortantes de nozes torradas e chocolate. Estas são fundamentais para muitos perfis de café clássicos.',
        'pl': 'Głębokie, pocieszające nuty prażonych orzechów i czekolady. Są one podstawą wielu klasycznych profili kawowych.',
        'nl': 'Diepe, vertrouwde tonen van geroosterde noten en chocolade. Deze vormen de basis voor veel klassieke koffieprofielen.',
        'sv': 'Djupa och trygga toner av rostade nötter och choklad. Dessa är grundläggande för många klassiska kaffeprofiler.',
        'tr': 'Kavrulmuş fındık ve çikolatanın derin, rahatlatıcı notaları. Bunlar birçok klasik kahve profilinin temelidir.',
        'ja': 'ローストしたナッツやチョコレートの、深く心地よいノート。多くの伝統的なコーヒーの特徴であり、高い甘みと低い酸味を表現します。',
        'ko': '구운 견과류와 초콜릿의 깊고 편안한 노트입니다. 많은 클래식한 커피 프로필의 기본이며, 높은 단맛과 낮은 산미를 나타냅니다.',
        'zh': '深沉、舒适的烤坚果和巧克力风味。这是许多经典咖啡风味的基础，代表了高甜度和低酸度。',
        'ar': 'نوتات عميقة ومريحة من المكسرات المحمصة والشوكولاتة. هذه النوتات أساسية للعديد من ملفات القهوة الكلاسيكية.',
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
    print(f"Updated {len(data)} categories with full detail.")

if __name__ == '__main__':
    update_file(EXPANSION_DATA)
    os.system(f'python scripts/fix_flavor_escaping.py')
