import re

path = r'd:\Games\Coffeeapp\lib\core\l10n\app_localizations.dart'

with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

# Translations for the 10 missing languages
new_langs = {
    'it': {
        'roast_light': 'Chiara',
        'roast_medium_light': 'Medio-Chiara',
        'roast_medium': 'Media',
        'roast_medium_dark': 'Medio-Scura',
        'roast_dark': 'Scura',
        'process_washed': 'Lavato',
        'process_natural': 'Naturale',
        'process_honey': 'Honey',
        'process_anaerobic': 'Anaerobico',
        'process_carbonic_maceration': 'Macerazione Carbonica',
        'process_wet_hulled': 'Giling Basah',
        'personal_roastery_label': 'Personale',
        'specialty_roaster_label': 'Torrefattore Specialty',
        'unnamed_label': 'Senza nome',
        'not_available': 'N/D',
    },
    'pt': {
        'roast_light': 'Clara',
        'roast_medium_light': 'Média-Clara',
        'roast_medium': 'Média',
        'roast_medium_dark': 'Média-Escura',
        'roast_dark': 'Escura',
        'process_washed': 'Lavado',
        'process_natural': 'Natural',
        'process_honey': 'Honey',
        'process_anaerobic': 'Anaeróbico',
        'process_carbonic_maceration': 'Maceración Carbónica',
        'process_wet_hulled': 'Giling Basah',
        'personal_roastery_label': 'Pessoal',
        'specialty_roaster_label': 'Torrador Specialty',
        'unnamed_label': 'Sem nome',
        'not_available': 'N/D',
    },
    'pl': {
        'roast_light': 'Jasne',
        'roast_medium_light': 'Średnio-Jasne',
        'roast_medium': 'Średnie',
        'roast_medium_dark': 'Średnio-Ciemne',
        'roast_dark': 'Ciemne',
        'process_washed': 'Myta',
        'process_natural': 'Naturalna',
        'process_honey': 'Honey',
        'process_anaerobic': 'Anaerobowa',
        'process_carbonic_maceration': 'Maceracja Węglowa',
        'process_wet_hulled': 'Giling Basah',
        'personal_roastery_label': 'Osobista',
        'specialty_roaster_label': 'Palarnia Specialty',
        'unnamed_label': 'Bez nazwy',
        'not_available': 'N/D',
    },
    'nl': {
        'roast_light': 'Licht',
        'roast_medium_light': 'Medium-Licht',
        'roast_medium': 'Medium',
        'roast_medium_dark': 'Medium-Donker',
        'roast_dark': 'Donker',
        'process_washed': 'Gewassen',
        'process_natural': 'Natural',
        'process_honey': 'Honey',
        'process_anaerobic': 'Anaerobisch',
        'process_carbonic_maceration': 'Carbonic Maceration',
        'process_wet_hulled': 'Giling Basah',
        'personal_roastery_label': 'Persoonlijk',
        'specialty_roaster_label': 'Specialty Brander',
        'unnamed_label': 'Naamloos',
        'not_available': 'N/B',
    },
    'sv': {
        'roast_light': 'Ljus',
        'roast_medium_light': 'Medium-Ljus',
        'roast_medium': 'Medium',
        'roast_medium_dark': 'Medium-Mörk',
        'roast_dark': 'Mörk',
        'process_washed': 'Tvättad',
        'process_natural': 'Bärtorkad',
        'process_honey': 'Honey',
        'process_anaerobic': 'Anaerobisk',
        'process_carbonic_maceration': 'Carbonic Maceration',
        'process_wet_hulled': 'Giling Basah',
        'personal_roastery_label': 'Personlig',
        'specialty_roaster_label': 'Specialty-rosteri',
        'unnamed_label': 'Namnlös',
        'not_available': 'N/A',
    },
    'tr': {
        'roast_light': 'Açık',
        'roast_medium_light': 'Orta-Açık',
        'roast_medium': 'Orta',
        'roast_medium_dark': 'Orta-Koyu',
        'roast_dark': 'Koyu',
        'process_washed': 'Yıkanmış',
        'process_natural': 'Doğal',
        'process_honey': 'Honey',
        'process_anaerobic': 'Anaerobik',
        'process_carbonic_maceration': 'Karbonik Maserasyon',
        'process_wet_hulled': 'Giling Basah',
        'personal_roastery_label': 'Kişisel',
        'specialty_roaster_label': 'Specialty Kavurucu',
        'unnamed_label': 'İsimsiz',
        'not_available': 'YOK',
    },
    'ja': {
        'roast_light': '浅煎り',
        'roast_medium_light': '中浅煎り',
        'roast_medium': '中煎り',
        'roast_medium_dark': '中深煎り',
        'roast_dark': '深煎り',
        'process_washed': 'ウォッシュド',
        'process_natural': 'ナチュラル',
        'process_honey': 'ハニー',
        'process_anaerobic': 'アナエロビック',
        'process_carbonic_maceration': 'カーボニック・マセレーション',
        'process_wet_hulled': 'スマトラ式',
        'personal_roastery_label': '自分用',
        'specialty_roaster_label': 'スペシャルティ・ロースター',
        'unnamed_label': '無題',
        'not_available': 'N/A',
    },
    'ko': {
        'roast_light': '약배전',
        'roast_medium_light': '중약배전',
        'roast_medium': '중배전',
        'roast_medium_dark': '중강배전',
        'roast_dark': '강배전',
        'process_washed': '워시드',
        'process_natural': '내추럴',
        'process_honey': '허니',
        'process_anaerobic': '무산소 발효',
        'process_carbonic_maceration': '카보닉 마세레이션',
        'process_wet_hulled': '길링 바사',
        'personal_roastery_label': '개인용',
        'specialty_roaster_label': '스페셜티 로스터리',
        'unnamed_label': '이름 없음',
        'not_available': 'N/A',
    },
    'zh': {
        'roast_light': '浅烘',
        'roast_medium_light': '中浅烘',
        'roast_medium': '中烘',
        'roast_medium_dark': '中深烘',
        'roast_dark': '深烘',
        'process_washed': '水洗',
        'process_natural': '日晒',
        'process_honey': '蜜处理',
        'process_anaerobic': '厌氧处理',
        'process_carbonic_maceration': '二氧化碳浸渍',
        'process_wet_hulled': '湿刨法',
        'personal_roastery_label': '私人',
        'specialty_roaster_label': '精品烘焙商',
        'unnamed_label': '未命名',
        'not_available': '无',
    },
    'ar': {
        'roast_light': 'خفيف',
        'roast_medium_light': 'متوسط خفيف',
        'roast_medium': 'متوسط',
        'roast_medium_dark': 'متوسط غامق',
        'roast_dark': 'غامق',
        'process_washed': 'مغسولة',
        'process_natural': 'مجففة',
        'process_honey': 'عسلية',
        'process_anaerobic': 'لا هوائية',
        'process_carbonic_maceration': 'تخمير كربوني',
        'process_wet_hulled': 'تجفيف مرطب',
        'personal_roastery_label': 'شخصي',
        'specialty_roaster_label': 'محمصة مختصة',
        'unnamed_label': 'بدون اسم',
        'not_available': 'N/A',
    }
}

# Add common grinder names to all new langs
grinders = {
    'grinder_comandante': 'Comandante',
    'grinder_timemore': 'Timemore',
    'grinder_fellow': 'Fellow',
    'grinder_1zpresso': '1Zpresso',
    'grinder_baratza': 'Baratza',
    'grinder_wilfa': 'Wilfa',
    'grinder_mahlkonig': 'Mahlkönig',
    'grinder_mazzer': 'Mazzer',
    'grinder_ek43': 'EK43',
    'grinder_fellow_ode': 'Fellow Ode',
}

for lang in new_langs:
    new_langs[lang].update(grinders)

def insert_langs(match):
    existing_content = match.group(1)
    new_blocks = []
    for lang, trans in new_langs.items():
        if f"'{lang}':" not in existing_content:
            block = f"    '{lang}': {{\n"
            for k, v in trans.items():
                block += f"      '{k}': '{v}',\n"
            block += "    },"
            new_blocks.append(block)
    
    return "  static const Map<String, Map<String, String>> _translations = {" + existing_content + "\n" + "\n".join(new_blocks) + "\n  };"

new_content = re.sub(r'static const Map<String, Map<String, String>> _translations = \{(.*?)\};', insert_langs, content, flags=re.DOTALL)

with open(path, 'w', encoding='utf-8') as f:
    f.write(new_content)

print("Added 10 missing languages to app_localizations.dart.")
