# -*- coding: utf-8 -*-
import re
import os

FLAVOR_FILE = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

BATCH5 = {
    'wheel_sub_dried_fruit': {
        'en': 'Concentrated, jammy sweetness reminiscent of raisins or dates. Often the result of over-ripening or natural sun-drying.',
        'uk': 'Концентрована, джемова солодкість, що нагадує родзинки або фініки. Часто є результатом перезрівання або натуральної сушки.',
        'de': 'Konzentrierte, marmeladige Süße, die an Rosinen oder Datteln erinnert. Oft das Ergebnis von Überreife.',
        'fr': 'Sucrosité concentrée et confiturée rappelant les raisins secs ou les dattes.',
        'es': 'Dulzor concentrado y amermelado que recuerda a pasas o dátiles.',
        'it': 'Dolcezza concentrata e marmellatosa che ricorda l\'uva passa o i datteri.',
        'pt': 'Doçura concentrada e de compota que lembra passas ou tâmaras.',
        'pl': 'Skoncentrowana, dżemowa słodycz przypominająca rodzynki lub daktyle.',
        'nl': 'Geconcentreerde, jam-achtige zoetheid die doet denken aan rozijnen of dadels.',
        'sv': 'Koncentrerad, syltliknande sötma som påminner om russin eller dadlar.',
        'tr': 'Kuru üzüm veya hurmayı anımsatan konsantre, reçelsi tatlılık.',
        'ja': 'レーズンやデーツを思わせる、濃縮されたジャムのような甘み。',
        'ko': '건포도나 대추야자를 연상시키는 농축된 잼 같은 단맛입니다.',
        'zh': '浓缩的、如酱般的甜味，令人联想到葡萄干或枣。',
        'ar': 'حلاوة مركزة تشبه المربى تذكرنا بالزبيب أو التمر.',
    },
    'wheel_sub_other_fruit': {
        'en': 'Tropical or temperate fruit notes like apple, pear, or mango. Represents intermediate acidity levels.',
        'uk': 'Ноти тропічних або фруктів помірного клімату, таких як яблуко, груша або манго. Представляє середні рівні кислотності.',
        'de': 'Tropische oder gemäßigte Fruchtnoten wie Apfel, Birne oder Mango. Repräsentiert mittlere Säuregrade.',
        'fr': 'Notes de fruits tropicaux ou tempérés comme la pomme, la poire ou la mangue.',
        'es': 'Notas de frutas tropicales o de clima templado como manzana, pera o mango.',
        'it': 'Note di frutta tropicale o temperata come mela, pera o mango.',
        'pt': 'Notas de frutas tropicais ou temperadas, como maçã, pêra ou manga.',
        'pl': 'Nuty owoców tropikalnych lub umiarkowanych, takich jak jabłko, gruszka lub mango.',
        'nl': 'Tropische of gematigde fruitnoten zoals appel, peer of mango.',
        'sv': 'Tropiska eller tempererade fruktoner som äpple, päron eller mango.',
        'tr': 'Elma, armut veya mango gibi tropikal veya ılıman meyve notaları.',
        'ja': 'リンゴ、梨、マンゴーなどのトロピカルまたは温帯の果物のノート。',
        'ko': '사과, 배 또는 망고와 같은 열대 또는 온대 과일 노트입니다.',
        'zh': '热带或温带水果风味，如苹果、梨或芒果。',
        'ar': 'نوتات فاكهة استوائية أو معتدلة مثل التفاح أو الكمثرى أو المانجو.',
    },
    'wheel_sub_tea': {
        'en': 'Clean, structured notes reminiscent of black, green, or herbal teas. Often accompanied by a pleasant tannin-like mouthfeel.',
        'uk': 'Чисті, структуровані ноти, що нагадують чорний, зелений або трав’яні чаї. Часто супроводжуються приємним таніновим відчуттям.',
        'de': 'Saubere, strukturierte Noten, die an schwarzen, grünen oder Kräutertee erinnern. Oft mit angenehmem Tanningefühl.',
        'fr': 'Notes propres et structurées rappelant le thé noir, vert ou les infusions.',
        'es': 'Notas limpias y estructuradas que recuerdan al té negro, verde o herbal.',
        'it': 'Note pulite e strutturate che ricordano il tè nero, verde o le tisane.',
        'pt': 'Notas limpas e estruturadas que lembram chás pretos, verdes ou de ervas.',
        'pl': 'Czyste, strukturalne nuty przypominające herbatę czarną, zieloną lub ziołową.',
        'nl': 'Schone, gestructureerde tonen die doen denken aan zwarte, groene of kruidenthee.',
        'sv': 'Rena, strukturerade toner som påminner om svart, grönt eller örtte.',
        'tr': 'Siyah, yeşil veya bitki çaylarını anımsatan temiz, yapılandırılmış notalar.',
        'ja': '紅茶、緑茶、ハーブティーを思わせる、クリーンで構造的なノート。',
        'ko': '홍차, 녹차 또는 허브차를 연상시키는 깔끔하고 구조적인 노트입니다.',
        'zh': '令人联想到红茶、绿茶或草本茶的干净、有结构感的风味。',
        'ar': 'نوتات نظيفة وبنيوية تذكرنا بالشاي الأسود أو الأخضر أو العشبي.',
    },
    'wheel_sub_sweet_aromatics': {
        'en': 'Encompasses fragrances like vanilla, honey, or creamy candy. These are often the result of light to medium roasting.',
        'uk': 'Охоплює такі аромати, як ваніль, мед або вершкові цукерки. Часто є результатом світлого або середнього обсмажування.',
        'de': 'Umfasst Düfte wie Vanille, Honig oder cremige Süßigkeiten. Oft das Ergebnis heller Röstung.',
        'fr': 'Comprend des parfums comme la vanille, le miel ou les bonbons crémeux.',
        'es': 'Abarca fragancias como vainilla, miel o caramelos cremosos.',
        'it': 'Comprende fragranze come vaniglia, miele o caramelle cremose.',
        'pt': 'Abrange fragrâncias como baunilha, mel ou doces cremosos.',
        'pl': 'Obejmuje zapachy takie jak wanilia, miód lub kremowe cukierki.',
        'nl': 'Omvat geuren zoals vanille, honing of romig snoepgoed.',
        'sv': 'Innefattar dofter som vanilj, honung eller krämigt godis.',
        'tr': 'Vanilya, bal veya kremsi şekerleme gibi kokuları kapsar.',
        'ja': 'バニラ、蜂蜜、クリーミーなキャンディのような香り。',
        'ko': '바닐라, 꿀 또는 크리미한 사탕과 같은 향을 포함합니다.',
        'zh': '包含香草、蜂蜜或奶油糖果等香气。',
        'ar': 'تشمل روائح مثل الفانيليا أو العسل أو الحلوى الكريمية.',
    },
    'wheel_sub_sugar_brown': {
        'en': 'Rich, caramelized sweetness ranging from light cane sugar to deep molasses. Key component of a balanced cup.',
        'uk': 'Насичена карамелізована солодкість, від світлого тростинного цукру до глибокої патоки. Ключовий компонент збалансованої чашки.',
        'de': 'Reiche, karamellisierte Süße von hellem Rohrzucker bis zu dunkler Melasse.',
        'fr': 'Sucrosité riche et caramélisée allant du sucre de canne clair à la mélasse profonde.',
        'es': 'Dulzor rico y caramelizado que va desde el azúcar de caña claro hasta la melaza profunda.',
        'it': 'Ricca dolcezza caramellata che va dallo zucchero di canna chiaro alla melassa profonda.',
        'pt': 'Doçura rica e caramelizada, variando de açúcar de cana claro a melaço profundo.',
        'pl': 'Bogata, skarmelizowana słodycz od jasnego cukru trzcinowego po gęstą melasę.',
        'nl': 'Rijke, gekaramelliseerde zoetheid variërend van lichte rietsuiker tot diepe melasse.',
        'sv': 'Rik, karamelliserad sötma från ljust rörsocker till mörk melass.',
        'tr': 'Açık kamış şekerinden koyu pekmeze kadar uzanan zengin, karamelize tatlılık.',
        'ja': 'ライトなサトウキビ糖から深い糖蜜まで、豊かなキャラメル状の甘み。',
        'ko': '연한 사탕수수 설탕부터 깊은 당밀까지 아우르는 풍부한 캐러멜 단맛입니다.',
        'zh': '浓郁的焦糖味，从浅色蔗糖到深色糖蜜。',
        'ar': 'حلاوة كراميل غنية تتراوح من سكر القصب الفاتح إلى الدبس العميق.',
    },
    'wheel_sub_nutty': {
        'en': 'Classic nut-like flavors such as almond, hazelnut, or peanut. Common in Brazilian and Colombian coffees.',
        'uk': 'Класичні горіхові смаки, такі як мигдаль, фундук або арахіс. Поширені в бразильській та колумбійській каві.',
        'de': 'Klassische nussige Aromen wie Mandel, Haselnuss oder Erdnuss.',
        'fr': 'Saveurs classiques de noix telles que l\'amande, la noisette ou la cacahuète.',
        'es': 'Sabores clásicos a frutos secos como almendra, avellana o cacahuete.',
        'it': 'Classici sapori di frutta secca come mandorla, nocciola o arachide.',
        'pt': 'Sabores clássicos de nozes, como amêndoa, avelã ou amendoim.',
        'pl': 'Klasyczne smaki orzechowe, takie jak migdał, orzech laskowy lub orzeszek ziemny.',
        'nl': 'Klassieke nootachtige smaken zoals amandel, hazelnoot of pinda.',
        'sv': 'Klassiska nötsmaker som mandel, hasselnöt eller jordnöt.',
        'tr': 'Badem, fındık veya yer fıstığı gibi klasik fındıksı tatlar.',
        'ja': 'アーモンド、ヘーゼルナッツ、ピーナッツのような伝統的なナッツの風味。',
        'ko': '아몬드, 헤이즐넛 또는 땅콩과 같은 클래식한 견과류 풍미입니다.',
        'zh': '经典的坚果风味，如杏仁、榛子或花生。',
        'ar': 'نكهات المكسرات الكلاسيكية مثل اللوز أو البندق أو الفول السوداني.',
    },
    'wheel_sub_cocoa': {
        'en': 'Notes of chocolate, from sweet milk chocolate to bitter dark cocoa. Often associated with the body and roast level.',
        'uk': 'Ноти шоколаду, від солодкого молочного до гіркого темного какао. Часто асоціюються з тілом і рівнем обсмажування.',
        'de': 'Schokoladennoten, von süßer Milchschokolade bis zu bitterem dunklem Kakao.',
        'fr': 'Notes de chocolat, du chocolat au lait sucré au cacao noir amer.',
        'es': 'Notas de chocolate, desde el dulce chocolate con leche hasta el cacao amargo.',
        'it': 'Note di cioccolato, dal dolce cioccolato al latte al cacao amaro fondente.',
        'pt': 'Notas de chocolate, do chocolate ao leite doce ao cacau amargo.',
        'pl': 'Nuty czekolady, od słodkiej mlecznej po gorzkie ciemne kakao.',
        'nl': 'Chocoladetonen, van zoete melkchocolade tot bittere pure cacao.',
        'sv': 'Chokladtoner, från söt mjölkchoklad till bitter mörk kakao.',
        'tr': 'Tatlı sütlü çikolatadan acı koyu kakaoya kadar çikolata notaları.',
        'ja': 'ミルクチョコレートの甘みからビターなダークカカオまで。',
        'ko': '달콤한 밀크 초콜릿부터 쌉싸름한 다크 카카오까지 초콜릿의 노트입니다.',
        'zh': '巧克力风味，从甜牛奶巧克力到苦黑可可。',
        'ar': 'نوتات الشوكولاتة، من شوكولاتة الحليب الحلوة إلى الكاكاو الداكن المر.',
    },
}

def update_file(data):
    with open(FLAVOR_FILE, 'r', encoding='utf-8') as f:
        content = f.read()
    
    for key, val in data.items():
        # Match both multiline and single line formats
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
    update_file(BATCH5)
