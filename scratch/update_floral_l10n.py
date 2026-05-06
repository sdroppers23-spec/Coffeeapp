
import re
import os

target_file = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

translations = {
    'wheel_sub_tea': {
        'en': "Clean, structured mouthfeel with herbal undertones. Relates to specific polyphenols in high-altitude beans. Hallmarks of Yirgacheffe and high-grade Kenyan lots.",
        'uk': "Чисте, структуроване відчуття в роті з трав'яними підтонами. Пов'язано зі специфічними поліфенолами у високогірних зернах. Візитна картка Іргачефу та висококласних кенійських лотів.",
        'de': "Sauberes, strukturiertes Mundgefühl mit kräuterigen Untertönen. Bezieht sich auf spezifische Polyphenole in Hochlandbohnen. Kennzeichen von Yirgacheffe und hochwertigen kenianischen Partien.",
        'fr': "Sensation en bouche propre et structurée avec des nuances herbacées. Lié à des polyphénols spécifiques dans les grains de haute altitude. Marque de fabrique du Yirgacheffe et des lots kenyans de haute qualité.",
        'es': "Sensación en boca limpia y estructurada con matices herbáceos. Se relaciona con polifenoles específicos en granos de gran altitud. Distintivo de Yirgacheffe y lotes kenianos de alta calidad.",
        'it': "Sensazione in bocca pulita e strutturata con sfumature erbacee. Correlato a specifici polifenoli nei chicchi d'alta quota. Segno distintivo di Yirgacheffe e lotti kenioti di alta qualità.",
        'pt': "Sensação na boca limpa e estruturada com subtons herbáceos. Relaciona-se com polifenóis específicos em grãos de elevada altitude. Marcas registadas de Yirgacheffe e lotes quenianos de alta qualidade.",
        'pl': "Czyste, strukturalne odczucie w ustach z ziołowymi tonami. Odnosi się do specyficznych polifenoli w ziarnach wysokogórskich. Znaki rozpoznawcze Yirgacheffe i wysokiej klasy partii kenijskich.",
        'nl': "Schoon, gestructureerd mondgevoel met kruidige ondertonen. Heeft betrekking op specifieke polyfenolen in hooggelegen bonen. Kenmerken van Yirgacheffe en hoogwaardige Keniaanse partijen.",
        'sv': "Ren, strukturerad munkänsla med örtiga undertoner. Relaterar till specifika polyfenoler i bönor från hög höjd. Kännetecken för Yirgacheffe och högkvalitativa kenyanska partier.",
        'tr': "Bitkisel alt tonlarla temiz, yapılandırılmış ağız hissi. Yüksek rakımlı çekirdeklerdeki spesifik polifenollerle ilgilidir. Yirgacheffe ve yüksek dereceli Kenya lotlarının ayırt edici özellikleridir.",
        'ja': "ハーブのような含みを持つ、クリーンで構造的な口当たり。高地の豆に含まれる特定のポリフェノールに関連している。イルガチェフェや高級ケニアロットの特徴。",
        'ko': "허브 향이 감도는 깔끔하고 구조감 있는 마우스필입니다. 고산지대 원두의 특정 폴리페놀과 관련이 있습니다. 예가체프와 고급 케냐 로트의 특징입니다.",
        'zh': "干净、结构清晰的口感，带有草本底蕴。与高海拔咖啡豆中的特定多酚有关。耶加雪菲和高级肯尼亚批次的标志。",
        'ar': "ملمس فم نظيف ومنظم مع إيحاءات عشبية. يرتبط بمركبات بوليفينول محددة في الحبوب المزروعة على ارتفاعات عالية. من سمات مناطق ييرغاشيفي والدفعات الكينية عالية الجودة.",
    },
    'wheel_sub_floral': {
        'en': "Delicate flower-like aromas including chamomile, rose, and jasmine. The hallmark of lightly roasted high-quality Gesha and Ethiopian heirloom varieties.",
        'uk': "Делікатні квіткові аромати, включаючи ромашку, троянду та жасмин. Візитна картка світло обсмаженої високоякісної Гейші та ефіопських сортів спадщини.",
        'de': "Zarte blumige Aromen wie Kamille, Rose und Jasmin. Das Kennzeichen von hell gerösteten, hochwertigen Gesha- und äthiopischen Heirloom-Varietäten.",
        'fr': "Arômes floraux délicats comprenant la camomille, la rose et le jasmin. La marque des variétés Gesha de haute qualità et des variétés anciennes éthiopiennes légèrement torréfiées.",
        'es': "Aromas florales delicados que incluyen manzanilla, rosa y jazmín. El sello distintivo de las variedades tradicionales etíopes y Gesha de alta calidad con tueste ligero.",
        'it': "Aromi floreali delicati tra cui camomilla, rosa e gelsomino. Il segno distintivo delle varietà autoctone etiopi e dei Gesha di alta qualità tostati leggermente.",
        'pt': "Aromas florais delicados, incluindo camomila, rosa e jasmim. A marca das variedades herança etíopes e Gesha de alta qualidade com torra clara.",
        'pl': "Delikatne aromaty kwiatowe, w tym rumianek, róża i jaśmin. Znak rozpoznawczy jasnopalonej, wysokiej jakości odmiany Gesha oraz etiopських odmian heirloom.",
        'nl': "Verfijnde bloemachtige aroma's waaronder kamille, roos en jasmijn. Het kenmerk van licht gebrande hoogwaardige Gesha en Ethiopische heirloom variëteiten.",
        'sv': "Delikata blomliknande aromer inklusive kamomill, ros och jasmin. Kännetecknet för lättrostade högkvalitativa Gesha och etiopiska arvsorter.",
        'tr': "Papatya, gül ve yasemin dahil narin çiçeksi aromalar. Hafif kavrulmuş yüksek kaliteli Gesha ve Etiyopya yerel çeşitlerinin ayırt edici özelliğidir.",
        'ja': "カモミール、ローズ、ジャスミンなどの繊細な花の香り。浅煎りの高品質なゲイシャ種やエチオピア在来種の特徴。",
        'ko': "카모마일, 장미, 자스민을 포함한 섬세한 꽃 향기입니다. 약배전된 고품질 게이샤와 에티오피아 토착종의 특징입니다.",
        'zh': "精致的花香，包括洋甘菊、玫瑰和茉莉。轻度烘焙的高品质瑰夏和埃塞俄比亚原生种的标志。",
        'ar': "روائح زهرية رقيقة تشمل البابونج والورد والياسمين. من سمات أصناف الجيشا عالية الجودة والسلالات الإثيوبية المحمصة تحميصًا خفيفًا.",
    },
}

with open(target_file, 'r', encoding='utf-8') as f:
    content = f.read()

for key, langs in translations.items():
    new_block = f"'{key}': {{\n"
    for lang, text in langs.items():
        safe_text = text.replace(chr(39), '\\' + chr(39))
        new_block += f"        '{lang}': '{safe_text}',\n"
    new_block += "      },"
    pattern = rf"'{key}':\s*\{{.*?\}},"
    content = re.sub(pattern, new_block, content, flags=re.DOTALL)

with open(target_file, 'w', encoding='utf-8', newline='\n') as f:
    f.write(content)

print('Update complete.')
