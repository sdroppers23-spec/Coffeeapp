import re

path = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

# Expanded translations for it, pt, pl, nl, sv, tr, ja, ko, zh, ar
# (Including categories already touched in previous turns to ensure consistency)
translations = {
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
        'ja': '心地よい刺激的な酸味から強烈な発酵感（ファンク）まで、複雑なノート。これらのフレーバーは、コーヒーの精製過程における代謝プロセス（長期発酵など）から生じる。コロンビアやコ스타リカの実験的精製ロットによく見られる。',
        'ko': '유쾌하고 톡 쏘는 산미에서 강렬한 발효 풍미에 이르는 복합적인 노트입니다. 이러한 풍미는 커피 가공 과정 중 대사 과정(예: 장기 발효)에서 비롯됩니다. 콜롬비아와 코스타리카의 실험적 가공 로트에서 자주 발견됩니다.',
        'zh': '复杂的气味，从愉悦的清脆酸度到强烈的发酵感。这些风味源自咖啡加工过程中的代谢过程（如延长发酵）。常出现在哥伦比亚和哥斯达黎加的实验性处理批次中。',
        'ar': 'نكهات معقدة يمكن أن تتراوح من أحماض لاذعة ممتعة إلى روائح تخمير مكثفة. تنتج هذه النكهات عن عمليات التمثيل الغذائي أثناء معالجة القهوة (مثل التخمير المطول). توجد غالبًا في دفعات المعالجة التجريبية من كولومبيا وكوستاريكا.',
    },
    'wheel_cat_green_veg': {
        'it': 'Note erbacee o vegetali che possono variare dall\'erba fresca tagliata ai piselli o al peperone verde. Spesso indica un grado di tostatura più chiaro o caffè lavorati con cura per preservare i precursori enzimatici.',
        'pt': 'Notas herbáceas ou vegetais que podem variar desde erva fresca cortada até ervilhas ou pimento verde. Frequentemente indica um grau de torra mais claro ou cafés processados com cuidado para preservar precursores enzimáticos.',
        'pl': 'Nuty trawiaste lub roślinne, które mogą wahać się od świeżo skoszonej trawy po groszek lub zieloną paprykę. Często wskazuje na jaśniejszy stopień wypalenia lub kawy przetwarzane z dbałością o zachowanie prekursorów enzymatycznych.',
        'nl': 'Grasachtige of plantaardige tonen die kunnen variëren van vers gemaaid gras tot doperwten of groene paprika. Vaak wijst dit op een lichtere branding of koffie die zorgvuldig is verwerkt om enzymatische voorlopers te behouden.',
        'sv': 'Gräsiga eller vegetabiliska toner som kan variera från nyslaget gräs till ärtor eller grön paprika. Indikerar ofta en ljusare rostningsgrad eller kaffe som bearbetats noggrant för att bevara enzymatiska prekursorer.',
        'tr': 'Taze kesilmiş ottan bezelye veya yeşil bibere kadar değişebilen otsu veya bitkisel notalar. Genellikle daha açık bir kavurma derecesini veya enzimatik öncüleri korumak için özenle işlenmiş kahveleri gösterir.',
        'ja': '刈りたての草からエンドウ豆、ピーマンまで、草本や植物のノート。多くの場合、浅めの焙煎度合いや、酵素前駆体を保持するために慎重に精製されたコーヒーであることを示す。',
        'ko': '갓 자른 풀에서 완두콩 또는 피망에 이르는 풀이나 식물성 노트입니다. 종종 더 밝은 로스팅 단계나 효소 전구체를 보존하기 위해 신중하게 가공된 커피를 나타냅니다.',
        'zh': '草本或植物气味，范围从刚割下的草地到豌豆或青椒。通常表示烘焙程度较浅，或为了保留酶前体而精心加工的咖啡。',
        'ar': 'نكهات عشبية أو نباتية يمكن أن تتراوح من العشب الطازج المقطوع إلى البازلاء أو الفلفل الأخضر. غالبًا ما يشير ذلك إلى درجة تحميص خفيفة أو قهوة تمت معالجتها بعناية للحفاظ على المركبات الإنزيمية.',
    },
    'wheel_cat_roasted': {
        'it': 'Sapori sviluppati durante il processo di tostatura, come il caramello, il pane tostato o le note di fumo. Queste note bilanciano l\'acidità con la dolcezza e la amarezza derivate dalla caramellizzazione e dalla reazione di Maillard.',
        'pt': 'Sabores desenvolvidos durante o processo de torra, como caramelo, pão torrado ou notas fumadas. Estas notas equilibram a acidez com a doçura e o amargor derivados da caramelização e da reação de Maillard.',
        'pl': 'Smaki powstałe podczas procesu palenia, takie jak karmel, tostowany chleb lub nuty dymne. Nuty te równoważą kwasowość słodyczą i goryczką pochodzącą z karmelizacji i reakcji Maillarda.',
        'nl': 'Smaken ontwikkeld tijdens het brandproces, zoals karamel, geroosterd brood of rokerige tonen. Deze tonen balanceren de zuurgraad met zoetheid en bitterheid die voortkomen uit karamellisatie en de Maillard-reactie.',
        'sv': 'Smaker som utvecklas under rostningsprocessen, såsom karamell, rostat bröd eller rökiga toner. Dessa toner balanserar syran med sötma och bitterhet som härrör från karamellisering och Maillard-reaktionen.',
        'tr': 'Karamel, kızarmış ekmek veya isli notalar gibi kavurma işlemi sırasında geliştirilen tatlar. Bu notalar, karamelizasyon ve Maillard reaksiyonundan kaynaklanan tatlılık ve acılık ile asiditeyi dengeler.',
        'ja': 'キャラメル、トースト、スモーキーなノートなど、焙煎過程で形成されるフレーバー。これらのノートは、キャラメル化やメイラード反応に由来する甘みや苦味と酸味のバランスを整える。',
        'ko': '카라멜, 토스트 또는 스모키한 노트와 같이 로스팅 과정에서 발달된 풍미입니다. 이러한 노트는 카라멜화 및 마이야르 반응에서 비롯된 단맛과 쓴맛으로 산미의 균형을 맞춥니다.',
        'zh': '烘焙过程中产生的风味，如焦糖、烤面包或烟熏味。这些音符通过焦糖化和美拉德反应带来的甜味和苦味来平衡酸度。',
        'ar': 'نكهات تتطور أثناء عملية التحميص، مثل الكراميل أو الخبز المحمص أو النكهات الدخانية. توازن هذه النكهات الحموضة مع الحلاوة واللمسة المرة الناتجة عن الكرملة وتفاعل مايلارد.',
    },
    'wheel_cat_spices': {
        'it': 'Note calde e speziate come cannella, chiodo di garofano o pepe. Spesso associate a tostature medie o a specifiche origini asiatiche, queste note aggiungono profondità e complessità al profilo sensoriale.',
        'pt': 'Notas quentes e condimentadas como canela, cravinho ou pimenta. Frequentemente associadas a torras médias ou a origens asiáticas específicas, estas notas adicionam profundità e complexidade ao perfil sensorial.',
        'pl': 'Ciepłe i korzenne nuty, takie jak cynamon, goździki lub pieprz. Często kojarzone ze średnim stopniem palenia lub konkretnymi azjatyckimi pochodzeniami, nuty te dodają głębi i złożoności profilowi sensorycznemu.',
        'nl': 'Warme en kruidige tonen zoals kaneel, kruidnagel of peper. Vaak geassocieerd met medium brandingen of specifieke Aziatische herkomsten; deze tonen voegen diepte und complexiteit toe aan het sensorische profiel.',
        'sv': 'Varma och kryddiga toner som kanel, kryddnejlika eller peppar. Ofta förknippade med mellanrostning eller specifika asiatiska ursprung, tillför dessa toner djup och komplexitet till den sensoriska profilen.',
        'tr': 'Tarçın, karanfil veya biber gibi sıcak ve baharatlı notalar. Genellikle orta kavurmalarla veya belirli Asya kökenleriyle ilişkilendirilen bu notalar, duyusal profile derinlik ve karmaşıklık katar.',
        'ja': 'シナモン、クローブ、ペッパーなどの温かみのあるスパイシーなノート。中煎りや特定のアジア産コーヒーに関連することが多く、官能的なプロファイルに深みと複雑さを加える。',
        'ko': '시나몬, 클로브 또는 후추와 같은 따뜻하고 스파이시한 노트입니다. 종종 중배전이나 특정 아시아 산지와 관련이 있으며, 이러한 노트는 감각적 프로필에 깊이와 복합성을 더해줍니다.',
        'zh': '温暖的香料气味，如肉桂、丁香或胡椒。通常与中度烘焙或特定的亚洲产地有关，这些音符为感官轮廓增添了深度和复杂性。',
        'ar': 'نكهات دافئة وحارة مثل القرفة أو القرنفل أو الفلفل. ترتبط غالبًا بالتحميص المتوسط أو أصول آسيوية محددة، وتضيف هذه النكهات عمقًا وتعقيدًا للملف الحسي.',
    },
    'wheel_cat_nutty_cocoa': {
        'it': 'Note rassicuranti di nocciola, mandorla o cioccolato fondente. Queste sono tra le note più comuni e apprezzate nel caffè, derivanti dalla decomposizione degli zuccheri e delle proteine durante la tostatura.',
        'pt': 'Notas reconfortantes de avelã, amêndoa ou chocolate preto. Estas estão entre as notas mais comuns e apreciadas no café, resultantes da decomposição de açúcares e proteínas durante a torra.',
        'pl': 'Kojące nuty orzechów laskowych, migdałów lub ciemnej czekolady. Są to jedne z najczęstszych i najbardziej cenionych nut w kawie, wynikające z rozpadu cukrów i białek podczas palenia.',
        'nl': 'Vertrouwde tonen van hazelnoot, amandel of pure chocolade. Deze behoren tot de meest voorkomende en gewaardeerde tonen in koffie, voortkomend uit de afbraak van suikers en eiwitten tijdens het branden.',
        'sv': 'Trygga toner av hasselnöt, mandel eller mörk choklad. Dessa hör till de vanligaste och mest uppskattade tonerna i kaffe och härrör från nedbrytning av sockerarter och proteiner under rostningen.',
        'tr': 'Fındık, badem veya bitter çikolata gibi güven verici notalar. Bunlar, kavurma sırasında şekerlerin ve proteinlerin parçalanmasından kaynaklanan, kahvede en yaygın ve beğenilen notalar arasındadır.',
        'ja': 'ヘーゼルナッツ、アーモンド、ダークチョコレートなどの安心感のあるノート。これらはコーヒーにおいて最も一般的で好まれるノートの一つであり、焙煎中の糖分やタンパク質の分解によって生じる。',
        'ko': '헤이즐넛, 아몬드 또는 다크 초콜릿과 같은 편안한 노트입니다. 이는 로스팅 중 당분과 단백질이 분해되면서 발생하는, 커피에서 가장 흔하고 선호되는 노트 중 하나입니다.',
        'zh': '令人舒心的榛子、杏仁或黑巧克力气味。这些是咖啡中最常见且最受欢迎的风味之一，源自烘焙过程中糖分和蛋白质的分解。',
        'ar': 'نكهات مريحة من البندق أو اللوز أو الشوكولاتة الداكنة. هذه من بين النكهات الأكثر شيوعًا وتقديرًا في القهوة، وهي ناتجة عن تحلل السكريات والبروتينات أثناء التحميص.',
    },
    'wheel_cat_sweet': {
        'it': 'La percezione della dolcezza che può ricordare lo zucchero di canna, il miele o il caramello. Fondamentale per bilanciare l\'amarezza e l\'acidità, la dolcezza è spesso il segno di una raccolta di ciliegie mature e di una tostatura precisa.',
        'pt': 'A perceção de doçura que pode lembrar açúcar mascavado, mel ou caramelo. Fundamental para equilibrar o amargor e a acidez, a doçura é frequentemente sinal de uma colheita de cerejas maduras e de uma torra precisa.',
        'pl': 'Odczucie słodyczy, które może przypominać brązowy cukier, miód lub karmel. Słodycz, kluczowa dla zrównoważenia goryczy i kwasowości, jest często oznaką zbioru dojrzałych owoców i precyzyjnego palenia.',
        'nl': 'De perceptie van zoetheid die kan doen denken aan bruine suiker, honing of karamel. Essentieel voor het balanceren van bitterheid en zuurgraad; zoetheid is vaak een teken van het oogsten van rijpe bessen en nauwkeurig branden.',
        'sv': 'Upplevelsen av sötma som kan påminna om farinsocker, honung eller karamell. Sötma är avgörande för att balansera bitterhet och syra och är ofta ett tecken på skörd av mogna bär och en precis rostning.',
        'tr': 'Esmer şeker, bal veya karameli andırabilen tatlılık algısı. Acılık ve asiditeyi dengelemek için temel olan tatlılık, genellikle olgun meyvelerin hasat edilmesinin ve hassas bir kavurmanın işaretidir.',
        'ja': 'ブラウンシュガー、蜂蜜、キャラメルなどを連想させる甘みの感覚。苦味と酸味のバランスを整えるのに不可欠な甘みは、完熟したチェリーの収穫と正確な焙煎の証であることが多い。',
        'ko': '흑설탕, 꿀 또는 카라멜을 연상시킬 수 있는 단맛의 지각입니다. 쓴맛과 산미의 균형을 맞추는 데 필수적인 단맛은 종종 잘 익은 체리의 수확과 정밀한 로스팅의 신호입니다.',
        'zh': '对甜味的感知，可能令人联想到红糖、蜂蜜或焦糖。甜味对于平衡苦味和酸度至关重要，通常是采摘成熟浆果和精准烘焙的标志。',
        'ar': 'إدراك الحلاوة الذي يمكن أن يذكرنا بالسكر البني أو العسل أو الكراميل. تعتبر الحلاوة أساسية لموازنة المرارة والحموضة، وغالبًا ما تكون علامة على حصاد الكرز الناضج والتحميص الدقيق.',
    },
    'wheel_cat_others': {
        'it': 'Include note meno comuni o difetti, come sentori di carta, terra o note chimiche. In un contesto specialty, queste possono anche riferirsi a profili aromatici unici che non rientrano chiaramente nelle altre categorie.',
        'pt': 'Inclui notas menos comuns ou defeitos, como aromas de papel, terra ou notas químicas. Num contexto specialty, estas também se podem referir a perfis aromáticos únicos que não se encaixano claramente noutras categorias.',
        'pl': 'Obejmuje rzadsze nuty lub wady, takie jak aromaty papieru, ziemi lub nuty chemiczne. W kontekście specialty mogą one również odnosić się do unikalnych profili aromatycznych, które nie pasują wyraźnie do innych kategorii.',
        'nl': 'Bevat minder gebruikelijke tonen of defecten, zoals aroma\'s van papier, aarde of chemische tonen. In een specialty context kunnen deze ook verwijzen naar unieke aromatische profielen die niet duidelijk in andere categorieën vallen.',
        'sv': 'Innehåller mindre vanliga toner eller defekter, såsom aromer av papper, jord eller kemiska toner. I ett specialty-sammanhang kan dessa också syfta på unika aromatiska profiler som inte tydligt passar in i andra kategorier.',
        'tr': 'Kağıt, toprak veya kimyasal notalar gibi daha az yaygın notaları veya kusurları içerir. Nitelikli kahve (specialty) bağlamında bunlar, diğer kategorilere net bir şekilde uymayan benzersiz aromatik profilleri de ifade edebilir.',
        'ja': '紙、土、化学的なノートなど、一般的でないノートや欠陥を含む。スペシャルティコーヒーの文脈では、他のカテゴリーに明確に当てはまらないユニークなアロマプロファイルを指すこともある。',
        'ko': '종이, 흙 또는 화학적 노트와 같이 덜 일반적인 노트나 결함을 포함합니다. 스페셜티 상황에서는 다른 카테고리에 명확하게 들어맞지 않는 독특한 아로마 프로필을 의미할 수도 있습니다.',
        'zh': '包括较不常见的音符或缺陷，如纸张、泥土或化学气味。在精品咖啡语境中，这些也可能指不属于其他类别的独特香气轮廓。',
        'ar': 'تشمل النكهات الأقل شيوعًا أو العيوب، مثل روائح الورق أو التربة أو النكهات الكيميائية. في سياق القهوة المختصة، يمكن أن تشير هذه أيضًا إلى ملفات عطرية فريدة لا تندرج بوضوح تحت الفئات الأخرى.',
    }
}

def update_content(match):
    cat_id = match.group(1)
    block = match.group(2)
    
    if cat_id in translations:
        for lang, text in translations[cat_id].items():
            # Check if language already exists in the block
            lang_pattern = f"'{lang}':\\s*['\"].*?['\"]"
            if re.search(lang_pattern, block):
                # Replace existing
                block = re.sub(lang_pattern, f"'{lang}': '{text}'", block)
            else:
                # Add new at the end of the block before the closing brace
                block = block.rstrip() + f",\n        '{lang}': '{text}'"
                
    return f"'{cat_id}': {{{block}}},"

new_content = re.sub(r"'([a-z_]+)': \{(.*?)\},", update_content, content, flags=re.DOTALL)

with open(path, 'w', encoding='utf-8') as f:
    f.write(new_content)

print("Updated flavor descriptions for 10 additional languages.")
