# -*- coding: utf-8 -*-
import re
import os

FLAVOR_FILE = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

BATCH3 = {
    'wheel_note_grapefruit': {
        'en': 'Bitter-sweet citrus note with high intensity.',
        'uk': 'Гірко-солодка цитрусова нота високої інтенсивності.',
        'de': 'Bittersüße Zitrusnote mit hoher Intensität.',
        'fr': 'Note d\'agrumes douce-amère de haute intensité.',
        'es': 'Nota cítrica agridulce con alta intensidad.',
        'it': 'Nota agrumata agrodolce ad alta intensità.',
        'pt': 'Nota cítrica agridoce de alta intensidade.',
        'pl': 'Gorzkosłodka nuta cytrusowa o wysokiej intensywności.',
        'nl': 'Bitterzoete citrusnoot met een hoge intensiteit.',
        'sv': 'Bittersöt citruston med hög intensitet.',
        'tr': 'Yüksek yoğunluklu acı-tatlı narenciye notası.',
        'ja': '高強度のほろ苦いシトラスのノート。',
        'ko': '강렬한 쌉싸름한 시트러스 노트입니다.',
        'zh': '高强度的苦甜柑橘风味。',
        'ar': 'نوتة حمضيات حلوة-مرة ذات كثافة عالية.',
    },
    'wheel_note_orange': {
        'en': 'Sweet and zesty citrus profile.',
        'uk': 'Солодкий і пікантний цитрусовий профіль.',
        'de': 'Süßes und spritziges Zitrusprofil.',
        'fr': 'Profil d\'agrumes sucré et zesté.',
        'es': 'Perfil cítrico dulce y picante.',
        'it': 'Profilo agrumato dolce e frizzante.',
        'pt': 'Perfil cítrico doce e picante.',
        'pl': 'Słodki i pikantny profil cytrusowy.',
        'nl': 'Zoet en fris citrusprofiel.',
        'sv': 'Söt och frisk citrusprofil.',
        'tr': 'Tatlı ve lezzetli narenciye profili.',
        'ja': '甘く爽やかなシトラスの特徴。',
        'ko': '달콤하고 상큼한 시트러스 프로필입니다.',
        'zh': '甜美而清爽的柑橘风味。',
        'ar': 'ملف حمضيات حلو ومنعش.',
    },
    'wheel_note_lemon': {
        'en': 'Sharp, clean, and high-intensity citrus acidity.',
        'uk': 'Гостра, чиста та високоінтенсивна цитрусова кислотність.',
        'de': 'Scharfe, saubere und hochintensive Zitrus-Säure.',
        'fr': 'Acidité d\'agrumes vive, propre et de haute intensité.',
        'es': 'Acidez cítrica punzante, limpia y de alta intensidad.',
        'it': 'Acidità agrumata pungente, pulita e ad alta intensità.',
        'pt': 'Acidez cítrica picante, limpa e de alta intensidade.',
        'pl': 'Ostra, czysta i intensywna kwasowość cytrusowa.',
        'nl': 'Scherpe, schone en zeer intense citrus-aciditeit.',
        'sv': 'Skarp, ren och högintensiv citrussyra.',
        'tr': 'Keskin, temiz ve yüksek yoğunluklu narenciye asiditesi.',
        'ja': '鋭くクリーンで強烈なシトラスの酸味。',
        'ko': '날카롭고 깔끔한 고강도 시트러스 산미입니다.',
        'zh': '尖锐、干净且高强度的柑橘酸度。',
        'ar': 'حموضة حمضية حادة ونظيفة وعالية الكثافة.',
    },
    'wheel_note_lime': {
        'en': 'Zesty and slightly bitter green citrus note.',
        'uk': 'Пікантна і злегка гірка нота зеленого цитруса.',
        'de': 'Spritzige und leicht bittere grüne Zitrusnote.',
        'fr': 'Note d\'agrumes verts zestée et légèrement amère.',
        'es': 'Nota de cítricos verdes picante y ligeramente amarga.',
        'it': 'Nota di agrumi verdi frizzante e leggermente amara.',
        'pt': 'Nota cítrica verde picante e levemente amarga.',
        'pl': 'Pikantna i lekko gorzka nuta zielonych cytrusów.',
        'nl': 'Frisse en licht bittere groene citrusnoot.',
        'sv': 'Frisk och lätt bitter grön citruston.',
        'tr': 'Lezzetli ve hafif acı yeşil narenciye notası.',
        'ja': '爽やかでわずかに苦味のあるグリーンシトラスのノート。',
        'ko': '상큼하고 약간 쌉싸름한 그린 시트러스 노트입니다.',
        'zh': '清爽且略带苦味的青柠风味。',
        'ar': 'نوتة حمضيات خضراء منعشة ومرة قليلاً.',
    },
    'wheel_note_black_tea': {
        'en': 'Tannic and structured tea-like profile.',
        'uk': 'Таніновий і структурований профіль, схожий на чай.',
        'de': 'Tanninhaltiges und strukturiertes teeähnliches Profil.',
        'fr': 'Profil tannique et structuré rappelant le thé.',
        'es': 'Perfil tánico y estructurado similar al té.',
        'it': 'Profilo tannico e strutturato simile al tè.',
        'pt': 'Perfil tânico e estruturado semelhante au chá.',
        'pl': 'Taninowy i strukturalny profil herbaciany.',
        'nl': 'Tanninerijk en gestructureerd theeachtig profiel.',
        'sv': 'Sträv och strukturerad teliknande profil.',
        'tr': 'Tanenli ve yapılandırılmış çay benzeri profil.',
        'ja': 'タンニンを感じる構造的なお茶の特徴。',
        'ko': '탄닌감이 느껴지는 구조적인 차 프로필입니다.',
        'zh': '具有单宁感和结构感的茶系特征。',
        'ar': 'ملف شبيه بالشاي وبنيوي.',
    },
    'wheel_note_green_tea': {
        'en': 'Fresh, herbal, and slightly astringent notes.',
        'uk': 'Свіжі, трав’яні та злегка терпкі ноти.',
        'de': 'Frische, kräuterige und leicht herbe Noten.',
        'fr': 'Notes fraîches, herbacées et légèrement astringentes.',
        'es': 'Notas frescas, herbáceas y ligeramente astringentes.',
        'it': 'Note fresche, erbacee e leggermente astringenti.',
        'pt': 'Notas frescas, herbáceas e levemente adstringentes.',
        'pl': 'Świeże, ziołowe i lekko cierpkie nuty.',
        'nl': 'Frisse, kruidige en licht wrange tonen.',
        'sv': 'Friska, örtiga och lätt kärva toner.',
        'tr': 'Taze, bitkisel ve hafif buruk notalar.',
        'ja': 'フレッシュで草木のような、わずかに渋みのある香り。',
        'ko': '신선하고 허브 느낌이 나는 약간 떫은 노트입니다.',
        'zh': '清新、草本且略带涩感的风味。',
        'ar': 'نوتات طازجة وعشبية وقابضة قليلاً.',
    },
    'wheel_note_chamomile': {
        'en': 'Floral and soothing herbal sweetness.',
        'uk': 'Квіткова та заспокійлива трав’яна солодкість.',
        'de': 'Blumige und beruhigende Kräutersüße.',
        'fr': 'Sucrosité florale et herbacée apaisante.',
        'es': 'Dulzor floral y herbal calmante.',
        'it': 'Dolcezza floreale ed erboristica lenitiva.',
        'pt': 'Doçura floral e de ervas calmante.',
        'pl': 'Kwiatowa i kojąca ziołowa słodycz.',
        'nl': 'Bloemige en rustgevende kruidenzoetheid.',
        'sv': 'Blommig och lugnande örtsötma.',
        'tr': 'Çiçeksi ve yatıştırıcı bitkisel tatlılık.',
        'ja': 'フローラルで落ち着くハーブの甘み。',
        'ko': '꽃 향기가 나는 차분한 허브 단맛입니다.',
        'zh': '花香且舒缓的草本甜味。',
        'ar': 'حلاوة عشبية وزهرية مهدئة.',
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
    update_file(BATCH3)
