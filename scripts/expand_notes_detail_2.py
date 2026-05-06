# -*- coding: utf-8 -*-
import re
import os

FLAVOR_FILE = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

EXPANSION_DATA = {
    'wheel_note_raspberry': {
        'en': 'Tart, sweet, and vibrantly acidic red fruit note. Common in high-altitude coffees.',
        'uk': 'Терпка, солодка та яскрава кислотна нота червоних фруктів. Поширена у високогірній каві.',
        'de': 'Herbe, süße und lebhaft säuerliche rote Fruchtnote. Häufig in Hochlandkaffees.',
        'fr': 'Note de fruits rouges acidulée, sucrée et vibrante. Commun dans les cafés d\'altitude.',
        'es': 'Nota de fruta roja ácida, dulce y vibrante. Común en cafés de gran altura.',
        'it': 'Nota di frutti rossi aspra, dolce e vibrante. Comune nei caffè d\'alta quota.',
        'pt': 'Nota de fruta vermelha ácida, doce e vibrante. Comum em cafés de grande altitude.',
        'pl': 'Cierpka, słodka i żywo kwasowa nuta czerwonych owoców. Powszechna w kawach wysokogórskich.',
        'nl': 'Zure, zoete en levendige rode fruitnoot. Veelvoorkomend in hooglandkoffie.',
        'sv': 'Syrlig, söt och livligt syrlig röd frukton. Vanligt i kaffe från hög höjd.',
        'tr': 'Mayhoş, tatlı ve canlı asidik kırmızı meyve notası. Yüksek rakımlı kahvelerde yaygındır.',
        'ja': '甘酸っぱく、鮮やかな酸味のあるレッドフルーツのノート。標高の高い場所で栽培されたコーヒーによく見られます。',
        'ko': '새콤달콤하고 활기찬 산미가 느껴지는 레드 과일 노트입니다. 고지대 커피에서 흔히 발견됩니다.',
        'zh': '酸甜且明亮的红色水果风味。常见于高海拔咖啡。',
        'ar': 'نوتة فاكهة حمراء لاذعة وحلوة وحمضية بشكل حيوي. شائعة في القهوة المزروعة على ارتفاعات عالية.',
    },
    'wheel_note_blueberry': {
        'en': 'Deep, sweet, and aromatic blue fruit note. Signature of natural-processed Harrar and Sidamo lots.',
        'uk': 'Глибока, солодка та ароматна нота синіх фруктів. Фірмова ознака ефіопських лотів Харрар та Сідамо натуральної обробки.',
        'de': 'Tiefe, süße und aromatische blaue Fruchtnote. Markenzeichen von naturrein aufbereiteten Harrar- und Sidamo-Partien.',
        'fr': 'Note de fruits bleus profonde, sucrée et aromatique. Signature des lots Harrar et Sidamo traités naturellement.',
        'es': 'Nota de fruta azul profunda, dulce y aromática. Firma de los lotes Harrar y Sidamo procesados naturalmente.',
        'it': 'Nota di frutti blu profonda, dolce e aromatica. Segno distintivo dei lotti Harrar e Sidamo a lavorazione naturale.',
        'pt': 'Nota de fruta azul profunda, doce e aromática. Marca registrada de lotes Harrar e Sidamo processados naturalmente.',
        'pl': 'Głęboka, słodka i aromatyczna nuta niebieskich owoców. Sygnatura partii Harrar i Sidamo z obróbki naturalnej.',
        'nl': 'Diepe, zoete en aromatische blauwe fruitnoot. Kenmerkend voor natuurlijk verwerkte Harrar en Sidamo partijen.',
        'sv': 'Djup, söt och aromatisk blå frukton. Signatur för naturligt processat kaffe från Harrar och Sidamo.',
        'tr': 'Derin, tatlı ve aromatik mavi meyve notası. Doğal işlenmiş Harrar ve Sidamo kahvelerinin imza özelliğidir.',
        'ja': '深く甘い、芳醇なブルーフルーツのノート。ナチュラル精製のハラーやシダモ産コーヒーを象徴する風味です。',
        'ko': '깊고 달콤하며 향긋한 블루 과일 노트입니다. 내추럴 가공된 하라(Harrar)와 시다모(Sidamo) 커피의 상징적인 특징입니다.',
        'zh': '深沉、甜美且芬芳的蓝色水果风味。日晒处理哈拉尔和西达摩咖啡的标志。',
        'ar': 'نوتة فاكهة زرقاء عميقة وحلوة وعطرية. علامة مميزة لمحاصيل هرر وسيدامو المعالجة طبيعيًا.',
    },
    'wheel_note_grapefruit': {
        'en': 'Bitter-sweet citrus note with high intensity. Indicates sharp, structured acidity.',
        'uk': 'Гірко-солодка цитрусова нота високої інтенсивності. Вказує на гостру, структуровану кислотність.',
        'de': 'Bittersüße Zitrusnote mit hoher Intensität. Deutet auf scharfe, strukturierte Säure hin.',
        'fr': 'Note d\'agrumes douce-amère de haute intensité. Indique une acidité vive et structurée.',
        'es': 'Nota cítrica agridulce con alta intensidad. Indica una acidez punzante y estructurada.',
        'it': 'Nota agrumata agrodolce ad alta intensità. Indica un\'acidità pungente e strutturata.',
        'pt': 'Nota cítrica agridoce de alta intensidade. Indica uma acidez picante e estruturada.',
        'pl': 'Gorzkosłodka nuta cytrusowa o wysokiej intensywności. Wskazuje na ostrą, strukturalną kwasowość.',
        'nl': 'Bitterzoete citrusnoot met een hoge intensiteit. Wijst op een scherpe, gestructureerde aciditeit.',
        'sv': 'Bittersöt citruston med hög intensitet. Indikerar skarp, strukturerad syrlighet.',
        'tr': 'Yüksek yoğunluklu acı-tatlı narenciye notası. Keskin, yapılandırılmış asiditeyi gösterir.',
        'ja': '高強度のほろ苦いシトラスのノート。鋭く構造的な酸味を示します。',
        'ko': '강렬한 쌉싸름한 시트러스 노트입니다. 날카롭고 구조적인 산미를 나타냅니다.',
        'zh': '高强度的苦甜柑橘风味。代表尖锐且有结构感的酸度。',
        'ar': 'نوتة حمضيات حلوة-مرة ذات كثافة عالية. تشير إلى حموضة حادة وبنيوية.',
    },
    'wheel_note_orange': {
        'en': 'Sweet and zesty citrus profile with moderate acidity. Reminiscent of fresh orange peel.',
        'uk': 'Солодкий і пікантний цитрусовий профіль з помірною кислотністю. Нагадує свіжу апельсинову цедру.',
        'de': 'Süßes und spritziges Zitrusprofil mit mäßiger Säure. Erinnert an frische Orangenschale.',
        'fr': 'Profil d\'agrumes sucré et zesté avec une acidité modérée. Rappelant le zeste d\'orange fraîche.',
        'es': 'Perfil cítrico dulce y picante con acidez moderada. Recuerda a la cáscara de naranja fresca.',
        'it': 'Profilo agrumato dolce e frizzante con acidità moderata. Ricorda la scorza d\'arancia fresca.',
        'pt': 'Perfil cítrico doce e picante com acidez moderada. Lembra a casca de laranja fresca.',
        'pl': 'Słodki i pikantny profil cytrusowy o umiarkowanej kwasowości. Przypomina świeżą skórkę pomarańczy.',
        'nl': 'Zoet en fris citrusprofiel met een matige aciditeit. Doet denken aan verse sinaasappelschil.',
        'sv': 'Söt och frisk citrusprofil med måttlig syra. Påminner om färskt apelsinskal.',
        'tr': 'Orta düzeyde asiditeye sahip tatlı ve lezzetli narenciye profili. Taze portakal kabuğunu anımsatır.',
        'ja': '中程度の酸味を伴う、甘く爽やかなシトラスの特徴。新鮮なオレンジの皮を思わせます。',
        'ko': '중간 정도의 산미를 가진 달콤하고 상큼한 시트러스 프로필입니다. 신선한 오렌지 껍질을 연상시킵니다.',
        'zh': '甜美而清爽的柑橘风味，酸度适中。令人联想到新鲜橙皮。',
        'ar': 'ملف حمضيات حلو ومنعش مع حموضة معتدلة. يذكرنا بقشر البرتقال الطازج.',
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
