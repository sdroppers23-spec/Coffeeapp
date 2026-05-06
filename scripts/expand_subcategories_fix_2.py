# -*- coding: utf-8 -*-
import re
import os

FLAVOR_FILE = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

EXPANSION_DATA = {
    'wheel_sub_chemical': {
        'en': 'Pungent or medicinal notes often resulting from processing defects or improper storage. Rare in specialty lots.',
        'uk': 'Гострі або аптечні ноти, що часто є результатом дефектів обробки або неправильного зберігання. Рідко зустрічаються в спешелті-лотах.',
        'de': 'Stechende oder medizinische Noten, die oft auf Verarbeitungsfehler zurückzuführen sind.',
        'fr': 'Notes piquantes ou médicinales résultant souvent de défauts de traitement.',
        'es': 'Notas punzantes o medicinales que a menudo resultan de defectos de procesamiento.',
        'it': 'Note pungenti o medicinali che spesso derivano da difetti di lavorazione.',
        'pt': 'Notas picantes ou medicinais que frequentemente resultam de defeitos de processamento.',
        'pl': 'Ostre lub medyczne nuty często wynikające z błędów w obróbce.',
        'nl': 'Bijtende of medicinale tonen die vaak het gevolg zijn van verwerkingsfouten.',
        'sv': 'Stickande eller medicinska toner som ofta beror på bearbetningsdefekter.',
        'tr': 'Genellikle işleme kusurlarından kaynaklanan keskin veya tıbbi notalar.',
        'ja': '加工の欠陥や不適切な保管によって生じる、刺激的な、あるいは薬品のようなノート。',
        'ko': '가공 결함이나 부적절한 보관으로 인해 발생하는 톡 쏘는 또는 약품 같은 노트입니다.',
        'zh': '刺鼻或药味，通常由处理缺陷或储存不当引起。在精品咖啡中很少见。',
        'ar': 'نوتات لاذعة أو طبية تنتج غالبًا عن عيوب المعالجة أو التخزين غير السليم.',
    },
    'wheel_sub_papery': {
        'en': 'Dry, woody or stale notes reminiscent of cardboard. Often indicates old-crop beans or moisture loss during storage.',
        'uk': 'Сухі, деревні або затхлі ноти, що нагадують картон. Часто вказує на старий врожай або втрату вологи під час зберігання.',
        'de': 'Trockene, holzige oder abgestandene Noten, die an Pappe erinnern. Deutet oft auf alte Ernten hin.',
        'fr': 'Notes sèches, boisées ou rassis rappelant le carton. Indique souvent des grains de récolte ancienne.',
        'es': 'Notas secas, amaderadas o rancias que recuerdan al cartón. A menudo indica granos de cosechas antiguas.',
        'it': 'Note secche, legnose o stantie che ricordano il cartone. Spesso indica chicchi di raccolto vecchio.',
        'pt': 'Notas secas, amadeiradas ou envelhecidas que lembram papelão. Frequentemente indica grãos de safras antigas.',
        'pl': 'Suche, drzewne lub zwietrzałe nuty przypominające tekturę. Często wskazują na stare ziarno.',
        'nl': 'Droge, houtachtige of muffe tonen die doen denken aan karton. Wijst vaak op oude oogsten.',
        'sv': 'Torra, träiga eller unkna toner som påminner om kartong. Indikerar ofta gamla bönor.',
        'tr': 'Kartonu andıran kuru, odunsu veya bayat notalar. Genellikle eski mahsul çekirdekleri gösterir.',
        'ja': '段ボールを思わせる、乾いた、あるいは木のような、古びたノート。古い収穫豆や保管中の水分喪失を示します。',
        'ko': '판지를 연상시키는 건조하고 나무 같거나 묵은 느낌의 노트입니다. 주로 오래된 수확물이나 보관 중 수분 손실을 나타냅니다.',
        'zh': '干燥、木质或陈旧的风味，令人联想到纸板。通常预示着陈年豆或储存过程中的水分流失。',
        'ar': 'نوتات جافة أو خشبية أو قديمة تشبه الكرتون. غالبًا ما تشير إلى محاصيل قديمة أو فقدان الرطوبة أثناء التخزين.',
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
    print(f"Updated {len(data)} subcategories with full detail.")

if __name__ == '__main__':
    update_file(EXPANSION_DATA)
    os.system(f'python scripts/fix_flavor_escaping.py')
