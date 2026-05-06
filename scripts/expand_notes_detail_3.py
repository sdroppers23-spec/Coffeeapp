# -*- coding: utf-8 -*-
import re
import os

FLAVOR_FILE = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

EXPANSION_DATA = {
    'wheel_note_apple': {
        'en': 'Crisp acidity and clean sweetness reminiscent of fresh apples. Often indicates malic acidity in the cup.',
        'uk': 'Хрустка кислотність і чиста солодкість, що нагадує свіжі яблука. Часто вказує на яблучну кислотність у чашці.',
        'de': 'Knackige Säure und saubere Süße, die an frische Äpfel erinnert. Deutet oft auf Apfelsäure in der Tasse hin.',
        'fr': 'Acidité croquante et sucrosité propre rappelant les pommes fraîches. Indique souvent une acidité malique.',
        'es': 'Acidez crujiente y dulzor limpio que recuerda a las manzanas frescas. A menudo indica acidez málica.',
        'it': 'Acidità croccante e dolcezza pulita che ricorda le mele fresche. Spesso indica acidità malica in tazza.',
        'pt': 'Acidez nítida e doçura limpa que lembra maçãs frescas. Frequentemente indica acidez málica.',
        'pl': 'Rześka kwasowość i czysta słodycz przypominająca świeże jabłka. Często wskazuje на obecność kwasu jabłkowego.',
        'nl': 'Frisse aciditeit en schone zoetheid die doet denken aan verse appels. Wijst vaak op appelzuur in de kop.',
        'sv': 'Krispig syra och ren sötma som påminner om färska äpplen. Indikerar ofta äppelsyra i koppen.',
        'tr': 'Taze elmaları anımsatan gevrek asidite ve temiz tatlılık. Genellikle fincandaki malik asiditeyi gösterir.',
        'ja': '新鮮なリンゴを思わせる、キレのある酸味とクリーンな甘み。カップにリンゴ酸が含まれていることを示します。',
        'ko': '신선한 사과를 연상시키는 아삭한 산미와 깔끔한 단맛입니다. 주로 사과산(malic acidity)을 나타냅니다.',
        'zh': '爽脆的酸度和干净的甜味，令人联想到新鲜苹果。通常代表杯中含有苹果酸。',
        'ar': 'حموضة هشة وحلاوة نظيفة تذكرنا بالتفاح الطازج. غالبًا ما تشير إلى حموضة التفاح في الكوب.',
    },
    'wheel_note_pear': {
        'en': 'Subtle, clean fruit sweetness with a slight grainy texture. Represents delicate, balanced acidity.',
        'uk': 'Тонка чиста фруктова солодкість із легкою зернистою текстурою. Представляє делікатну, збалансовану кислотність.',
        'de': 'Subtile, saubere Fruchtsüße mit einer leicht körnigen Textur. Repräsentiert eine zarte, ausgewogene Säure.',
        'fr': 'Sucrosité fruitée subtile et propre avec une texture légèrement granuleuse. Représente une acidité délicate.',
        'es': 'Dulzor frutal sutil y limpio con una ligera textura granulada. Representa una acidez delicada y equilibrada.',
        'it': 'Sottile e pulita dolcezza fruttata con una leggera consistenza granulosa. Rappresenta un\'acidità delicata.',
        'pt': 'Doçura frutada sutil e limpa com uma leve textura granulada. Representa uma acidez delicada e equilibrada.',
        'pl': 'Subtelna, czysta owocowa słodycz o lekko ziarnistej teksturze. Reprezentuje delikatną, zrównoważoną kwasowość.',
        'nl': 'Subtiele, schone fruitzoetheid met een licht korrelige textuur. Staat voor een delicate, evenwichtige aciditeit.',
        'sv': 'Subtil, ren fruktsötma med en lätt grynig textur. Representerar en delikat och balanserad syra.',
        'tr': 'Hafif grenli dokusuyla ince, temiz meyve tatlılığı. Narin ve dengeli bir asiditeyi temsil eder.',
        'ja': 'わずかにザラつきのある質感、繊細でクリーンな果実の甘み。繊細でバランスの取れた酸味を表現しています。',
        'ko': '약간의 거친 질감을 동반한 미묘하고 깔끔한 과일 단맛입니다. 섬세하고 균형 잡힌 산미를 나타냅니다.',
        'zh': '细致、干净的水果甜味，带有轻微的沙质感。代表了细腻且平衡的酸度。',
        'ar': 'حلاوة فاكهة رقيقة ونظيفة مع ملمس محبب قليلاً. تمثل حموضة رقيقة ومتوازنة.',
    },
    'wheel_note_peach': {
        'en': 'Soft, delicate stone fruit sweetness. Hallmark of certain washed Ethiopian and Colombian coffees.',
        'uk': 'М\'яка, ніжна солодкість кісточкових фруктів. Ознака деяких митих ефіопських та колумбійських лотів.',
        'de': 'Weiche, zarte Steinobstsüße. Markenzeichen bestimmter gewaschener äthiopischer und kolumbianischer Kaffees.',
        'fr': 'Sucrosité de fruit à noyau douce et délicate. Marque de fabrique de certains cafés éthiopiens et colombiens lavés.',
        'es': 'Dulzor de fruta de hueso suave y delicado. Característica de ciertos cafés lavados etíopes y colombianos.',
        'it': 'Dolcezza di drupacee morbida e delicata. Segno distintivo di alcuni caffè etiopi e colombiani lavati.',
        'pt': 'Doçura de fruta de caroço suave e delicada. Marca registrada de certos cafés lavados etíopes e colombianos.',
        'pl': 'Miękka, delikatna słodycz owoców pestkowych. Charakterystyczna dla niektórych mytych kaw etiopskich i kolumbijskich.',
        'nl': 'Zachte, delicate steenvruchtzoetheid. Kenmerk van bepaalde gewassen Ethiopische en Colombiaanse koffies.',
        'sv': 'Mjuk, delikat stenfruktsötma. Signum för vissa tvättade etiopiska och colombianska kaffesorter.',
        'tr': 'Yumuşak, narin çekirdekli meyve tatlılığı. Belirli yıkanmış Etiyopya ve Kolombiya kahvelerinin ayırt edici özelliğidir.',
        'ja': '柔らかく繊細な核果の甘み。ウォッシュド精製のエチオピア産やコロンビア産コーヒーの特徴です。',
        'ko': '부드럽고 섬세한 핵과류의 단맛입니다. 일부 워시드 가공된 에티오피아 및 콜롬비아 커피의 상징적인 특징입니다.',
        'zh': '柔和、细腻的核果甜味。某些水洗处理埃塞俄比亚和哥伦比亚咖啡的标志。',
        'ar': 'حلاوة فاكهة ذات نواة ناعمة ورقيقة. علامة مميزة لبعض أنواع البن الإثيوبي والكولومبي المغسول.',
    },
    'wheel_note_rose': {
        'en': 'Elegant and high-toned floral fragrance. Often associated with pink bourbon or Geisha varietals.',
        'uk': 'Елегантний і витончений квітковий аромат. Часто асоціюється з рожевим бурбоном або сортами Гейша.',
        'de': 'Eleganter und hochtoniger blumiger Duft. Oft mit Pink Bourbon oder Geisha-Varietäten assoziiert.',
        'fr': 'Parfum floral élégant et de haute tenue. Souvent associé aux variétés Pink Bourbon ou Geisha.',
        'es': 'Fragancia floral elegante y de notas altas. A menudo asociada con variedades Pink Bourbon o Geisha.',
        'it': 'Fragranza floreale elegante e dai toni alti. Spesso associata alle varietà Pink Bourbon o Geisha.',
        'pt': 'Fragrância floral elegante e de tom elevado. Frequentemente associada às variedades Pink Bourbon ou Geisha.',
        'pl': 'Elegancki i wysoki zapach kwiatowy. Często kojarzony z odmianami Pink Bourbon lub Geisha.',
        'nl': 'Elegante en verfijnde florale geur. Vaak geassocieerd met Pink Bourbon of Geisha variëteiten.',
        'sv': 'Elegant och ljus blomdoft. Förknippas ofta med Pink Bourbon eller Geisha-varieteter.',
        'tr': 'Zarif ve yüksek tonlu çiçeksi koku. Genellikle Pink Bourbon veya Geisha varyeteleriyle ilişkilendirilir.',
        'ja': '優雅で華やかな花の香り。ピンクブルボン種やゲイシャ種によく見られます。',
        'ko': '우아하고 고음조의 꽃 향기입니다. 주로 핑크 버본(Pink Bourbon) 또는 게이샤(Geisha) 품종과 관련이 있습니다.',
        'zh': '优雅、高调的花香。通常与粉红波旁或瑰夏品种相关。',
        'ar': 'عبير زهري أنيق وعالٍ. غالبًا ما يرتبط بسلالات الوردي بوربون أو غيشا.',
    },
    'wheel_note_black_tea': {
        'en': 'Tannic and structured tea-like profile. Found in many classic washed Kenyan and Ethiopian coffees.',
        'uk': 'Таніновий і структурований профіль, схожий на чай. Зустрічається у багатьох класичних митих кенійських та ефіопських кавах.',
        'de': 'Tanninhaltiges und strukturiertes teeähnliches Profil. In vielen gewaschenen kenianischen und äthiopischen Kaffees zu finden.',
        'fr': 'Profil tannique et structuré rappelant le thé. Trouvé dans de nombreux cafés classiques lavés du Kenya et d\'Éthiopie.',
        'es': 'Perfil tánico y estructurado similar al té. Se encuentra en muchos cafés lavados clásicos de Kenia y Etiopía.',
        'it': 'Profilo tannico e strutturato simile al tè. Presente in molti classici caffè lavati del Kenya e dell\'Etiopia.',
        'pt': 'Perfil tânico e estruturado semelhante ao chá. Encontrado em muitos cafés lavados clássicos do Quênia e da Etiópia.',
        'pl': 'Taninowy i strukturalny profil herbaciany. Spotykany w wielu klasycznych mytych kawach z Kenii i Etiopii.',
        'nl': 'Tanninerijk en gestructureerd theeachtig profiel. Te vinden in veel klassieke gewassen Keniaanse en Ethiopische koffies.',
        'sv': 'Sträv och strukturerad teliknande profil. Finns i många klassiska tvättade kaffesorter från Kenya och Etiopien.',
        'tr': 'Tanenli ve yapılandırılmış çay benzeri profil. Birçok klasik yıkanmış Kenya ve Etiyopya kahvesinde bulunur.',
        'ja': 'タンニンを感じる構造的なお茶の特徴。伝統的なウォッシュド精製のケニア産やエチオピア産コーヒーに見られます。',
        'ko': '탄닌감이 느껴지는 구조적인 차 프로필입니다. 많은 클래식한 워시드 가공 케냐 및 에티오피아 커피에서 발견됩니다.',
        'zh': '具有单宁感和结构感的茶系特征。常见于经典的肯尼亚和埃塞俄比亚水洗咖啡。',
        'ar': 'ملف شبيه بالشاي وبنيوي. يوجد في العديد من أنواع البن الكيني والإثيوبي المغسول الكلاسيكي.',
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
