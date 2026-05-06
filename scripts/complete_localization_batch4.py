# -*- coding: utf-8 -*-
import re
import os

FLAVOR_FILE = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

BATCH4 = {
    'wheel_note_rose': {
        'en': 'Elegant and high-toned floral fragrance.',
        'uk': 'Елегантний і витончений квітковий аромат.',
        'de': 'Eleganter und hochtoniger blumiger Duft.',
        'fr': 'Parfum floral élégant et de haute tenue.',
        'es': 'Fragancia floral elegante y de notas altas.',
        'it': 'Fragranza floreale elegante e dai toni alti.',
        'pt': 'Fragrância floral elegante e de tom elevado.',
        'pl': 'Elegancki i wysoki zapach kwiatowy.',
        'nl': 'Elegante en verfijnde florale geur.',
        'sv': 'Elegant och ljus blomdoft.',
        'tr': 'Zarif ve yüksek tonlu çiçeksi koku.',
        'ja': '優雅で華やかな花の香り。',
        'ko': '우아하고 고음조의 꽃 향기입니다.',
        'zh': '优雅、高调的花香。',
        'ar': 'عبير زهري أنيق وعالٍ.',
    },
    'wheel_note_jasmine': {
        'en': 'Intense, sweet, and classic floral note.',
        'uk': 'Інтенсивна солодкувата класична квіткова нота.',
        'de': 'Intensive, süße und klassische blumige Note.',
        'fr': 'Note florale intense, sucrée et classique.',
        'es': 'Nota floral intensa, dulce y clásica.',
        'it': 'Nota floreale intensa, dolce e classica.',
        'pt': 'Nota floral intensa, doce e classica.',
        'pl': 'Intensywna, słodka i klasyczna nuta kwiatowa.',
        'nl': 'Intense, zoete en klassieke florale noot.',
        'sv': 'Intensiv, söt och klassisk blommig ton.',
        'tr': 'Yoğun, tatlı ve klasik çiçeksi nota.',
        'ja': '強烈で甘い、伝統的な花の香り。',
        'ko': '강렬하고 달콤한 클래식한 꽃 노트입니다.',
        'zh': '强烈、甜美且经典的花香。',
        'ar': 'نوتة زهرية مكثفة وحلوة وكلاسيكية.',
    },
    'wheel_note_vanilla': {
        'en': 'Creamy and sweet aromatic note.',
        'uk': 'Вершкова та солодка ароматична нота.',
        'de': 'Cremige und süße aromatische Note.',
        'fr': 'Note aromatique crémeuse et sucrée.',
        'es': 'Nota aromática cremosa y dulce.',
        'it': 'Nota aromatica cremosa e dolce.',
        'pt': 'Nota aromática cremosa e doce.',
        'pl': 'Kremowa i słodka nuta aromatyczna.',
        'nl': 'Romige en zoete aromatische noot.',
        'sv': 'Krämig och söt aromatisk ton.',
        'tr': 'Kremsi ve tatlı aromatik nota.',
        'ja': 'クリーミーで甘い香りのノート。',
        'ko': '크리미하고 달콤한 향의 노트입니다.',
        'zh': '奶香且甜美的芳香风味。',
        'ar': 'نوتة عطرية كريمية وحلوة.',
    },
    'wheel_note_caramel': {
        'en': 'Classic toasted sugar sweetness.',
        'uk': 'Класична солодкість паленого цукру.',
        'de': 'Klassische geröstete Zucker-Süße.',
        'fr': 'Sucrosité classique de sucre grillé.',
        'es': 'Dulzor clásico de azúcar tostado.',
        'it': 'Classica dolcezza di zucchero tostato.',
        'pt': 'Doçura clássica de açúcar torrado.',
        'pl': 'Klasyczna słodycz palonego cukru.',
        'nl': 'Klassieke gebrande suikerzoetheid.',
        'sv': 'Klassisk rostad sockersötma.',
        'tr': 'Klasik kavrulmuş şeker tatlılığı.',
        'ja': '伝統的な焦がし砂糖の甘み。',
        'ko': '클래식한 구운 설탕의 단맛입니다.',
        'zh': '经典的烤糖甜味。',
        'ar': 'حلاوة السكر المحمص الكلاسيكية.',
    },
    'wheel_note_honey': {
        'en': 'Clean, floral sweetness.',
        'uk': 'Чиста квіткова солодкість.',
        'de': 'Saubere, blumige Süße.',
        'fr': 'Sucrosité propre et florale.',
        'es': 'Dulzor limpio y floral.',
        'it': 'Dolcezza pulita e floreale.',
        'pt': 'Doçura limpa e floral.',
        'pl': 'Czysta, kwiatowa słodycz.',
        'nl': 'Schone, florale zoetheid.',
        'sv': 'Ren, blommig sötma.',
        'tr': 'Temiz, çiçeksi tatlılık.',
        'ja': 'クリーンでフローラルな甘み。',
        'ko': '깔끔한 꽃 향의 단맛입니다.',
        'zh': '干净、带花香的甜味。',
        'ar': 'حلاوة زهرية نظيفة.',
    },
    'wheel_note_hazelnut': {
        'en': 'Sweet and buttery nut profile.',
        'uk': 'Солодкий і маслянистий горіховий профіль.',
        'de': 'Süßes und butterartiges Nuss-Profil.',
        'fr': 'Profil de noisette sucré et beurré.',
        'es': 'Perfil de fruto seco dulce y mantecoso.',
        'it': 'Profilo di frutta secca dolce e burroso.',
        'pt': 'Perfil de nozes doce e amanteigado.',
        'pl': 'Słodki i maślany profil orzechowy.',
        'nl': 'Zoet en boterachtig notenprofiel.',
        'sv': 'Söt och smörig nötprofil.',
        'tr': 'Tatlı ve tereyağımsı fındık profili.',
        'ja': '甘くバターのようなナッツの特徴。',
        'ko': '달콤하고 버터 같은 견과류 프로필입니다.',
        'zh': '甜美、带奶香的坚果特征。',
        'ar': 'ملف مكسرات حلو وزبدي.',
    },
    'wheel_note_almond': {
        'en': 'Clean and slightly bitter nuttiness.',
        'uk': 'Чиста і злегка гірка горіховість.',
        'de': 'Saubere und leicht bittere Nussigkeit.',
        'fr': 'Goût de noisette propre et légèrement amer.',
        'es': 'Sabor a nuez limpio y ligeramente amargo.',
        'it': 'Note di frutta secca pulite e leggermente amare.',
        'pt': 'Sabor de nozes limpo e levemente amargo.',
        'pl': 'Czysta i lekko gorzka orzechowość.',
        'nl': 'Schone en licht bittere nootachtigheid.',
        'sv': 'Ren och lätt bitter nötighet.',
        'tr': 'Temiz ve hafif acı fındıksılık.',
        'ja': 'クリーンでわずかに苦味のあるナッツ感。',
        'ko': '깔끔하고 약간 쌉싸름한 견과류 맛입니다.',
        'zh': '干净且略带苦味的坚果感。',
        'ar': 'نكهة مكسرات نظيفة ومرة قليلاً.',
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
    update_file(BATCH4)
