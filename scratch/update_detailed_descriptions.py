import re

path = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

detailed_trans = {
    'wheel_cat_floral': {
        'it': 'Note delicate e aromatiche che ricordano i fiori. Questi sapori derivano spesso da ambienti ad alta quota dove la maturazione lenta concentra i composti aromatici volatili. Caratteristico delle varietà autoctone etiopi e dei Gesha.',
        'pt': 'Notas delicadas e aromáticas que lembram flores. Estes sabores provêm frequentemente de ambientes de elevada altitude, onde a maturação lenta concentra compostos aromáticos voláteis. Característico das variedades herança etíopes e Gesha.',
        'pl': 'Delikatne i aromatyczne nuty przypominające kwiaty. Smaki te często pochodzą z obszarów wysokogórskich, gdzie powolne dojrzewanie koncentruje lotne związki aromatyczne. Charakterystyczne dla etiopskich odmian heirloom i Gesha.',
        'nl': 'Verfijnde en aromatische tonen die doen denken aan bloesems. Deze smaken komen vaak voort uit hooggelegen gebieden waar langzame rijping vluchtige aromatische verbindingen concentreert. Kenmerkend voor Ethiopische heirloom en Gesha variëteiten.',
        'sv': 'Delikata och aromatiska toner som påminner om blommor. Dessa smaker kommer ofta från miljöer på hög höjd där långsam mognad koncentrerar flyktiga aromatiska föreningar. Karaktäristiskt för etiopiska arvsorter och Gesha-varieteter.',
        'tr': 'Çiçekleri andıran narin ve aromatik notalar. Bu tatlar genellikle yavaş olgunlaşmanın uçucu aromatik bileşikleri yoğunlaştırdığı yüksek rakımlı ortamlardan gelir. Etiyopya yerel çeşitleri ve Gesha çeşitlerinin özelliğidir.',
        'ja': '花を思わせる繊細で芳醇なノート。これらのフレーバーは、ゆっくりとした成熟によって揮発性芳香化合物が凝縮される高地環境に由来することが多い。エチオピアの在来種やゲイシャ種の特徴。',
        'ko': '꽃을 연상시키는 섬세하고 향기로운 노트입니다. 이러한 풍미는 종종 느린 성숙을 통해 휘발성 방향 화합물이 농축되는 고산 지대 환경에서 비롯됩니다. 에티오피아 토착종과 게이샤 품종의 특징입니다.',
        'zh': '令人联想到花朵的细腻芬芳。这些风味通常源自高海拔环境，缓慢的成熟过程浓缩了挥发性香气化合物。埃塞俄比亚原生种和瑰夏品种的典型特征。',
        'ar': 'نكهات رقيقة وعطرية تذكرنا بالزهور. غالبًا ما تأتي هذه النكهات من بيئات مرتفعة حيث يركز النضج البطيء المركبات العطرية المتطايرة. مميزة للسلالات الإثيوبية وأصناف الجيشا.',
    },
    'wheel_cat_fruity': {
        'it': 'Una vasta gamma di note dolci e aspre, dai frutti di bosco alle drupacee. Queste sono tipicamente associate ad acidi organici come il citrico e il malico, spesso esaltati da lavorazioni naturali o anaerobiche. Comuni nei caffè africani e del Centro America.',
        'pt': 'Uma vasta gama de notas doces e ácidas, desde bagas a frutas de caroço. Estas estão tipicamente associate a ácidos orgânicos como o cítrico e o málico, frequentemente realçados por processamento natural ou anaeróbico. Comum em cafés africanos e da América Central.',
        'pl': 'Szeroka gama słodkich i cierpkich nut, od jagód po owoce pestkowe. Są one zazwyczaj powiązane z kwasami organicznymi, takimi jak cytrynowy i jabłkowy, często wzmocnione przez obróbkę naturalną lub anaerobową. Powszechne w kawach afrykańskich i środkowoamerykańskich.',
        'nl': 'Een breed scala aan zoete en wrange tonen, van bessen tot steenvruchten. Deze worden doorgaans geassocieerd met organische zuren zoals citroenzuur en appelzuur, vaak versterkt door natuurlijke of anaerobe verwerking. Veelvoorkomend in Afrikaanse en Midden-Amerikaanse koffies.',
        'sv': 'Ett brett utbud av söta och syrliga toner från bär till stenfrukter. Dessa är vanligtvis förknippade med organiska syror som citron- och äppelsyra, ofta förstärkta genom naturlig eller anaerobisk process. Vanligt i afrikanska och centralamerikanska kaffebönor.',
        'tr': 'Meyvelerden çekirdekli meyvelere kadar geniş bir tatlı ve ekşi nota yelpazesi. Bunlar tipik olarak sitrik ve malik gibi organik asitlerle ilişkilidir ve genellikle doğal veya anaerobik işleme ile geliştirilir. Afrika ve Orta Amerika kahvelerinde yaygındır.',
        'ja': 'ベリーから核果まで、甘みと酸味の幅広いノート。これらは通常、クエン酸やリンゴ酸などの有機酸に関連しており、ナチュラルやアナエロビック（好気性）精製によって強調されることが多い。アフリカや中米のコーヒーに一般的。',
        'ko': '베리류에서 핵과류에 이르기까지 폭넓은 단맛과 산미의 노트입니다. 이는 일반적으로 구연산 및 사과산과 같은 유기산과 관련이 있으며, 내추럴 또는 무산소 발효 공정을 통해 강화되는 경우가 많습니다. 아프리카 및 중앙아메리카 커피에서 흔히 볼 수 있습니다.',
        'zh': '从浆果到核果的各种甜美和酸脆的音符。这些通常与柠檬酸和苹果酸等有机酸有关，常通过日晒或厌氧处理得到增强。常见于非洲和中美洲咖啡。',
        'ar': 'مجموعة واسعة من النكهات الحلوة واللاذعة من التوت إلى الفواكه ذات النواة. ترتبط هذه عادة بالأحماض العضوية مثل الستريك والماليك، وغالبًا ما يتم تعزيزها بالمعالجة الطبيعية أو اللاوائية. شائعة في القهوة الأفريقية ومن أمريكا الوسطى.',
    },
    'wheel_cat_sour_fermented': {
        'it': 'Note complesse che possono spaziare da piacevoli acidità pungenti a un intenso "funk" fermentato. Questi sapori derivano da processi metabolici durante la lavorazione del caffè (come la fermentazione prolungata). Spesso presenti in lotti a lavorazione sperimentale dalla Colombia e Costa Rica.',
        'pt': 'Notas complexas que podem variar entre ácidos picantes agradáveis e um intenso "funk" fermentado. Estes sabores resultam de processos metabólicos durante o processamento do café (como fermentação prolongada). Frequentemente encontrado em lotes de processamento experimental da Colômbia e Costa Rica.',
        'pl': 'Złożone nuty, od przyjemnych, cierpkich kwasów po intensywny, sfermentowany "funk". Smaki te wynikają z procesów metabolicznych podczas obróbki kawy (np. przedłużonej fermentacji). Często spotykane w partiach z eksperymentalną obróbką z Kolumbii i Kostaryki.',
        'nl': 'Complexe tonen die kunnen variëren van aangename pittige zuren tot intense gefermenteerde "funk". Deze smaken zijn het resultaat van metabolische processen tijdens de koffieverwerking (zoals langdurige fermentatie). Vaak te vinden in experimentele verwerkingspartijen uit Colombia en Costa Rica.',
        'sv': 'Komplexa toner som kan sträcka sig från behagliga syror till intensiv fermenterad "funk". Dessa smaker är ett resultat av metaboliska processer under kaffebearbetningen (som förlängd fermentering). Finns ofta i experimentella partier från Colombia och Costa Rica.',
        'tr': 'Hoş keskin asitlerden yoğun fermente "funk"a kadar değişebilen karmaşık notalar. Bu tatlar, kahve işleme sırasındaki metabolik süreçlerden (uzun süreli fermantasyon gibi) kaynaklanır. Genellikle Kolombiya ve Kosta Rika\'dan gelen deneysel işleme lotlarında bulunur.',
        'ja': '心地よい刺激的な酸味から強烈な発酵感（ファンク）まで、複雑なノート。これらのフレーバーは、コーヒーの精製過程における代謝プロセス（長期発酵など）から生じる。コロンビアやコスタリカの実験的精製ロットによく見られる。',
        'ko': '유쾌하고 톡 쏘는 산미에서 강렬한 발효 풍미에 이르는 복합적인 노트입니다. 이러한 풍미는 커피 가공 과정 중 대사 과정(예: 장기 발효)에서 비롯됩니다. 콜롬비아와 코스타리카의 실험적 가공 로트에서 자주 발견됩니다.',
        'zh': '复杂的气味，从愉悦的清脆酸度到强烈的发酵感。这些风味源自咖啡加工过程中的代谢过程（如延长发酵）。常出现在哥伦比亚和哥斯达黎加的实验性处理批次中。',
        'ar': 'نكهات معقدة يمكن أن تتراوح من أحماض لاذعة ممتعة إلى روائح تخمير مكثفة. تنتج هذه النكهات عن عمليات التمثيل الغذائي أثناء معالجة القهوة (مثل التخمير المطول). توجد غالبًا في دفعات المعالجة التجريبية من كولومبيا وكوستاريكا.',
    }
}

# Categories that need detailed trans for the remaining 10 langs
categories = [
    'wheel_cat_floral',
    'wheel_cat_fruity',
    'wheel_cat_sour_fermented',
    'wheel_cat_green_veg',
    'wheel_cat_roasted',
    'wheel_cat_spices',
    'wheel_cat_nutty_cocoa',
    'wheel_cat_sweet',
    'wheel_cat_others'
]

# (I will add the rest of the categories to detailed_trans in the script logic to save space here)

def update_cat(match):
    cat_id = match.group(1)
    block = match.group(2)
    
    if cat_id in detailed_trans:
        for lang, text in detailed_trans[cat_id].items():
            # Replace existing short trans with detailed one
            block = re.sub(f"'{lang}': '.*?'", f"'{lang}': '{text}'", block)
            # Or if it doesn't exist, add it
            if f"'{lang}':" not in block:
                block += f"\n        '{lang}': '{text}',"
    
    return f"'{cat_id}': {{{block}}},"

new_content = re.sub(r"'([a-z_]+)': \{(.*?)\},", update_cat, content, flags=re.DOTALL)

# (I will run a more complete script to handle all categories)
