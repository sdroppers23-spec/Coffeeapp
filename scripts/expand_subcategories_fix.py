# -*- coding: utf-8 -*-
import re
import os

FLAVOR_FILE = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

EXPANSION_DATA = {
    'wheel_sub_brown_spice': {
        'en': 'Warm, sweet spice notes that develop as sugars caramelize. Rich in phenolic compounds. Characteristic of Sumatran and Rwandan coffees.',
        'uk': 'Теплі, солодкі пряні ноти, що розвиваються при карамелізації цукрів. Багаті на фенольні сполуки. Характерно для суматранської та руандійської кави.',
        'de': 'Warme, süße Gewürznoten, die sich bei der Karamelisierung von Zucker entwickeln. Reich an phenolischen Verbindungen.',
        'fr': 'Notes d\'épices chaudes et sucrées qui se développent à mesure que les sucres se caramélisent. Riches en composés phénoliques.',
        'es': 'Notas de especias cálidas y dulces que se desarrollan a medida que los azúcares se caramelizan. Ricas en compuestos fenólicos.',
        'it': 'Note di spezie calde e dolci que si sviluppano man mano che gli zuccheri si caramellano. Ricco di composti fenolici.',
        'pt': 'Notas de especiarias quentes e doces que se desenvolvem à medida que os açúcares caramelizam. Ricas em compostos fenólicos.',
        'pl': 'Ciepłe, słodkie nuty korzenne, które rozwijają się podczas karmelizacji cukrów. Bogate w związki fenolowe.',
        'nl': 'Warme, zoete kruidige tonen die ontstaan wanneer suikers karameliseren. Rijk aan fenolische verbindingen.',
        'sv': 'Varma, söta kryddiga toner som utvecklas när sockerarterna karamelliseras. Rika på fenolföreningar.',
        'tr': 'Şekerler karamelize oldukça gelişen sıcak, tatlı baharat notaları. Fenolik bileşikler açısından zengindir.',
        'ja': '糖分がキャラメル化する際に生じる、温かみのある甘いスパイスのノート。フェノール化合物が豊富です。',
        'ko': '당분이 캐러멜화되면서 발생하는 따뜻하고 달콤한 스파이스 노트입니다. 페놀 화합물이 풍부합니다.',
        'zh': '糖分焦糖化时产生的温暖、甜香料风味。含有丰富的酚类化合物。苏门答腊和卢旺达咖啡的特征。',
        'ar': 'نوتات توابل دافئة وحلوة تتطور مع كراميل السكريات. غنية بالمركبات الفينولية.',
    },
    'wheel_sub_cereal': {
        'en': 'Toasted grain and bread-like notes. Indicative of early roast stages or specific bean density. Common in many Brazilian and Indian lots.',
        'uk': 'Ноти підсмаженого зерна та хліба. Вказують на ранні стадії обсмажування або специфічну щільність зерна. Зустрічається в багатьох бразильських та індійських лотах.',
        'de': 'Noten von geröstetem Getreide und Brot. Hinweis auf frühe Röstphasen oder spezifische Bohnendichte.',
        'fr': 'Notes de céréales grillées et de pain. Indique les premières étapes de la torréfaction.',
        'es': 'Notas de grano tostado y pan. Indicativo de las primeras etapas del tueste.',
        'it': 'Note di cereali tostati e pane. Indicativo delle prime fasi di tostatura.',
        'pt': 'Notas de grãos torrados e pão. Indicativo das fases iniciais da torra.',
        'pl': 'Nuty prażonych zbóż i chleba. Wskazują na wczesne etapy palenia.',
        'nl': 'Tonen van geroosterd graan en brood. Indicatief voor vroege brandstadia.',
        'sv': 'Toner av rostat spannmål och bröd. Indikerar tidiga rostningsstadier.',
        'tr': 'Kavrulmuş tahıl ve ekmek benzeri notalar. Erken kavurma aşamalarının göstergesidir.',
        'ja': 'トーストした穀物やパンのようなノート。焙煎の初期段階や特定の生豆密度を示します。',
        'ko': '구운 곡물과 빵 같은 노트입니다. 로스팅 초기 단계나 특정 생두 밀도를 나타냅니다.',
        'zh': '烤谷物和面包般风味。预示着烘焙早期阶段或特定的豆子密度。常见于许多巴西和印度咖啡。',
        'ar': 'نوتات الحبوب المحمصة والخبز. تشير إلى مراحل التحميص المبكرة أو كثافة معينة للحبوب.',
    },
    'wheel_sub_burnt': {
        'en': 'Intense smoky or carbonized notes. Result of high-temperature pyrolysis during roasting. Hallmarks of dark roast profiles.',
        'uk': 'Інтенсивні димні або обвуглені ноти. Результат високотемпературного піролізу під час обсмажування. Візитна картка профілів темного обсмаження.',
        'de': 'Intensive rauchige oder verkohlte Noten. Ergebnis der Hochtemperatur-Pyrolyse.',
        'fr': 'Notes fumées ou carbonisées intenses. Résultat d\'une pyrolyse à haute température.',
        'es': 'Notas intensas ahumadas o carbonizadas. Resultado de la pirólisis a alta temperatura.',
        'it': 'Intense note fumose o carbonizzate. Risultato della pirolisi ad alta temperatura.',
        'pt': 'Notas intensas de fumo ou carbonizadas. Resultado da pirólise a alta temperatura.',
        'pl': 'Intensywne nuty dymne lub zwęglone. Wynik pirolizy w wysokiej temperaturze.',
        'nl': 'Intense rokerige of verkoolde tonen. Resultaat van pyrolyse bij hoge temperaturen.',
        'sv': 'Intensiva rökiga eller karboniserade toner. Resultat av högtemperaturpyrolys.',
        'tr': 'Yoğun isli veya karbonize notalar. Kavurma sırasında yüksek sıcaklıkta piroliz sonucu oluşur.',
        'ja': '強烈なスモーキー、あるいは炭化したノート。焙煎中の高温熱分解の結果であり、深煎りの特徴です。',
        'ko': '강렬한 스모키 또는 탄 듯한 노트입니다. 로스팅 중 고온 열분해의 결과이며, 다크 로스트의 특징입니다.',
        'zh': '强烈的烟熏或碳化风味。烘焙过程中高温热分解的结果。深焙风味的标志。',
        'ar': 'نوتات دخانية مكثفة أو متفحمة. ناتجة عن التحلل الحراري في درجات حرارة عالية أثناء التحميص.',
    },
    'wheel_sub_green_vegetative': {
        'en': 'Herbal and grassy notes associated with fresh plant matter. Can reflect terroir or light roasting. Typical of under-developed high-density beans.',
        'uk': 'Трав\'янисті та злакові ноти, пов\'язані зі свіжою рослинною матерією. Можуть відображати терруар або світле обсмаження. Типово для недорозвинених щільних зерен.',
        'de': 'Kräuterige und grasige Noten, die mit frischer Pflanzenmaterie verbunden sind.',
        'fr': 'Notes herbacées et herbeuses associées à de la matière végétale fraîche.',
        'es': 'Notas herbales y herbáceas asociadas con materia vegetal fresca.',
        'it': 'Note erbacee e di erba associate a materia vegetale fresca.',
        'pt': 'Notas herbáceas e de relva associadas a matéria vegetal fresca.',
        'pl': 'Ziołowe i trawiaste nuty związane ze świeżą materią roślinną.',
        'nl': 'Kruidige en grasachtige tonen die geassocieerd worden met vers plantaardig materiaal.',
        'sv': 'Örtiga och gräsiga toner förknippade med färskt växtmaterial.',
        'tr': 'Taze bitkisel maddelerle ilişkili otsu ve çimensi notalar.',
        'ja': '新鮮な植物に関連する、ハーブや芝生のようなノート。テロワールや浅煎りを反映することがあります。',
        'ko': '신선한 식물과 관련된 허브 및 풀 같은 노트입니다. 테루아 또는 라이트 로스팅을 반영할 수 있습니다.',
        'zh': '与新鲜植物物质相关的草本和草地风味。可反映产地特征或浅焙。典型的高密度未完全发育的咖啡豆特征。',
        'ar': 'نوتات عشبية مرتبطة بالمادة النباتية الطازجة. يمكن أن تعكس التيروار أو التحميص الخفيف.',
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
