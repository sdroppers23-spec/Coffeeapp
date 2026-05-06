import re
import os

# Target file
FLAVOR_FILE = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

# Translation data
TRANSLATIONS = {
    'wheel_cat_floral': {
        'en': 'Delicate and aromatic notes reminiscent of blossoms. Often found in high-altitude coffees like Ethiopian Yirgacheffe or Gesha varieties.',
        'uk': 'Делікатні та ароматні ноти, що нагадують цвітіння. Часто зустрічаються у високогірній каві, такій як ефіопський Іргачефф або сорти Гейша.',
        'de': 'Zarte und aromatische Noten, die an Blüten erinnern. Oft in Hochlagenkaffees wie äthiopischem Yirgacheffe oder Gesha-Sorten zu finden.',
        'fr': 'Notes délicates et aromatiques rappelant les fleurs. Souvent présentes dans les cafés d\'altitude comme le Yirgacheffe éthiopien ou les variétés Gesha.',
        'es': 'Notas delicadas y aromáticas que recuerdan a las flores. A menudo se encuentran en cafés de gran altitud como el Yirgacheffe etíope o las variedades Gesha.',
        'it': 'Note delicate e aromatiche che ricordano i fiori. Spesso presenti nei caffè d\'alta quota come l\'Yirgacheffe etiope o le varietà Gesha.',
        'pt': 'Notas delicadas e aromáticas que lembram flores. Frequentemente encontradas em cafés de alta altitude, como o Yirgacheffe etíope ou variedades Gesha.',
        'pl': 'Delikatne i aromatyczne nuty przypominające kwiaty. Często spotykane w kawach wysokogórskich, takich jak etiopska Yirgacheffe czy odmiany Gesha.',
        'nl': 'Verfijnde en aromatische tonen die doen denken aan bloesems. Vaak te vinden in koffiesoorten van grote hoogte, zoals Ethiopische Yirgacheffe of Gesha-variëteiten.',
        'sv': 'Delikata och aromatiska toner som påminner om blommor. Finns ofta i kaffe från hög höjd, som etiopisk Yirgacheffe eller Gesha-varianter.',
        'tr': 'Çiçekleri anımsatan narin ve aromatik notalar. Genellikle Etiyopya Yirgacheffe veya Gesha çeşitleri gibi yüksek rakımlı kahvelerde bulunur.',
        'ja': '花を思わせる繊細で芳醇な香り。エチオピアのイルガチェフェやゲイシャ種など、標高の高い場所で栽培されたコーヒーによく見られます。',
        'ko': '꽃을 연상시키는 섬세하고 향긋한 노트입니다. 에티오피아 예가체프나 게이샤 품종과 같은 고지대 커피에서 주로 발견됩니다.',
        'zh': '令人联想到花朵的精致芳香。常见于埃塞俄比亚耶加雪菲或瑰夏等高海拔咖啡。',
        'ar': 'نوتات رقيقة وعطرية تذكرنا بالزهور. غالبًا ما توجد في القهوة المزروعة على ارتفاعات عالية مثل اليرغاتشيف الإثيوبية أو أصناف الغيشا.',
    },
    'wheel_cat_fruity': {
        'en': 'A broad range of sweet, tart, and juicy fruit characteristics. Indicates a vibrant acidity and complex sugar development.',
        'uk': 'Широкий спектр солодких, терпких та соковитих фруктових характеристик. Вказує на яскраву кислотність і складний розвиток цукрів.',
        'de': 'Ein breites Spektrum an süßen, säuerlichen und saftigen Fruchtcharakteristika. Deutet auf eine lebhafte Säure und komplexe Zuckerentwicklung hin.',
        'fr': 'Une large gamme de caractéristiques de fruits sucrés, acidulés et juteux. Indique une acidité vibrante et un développement complexe des sucres.',
        'es': 'Una amplia gama de características de frutas dulces, ácidas y jugosas. Indica una acidez vibrante y un desarrollo complejo de los azúcares.',
        'it': 'Un\'ampia gamma di caratteristiche di frutta dolce, aspra e succosa. Indica un\'acidità vibrante e un complesso sviluppo degli zuccheri.',
        'pt': 'Uma ampla gama de características de frutas doces, ácidas e suculentas. Indica uma acidez vibrante e um desenvolvimento complexo de açúcares.',
        'pl': 'Szeroka gama słodkich, cierpkich i soczystych cech owocowych. Wskazuje na żywą kwasowość i złożony rozwój cukrów.',
        'nl': 'Een breed scala aan zoete, zure en sappige fruitkenmerken. Wijst op een levendige aciditeit en complexe suikerontwikkeling.',
        'sv': 'Ett brett utbud av söta, syrliga och saftiga fruktkaraktärer. Indikerar en livlig syra och komplex sockerutveckling.',
        'tr': 'Tatlı, mayhoş ve sulu meyve özelliklerinin geniş bir yelpazesi. Canlı bir asidite ve karmaşık şeker gelişimini gösterir.',
        'ja': '甘み、酸味、ジューシーな果実味の幅広い特徴。鮮やかな酸味と複雑な糖分形成を示します。',
        'ko': '달콤하고 새콤하며 과즙이 풍부한 광범위한 과일 특성입니다. 활기찬 산미와 복합적인 당분 발달을 나타냅니다.',
        'zh': '涵盖甜、酸、多汁的水果特征。表现出明亮的酸度和复杂的糖分发育。',
        'ar': 'مجموعة واسعة من خصائص الفاكهة الحلوة واللاذعة والعصارية. تشير إلى حموضة نابضة بالحياة وتطور معقد للسكريات.',
    },
    'wheel_sub_berry': {
        'en': 'Tart and sweet notes of berries like blackberry or strawberry. Often indicates bright, playful acidity in natural processed lots.',
        'uk': 'Терпкі та солодкі ноти ягід, таких як ожина або полуниця. Часто вказує на яскраву, грайливу кислотність у лотах натуральної обробки.',
        'de': 'Herbe und süße Noten von Beeren wie Brombeere oder Erdbeere. Deutet oft auf eine helle, spielerische Säure in naturverarbeiteten Chargen hin.',
        'fr': 'Notes acidulées et sucrées de baies comme la mûre ou la fraise. Indique souvent une acidité vive et ludique dans les lots traités naturellement.',
        'es': 'Notas ácidas y dulces de bayas como la mora o la fresa. A menudo indica una acidez brillante y juguetona en lotes procesados al natural.',
        'it': 'Note aspre e dolci di frutti di bosco come mora o fragola. Spesso indica un\'acidità brillante e vivace nei lotti lavorati naturalmente.',
        'pt': 'Notas ácidas e doces de bagas como amora ou morango. Frequentemente indica uma acidez brilhante e divertida em lotes processados naturalmente.',
        'pl': 'Cierpkie i słodkie nuty jagód, takich jak jeżyna czy truskawka. Często wskazuje na jasną, zabawną kwasowość w partiach przetwarzanych naturalnie.',
        'nl': 'Zure en zoete tonen van bessen zoals braam of aardbei. Wijst vaak op een heldere, speelse aciditeit in natuurlijk verwerkte partijen.',
        'sv': 'Syrliga och söta toner av bär som björnbär eller jordgubbar. Indikerar ofta en ljus, lekfull syra i naturprocessade partier.',
        'tr': 'Böğürtlen veya çilek gibi meyvelerin mayhoş ve tatlı notaları. Genellikle doğal olarak işlenmiş partilerde parlak ve oyuncu bir asiditeyi gösterir.',
        'ja': 'ブラックベリーやイチゴのようなベリー系の甘酸っぱい香り。ナチュラル精製のロットによく見られる、明るく遊び心のある酸味を示します。',
        'ko': '블랙베리나 딸기와 같은 베리류의 새콤달콤한 노트입니다. 주로 내추럴 가공 랏에서 밝고 경쾌한 산미를 나타냅니다.',
        'zh': '黑莓或草莓等浆果的酸甜风味。通常代表日晒处理批次中明亮、活泼的酸度。',
        'ar': 'نوتات لاذعة وحلوة من التوت مثل التوت الأسود أو الفراولة. غالبًا ما تشير إلى حموضة ساطعة في الدفعات المعالجة طبيعيًا.',
    },
    'wheel_note_blackberry': {
        'en': 'Deep, juicy sweetness with a balanced tartness. Typical of high-altitude Kenyans and certain anaerobic Colombians.',
        'uk': 'Глибока, соковита солодкість зі збалансованою терпкістю. Типово для високогірних кенійських сортів та певних анаеробних колумбійських.',
        'de': 'Tiefe, saftige Süße mit einer ausgewogenen Herbe. Typisch für kenianische Hochlandkaffees und bestimmte anaerobe kolumbianische Kaffees.',
        'fr': 'Sucrosité profonde et juteuse avec une acidité équilibrée. Typique des cafés kenyans d\'altitude et de certains colombiens anaérobies.',
        'es': 'Dulzor profundo y jugoso con una acidez equilibrada. Típico de los cafés kenianos de gran altitud y ciertos colombianos anaeróbicos.',
        'it': 'Dolcezza profonda e succosa con un\'acidità equilibrata. Tipico dei caffè kenioti d\'alta quota e di alcuni colombiani anaerobici.',
        'pt': 'Doçura profunda e suculenta com uma acidez equilibrada. Típico de cafés quenianos de alta altitude e certos colombianos anaeróbicos.',
        'pl': 'Głęboka, soczysta słodycz ze zrównoważoną cierpkością. Typowa dla wysokogórskich kaw z Kenii i niektórych kolumbijskich kaw anaerobowych.',
        'nl': 'Diepe, sappige zoetheid met een gebalanceerde zurigheid. Typisch voor Keniaanse koffiesoorten van grote hoogte en bepaalde anaerobe Colombiaanse soorten.',
        'sv': 'Djup, saftig sötma med en balanserad syrlighet. Typiskt för kenyanskt kaffe från hög höjd och vissa anaeroba colombianska partier.',
        'tr': 'Dengeli bir mayhoşlukla derin, sulu tatlılık. Yüksek rakımlı Kenya kahvelerinin ve bazı anaerobik Kolombiya kahvelerinin tipik özelliğidir.',
        'ja': 'バランスの取れた酸味を伴う、深くジューシーな甘み。ケニアの高地産や、特定のコロンビア産アナエロビック（好気性発酵）に典型的です。strip',
        'ko': '균형 잡힌 산미와 함께 깊고 육즙이 풍부한 단맛입니다. 고지대 케냐 커피와 특정 무산소 발효 콜롬비아 커피에서 주로 나타납니다.',
        'zh': '浓郁多汁的甜味，伴有均衡的酸涩感。典型的肯尼亚高海拔咖啡及特定哥伦比亚厌氧批次特征。',
        'ar': 'حلاوة عميقة وعصارية مع حموضة متوازنة. نموذجي للقهوة الكينية من المرتفعات وبعض دفعات كولومبيا اللاهوائية.',
    },
    'wheel_note_blueberry': {
        'en': 'Distinctive, aromatic berry sweetness. The hallmark of high-quality natural processed Ethiopians, especially from Guji and Yirgacheffe.',
        'uk': 'Виразна, ароматна ягідна солодкість. Візитна картка високоякісних ефіопських сортів натуральної обробки, особливо з Гуджі та Іргачефф.',
        'de': 'Markante, aromatische Beerensüße. Das Markenzeichen hochwertiger naturverarbeiteter Äthiopier, insbesondere aus Guji und Yirgacheffe.',
        'fr': 'Sucrosité de baies distinctive et aromatique. La marque des éthiopiens de haute qualité traités naturellement, en particulier de Guji et Yirgacheffe.',
        'es': 'Dulzor de baya distintivo y aromático. El sello distintivo de los cafés etíopes de alta calidad procesados al natural, especialmente de Guji y Yirgacheffe.',
        'it': 'Dolcezza di frutti di bosco distintiva e aromatica. Il segno distintivo dei caffè etiopi di alta qualità lavorati naturalmente, specialmente di Guji e Yirgacheffe.',
        'pt': 'Doçura de bagas distintiva e aromática. A marca registrada de cafés etíopes de alta qualidade processados naturalmente, especialmente de Guji e Yirgacheffe.',
        'pl': 'Wyraźna, aromatyczna jagodowa słodycz. Wizytówka wysokiej jakości naturalnych kaw z Etiopii, szczególnie z regionów Guji i Yirgacheffe.',
        'nl': 'Kenmerkende, aromatische bessenzoetheid. Het handelsmerk van hoogwaardige natuurlijk verwerkte Ethiopische koffie, vooral uit Guji en Yirgacheffe.',
        'sv': 'Distinkt, aromatisk bärsötma. Kännetecknet för högkvalitativt naturprocessat etiopiskt kaffe, särskilt från Guji och Yirgacheffe.',
        'tr': 'Belirgin, aromatik meyve tatlılığı. Özellikle Guji ve Yirgacheffe\'den gelen yüksek kaliteli doğal işlenmiş Etiyopya kahvelerinin ayırt edici özelliğidir.',
        'ja': '特徴的で芳醇なベリーの甘み。高品質なエチオピア産のナチュラル精製、特にグジやイルガチェフェの代名詞的特徴です。',
        'ko': '특유의 향긋한 베리류 단맛입니다. 특히 구지와 예가체프 지역의 고품질 내추럴 에티오피아 커피의 상징적인 특징입니다.',
        'zh': '独特且芳香的浆果甜味。埃塞俄比亚高品质日晒咖啡（特别是古吉和耶加雪菲）的标志性特征。',
        'ar': 'حلاوة توت عطرية ومميزة. السمة المميزة للقهوة الإثيوبية عالية الجودة المعالجة طبيعيًا، خاصة من غوجي واليرغاتشيف.',
    },
    # ... I will add more in the actual script execution
}

def update_file():
    with open(FLAVOR_FILE, 'r', encoding='utf-8') as f:
        content = f.read()
    
    for key, langs in TRANSLATIONS.items():
        replacement = f"'{key}': {{\n"
        for lang, text in langs.items():
            escaped_text = text.replace("'", "\\'")
            replacement += f"        '{lang}': '{escaped_text}',\n"
        replacement += "      }"
        
        pattern = re.compile(rf"'{key}':\s*\{{.*?\}}", re.DOTALL)
        
        if pattern.search(content):
            content = pattern.sub(replacement, content)
            print(f"Updated {key}")
        else:
            # If not found, we could append it, but the structure is complex.
            # For now, let's just warn.
            print(f"Key {key} not found in file")

    with open(FLAVOR_FILE, 'w', encoding='utf-8') as f:
        f.write(content)

if __name__ == '__main__':
    update_file()
