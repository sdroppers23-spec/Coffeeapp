class FlavorDescriptions {
  static String getDescription(String key, String locale) {
    final Map<String, Map<String, String>> descriptions = {
      // --- CATEGORIES ---
      'wheel_cat_floral': {
        'en':
            'Delicate and aromatic notes reminiscent of blossoms. These flavors often arise from high-altitude conditions where slow maturation concentrates volatile aromatic compounds. Characteristic of Ethiopian heirlooms and Gesha varieties.',
        'uk':
            'Делікатні та ароматні ноти, що нагадують цвітіння. Ці смаки часто виникають завдяки високогірним умовам, де повільне дозрівання концентрує летючі ароматичні сполуки. Характерно для ефіопської спадщини та сортів Гейша.',
        'de':
            'Zarte und aromatische Noten, die an Blüten erinnern. Diese Aromen entstehen oft durch Höhenlagen, in denen eine langsame Reifung flüchtige aromatische Verbindungen konzentriert. Charakteristisch für äthiopische Erbstücke und Gesha-Varietäten.',
        'fr':
            'Notes délicates et aromatiques rappelant les fleurs. Ces saveurs proviennent souvent de conditions de haute altitude où la maturation lente concentre les composés aromatiques volatils. Caractéristique des variétés héritage éthiopiennes et Gesha.',
        'es':
            'Notas delicadas y aromáticas que recuerdan a las flores. Estos sabores suelen surgir de condiciones de gran altitud donde la maduración lenta concentra compuestos aromáticos volátiles. Característico de las variedades tradicionales etíopes y Gesha.',
        'it':
            'Note delicate e aromatiche che ricordano i fiori. Questi sapori derivano spesso da condizioni di alta quota dove la lenta maturazione concentra i composti aromatici volatili. Caratteristico delle varietà heirloom etiopi e Gesha.',
        'pt':
            'Notas delicadas e aromáticas que lembram flores. Esses sabores surgem frequentemente de condições de alta altitude, onde a maturação lenta concentra compostos aromáticos voláteis. Característico das variedades tradicionais etíopes e Gesha.',
        'pl':
            'Delikatne i aromatyczne nuty przypominające kwiaty. Smaki te często wynikają z warunków wysokogórskich, w których powolne dojrzewanie koncentruje lotne związki aromatyczne. Charakterystyczne dla etiopskich odmian heirloom i Gesha.',
        'nl':
            'Verfijnde en aromatische tonen die doen denken aan bloesem. Deze smaken ontstaan vaak door omstandigheden op grote hoogte, waar langzame rijping vluchtige aromatische verbindingen concentreert. Kenmerkend voor Ethiopische erfstukken en Gesha-variëteiten.',
        'sv':
            'Delikata och aromatiska toner som påminner om blommor. Dessa smaker uppstår ofta från höghöjdsförhållanden där långsam mognad koncentrerar flyktiga aromatiska föreningar. Karaktäristiskt för etiopiska kulturarvsorter och Gesha-varieteter.',
        'tr':
            'Çiçekleri anımsatan narin ve aromatik notalar. Bu tatlar genellikle, yavaş olgunlaşmanın uçucu aromatik bileşikleri yoğunlaştırdığı yüksek rakımlı koşullardan kaynaklanır. Etiyopya heirloom ve Gesha çeşitlerinin özelliğidir.',
        'ja':
            '開花を思わせる繊細で芳醇なノート。これらのフレーバーは、ゆっくりとした成熟によって揮発性芳香化合物が濃縮される高地条件から生じることが多いです。エチオピアの在来種やゲイシャ種に特徴的です。',
        'ko':
            '꽃을 연상시키는 섬세하고 향긋한 노트. 이러한 풍미는 천천히 숙성되면서 휘발성 방향 성분이 농축되는 고산 지대 환경에서 주로 발생합니다. 에티오피아의 토종 품종과 게이샤 품종의 특징입니다.',
        'zh':
            '令人联想到花朵的细腻芳香。这些风味通常源于高海拔条件，缓慢的成熟过程使挥发性芳香化合物更加浓缩。是埃塞俄比亚原生种和瑰夏品种的特征。',
        'ar':
            'نكهات رقيقة وعطرية تذكرنا بالأزهار. غالبًا ما تنشأ هذه النكهات من ظروف الارتفاعات العالية حيث يركز النضج البطيء المركبات العطرية المتطايرة. مميز للسلالات الإثيوبية وأصناف جيشا.',
      },
      'wheel_sub_floral': {
        'en':
            'Distinct and clear floral aromas. Typically these are primary aromas found in very fresh coffee or light roasted coffee. Characteristic of high-quality Ethiopian and Panamanian lots.',
        'uk':
            'Виразні та чіткі квіткові аромати. Зазвичай це первинні аромати, що зустрічаються в дуже свіжій каві або каві світлого обсмажування. Характерно для високоякісних ефіопських та панамських лотів.',
        'de':
            'Ausgeprägte und klare blumige Aromen. Normalerweise sind dies primäre Aromen, die in sehr frischem Kaffee oder hell geröstetem Kaffee vorkommen. Charakteristisch für hochwertige äthiopische und panamaische Partien.',
        'fr':
            "Arômes floraux distincts et clairs. Il s'agit généralement d'arômes primaires trouvés dans le café très frais ou le café à torréfaction légère. Caractéristique des lots éthiopiens et panaméens de haute qualité.",
        'es':
            'Aromas florales claros y distintos. Normalmente estos son aromas primarios que se encuentran en cafés muy frescos o de tueste ligero. Característico de los lotes de alta calidad de Etiopía y Panamá.',
        'it':
            'Aromi floreali distinti e chiari. Tipicamente questi sono aromi primari che si trovano in caffè molto fresco o caffè a tostatura chiara. Caratteristico dei lotti etiopi e panamensi di alta qualità.',
        'pt':
            'Aromas florais distintos e claros. Normalmente estes são aromas primários encontrados em café muito fresco ou café de torra clara. Característico de lotes etíopes e panamenses de alta qualidade.',
        'pl':
            'Wyraźne i jasne aromaty kwiatowe. Zazwyczaj są to aromaty pierwotne występujące w bardzo świeżej kawie lub kawie o jasnym paleniu. Charakterystyczne dla wysokiej jakości etiopskich i panamskich partii.',
        'nl':
            "Duidelijke en heldere bloemige aroma's. Meestal zijn dit primaire aroma's die voorkomen in zeer verse koffie of licht gebrande koffie. Kenmerkend voor hoogwaardige Ethiopische en Panamese partijen.",
        'sv':
            'Tydliga och klara blommiga aromer. Vanligtvis är dessa primära aromer som finns i mycket färskt kaffe eller ljusrostat kaffe. Karaktäristiskt för etiopiska och panamanska partier av hög kvalitet.',
        'tr':
            'Belirgin ve net çiçeksi aromalar. Genellikle bunlar çok taze kahvelerde veya hafif kavrulmuş kahvelerde bulunan birincil aromalardır. Yüksek kaliteli Etiyopya ve Panama lotlarının özelliğidir.',
        'ja':
            'はっきりと明確なフローラルの香り。通常、これらは非常に新鮮なコーヒーや浅煎りのコーヒーに見られる一次アロマです。高品質なエチオピア産やパナマ産のロットに特徴的です。',
        'ko':
            '뚜렷하고 선명한 꽃향기. 일반적으로 매우 신선한 커피나 약배전 커피에서 발견되는 1차 아로마입니다. 고품질 에티오피아 및 파나마 로트의 특징입니다.',
        'zh': '独特而清晰的花香。通常这些是在非常新鲜的咖啡或浅烘焙咖啡中发现的主要香气。是高品质埃塞俄比亚和巴拿马批次的特征。',
        'ar':
            'روائح زهرية متميزة وواضحة. وعادة ما تكون هذه هي الروائح الأساسية الموجودة في القهوة الطازجة جداً أو القهوة المحمصة بشكل خفيف. مميزة للمحاصيل الإثيوبية والبنمانية عالية الجودة.',
      },
      'wheel_cat_fruity': {
        'en':
            'A wide range of sweet and tart notes from berries to stone fruits. These are typically associated with organic acids like citric and malic, often enhanced by natural or anaerobic processing. Common in African and Central American coffees.',
        'uk':
            'Широкий спектр солодких та кислих нот від ягід до кісточкових фруктів. Зазвичай вони пов\'язані з органічними кислотами, такими як лимонна та яблучна, часто посилюються натуральною або анаеробною обробкою. Типово для африканської та центральноамериканської кави.',
        'de':
            'Ein breites Spektrum an süßen und säuerlichen Noten, von Beeren bis hin zu Steinobst. Diese werden typischerweise mit organischen Säuren wie Zitronen- und Apfelsäure in Verbindung gebracht, die oft durch natürliche oder anaerobe Aufbereitung verstärkt werden. Häufig bei afrikanischen und mittelamerikanischen Kaffees.',
        'fr':
            'Une large gamme de notes sucrées et acidulées, des baies aux fruits à noyau. Celles-ci sont généralement associées à des acides organiques comme les acides citrique et malique, souvent renforcés par un traitement naturel ou anaérobie. Commun dans les cafés africains et d\'Amérique centrale.',
        'es':
            'Una amplia gama de notas dulces y ácidas, desde bayas hasta frutas de hueso. Estas suelen asociarse con ácidos orgánicos como el cítrico y el málico, a menudo potenciados por procesos naturales o anaeróbicos. Común en cafés africanos y centroamericanos.',
        'it':
            'Un\'ampia gamma di note dolci e aspre, dalle bacche alle drupacee. Questi aromi sono tipicamente associati ad acidi organici come il citrico e il malico, spesso esaltati da processi naturali o anaerobici. Comune nei caffè africani e del Centro America.',
        'pt':
            'Uma ampla gama de notas doces e ácidas, de bagas a frutas de caroço. Estas estão tipicamente associadas a ácidos orgânicos como o cítrico e o málico, muitas vezes reforçados por processamento natural ou anaeróbico. Comum em cafés africanos e centro-americanos.',
        'pl':
            'Szeroka gama słodkich i cierpkich nut, od jagód po owoce pestkowe. Są one zazwyczaj związane z kwasami organicznymi, takimi jak cytrynowy i jabłkowy, często wzmocnionymi przez obróbkę naturalną lub anaerobową. Powszechne w kawach afrykańskich i środkowoamerykańskich.',
        'nl':
            'Een breed scala aan zoete en rinse tonen, van bessen tot steenvruchten. Deze worden meestal geassocieerd met organische zuren zoals citroenzuur und appelzuur, vaak versterkt door natuurlijke of anaerobe verwerking. Veelvoorkomend in Afrikaanse en Centraal-Amerikaanse koffiesoorten.',
        'sv':
            'Ett brett utbud av söta och syrliga noter från bär till stenfrukter. Dessa förknippas vanligtvis med organiska syror som citron- och äppelsyra, ofta förstärkta genom naturlig eller anaerobisk process. Vanligt i afrikanskt och mellanamerikanskt kaffe.',
        'tr':
            'Böğürtlenlerden çekirdekli meyvelere kadar geniş bir tatlı ve mayhoş nota yelpazesi. Bunlar tipik olarak sitrik ve malik gibi organik asitlerle ilişkilendirilir ve genellikle doğal veya anaerobik işleme ile güçlendirilir. Afrika ve Orta Amerika kahvelerinde yaygındır.',
        'ja':
            'ベリー系から核果系まで、甘みと酸味の幅広いノート。これらは通常、クエン酸やリン酸などの有機酸に関連しており、ナチュラルやアナエロビック（好気性）精製によって強調されることが多いです。アフリカ産や中米産のコーヒーによく見られます。',
        'ko':
            '베리류부터 핵과류까지 광범위한 달콤하고 새콤한 노트입니다. 이는 일반적으로 구연산 및 사과산과 같은 유기산과 관련이 있으며, 내추럴 또는 무산소 발효 가공에 의해 강화되는 경우가 많습니다. 아프리카 및 중앙아메리카 커피에서 흔히 볼 수 있습니다.',
        'zh':
            '从浆果到核果的各种甜美和酸甜的气息。这些风味通常与柠檬酸和苹果酸等有机酸有关，通常通过自然或厌氧处理得到增强。在非洲和中美洲咖啡中很常见。',
        'ar':
            'مجموعة واسعة من النكهات الحلوة واللاذعة من التوت إلى الفواكه ذات النواة. ترتبط هذه النكهات عادةً بالأحماض العضوية مثل حامض الستريك والماليك، وغالباً ما يتم تعزيزها من خلال المعالجة الطبيعية أو اللاهوائية. شائعة في أنواع القهوة الأفريقية ومن أمريكا الوسطى.',
      },
      'wheel_cat_sour_fermented': {
        'en':
            'Complex notes that can range from pleasant tangy acids to intense fermented funk. These flavors result from metabolic processes during coffee processing (like prolonged fermentation). Often found in experimental processing lots from Colombia and Costa Rica.',
        'uk':
            'Комплексні ноти, що можуть варіюватися від приємних гострих кислот до інтенсивного ферментованого "фанку". Ці смаки є результатом метаболічних процесів під час обробки кави (наприклад, тривала ферментація). Часто зустрічається в лотах з експериментальною обробкою з Колумбії та Коста-Ріки.',
        'de':
            'Komplexe Noten, die von angenehm spritzigen Säuren bis hin zu intensivem fermentiertem "Funk" reichen können. Diese Aromen resultieren aus Stoffwechselprozessen während der Kaffeeaufbereitung (wie z. B. längerer Fermentation). Oft zu finden in experimentell aufbereiteten Partien aus Kolumbien und Costa Rica.',
        'fr':
            'Notes complexes pouvant aller d\'acides acidulés agréables à un "funk" fermenté intense. Ces saveurs résultent de processus métaboliques pendant le traitement du café (comme une fermentation prolongée). Souvent trouvé dans les lots de traitement expérimental de Colombie et du Costa Rica.',
        'es':
            'Notas complejas que pueden ir desde agradables ácidos punzantes hasta un intenso "funk" fermentado. Estos sabores resultan de procesos metabólicos durante el procesamiento del café (como la fermentación prolongada). A menudo se encuentran en lotes de procesamiento experimental de Colombia y Costa Rica.',
        'it':
            'Note complesse che possono variare da piacevoli acidi pungenti a un intenso "funk" fermentato. Questi aromi derivano da processi metabolici durante la lavorazione del caffè (come una fermentazione prolungata). Spesso presente in lotti di lavorazione sperimentale provenienti da Colombia e Costa Rica.',
        'pt':
            'Notas complexas que podem variar de ácidos picantes agradáveis a um intenso "funk" fermentado. Estes sabores resultam de processos metabólicos durante o processamento do café (como a fermentação prolongada). Frequentemente encontrado em lotes de processamento experimental da Colômbia e Costa Rica.',
        'pl':
            'Złożone nuty, które mogą obejmować zarówno przyjemne, ostre kwasy, jak i intensywny sfermentowany "funk". Smaki te wynikają z procesów metabolicznych podczas obróbki kawy (np. przedłużonej fermentacji). Często spotykane w eksperymentalnych partiach z Kolumbii i Kostaryki.',
        'nl':
            'Complex tonen die kunnen variëren van aangenaam scherpe zuren tot intens gefermenteerde "funk". Deze smaken zijn het resultaat van metabole processen tijdens de koffieverwerking (zoals langdurige fermentatie). Vaak te vinden in experimenteel verwerkte partijen uit Colombia en Costa Rica.',
        'sv':
            'Komplexa noter som kan sträcka sig från behagligt syrliga syror till intensiv fermenterad "funk". Dessa smaker är ett resultat av metaboliska processer under kaffeberedningen (som förlängd fermentering). Finns ofta i experimentellt beredda partier från Colombia och Costa Rica.',
        'tr':
            'Hoş keskin asitlerden yoğun fermente "funk" notalarına kadar uzanabilen karmaşık notalar. Bu tatlar, kahve işleme sırasındaki metabolik süreçlerin (uzun süreli fermantasyon gibi) sonucudur. Genellikle Kolombiya ve Kosta Rika\'dan gelen deneysel işleme lotlarında bulunur.',
        'ja':
            '心地よい刺激のある酸味から、強烈な発酵感（ファンク）まで多岐にわたる複雑なノート。これらは、コーヒーの精製過程における代謝プロセス（長期発酵など）の結果として生まれます。コロンビアやコスタリカの実験的な精製ロットによく見られます。',
        'ko':
            '기분 좋게 톡 쏘는 산미부터 강렬한 발효된 "펑크(funk)"까지 다양한 복합적인 노트입니다. 이러한 풍미는 커피 가공 중 대사 과정(예: 장기 발효)에서 발생합니다. 콜롬비아와 코스타리카의 실험적인 가공 로트에서 자주 발견됩니다.',
        'zh':
            '复杂的风味，从愉悦的酸爽到强烈的发酵感。这些风味源于咖啡处理过程中的代谢反应（如延长发酵时间）。常见于哥伦比亚和哥斯达黎加的实验性处理批次。',
        'ar':
            'نكهات معقدة يمكن أن تتراوح من أحماض لاذعة ممتعة إلى روائح تخمر قوية. تنتج هذه النكهات عن عمليات التمثيل الغذائي أثناء معالجة القهوة (مثل التخمير المطول). غالباً ما توجد في محاصيل المعالجة التجريبية من كولومبيا وكوستاريكا.',
      },
      'wheel_cat_green_veg': {
        'en':
            'Herbal or vegetal notes that evoke fresh-cut grass or raw vegetables. These can indicate a lighter roast profile or specific varieties that retain "green" characteristics. Common in some Indonesian or under-roasted high-density beans.',
        'uk':
            'Трав\'янисті або овочеві ноти, що нагадують свіжоскошену траву або сирі овочі. Вони можуть вказувати на світлий профіль обсмаження або специфічні сорти, що зберігають "зелені" характеристики. Зустрічається в деяких індонезійських лотах або при світлому обсмаженні щільних зерен.',
        'de':
            'Kräuter- oder Gemüsenoten, die an frisch geschnittenes Gras oder rohes Gemüse erinnern. Diese können auf ein helleres Röstprofil oder spezifische Varietäten hindeuten, die "grüne" Eigenschaften beibehalten. Häufig bei einigen indonesischen oder hell gerösteten Kaffees mit hoher Dichte.',
        'fr':
            'Notes herbacées ou végétales évoquant l\'herbe fraîchement coupée ou les légumes crus. Celles-ci peuvent indiquer un profil de torréfaction plus clair ou des variétés spécifiques qui conservent des caractéristiques "vertes". Commun dans certains lots indonésiens ou les grains à haute densité sous-torréfiés.',
        'es':
            'Notas herbales o vegetales que evocan hierba recién cortada o verduras crudas. Estas pueden indicar un perfil de tueste más ligero o variedades específicas que conservan características "verdes". Común en algunos lotes indonesios o granos de alta densidad poco tostados.',
        'it':
            'Note erbacee o vegetali che evocano l\'erba appena tagliata o le verdure crude. Questi aromi possono indicare un profilo di tostatura più chiaro o varietà specifiche che mantengono caratteristiche "verdi". Comune in alcuni lotti indonesiani o in chicchi ad alta densità poco tostati.',
        'pt':
            'Notas herbais ou vegetais que evocam relva acabada de cortar ou vegetais crus. Estas podem indicar um perfil de torra mais claro ou variedades específicas que mantêm características "verdes". Comum em alguns lotes indonésios ou grãos de alta densidade pouco torrados.',
        'pl':
            'Ziołowe lub roślinne nuty przypominające świeżo skoszoną trawę lub surowe warzywa. Mogą one wskazywać na jaśniejszy profil palenia lub specyficzne odmiany, które zachowują "zielone" cechy. Powszechne w niektórych partiach indonezyjskich lub niedopalonych ziarnach o wysokiej gęstości.',
        'nl':
            'Kruidige of plantaardige tonen die doen denken aan vers gemaaid gras of rauwe groenten. Deze kunnen wijzen op een lichter brandingsprofiel of specifieke variëteiten die "groene" kenmerken behouden. Veelvoorkomend in sommige Indonesische of te licht gebrande koffiebonen met een hoge dichtheid.',
        'sv':
            'Ört- eller vegetabiliska noter som påminner om nyklippt gräs eller råa grönsaker. Dessa kan tyda på en ljusare rostningsprofil eller specifika varieteter som behåller "gröna" egenskaper. Vanligt i vissa indonesiska partier eller underrostade bönor med hög densitet.',
        'tr':
            'Taze kesilmiş çimen veya çiğ sebzeleri andıran otsu veya bitkisel notalar. Bunlar, daha açık bir kavurma profilini veya "yeşil" özelliklerini koruyan belirli çeşitleri işaret edebilir. Bazı Endonezya kahvelerinde veya az kavrulmuş yüksek yoğunluklu çekirdeklerde yaygındır.',
        'ja':
            '刈りたての草や生の野菜を思わせる、ハーブ系または植物系のノート。これらは浅煎りの焙煎プロフィールや、「グリーン」な特性を保持しやすい特定の品種を示している場合があります。一部のインドネシア産や、焙煎不足の密度の高い豆によく見られます。',
        'ko':
            '갓 자른 풀이나 생채소를 연상시키는 허브 또는 식물성 노트입니다. 이는 더 라이트한 로스팅 프로필이나 "그린" 특성을 유지하는 특정 품종을 나타낼 수 있습니다. 일부 인도네시아 커피나 로스팅이 덜 된 고밀도 생두에서 흔히 볼 수 있습니다.',
        'zh':
            '草本或蔬菜的气息，让人联想到新割的草或生蔬菜。这些风味可能预示着浅度烘焙风格或某些保留了“青绿色”特征的品种。在某些印度尼西亚咖啡或烘焙程度不足的高密度咖啡豆中很常见。',
        'ar':
            'نكهات عشبية أو نباتية تذكر بالأعشاب المقصوصة حديثاً أو الخضروات النيئة. يمكن أن تشير هذه النكهات إلى ملف تحميص فاتح أو أصناف معينة تحتفظ بخصائص "خضراء". شائعة في بعض المحاصيل الإندونيسية أو الحبوب عالية الكثافة غير المحمصة كفاية.',
      },
      'wheel_cat_roasted': {
        'en':
            'Savory and deep notes resulting from the Maillard reaction and caramelization during roasting. These range from toasted bread to smoky accents. Typically associated with medium to dark roast profiles from Brazil or India.',
        'uk':
            'Пікантні та глибокі ноти, що виникають внаслідок реакції Майяра та карамелізації під час обсмажування. Вони варіюються від підсмаженого хліба до димних акцентів. Зазвичай асоціюються з профілями середнього та темного обсмаження з Бразилії чи Індії.',
        'de':
            'Herzhafte und tiefe Noten, die aus der Maillard-Reaktion und der Karamellisierung während der Röstung resultieren. Diese reichen von getoastetem Brot bis hin zu rauchigen Akzenten. Typischerweise assoziiert mit mittleren bis dunklen Röstprofilen aus Brasilien oder Indien.',
        'fr':
            'Notes savoureuses et profondes résultant de la réaction de Maillard et de la caramélisation pendant la torréfaction. Celles-ci vont du pain grillé aux accents fumés. Typiquement associées aux profils de torréfaction moyenne à foncée du Brésil ou de l\'Inde.',
        'es':
            'Notas sabrosas y profundas resultantes de la reacción de Maillard y la caramelización durante el tueste. Estas van desde pan tostado hasta acentos ahumados. Típicamente asociadas con perfiles de tueste medio a oscuro de Brasil o India.',
        'it':
            'Note sapide e profonde derivanti dalla reazione di Maillard e dalla caramellizzazione durante la tostatura. Queste variano dal pane tostato ad accenti fumosi. Tipicamente associate a profili di tostatura da media a scura del Brasile o dell\'India.',
        'pt':
            'Notas salgadas e profundas resultantes da reação de Maillard e caramelização durante a torra. Estas variam de pão torrado a acentos defumados. Tipicamente associadas a perfis de torra média a escura do Brasil ou da Índia.',
        'pl':
            'Pikantne i głębokie nuty wynikające z reakcji Maillarda i karmelizacji podczas palenia. Obejmują one zarówno przypieczony chleb, jak i dymne akcenty. Zazwyczaj kojarzone ze średnimi i ciemnymi profilami palenia z Brazylii lub Indii.',
        'nl':
            'Hartige en diepe tonen als gevolg van de Maillard-reactie en karamelisatie tijdens het branden. Deze variëren van geroosterd brood tot rokerige accenten. Meestal geassocieerd met medium tot donkere brandingsprofielen uit Brazilië of India.',
        'sv':
            'Fylliga och djupa noter som ett resultat av Maillard-reaktionen och karamellisering under rostningen. Dessa sträcker sig från rostat bröd till rökiga accenter. Vanligtvis förknippade med mellan- till mörkrostade profiler från Brasilien eller Indien.',
        'tr':
            'Kavurma sırasında Maillard reaksiyonu ve karamelizasyondan kaynaklanan lezzetli ve derin notalar. Bunlar kızarmış ekmekten isli vurgulara kadar uzanır. Tipik olarak Brezilya veya Hindistan\'dan gelen orta ila koyu kavurma profilleriyle ilişkilendirilir.',
        'ja':
            '焙煎中のメイラード反応とカラメル化によって生まれる、香ばしく深みのあるノート。トーストしたパンからスモーキーなアクセントまで多岐にわたります。通常、ブラジルやインドの中煎りから深煎りのプロフィールに関連しています。',
        'ko':
            '로스팅 과정 중 마이야르 반응과 카라멜화로 인해 발생하는 풍부하고 깊은 노트입니다. 구운 빵에서 스모키한 악센트까지 다양합니다. 주로 브라질이나 인도의 미디엄에서 다크 로스팅 프로필과 관련이 있습니다.',
        'zh': '烘焙过程中美拉德反应和焦糖化产生的咸鲜而深沉的风味。范围从烤面包到烟熏调。通常与巴西或印度的中度至深度烘焙风格相关。',
        'ar':
            'نكهات عميقة ومالحة ناتجة عن تفاعل مايار والكرملة أثناء التحميص. تتراوح هذه النكهات من الخبز المحمص إلى لمحات مدخنة. ترتبط عادةً بملفات التحميص المتوسطة إلى الداكنة من البرازيل أو الهند.',
      },
      'wheel_cat_spices': {
        'en':
            'Warm, pungent, or sweet spice notes like pepper, clove, or cinnamon. These often emerge during the middle stages of roasting. Frequently found in Sumatran coffees or spicy varieties from Rwanda.',
        'uk':
            'Теплі, гострі або солодкі пряні ноти, такі як перець, гвоздика або кориця. Вони часто проявляються на середніх етапах обсмажування. Часто зустрічаються в суматранській каві або пряних сортах з Руанди.',
        'de':
            'Warme, scharfe oder süße Gewürznoten wie Pfeffer, Nelken oder Zimt. Diese entstehen oft in den mittleren Phasen der Röstung. Häufig in Sumatra-Kaffees oder würzigen Sorten aus Ruanda zu finden.',
        'fr':
            'Notes d\'épices chaudes, piquantes ou sucrées comme le poivre, le clou de girofle ou la cannelle. Celles-ci émergent souvent pendant les étapes moyennes de la torréfaction. Fréquemment trouvées dans les cafés de Sumatra ou les variétés épicées du Rwanda.',
        'es':
            'Notas de especias cálidas, picantes o dulces como pimienta, clavo o canela. Estas suelen surgir durante las etapas medias del tueste. Se encuentran frecuentemente en cafés de Sumatra o variedades especiadas de Ruanda.',
        'it':
            'Note di spezie calde, pungenti o dolci come pepe, chiodi di garofano o cannella. Queste emergono spesso durante le fasi intermedie della tostatura. Frequentemente presenti nei caffè di Sumatra o nelle varietà speziate del Ruanda.',
        'pt':
            'Notas de especiarias quentes, picantes ou doces, como pimenta, cravo ou canela. Estas surgem frequentemente durante as fases intermédias da torra. Frequentemente encontradas em cafés de Sumatra ou variedades picantes de Ruanda.',
        'pl':
            'Ciepłe, ostre lub słodkie nuty przyprawowe, takie jak pieprz, goździki lub cynamon. Często pojawiają się one na środkowych etapach palenia. Często spotykane w kawach z Sumatry lub przyprawowych odmianach z Rwandy.',
        'nl':
            'Warme, scherpe of zoete kruidige tonen zoals peper, kruidnagel of kaneel. Deze ontstaan vaak tijdens de middelste fasen van het branden. Veelvoorkomend in Sumatraanse koffiesoorten of kruidige variëteiten uit Rwanda.',
        'sv':
            'Varma, skarpa eller söta kryddnoter som peppar, kryddnejlika eller kanel. Dessa uppstår ofta under rostningens mellersta skeden. Vanligt förekommande i kaffe från Sumatra eller kryddiga sorter från Rwanda.',
        'tr':
            'Biber, karanfil veya tarçın gibi sıcak, keskin veya tatlı baharat notaları. Bunlar genellikle kavurmanın orta aşamalarında ortaya çıkar. Sıklıkla Sumatra kahvelerinde veya Ruanda\'dan gelen baharatlı çeşitlerde bulunur.',
        'ja':
            '胡椒、クローブ、シナモンのような、温かみのある、刺激的な、あるいは甘いスパイスのノート。これらは焙煎の中盤に現れることが多いです。スマトラ産のコーヒーや、ルワンダ産の甘辛い品種によく見られます。',
        'ko':
            '후추, 정향 또는 시나몬과 같은 따뜻하고 톡 쏘는 또는 달콤한 스파이스 노트입니다. 로스팅의 중간 단계에서 주로 나타납니다. 수마트라 커피나 루완다의 스파이시한 품종에서 자주 발견됩니다.',
        'zh': '温暖、辛辣或甜美的香料味，如胡椒、丁香或肉桂。这些味道通常在烘焙的中期阶段出现。常见于苏门答腊咖啡或卢旺达的辛香品种。',
        'ar':
            'نكهات توابل دافئة أو لاذعة أو حلوة مثل الفلفل أو القرنفل أو القرفة. تظهر هذه النكهات غالباً خلال المراحل المتوسطة من التحميص. توجد بكثرة في قهوة سومطرة أو الأصناف المتبلة من رواندا.',
      },
      'wheel_cat_nutty_cocoa': {
        'en':
            'Comforting notes of chocolate, nuts, and cocoa. These result from stable sugars and oils that develop early in the roast. The standard profile for many high-quality Arabicas from Brazil, Guatemala, and Vietnam.',
        'uk':
            'Приємні ноти шоколаду, горіхів та какао. Вони виникають завдяки стабільним цукрам та оліям, що розвиваються на початку обсмаження. Звичайний профіль для багатьох високоякісних арабік з Бразилії, Гватемали та В\'єтнаму.',
        'de':
            'Angenehme Noten von Schokolade, Nüssen und Kakao. Diese entstehen durch stabile Zucker und Öle, die sich zu Beginn der Röstung entwickeln. Ein typisches Profil für viele hochwertige Arabicas aus Brasilien, Guatemala und Vietnam.',
        'fr':
            'Notes réconfortantes de chocolat, de noix et de cacao. Celles-ci résultent de sucres et d\'huiles stables qui se développent tôt dans la torréfaction. Le profil standard pour de nombreux Arabicas de haute qualité du Brésil, du Guatemala et du Vietnam.',
        'es':
            'Notas reconfortantes de chocolate, frutos secos y cacao. Estas resultan de azúcares y aceites estables que se desarrollan temprano en el tueste. El perfil estándar para muchos Arábicas de alta calidad de Brasil, Guatemala y Vietnam.',
        'it':
            'Note confortevoli di cioccolato, frutta a guscio e cacao. Derivano da zuccheri e oli stabili che si sviluppano all\'inizio della tostatura. Il profilo standard per molti Arabica di alta qualità provenienti da Brasile, Guatemala e Vietnam.',
        'pt':
            'Notas reconfortantes de chocolate, nozes e cacau. Estas resultam de açúcares e óleos estáveis que se desenvolvem cedo na torra. O perfil padrão para muitos Arábicas de alta qualidade do Brasil, Guatemala e Vietnã.',
        'pl':
            'Przyjemne nuty czekolady, orzechów i kakao. Powstają one dzięki stabilnym cukrom i olejom, które rozwijają się na początku palenia. Typowy profil dla wielu wysokiej jakości arabik z Brazylii, Gwatemali i Wietnamu.',
        'nl':
            'Comfortabele tonen van chocolade, noten en cacao. Deze zijn het resultaat van stabiele suikers en oliën die zich vroeg in de branding ontwikkelen. Het standaardprofiel voor veel hoogwaardige Arabica\'s uit Brazilië, Guatemala en Vietnam.',
        'sv':
            'Behagliga toner av choklad, nötter och kakao. Dessa beror på stabila sockerarter och oljor som utvecklas tidigt i rostningen. Standardprofilen för många högkvalitativa arabicabönor från Brasilien, Guatemala och Vietnam.',
        'tr':
            'Çikolata, fındık ve kakaonun rahatlatıcı notaları. Bunlar, kavurmanın erken aşamalarında gelişen kararlı şekerler ve yağlardan kaynaklanır. Brezilya, Guatemala ve Vietnam\'dan gelen birçok yüksek kaliteli Arabica için standart profildir.',
        'ja':
            'チョコレート、ナッツ、ココアの心地よいノート。これらは焙煎の初期段階で発達する安定した糖分とオイルに由来します。ブラジル、グアテマラ、ベトナム産の多くの高品質アラビカ種の標準的なプロフィールです。',
        'ko':
            '초콜릿, 견과류, 코코아의 편안한 노트입니다. 이는 로스팅 초기 단계에서 발달하는 안정적인 당분과 오일에서 비롯됩니다. 브라질, 과테말라, 베트남산 고품질 아라비카의 표준적인 프로필입니다.',
        'zh':
            '巧克力、坚果和可可的舒适香气。这些源于烘焙初期形成的稳定糖分和油脂。是巴西、危地马拉和越南等许多高品质阿拉比卡咖啡豆的标准风味。',
        'ar':
            'نكهات مريحة من الشوكولاتة والمكسرات والكاكاو. تنتج هذه عن السكريات والزيوت المستقرة التي تتطور في وقت مبكر من التحميص. الملف التعريفي القياسي للعديد من أنواع أرابيكا عالية الجودة من البرازيل وغواتيمالا وفيتنام.',
      },
      'wheel_cat_sweet': {
        'en':
            'The foundational sweetness in coffee, ranging from white sugar to complex molasses. It comes from the breakdown of carbohydrates during roasting. Present in almost all balanced, specialty coffees.',
        'uk':
            'Основна солодкість кави, від білого цукру до складних патокових відтінків. Вона походить від розпаду вуглеводів під час обсмажування. Присутня майже у всій збалансованій спешелті-каві.',
        'de':
            'Die grundlegende Süße im Kaffee, die von weißem Zucker bis zu komplexer Melasse reicht. Sie entsteht durch den Abbau von Kohlenhydraten während der Röstung. In fast allen ausgewogenen Specialty Coffees enthalten.',
        'fr':
            'La sucrosité fondamentale du café, allant du sucre blanc à la mélasse complexe. Elle provient de la dégradation des glucides pendant la torréfaction. Présente dans presque tous les cafés de spécialité équilibrés.',
        'es':
            'El dulzor fundamental en el café, que va desde el azúcar blanco hasta la melaza compleja. Proviene de la descomposición de los carbohidratos durante el tueste. Presente en casi todos los cafés de especialidad equilibrados.',
        'it':
            'La dolcezza fondamentale nel caffè, che va dallo zucchero bianco alla melassa complessa. Deriva dalla scomposizione dei carboidrati durante la tostatura. Presente in quasi tutti i caffè specialty bilanciati.',
        'pt':
            'A doçura fundamental no café, variando de açúcar branco a melaço complexo. Vem da quebra de carboidratos durante a torra. Presente em quase todos os cafés de especialidade equilibrados.',
        'pl':
            'Podstawowa słodycz w kawie, od białego cukru po złożone odcienie melasy. Pochodzi z rozpadu węglowodanów podczas palenia. Obecna w prawie wszystkich zbalansowanych kawach specialty.',
        'nl':
            'De fundamentele zoetheid in koffie, variërend van witte suiker tot complexe melasse. Het komt voort uit de afbraak van koolhydraten tijdens het branden. Aanwezig in bijna alle gebalanceerde specialty koffies.',
        'sv':
            'Den grundläggande sötman i kaffe, från vitt socker till komplex melass. Den kommer från nedbrytningen av kolhydrater under rostningen. Finns i nästan allt balanserat specialkaffe.',
        'tr':
            'Kahvedeki temel tatlılık, beyaz şekerden karmaşık pekmezlere kadar uzanır. Kavurma sırasında karbonhidratların parçalanmasından kaynaklanır. Neredeyse tüm dengeli, nitelikli kahvelerde bulunur.',
        'ja':
            '白砂糖から複雑な廃糖蜜まで、コーヒーの基礎となる甘み。焙煎中の炭水化物の分解に由来します。ほぼすべてのバランスの取れたスペシャリティコーヒーに含まれています。',
        'ko':
            '백설탕에서 복합적인 당밀에 이르는 커피의 기초적인 단맛입니다. 로스팅 중 탄수화물의 분해에서 비롯됩니다. 거의 모든 균형 잡힌 스페셜티 커피에 존재합니다.',
        'zh': '咖啡的基础甜感，范围从白糖到复杂的糖蜜。源于烘焙过程中碳水化合物的分解。几乎存在于所有平衡的精品咖啡中。',
        'ar':
            'الحلاوة الأساسية في القهوة، من السكر الأبيض إلى دبس السكر المعقد. تأتي من تكسر الكربوهيدرات أثناء التحميص. موجودة في جميع أنواع القهوة المختصة المتوازنة تقريباً.',
      },
      'wheel_cat_others': {
        'en':
            'A category for unique or unconventional notes that don\'t fit elsewhere, often reflecting rare chemical artifacts of processing or storage. These notes can be either desirable specialty traits or indicators of defects. Found in uniquely processed or long-aged coffees.',
        'uk':
            'Категорія для унікальних або нетрадиційних нот, які не вписуються в інші розділи, часто відображаючи рідкісні хімічні особливості обробки або зберігання. Ці ноти можуть бути як бажаними ознаками спешелті, так і показниками дефектів. Зустрічається в каві з унікальною обробкою або при тривалому зберіганні.',
        'de':
            'Eine Kategorie für einzigartige oder unkonventionelle Noten, die nirgendwo anders hineinpassen und oft seltene chemische Artefakte der Aufbereitung oder Lagerung widerspiegeln. Diese Noten können entweder wünschenswerte Specialty-Merkmale oder Indikatoren für Defekte sein. Zu finden in einzigartig aufbereiteten oder lang gereiften Kaffees.',
        'fr':
            'Une catégorie pour les notes uniques ou non conventionnelles qui ne rentrent pas ailleurs, reflétant souvent de rares artefacts chimiques de traitement ou de stockage. Ces notes peuvent être soit des traits de spécialité souhaitables, soit des indicateurs de défauts. Trouvé dans des cafés traités de manière unique ou vieillis longuement.',
        'es':
            'Una categoría para notas únicas o poco convencionales que no encajan en otro lugar, a menudo reflejando raros artefactos químicos del procesamiento o almacenamiento. Estas notas pueden ser rasgos de especialidad deseables o indicadores de defectos. Se encuentran en cafés procesados de forma única o de envejecimiento prolongado.',
        'it':
            'Una categoria per note uniche o non convenzionali che non rientrano altrove, spesso riflettendo rari artefatti chimici di lavorazione o stoccaggio. Queste note possono essere tratti di specialità desiderabili o indicatori di difetti. Presente in caffè lavorati in modo unico o invecchiati a lungo.',
        'pt':
            'Uma categoria para notas únicas ou não convencionais que não se encaixam noutro lugar, refletindo frequentemente raros artefactos químicos de processamento ou armazenamento. Estas notas podem ser traços de especialidade desejáveis ou indicadores de defeitos. Encontrado em cafés processados de forma única ou envelhecidos por muito tempo.',
        'pl':
            'Kategoria dla unikalnych lub niekonwencjonalnych nut, które nie pasują nigdzie indziej, często odzwierciedlając rzadkie chemiczne artefakty obróbki lub przechowywania. Nuty te mogą być pożądanymi cechami specialty lub wskaźnikami defektów. Spotykane w kawach o unikalnej obróbce lub długo starzonych.',
        'nl':
            'Een categorie voor unieke of onconventionele tonen die nergens anders passen, vaak als weerspiegeling van zeldzame chemische artefacten van verwerking of opslag. Deze tonen kunnen wenselijke specialty-kenmerken zijn of indicatoren van defecten. Te vinden in uniek verwerkte of lang gerijpte koffiesoorten.',
        'sv':
            'En kategori för unika eller okonventionella noter som inte passar in någon annanstans, ofta reflekterande sällsynta kemiska artefakter från beredning eller lagring. Dessa noter kan vara antingen önskvärda specialty-drag eller indikatorer på defekter. Finns i unikt beredda eller lagrade kaffesorter.',
        'tr':
            'Başka hiçbir yere uymayan, genellikle işlemenin veya depolamanın nadir kimyasal yan ürünlerini yansıtan benzersiz veya alışılmadık notalar için bir kategori. Bu notalar arzu edilen nitelikli özellikler veya kusurların göstergeleri olabilir. Benzersiz şekilde işlenmiş veya uzun süre bekletilmiş kahvelerde bulunur.',
        'ja':
            '他のカテゴリーに当てはまらない、ユニークまたは型破りなノートのカテゴリー。精製や保管中の稀な化学的反応を反映していることが多いです。これらは望ましいスペシャリティの特性である場合もあれば、欠点（欠点豆）の指標である場合もあります。特殊な精製を施したコーヒーや、長期熟成されたコーヒーに見られます。',
        'ko':
            '다른 곳에 분류되지 않는 독특하거나 파격적인 노트를 위한 카테고리로, 종종 가공이나 저장 과정에서 발생하는 희귀한 화학적 결과물을 반영합니다. 이러한 노트는 바람직한 스페셜티 특성일 수도 있고 결함의 지표일 수도 있습니다. 독특하게 가공되거나 장기 숙성된 커피에서 발견됩니다.',
        'zh':
            '一个包含独特或非传统风味的类别，通常反映了处理或储存过程中罕见的化学产物。这些风味既可能是理想的精品咖啡特征，也可能是缺陷的指标。存在于独特处理或长期陈化的咖啡中。',
        'ar':
            'فئة للنكهات الفريدة أو غير التقليدية التي لا تناسب أي مكان آخر، وغالباً ما تعكس تفاعلات كيميائية نادرة ناتجة عن المعالجة أو التخزين. يمكن أن تكون هذه النكهات إما سمات مرغوبة للقهوة المختصة أو مؤشرات على وجود عيوب. توجد في أنواع القهوة المعالجة بشكل فريد أو المعتقة لفترات طويلة.',
      },

      // --- SUB-CATEGORIES ---
      'wheel_sub_berry': {
        'en':
            'Vibrant and sweet-tart notes of small fruits. Derived from concentrated anthocyanins. Typical of Ethiopian natural coffees and Kenyan SL-varieties.',
        'uk':
            'Яскраві солодкувато-кислі ноти дрібних плодів. Походять від концентрованих антоціанів. Типово для ефіопської кави натуральної обробки та кенійських сортів SL.',
        'de':
            'Lebendige und süß-säuerliche Noten kleiner Früchte. Abgeleitet von konzentrierten Anthocyanen. Typisch für äthiopische Natural-Kaffees und kenianische SL-Varietäten.',
        'fr':
            'Notes vibrantes et sucrées-acidulées de petits fruits. Dérivé d\'anthocyanes concentrés. Typique des cafés éthiopiens naturels et des variétés SL kenyanes.',
        'es':
            'Notas vibrantes y agridulces de frutas pequeñas. Derivadas de antocianinas concentradas. Típico de los cafés naturales etíopes y las variedades SL kenianas.',
        'it':
            'Note vibranti e agrodolci di piccoli frutti. Derivano da antociani concentrati. Tipico dei caffè naturali etiopi e delle varietà SL keniote.',
        'pt':
            'Notas vibrantes e agridoces de pequenas frutas. Derivadas de antocianinas concentradas. Típico dos cafés naturais etíopes e variedades SL quenianas.',
        'pl':
            'Żywe i słodko-cierpkie nuty małych owoców. Pochodzą ze skoncentrowanych antocyjanów. Typowe dla etiopskich kaw naturalnych i kenijskich odmian SL.',
        'nl':
            'Levendige en zoetzure tonen van kleine vruchten. Afgeleid van geconcentreerde anthocyanen. Typisch voor Ethiopische natural koffies en Keniaanse SL-variëteiten.',
        'sv':
            'Livliga och sötsuraktiga noter av små frukter. Härrör från koncentrerade antocyaniner. Typiskt för etiopiskt naturligt kaffe och kenyanska SL-varieteter.',
        'tr':
            'Küçük meyvelerin canlı ve tatlı-mayhoş notaları. Konsantre antosiyaninlerden türetilmiştir. Etiyopya doğal kahvelerinin ve Kenya SL çeşitlerinin özelliğidir.',
        'ja':
            '小ぶりな果実の、鮮やかで甘酸っぱいノート。濃縮されたアントシアニンに由来します。エチオピアのナチュラルプロセスや、ケニアのSL品種によく見られます。',
        'ko':
            '작은 과일의 활기차고 새콤달콤한 노트입니다. 농축된 안토시아닌에서 유래합니다. 에티오피아 내추럴 커피와 케냐 SL 품종의 전형적인 특징입니다.',
        'zh': '小水果那种充满活力且酸甜交织的风味。源于浓缩的花青素。是埃塞俄比亚日晒咖啡和肯尼亚SL品种的典型特征。',
        'ar':
            'نكهات حيوية وحلوة حامضة للفواكه الصغيرة. مشتقة من الأنثوسيانين المركز. مميزة للقهوة الإثيوبية المعالجة طبيعياً وأصناف SL الكينية.',
      },
      'wheel_sub_dried_fruit': {
        'en':
            'Concentrated, jammy sweetness reminiscent of raisins or dates. Often the result of over-ripening or natural sun-drying. Common in Yemen Moka and processed lots from Brazil.',
        'uk':
            'Концентрована, джемова солодкість, що нагадує родзинки або фініки. Часто є результатом перезрівання або натуральної сушки на сонці. Зустрічається в єменській каві Мока та оброблених лотах з Бразилії.',
        'de':
            'Konzentrierte, marmeladige Süße, die an Rosinen oder Datteln erinnert. Oft das Ergebnis von Überreife oder natürlicher Sonnentrocknung. Häufig bei Yemen Moka und aufbereiteten Partien aus Brasilien.',
        'fr':
            'Sucrosité concentrée et confiturée rappelant les raisins secs ou les dattes. Souvent le résultat d\'une surmaturation ou d\'un séchage naturel au soleil. Commun dans le Moka du Yémen et les lots traités du Brésil.',
        'es':
            'Dulzor concentrado y amermelado que recuerda a pasas o dátiles. A menudo resultado de la sobremaduración o el secado natural al sol. Común en el Moka de Yemen y lotes procesados de Brasil.',
        'it':
            'Dolcezza concentrata e marmellatosa che ricorda l\'uvetta o i datteri. Spesso il risultato di una sovramaturazione o di un essiccamento naturale al sole. Comune nel Moka dello Yemen e nei lotti lavorati del Brasile.',
        'pt':
            'Doçura concentrada e de compota que lembra passas ou tâmaras. Frequentemente o resultado de amadurecimento excessivo ou secagem natural ao sol. Comum em Yemen Moka e lotes processados do Brasil.',
        'pl':
            'Skoncentrowana, dżemowa słodycz przypominająca rodzynki lub daktyle. Często wynik przejrzałości lub naturalnego suszenia na słońcu. Powszechne w kawie Yemen Moka i partiach obrabianych z Brazylii.',
        'nl':
            'Geconcentreerde, jam-achtige zoetheid die doet denken aan rozijnen of dadels. Vaak het resultaat van overrijpheid of natuurlijke zon-droging. Veelvoorkomend in Yemen Moka en verwerkte partijen uit Brazilië.',
        'sv':
            'Koncentrerad, syltliknande sötma som påminner om russin eller dadlar. Ofta resultatet av övermognad eller naturlig soltorkning. Vanligt i Yemen Moka och bearbetade partier från Brasilien.',
        'tr':
            'Kuru üzüm veya hurmayı andıran konsantre, reçelsi tatlılık. Genellikle aşırı olgunlaşmanın veya doğal güneşte kurutmanın sonucudur. Yemen Moka ve Brezilya\'dan gelen işlenmiş lotlarda yaygındır.',
        'ja':
            'レーズンやデーツを思わせる、濃縮されたジャムのような甘み。過熟や天日乾燥（ナチュラル）によって生まれることが多いです。イエメンのモカや、ブラジルの精製ロットによく見られます。',
        'ko':
            '건포도나 대추를 연상시키는 농축된 잼 같은 단맛입니다. 종종 과숙이나 자연 일광 건조의 결과로 나타납니다. 예멘 모카와 브라질의 가공된 로트에서 흔히 볼 수 있습니다.',
        'zh': '浓缩的果酱般的甜味，让人联想到葡萄干或红枣。通常是过熟或自然日晒的结果。在也门摩卡和巴西的处理批次中很常见。',
        'ar':
            'حلاوة مركزة تشبه المربى تذكر بالزبيب أو التمر. غالباً ما تكون نتيجة النضج الزائد أو التجفيف الطبيعي تحت الشمس. شائعة في موكا اليمن والمحاصيل المعالجة من البرازيل.',
      },
      'wheel_sub_citrus': {
        'en':
            'Zesty and acidic notes providing brightness and "sparkle". Linked to high citric acid content. Signature profile of high-grown Colombian and Honduran coffees.',
        'uk':
            'Цедрові та кислі ноти, що забезпечують яскравість та "іскристість". Пов\'язані з високим вмістом лимонної кислоти. Фірмовий профіль високогірної колумбійської та гондураської кави.',
        'de':
            'Spritzige und säuerliche Noten, die für Helligkeit und "Funkeln" sorgen. Verbunden mit einem hohen Zitronensäuregehalt. Signaturprofil von im Hochland angebauten kolumbianischen und honduranischen Kaffees.',
        'fr':
            'Notes zestées et acides apportant de la brillance et du "pétillant". Lié à une forte teneur en acide citrique. Profil signature des cafés de haute altitude de Colombie et du Honduras.',
        'es':
            'Notas cítricas y ácidas que aportan brillo y "chispa". Vinculado a un alto contenido de ácido cítrico. Perfil característico de los cafés de gran altura de Colombia y Honduras.',
        'it':
            'Note agrumate e acide che forniscono luminosità e "brillantezza". Legato all\'alto contenuto di acido citrico. Profilo caratteristico dei caffè colombiani e honduregni coltivati ad alta quota.',
        'pt':
            'Notas cítricas e ácidas que proporcionam brilho e "vivacidade". Ligado ao alto teor de ácido cítrico. Perfil de assinatura de cafés colombianos e hondurenhos cultivados em altitude.',
        'pl':
            'Pikantne i kwaśne nuty zapewniające jasność i "iskierkę". Związane z wysoką zawartością kwasu cytrynowego. Charakterystyczny profil kaw wysokogórskich z Kolumbii i Hondurasu.',
        'nl':
            'Frisse en rinse tonen die zorgen voor helderheid en "sprankeling". Verbonden met een hoog citroenzuurgehalt. Kenmerkend profiel van hooggelegen Colombiaanse en Hondurese koffiesoorten.',
        'sv':
            'Friska och syrliga noter som ger klarhet och "gnista". Kopplat till hög citronsyrahalt. Signaturprofil för höghöjdskaffe från Colombia och Honduras.',
        'tr':
            'Parlaklık ve "canlılık" sağlayan lezzetli ve asidik notalar. Yüksek sitrik asit içeriğiyle bağlantılıdır. Yüksek rakımlı Kolombiya ve Honduras kahvelerinin imza profilidir.',
        'ja':
            '明るさと「きらめき」を与える、柑橘系の酸味のあるノート。高いクエン酸含有量に関連しています。高地栽培されたコロンビア産やホンジュラス産コーヒーの代表的なプロフィールです。',
        'ko':
            '밝기와 "생동감"을 주는 상큼하고 산미 있는 노트입니다. 높은 구연산 함량과 관련이 있습니다. 고지대에서 재배된 콜롬비아 및 온두라스 커피의 시그니처 프로필입니다.',
        'zh': '清新且酸爽的气息，赋予咖啡明亮度。与高含量的柠檬酸有关。是高海拔哥伦比亚和洪都拉斯咖啡的标志性特征。',
        'ar':
            'نكهات لاذعة وحامضة توفر إشراقاً و "حيوية". ترتبط بمحتوى عالٍ من حمض الستريك. السمة المميزة لأنواع القهوة الكولومبية والهندوراسية المزروعة على ارتفاعات عالية.',
      },
      'wheel_sub_other_fruit': {
        'en':
            'Tropical or temperate fruit notes like apple, pear, or mango. Represents intermediate acidity levels. Characteristic of Costa Rican and Salvadoran coffees.',
        'uk':
            'Ноти тропічних або фруктів помірного клімату, таких як яблуко, груша або манго. Представляє середні рівні кислотності. Характерно для кави з Коста-Ріки та Сальвадору.',
        'de':
            'Tropische oder gemäßigte Fruchtnoten wie Apfel, Birne oder Mango. Repräsentiert mittlere Säuregrade. Charakteristisch für Kaffees aus Costa Rica und El Salvador.',
        'fr':
            'Notes de fruits tropicaux ou tempérés comme la pomme, la poire ou la mangue. Représente des niveaux d\'acidité intermédiaires. Caractéristique des cafés du Costa Rica et du Salvador.',
        'es':
            'Notas de frutas tropicales o templadas como manzana, pera o mango. Representa niveles de acidez intermedios. Característico de los cafés de Costa Rica y El Salvador.',
        'it':
            'Note di frutta tropicale o temperata come mela, pera o mango. Rappresenta livelli di acidità intermedi. Caratteristico dei caffè della Costa Rica e di El Salvador.',
        'pt':
            'Notas de frutas tropicais ou temperadas como maçã, pera ou manga. Representa níveis de acidez intermédios. Característico de cafés da Costa Rica e de El Salvador.',
        'pl':
            'Tropikalne lub umiarkowane nuty owocowe, takie як jabłko, gruszka lub mango. Reprezentuje pośrednie poziomy kwasowości. Charakterystyczne dla kaw z Kostaryki i Salwadoru.',
        'nl':
            'Tropische of gematigde fruittonen zoals appel, peer of mango. Vertegenwoordigt gemiddelde zuurgraden. Kenmerkend voor koffiesoorten uit Costa Rica en El Salvador.',
        'sv':
            'Tropiska eller tempererade fruktnoter som äpple, päron eller mango. Representerar medelhöga syranivåer. Karaktäristiskt för kaffe från Costa Rica och El Salvador.',
        'tr':
            'Elma, armut veya mango gibi tropikal veya ılıman meyve notaları. Orta düzeyde asidite seviyelerini temsil eder. Kosta Rika ve El Salvador kahvelerinin özelliğidir.',
        'ja':
            'リンゴ、梨、マンゴーのような、熱帯または温帯の果実のノート。中程度の酸味を示します。コスタリカ産やエルサルバドル産コーヒーの特徴です。',
        'ko':
            '사과, 배 또는 망고와 같은 열대 또는 온대 과일 노트입니다. 중간 정도의 산미를 나타냅니다. 코스타리카 및 엘살바도르 커피의 특징입니다.',
        'zh': '热带或温带水果风味，如苹果、梨或芒果。代表中等酸度水平。是哥斯达黎加和萨尔瓦多咖啡的特征。',
        'ar':
            'نكهات فواكه استوائية أو معتدلة مثل التفاح أو الكمثرى أو المانجو. تمثل مستويات حموضة متوسطة. مميزة لأنواع القهوة من كوستاريكا والسلفادور.',
      },
      'wheel_sub_sour': {
        'en':
            'Direct and sharp acidic notes. When balanced, it provides structure; when excessive, it indicates under-extraction or high organic acid concentration.',
        'uk':
            'Прямі та гострі кислі ноти. У збалансованому вигляді це забезпечує структуру; при надлишку вказує на недоекстракцію або високу концентрацію органічних кислот.',
        'de':
            'Direkte und scharfe saure Noten. Wenn sie ausgewogen sind, verleihen sie Struktur; im Übermaß deuten sie auf Unterextraktion oder eine hohe Konzentration an organischen Säuren hin.',
        'fr':
            'Notes acides directes et tranchantes. Équilibré, il apporte de la structure ; excessif, il indique une sous-extraction ou une forte concentration en acides organiques.',
        'es':
            'Notas ácidas directas y punzantes. Cuando está equilibrado, aporta estructura; cuando es excesivo, indica subextracción o alta concentración de ácidos orgánicos.',
        'it':
            'Note acide dirette e pungenti. Se equilibrate, forniscono struttura; se eccessive, indicano una sottoestrazione o un\'alta concentrazione di acidi organici.',
        'pt':
            'Notas ácidas diretas e agudas. Quando equilibrado, fornece estrutura; quando excessivo, indica subextração ou alta concentração de ácido orgânico.',
        'pl':
            'Bezpośrednie i ostre kwaśne nuty. Gdy są zrównoważone, zapewniają strukturę; gdy są nadmierne, wskazują na niedostateczną ekstrakcję lub wysokie stężenie kwasów organicznych.',
        'nl':
            'Directe en scherpe zure tonen. Indien in evenwicht, geeft het structuur; indien overmatig, duidt het op onderextractie of een hoge concentratie aan organische zuren.',
        'sv':
            'Direkta och skarpa sura noter. När de är balanserade ger de struktur; när de är överdrivna tyder det på underextraktion eller hög koncentration av organiska syror.',
        'tr':
            'Doğrudan ve keskin ekşi notalar. Dengelendiğinde yapı sağlar; aşırı olduğunda eksik ekstraksiyonu veya yüksek organik asit konsantrasyonunu gösterir.',
        'ja': '直接的で鋭い酸味のノート。バランスが取れていれば骨格を与えますが、過剰な場合は抽出不足や高い有機酸濃度を示します。',
        'ko':
            '직접적이고 날카로운 산미 노트입니다. 균형이 잡히면 구조감을 제공하지만, 과도하면 과소 추출이나 높은 유기산 농도를 나타냅니다.',
        'zh': '直接且尖锐的酸味。平衡时能提供骨架感；过度时则预示着萃取不足或有机酸浓度过高。',
        'ar':
            'نكهات حامضة مباشرة وحادة. عندما تكون متوازنة، فإنها توفر قواماً؛ وعندما تكون زائدة، فإنها تشير إلى نقص الاستخلاص أو ارتفاع تركيز الأحماض العضوية.',
      },
      'wheel_sub_alcohol_fermented': {
        'en':
            'Heady and winey notes resulting from anaerobic or yeast-assisted fermentation. Reminiscent of spirits or cider. Typical of modern experimental lots from Colombia.',
        'uk':
            'П\'янкі та винні ноти, що виникають внаслідок анаеробної або дріжджової ферментації. Нагадує міцні напої або сидр. Типово для сучасних експериментальних лотів з Колумбії.',
        'de':
            'Berauschende und weinartige Noten, die aus anaerober oder hefeunterstützter Fermentation resultieren. Erinnern an Spirituosen oder Apfelwein. Typisch für moderne experimentelle Partien aus Kolumbien.',
        'fr':
            'Notes enivrantes et vineuses résultant d\'une fermentation anaérobie ou assistée par levure. Rappelle les spiritueux ou le cidre. Typique des lots expérimentaux modernes de Colombie.',
        'es':
            'Notas embriagadoras y vinosas resultantes de la fermentación anaeróbica o asistida por levadura. Recuerda a licores o sidra. Típico de los lotes experimentales modernos de Colombia.',
        'it':
            'Note inebrianti e vinose derivanti da fermentazione anaerobica o assistita da lieviti. Ricorda i superalcolici o il sidro. Tipico dei moderni lotti sperimentali provenienti dalla Colombia.',
        'pt':
            'Notas inebriantes e vinosas resultantes de fermentação anaeróbica ou assistida por levedura. Lembra destilados ou cidra. Típico de lotes experimentais modernos da Colômbia.',
        'pl':
            'Uderzające do głowy i winne nuty wynikające z fermentacji anaerobowej lub wspomaganej drożdżami. Przypominają alkohole wysokoprocentowe lub cydr. Typowe dla nowoczesnych eksperymentalnych partii z Kolumbii.',
        'nl':
            'Bedwelmende en wijnachtige tonen als gevolg van anaerobe of met gist ondersteunde fermentatie. Doet denken aan sterke drank of cider. Typisch voor moderne experimentele partijen uit Colombia.',
        'sv':
            'Berusande och vinösa noter som ett resultat av anaerob eller jäststödd fermentering. Påminner om sprit eller cider. Typiskt för moderna experimentella partier från Colombia.',
        'tr':
            'Anaerobik veya maya destekli fermantasyondan kaynaklanan baş döndürücü ve şarapsı notalar. İspirtolu içkileri veya elma şırasını andırır. Kolombiya\'dan gelen modern deneysel lotların özelliğidir.',
        'ja':
            'アナエロビック（好気性）や酵母添加精製によって生まれる、酔わせるようなワインに似たノート。蒸留酒やシードルを思わせます。コロンビアの現代的な実験的ロットに代表されます。',
        'ko':
            '무산소 또는 효모 보조 발효로 인한 취기가 도는 듯한 와인 노트입니다. 증류주나 사이다를 연상시킵니다. 콜롬비아의 현대적인 실험적 로트에서 주로 볼 수 있습니다.',
        'zh': '厌氧或酵母辅助发酵产生的令人陶醉的酒香。让人联想到烈酒或苹果酒。是哥伦比亚现代实验性处理批次的典型风味。',
        'ar':
            'نكهات مسكرة وخمرية ناتجة عن التخمير اللاهوائي أو المساعد بالخميرة. تذكر بالمشروبات الروحية أو سدر التفاح. مميزة لمحاصيل المعالجة التجريبية الحديثة من كولومبيا.',
      },
      'wheel_sub_cocoa': {
        'en':
            'Deep, dark chocolate profiles. Emerges during prolonged development in the roast. Quintessential Brazil and Indian Monsoon Malabar notes.',
        'uk':
            'Глибокі профілі темного шоколаду. З\'являються під час тривалого розвитку при обсмажуванні. Квінтесенція нот Бразилії та індійського Monsoon Malabar.',
        'de':
            'Tiefe, dunkle Schokoladenprofile. Entstehen bei längerer Entwicklung während der Röstung. Wesentliche Noten für Brasilien und indischen Monsoon Malabar.',
        'fr':
            'Profils profonds de chocolat noir. Émerge pendant un développement prolongé lors de la torréfaction. Notes quintessencielles du Brésil et du Monsoon Malabar indien.',
        'es':
            'Perfiles profundos de chocolate negro. Surgen durante un desarrollo prolongado en el tueste. Notas esenciales de Brasil y el Monsoon Malabar de la India.',
        'it':
            'Profili profondi di cioccolato fondente. Emergono durante uno sviluppo prolungato nella tostatura. Note essenziali per il Brasile e il Monsoon Malabar indiano.',
        'pt':
            'Perfis profundos de chocolate amargo. Surgem durante um desenvolvimento prolongado na torra. Notas essenciais do Brasil e do Monsoon Malabar indiano.',
        'pl':
            'Głębokie profile ciemnej czekolady. Pojawiają się podczas dłuższego rozwoju w procesie palenia. Kwintesencja nut brazylijskich i indyjskiego Monsoon Malabar.',
        'nl':
            'Diepe, donkere chocoladeprofielen. Ontstaan bij een langdurige ontwikkeling tijdens het branden. Essentiële tonen voor Brazilië en Indiase Monsoon Malabar.',
        'sv':
            'Djupa profiler av mörk choklad. Uppstår vid långvarig utveckling under rostningen. Typiska noter för Brasilien och indisk Monsoon Malabar.',
        'tr':
            'Derin, bitter çikolata profilleri. Kavurma sırasında uzun süreli gelişimle ortaya çıkar. Brezilya ve Hindistan Monsoon Malabar\'ın temel notalarıdır.',
        'ja':
            '深いダークチョコレートのプロフィール。焙煎中の長めのディベロップメント期間に現れます。ブラジルやインドのモンスーン・マラバールの典型的なノートです。',
        'ko':
            '깊고 진한 다크 초콜릿 프로필입니다. 로스팅 중 긴 디벨롭먼트 과정에서 나타납니다. 브라질과 인도 몬순 말라바르의 전형적인 노트입니다.',
        'zh': '深沉的黑巧克力风味。在烘焙过程中较长的发展阶段出现。是巴西和印度季风马拉巴咖啡豆的典型风味。',
        'ar':
            'ملفات تعريف الشوكولاتة الداكنة العميقة. تظهر أثناء التطور الطويل في التحميص. نكهات جوهرية لمحاصيل البرازيل والمونسون مالابار الهندية.',
      },
      'wheel_sub_nutty': {
        'en':
            'Earthy and savory notes of roasted nuts. Comes from amino acids reacting with sugars. Found in Classic South American profiles.',
        'uk':
            'Землисті та пікантні ноти смажених горіхів. Походять від реакції амінокислот із цукрами. Зустрічаються в класичних південноамериканських профілях.',
        'de':
            'Erdige und herzhafte Noten von gerösteten Nüssen. Entstehen durch die Reaktion von Aminosäuren mit Zucker. In klassischen südamerikanischen Profilen zu finden.',
        'fr':
            'Notes terreuses et savoureuses de fruits à coque grillés. Provient de la réaction des acides aminés avec les sucres. Présent dans les profils classiques d\'Amérique du Sud.',
        'es':
            'Notas terrosas y sabrosas de frutos secos tostados. Provienen de la reacción de los aminoácidos con los azúcares. Se encuentran en los perfiles clásicos de América del Sur.',
        'it':
            'Note terrose e sapide di frutta a guscio tostata. Derivano dalla reazione degli amminoacidi con gli zuccheri. Si trovano nei classici profili sudamericani.',
        'pt':
            'Notas terrosas e salgadas de nozes torradas. Provém da reação de aminoácidos com açúcares. Encontrado em perfis clássicos da América do Sul.',
        'pl':
            'Ziemiste i pikantne nuty prażonych orzechów. Pochodzą z reakcji aminokwasów z cukrami. Spotykane w klasycznych profilach południowoamerykańskich.',
        'nl':
            'Aardse en hartige tonen van geroosterde noten. Voortkomend uit de reactie van aminozuren met suikers. Te vinden in klassieke Zuid-Amerikaanse profielen.',
        'sv':
            'Jordiga och fylliga toner av rostade nötter. Kommer från aminosyror som reagerar med socker. Finns i klassiska sydamerikanska profiler.',
        'tr':
            'Kavrulmuş fındıkların topraksı ve lezzetli notaları. Amino asitlerin şekerlerle reaksiyona girmesinden kaynaklanır. Klasik Güney Amerika profillerinde bulunur.',
        'ja':
            'ローストしたナッツの土っぽく香ばしいノート。アミノ酸が糖分と反応することで生まれます。南米のクラシックなプロフィールに見られます。',
        'ko':
            '구운 견과류의 흙내음과 고소한 노트입니다. 아미노산이 당분과 반응하여 생깁니다. 클래식한 남미 프로필에서 발견됩니다.',
        'zh': '烘焙坚果的泥土味和咸鲜感。源于氨基酸与糖的反应。常见于经典的南美风味中。',
        'ar':
            'نكهات ترابية ومالحة للمكسرات المحمصة. تأتي من تفاعل الأحماض الأمينية مع السكريات. توجد في الملفات التعريفية الكلاسيكية لأمريكا الجنوبية.',
      },
      'wheel_sub_sugar_brown': {
        'en':
            'Rich caramel and syrup sweetness. The result of complex sugar browning. Universal in well-roasted medium profiles.',
        'uk':
            'Багата карамельна та сиропна солодкість. Результат складного карамелізації цукрів. Універсальна нота для добре обсмажених середніх профілів.',
        'de':
            'Reiche Karamell- und Sirupsüße. Das Ergebnis komplexer Zuckerbräunung. Universell in gut gerösteten mittleren Profilen.',
        'fr':
            'Douceur riche de caramel et de sirop. Le résultat d\'un brunissement complexe des sucres. Universel dans les profils moyens bien torréfiés.',
        'es':
            'Rico dulzor de caramelo y sirope. El resultado del pardeamiento complejo de los azúcares. Universal en perfiles medios bien tostados.',
        'it':
            'Ricca dolcezza di caramello e sciroppo. Il risultato della complessa caramellizzazione degli zuccheri. Universale nei profili medi ben tostati.',
        'pt':
            'Rica doçura de caramelo e xarope. O resultado do escurecimento complexo dos açúcares. Universal em perfis médios bem torrados.',
        'pl':
            'Bogata karmelowa i syropowa słodycz. Wynik złożonej karmelizacji cukrów. Uniwersalna nuta dla dobrze wypalonych średnich profili.',
        'nl':
            'Rijke karamel- en siroopzoetheid. Het resultaat van complexe suikerbruining. Universeel in goed gebrande medium profielen.',
        'sv':
            'Rik karamell- och sirapssötma. Resultatet av komplex sockerbryning. Universellt i välrostade mellanprofiler.',
        'tr':
            'Zengin karamel ve şurup tatlılığı. Karmaşık şeker esmerleşmesinin sonucudur. İyi kavrulmuş orta profillerde evrenseldir.',
        'ja': '豊かなキャラメルやシロップの甘み。複雑な糖の褐色化の結果です。適切に焙煎されたミディアムプロフィールの多くに見られます。',
        'ko':
            '풍부한 카라멜과 시럽의 단맛입니다. 복합적인 당의 갈변 반응 결과입니다. 잘 로스팅된 미디엄 프로필에서 보편적으로 나타납니다.',
        'zh': '浓郁的焦糖和糖浆甜感。糖分复杂褐变反应的结果。在烘焙良好的中度风味中非常普遍。',
        'ar':
            'حلاوة غنية بالكراميل والشراب. نتاج عملية تسمير السكريات المعقدة. شائعة في الملفات التعريفية المتوسطة المحمصة جيداً.',
      },
      'wheel_sub_tea': {
        'en':
            'Clean, structured mouthfeel with herbal undertones. Linked to specific polyphenols in high-altitude beans. Hallmarks of Yirgacheffe and high-grade Kenyan lots.',
        'uk':
            "Чисте, структуроване відчуття в роті з трав'яними підтонами. Пов'язано зі специфічними поліфенолами у високогірних зернах. Візитна картка Іргачефу та висококласних кенійських лотів.",
        'de':
            'Sauberes, strukturiertes Mundgefühl mit kräuterigen Untertönen. Verbunden mit spezifischen Polyphenolen in Bohnen aus großen Höhen. Markenzeichen von Yirgacheffe und hochwertigen kenianischen Partien.',
        'fr':
            "Sensation en bouche propre et structurée avec des nuances d'herbes. Lié à des polyphénols spécifiques dans les grains de haute altitude. Marque de fabrique du Yirgacheffe et des lots kenyans de haute qualité.",
        'es':
            'Sensación en boca limpia y estructurada con matices herbales. Vinculado a polifenoles específicos en granos de gran altitud. Sellos distintivos de Yirgacheffe y lotes kenianos de alta calidad.',
        'it':
            "Sensazione in bocca pulita e strutturata con sfumature erbacee. Legato a specifici polifenoli nei chicchi d'alta quota. Marchi di fabbrica di Yirgacheffe e dei lotti kenioti di alta qualità.",
        'pt':
            'Sensação na boca limpa e estruturada com nuances herbais. Ligado a polifenóis específicos em grãos de alta altitude. Marcas registradas de Yirgacheffe e lotes quenianos de alta qualidade.',
        'pl':
            'Czyste, strukturalne odczucie w ustach z ziołowymi tonami. Związane ze specyficznymi polifenolami w ziarnach z dużych wysokości. Znaki rozpoznawcze Yirgacheffe i wysokiej jakości partii kenijskich.',
        'nl':
            'Schoon, gestructureerd mondgevoel met kruidige ondertonen. Gekoppeld aan specifieke polyfenolen in bonen van grote hoogte. Kenmerken van Yirgacheffe en hoogwaardige Keniaanse partijen.',
        'sv':
            'Ren, strukturerad munkänsla med örtiga undertoner. Kopplat till specifika polyfenoler i bönor från hög höjd. Kännetecken för Yirgacheffe och kenyanska partier av hög kvalitet.',
        'tr':
            'Bitkisel alt tonlara sahip temiz, yapılandırılmış ağız hissi. Yüksek rakımlı çekirdeklerdeki belirli polifenollerle bağlantılıdır. Yirgacheffe ve yüksek kaliteli Kenya lotlarının ayırt edici özelliğidir.',
        'ja':
            'ハーブのニュアンスを伴う、クリーンで構造的な口当たり。高地の豆に含まれる特定のポリフェノールに関連しています。イルガチェフェや高級ケニアロットの特徴です。',
        'ko':
            '허브 뉘앙스가 있는 깨끗하고 구조적인 바디감. 고지대 생두의 특정 폴리페놀과 관련이 있습니다. 예가체프와 고급 케냐 로트의 전형적인 특징입니다.',
        'zh': '带有草本底蕴的清爽、有结构的口感。与高海拔豆类中的特定多酚有关。是耶加雪菲和高级肯尼亚批次的标志。',
        'ar':
            'قوام نظيف ومنظم مع لمحات عشبية. يرتبط بمركبات بوليفينول محددة في حبوب الارتفاعات العالية. علامة مميزة لمحاصيل ييرغاتشيفي الكينية عالية الجودة.',
      },
      'wheel_sub_sweet_aromatics': {
        'en':
            'Fragrant, comforting scents like vanilla or spice. Derived from late-stage Maillard reactions. Typical of high-quality Arabicas from Central America.',
        'uk':
            'Ароматні, затишні запахи, такі як ваніль або спеції. Походять від реакцій Майяра на пізніх стадіях. Типово для високоякісної арабіки з Центральної Америки.',
        'de':
            'Duftende, beruhigende Düfte wie Vanille oder Gewürze. Entstehen durch späte Maillard-Reaktionen. Typisch für hochwertige Arabicas aus Zentralamerika.',
        'fr':
            'Parfums parfumés et réconfortants comme la vanille ou les épices. Dérivé des réactions de Maillard à un stade avancé. Typique des Arabicas de haute qualité d\'Amérique centrale.',
        'es':
            'Aromas fragantes y reconfortantes como la vainilla o las especias. Derivados de las reacciones de Maillard en etapa tardía. Típicos de los Arábicas de alta calidad de América Central.',
        'it':
            'Profumi fragranti e confortevoli come la vaniglia o le spezie. Derivano dalle reazioni di Maillard in fase avanzata. Tipici degli Arabica di alta qualità del Centro America.',
        'pt':
            'Aromas perfumados e reconfortantes, como baunilha ou especiarias. Derivados de reações de Maillard em estágio avançado. Típicos de Arábicas de alta qualidade da América Central.',
        'pl':
            'Aromatyczne, przytulne zapachy, takie jak wanilia lub przyprawy. Pochodzą z reakcji Maillarda na późnych etapach. Typowe dla wysokiej jakości arabik z Ameryki Środkowej.',
        'nl':
            'Geurige, rustgevende geuren zoals vanille of specerijen. Afgeleid van Maillard-reacties in een laat stadium. Typisch voor hoogwaardige Arabica\'s uit Centraal-Amerika.',
        'sv':
            'Väldoftande, behagliga dofter som vanilj eller kryddor. Kommer från Maillard-reaktioner i sent skede. Typiskt för arabicabönor av hög kvalitet från Centralamerika.',
        'tr':
            'Vanilya veya baharat gibi hoş kokulu, rahatlatıcı kokular. Geç aşama Maillard reaksiyonlarından türetilir. Orta Amerika\'dan gelen yüksek kaliteli Arabica\'lar için tipiktir.',
        'ja':
            'バニラやスパイスのような、香り高く心地よい香り。メイラード反応の後期段階で生成されます。中米産の高品質なアラビカ種の典型的な特徴です。',
        'ko':
            '바닐라나 스파이스 같은 향기롭고 편안한 향입니다. 마이야르 반응의 후기 단계에서 유래합니다. 중앙 아메리카의 고품질 아라비카에서 전형적으로 나타납니다.',
        'zh': '香气扑鼻、令人愉悦的味道，如香草或香料。源于美拉德反应的后期阶段。是中美洲高品质阿拉比卡咖啡豆的典型特征。',
        'ar':
            'روائح عطرية ومريحة مثل الفانيليا أو التوابل. مشتقة من مراحل متأخرة لتفاعلات مايار. نموذجية لمحاصيل أرابيكا عالية الجودة من أمريكا الوسطى.',
      },
      'wheel_sub_brown_spice': {
        'en':
            'Warm, sweet spice notes that develop as sugars caramelize. Rich in phenolic compounds. Characteristic of Sumatran and Rwandan coffees.',
        'uk':
            'Теплі, солодкі пряні ноти, що розвиваються при карамелізації цукрів. Багаті на фенольні сполуки. Характерно для суматранської та руандійської кави.',
        'de':
            'Warme, süße Gewürznoten, die bei der Karamellisierung von Zucker entstehen. Reich an phenolischen Verbindungen. Charakteristisch für Sumatra- und Ruanda-Kaffees.',
        'fr':
            'Notes d\'épices chaudes et sucrées qui se développent lors de la caramélisation des sucres. Riche en composés phénoliques. Caractéristique des cafés de Sumatra et du Rwanda.',
        'es':
            'Notas de especias cálidas y dulces que se desarrollan a medida que los azúcares se caramelizan. Rico en compuestos fenólicos. Característico de los cafés de Sumatra y Ruanda.',
        'it':
            'Note di spezie calde e dolci che si sviluppano con la caramellizzazione degli zuccheri. Ricco di composti fenolici. Caratteristico dei caffè di Sumatra e del Ruanda.',
        'pt':
            'Notas de especiarias quentes e doces que se desenvolvem à medida que os açúcares caramelizam. Rico em compostos fenólicos. Característico dos cafés de Sumatra e Ruanda.',
        'pl':
            'Ciepłe, słodkie nuty przyprawowe, które rozwijają się podczas karmelizacji cukrów. Bogate w związki fenolowe. Charakterystyczne dla kaw z Sumatry i Rwandy.',
        'nl':
            'Warme, zoete kruidige tonen die ontstaan bij het karameliseren van suikers. Rijk aan fenolische verbindingen. Kenmerkend voor Sumatraanse en Rwandese koffiesoorten.',
        'sv':
            'Varma, söta kryddnoter som utvecklas när socker karamelliseras. Rik på fenoliska föreningar. Karaktäristiskt för kaffe från Sumatra och Rwanda.',
        'tr':
            'Şekerler karamelize oldukça gelişen sıcak, tatlı baharat notaları. Fenolik bileşikler açısından zengindir. Sumatra ve Ruanda kahvelerinin özelliğidir.',
        'ja':
            '糖分がカラメル化する際に生まれる、温かく甘いスパイスのノート。フェノール化合物が豊富です。スマトラ産やルワンダ産コーヒーの特徴です。',
        'ko':
            '설탕이 카라멜화되면서 발달하는 따뜻하고 달콤한 스파이스 노트입니다. 페놀 화합물이 풍부합니다. 수마트라와 르완다 커피의 특징입니다.',
        'zh': '随着糖分焦糖化而产生的温暖、甜美的香料味。富含酚类化合物。是苏门答腊和卢旺达咖啡的特征。',
        'ar':
            'نوتات توابل دافئة وحلوة تتطور مع كراميلة السكريات. غنية بالمركبات الفينولية. مميزة لأنواع القهوة من سومطرة ورواندا.',
      },
      'wheel_sub_cereal': {
        'en':
            'Toasted grain and bread-like notes. Indicative of early roast stages or specific bean density. Common in many Brazilian and Indian lots.',
        'uk':
            'Ноти підсмаженого зерна та хліба. Вказують на ранні стадії обсмажування або специфічну щільність зерна. Зустрічається в багатьох бразильських та індійських лотах.',
        'de':
            'Noten von geröstetem Getreide und Brot. Hinweis auf frühe Röstphasen oder spezifische Bohnendichte. Häufig in vielen brasilianischen und indischen Lots.',
        'fr':
            'Notes de céréales grillées et de pain. Indique les premières étapes de la torréfaction ou une densité de grain spécifique. Commun dans de nombreux lots brésiliens et indiens.',
        'es':
            'Notas de cereales tostados y pan. Indica etapas tempranas de tostado o una densidad de grano específica. Común en muchos lotes brasileños e indios.',
        'it':
            'Note di cereali tostati e pane. Indica le prime fasi di tostatura o una specifica densità del chicco. Comune in molti lotti brasiliani e indiani.',
        'pt':
            'Notas de cereais torrados e pão. Indica estágios iniciais de torra ou densidade específica do grão. Comum em muitos lotes brasileiros e indianos.',
        'pl':
            'Nuty prażonego ziarna i chleba. Wskazują na wczesne etapy palenia lub specyficzną gęstość ziarna. Występują w wielu brazylijskich i indyjskich partiach kawy.',
        'nl':
            'Noten van geroosterd graan en brood. Indicatief voor vroege brandfases of specifieke boon-dichtheid. Veelvoorkomend in veel Braziliaanse en Indiase kavels.',
        'sv':
            'Noter av rostat spannmål och bröd. Tyder på tidiga rostningsstadier eller specifik bön-densitet. Vanligt i många brasilianska och indiska partier.',
        'tr':
            'Kavrulmuş tahıl ve ekmek benzeri notalar. Erken kavurma aşamalarını veya özel çekirdek yoğunluğunu gösterir. Birçok Brezilya ve Hindistan lotunda yaygındır.',
        'ja':
            'トーストした穀物やパンのようなノート。焙煎の初期段階や特定の豆の密度を示します。多くのブラジル産やインド産コーヒーに見られます。',
        'ko':
            '구운 곡물과 빵 같은 노트입니다. 초기 로스팅 단계나 특정 생두 밀도를 나타냅니다. 많은 브라질과 인도 커피에서 흔히 발견됩니다.',
        'zh': '烘烤谷物和面包般的香气。预示着烘焙早期阶段或特定的咖啡豆密度。在许多巴西和印度批次中很常见。',
        'ar':
            'نوتات الحبوب المحمصة والخبز. تشير إلى مراحل التحميص المبكرة أو كثافة معينة للحبوب. شائعة في العديد من المحاصيل البرازيلية والهندية.',
      },
      'wheel_sub_burnt': {
        'en':
            'Intense, smoky, and charred aromas. Result of deep roasting or surface bean scorching. Characteristic of Italian and French roast profiles.',
        'uk':
            'Інтенсивні, димні та обвуглені аромати. Результат глибокого обсмажування або перегріву поверхні зерна. Характерно для профілів італійського та французького обсмаження.',
        'de':
            'Intensive, rauchige und verkohlte Aromen. Ergebnis einer tiefen Röstung oder eines Verbrennens der Bohnenoberfläche. Charakteristisch für italienische und französische Röstprofile.',
        'fr':
            'Arômes intenses, fumés et carbonisés. Résultat d\'une torréfaction poussée ou d\'un brûlage de la surface du grain. Caractéristique des profils de torréfaction italienne et française.',
        'es':
            'Aromas intensos, ahumados y carbonizados. Resultado de un tostado profundo o quemado superficial del grano. Característico de los perfiles de tostado italiano y francés.',
        'it':
            'Aromi intensi, fumosi e bruciati. Risultato di una tostatura profonda o di una bruciatura superficiale del chicco. Caratteristico dei profili di tostatura italiana e francese.',
        'pt':
            'Aromas intensos, defumados e carbonizados. Resultado de uma torra profunda ou queima superficial do grão. Característico dos perfis de torra italiana e francesa.',
        'pl':
            'Intensywne, dymne i przypalone aromaty. Wynik głębokiego palenia lub przypalenia powierzchni ziarna. Charakterystyczne dla włoskich i francuskich profili palenia.',
        'nl':
            'Intense, rokerige en verkoolde aroma\'s. Resultaat van diep branden of verbranding van het boon-oppervlak. Kenmerkend voor Italiaanse en Franse brandingsprofielen.',
        'sv':
            'Intensiva, rökiga och brända aromer. Resultat av djup rostning eller bränning av bönans yta. Karaktäristiskt för italienska och franska rostningsprofiler.',
        'tr':
            'Yoğun, isli ve yanık aromalar. Derin kavurmanın veya çekirdek yüzeyinin yanmasının sonucudur. İtalyan ve Fransız kavurma profillerinin özelliğidir.',
        'ja':
            '強烈で、スモーキー、そして焦げたようなアロマ。深煎りや豆の表面の焦げの結果です。イタリアンローストやフレンチローストの特徴です。',
        'ko':
            '강렬하고 스모키하며 탄 듯한 아로마입니다. 딥 로스팅이나 원두 표면이 그을린 결과입니다. 이탈리안 및 프렌치 로스팅 프로파일의 특징입니다.',
        'zh': '强烈、烟熏和烧焦的香气。是深度烘焙或豆表焦灼的结果。是意式和法式烘焙风格的特征。',
        'ar':
            'روائح حادة أو اصطناعية أو طبية. قد تشير إلى عيوب في المعالجة أو تلوث خارجي. تعتبر عادةً سمة سلبية في القهوة المختصة.',
      },
      'wheel_sub_green_vegetative': {
        'en':
            'Fresh, grassy, and plant-like notes. Often indicative of roast underdevelopment or specific terroir traits. Common in some high-altitude Central American lots.',
        'uk':
            'Свіжі, трав\'янисті та рослинні ноти. Часто вказують на недостатній розвиток при обсмажуванні або специфіку терруару. Властиво деяким високогірним сортам з Центральної Америки.',
        'de':
            'Frische, grasige und pflanzenartige Noten. Oft ein Hinweis auf eine unzureichende Röstentwicklung oder spezifische Terroir-Merkmale. Häufig in einigen mittelamerikanischen Hochlandkaffees.',
        'fr':
            'Notes fraîches, herbacées et végétales. Souvent indicatif d\'un sous-développement de la torréfaction ou de traits de terroir spécifiques. Commun dans certains lots de haute altitude d\'Amérique centrale.',
        'es':
            'Notas frescas, herbáceas y vegetales. A menudo indica una falta de desarrollo en el tostado o rasgos específicos del terroir. Común en algunos lotes de gran altura de América Central.',
        'it':
            'Note fresche, erbacee e vegetali. Spesso indicano un sottosviluppo della tostatura o tratti specifici del terroir. Comune in alcuni lotti ad alta quota dell\'America Centrale.',
        'pt':
            'Notas frescas, herbáceas e vegetais. Frequentemente indica falta de desenvolvimento na torra ou traços específicos do terroir. Comum em alguns lotes de alta altitude da América Central.',
        'pl':
            'Świeże, trawiaste i roślinne nuty. Często wskazują на niedostateczne wypalenie lub specyficzne cechy terroir. Charakterystyczne dla niektórych wysokogórskich kaw z Ameryki Środkowej.',
        'nl':
            'Verse, grassige en plantachtige noten. Vaak een indicatie van een onderontwikkeling van de branding of specifieke terroir-kenmerken. Veelvoorkomend in sommige Midden-Amerikaanse kavels op grote hoogte.',
        'sv':
            'Friska, gräsiga och växtliknande noter. Ofta tyder det på underutveckling vid rostning eller specifika terroir-drag. Vanligt i vissa höghöjdspartier från Centralamerika.',
        'tr':
            'Taze, otsu ve bitki benzeri notalar. Genellikle kavurma yetersizliğinin veya özel teruar özelliklerinin göstergesidir. Bazı yüksek rakımlı Orta Amerika lotlarında yaygındır.',
        'ja':
            '新鮮で、草のような、植物のようなノート。焙煎不足や特定のテロワールの特徴を示すことが多いです。中米の高地産コーヒーによく見られます。',
        'ko':
            '신선하고 풀 같으며 식물 같은 노트입니다. 종종 로스팅 부족이나 특정 테루아 특성을 나타냅니다. 일부 고지대 중앙아메리카 커피에서 흔히 발견됩니다.',
        'zh': '新鲜、青草和植物般的气息。通常预示着烘焙程度不足或特定的产地特征。在一些高海拔的中美洲批次中很常见。',
        'ar':
            'نوتات طازجة وعشبية ونباتية. غالباً ما تشير إلى نقص تطوير التحميص أو سمات تربة معينة. شائعة في بعض المحاصيل المرتفعة من أمريكا الوسطى.',
      },
      'wheel_sub_chemical': {
        'en':
            'Atypical, medicinal, or synthetic notes. Usually indicates processing defects, contamination, or water quality issues. Generally considered a negative attribute in specialty coffee.',
        'uk':
            'Атипові, лікарські або синтетичні ноти. Зазвичай вказує на дефекти обробки, забруднення або проблеми з якістю води. Загалом вважається негативною характеристикою у спешелті-каві.',
        'de':
            'Atypische, medizinische oder synthetische Noten. Deuten meist auf Verarbeitungsfehler, Kontamination oder Wasserqualitätsprobleme hin. Wird im Specialty Coffee allgemein als negatives Merkmal angesehen.',
        'fr':
            'Notes atypiques, médicinales ou synthétiques. Indique généralement des défauts de traitement, une contamination ou des problèmes de qualité de l\'eau. Généralement considéré comme un attribut négatif dans le café de spécialité.',
        'es':
            'Notas atípicas, medicinales o sintéticas. Suele indicar defectos de procesamiento, contaminación o problemas de calidad del agua. Generalmente se considera un atributo negativo en el café de especialidad.',
        'it':
            'Note atipiche, medicinali o sintetiche. Solitamente indica difetti di lavorazione, contaminazione o problemi di qualità dell\'acqua. Generalmente considerato un attributo negativo nel caffè specialty.',
        'pt':
            'Notas atípicas, medicinais ou sintéticas. Geralmente indica defeitos de processamento, contaminação ou problemas de qualidade da água. Geralmente considerado um atributo negativo no café de especialidade.',
        'pl':
            'Atypowe, medyczne lub syntetyczne nuty. Zazwyczaj wskazują na błędy w obróbce, zanieczyszczenie lub problemy z jakością wody. Ogólnie uważane za cechę negatywną w kawie specialty.',
        'nl':
            'Atypische, medicinale of synthetische tonen. Duidt meestal op verwerkingsfouten, verontreiniging of problemen met de waterkwaliteit. Over het algemeen beschouwd als een negatief kenmerk in specialty koffie.',
        'sv':
            'Atypiska, medicinska eller syntetiska noter. Tyder vanligtvis på beredningsdefekter, kontaminering eller problem med vattenkvaliteten. Betraktas generellt som en negativ egenskap i specialty-kaffe.',
        'tr':
            'Atipik, tıbbi veya sentetik notalar. Genellikle işleme kusurlarını, kontaminasyonu veya su kalitesi sorunlarını işaret eder. Nitelikli kahvede genellikle olumsuz bir özellik olarak kabul edilir.',
        'ja':
            '非典型的、薬のよう、あるいは合成的なノート。通常、精製の欠陥、汚染、または水質の問題を示します。スペシャルティコーヒーにおいては一般にネガティブな属性と見なされます。',
        'ko':
            '이례적이거나 약품 같은, 또는 합성적인 노트입니다. 일반적으로 가공 결함, 오염 또는 수질 문제를 나타냅니다. 스페셜티 커피에서는 대체로 부정적인 속성으로 간주됩니다.',
        'zh': '非典型、药味或合成味的气息。通常预示着处理缺陷、污染或水质问题。在精品咖啡中通常被视为负面特征。',
        'ar':
            'نكهات غير نمطية أو طبية أو اصطناعية. تشير عادةً إلى عيوب في المعالجة أو تلوث أو مشاكل في جودة المياه. تعتبر عموماً سمة سلبية في القهوة المختصة.',
      },
      'wheel_sub_papery': {
        'en':
            'Stale, cardboard, or woody notes associated with oxidation or long-term storage. Can also result from paper filters. Often found in past-crop or improperly stored coffees.',
        'uk':
            'Залежалі, картонні або деревні ноти, пов\'язані з окисленням або тривалим зберіганням. Також можуть бути результатом використання паперових фільтрів. Часто зустрічається у каві минулого врожаю або при неправильному зберіганні.',
        'de':
            'Abgestandene, kartonartige oder holzige Noten, die mit Oxidation oder langfristiger Lagerung einhergehen. Kann auch von Papierfiltern herrühren. Oft bei Kaffees aus der vorangegangenen Ernte oder falsch gelagerten Kaffees zu finden.',
        'fr':
            'Notes rances, de carton ou boisées associées à l\'oxydation ou au stockage à long terme. Peut également résulter des filtres en papier. Souvent trouvé dans les cafés de récoltes passées ou mal stockés.',
        'es':
            'Notas rancias, de cartón o amaderadas asociadas con la oxidación o el almacenamiento prolongado. También puede ser resultado de los filtros de papel. A menudo se encuentra en cafés de cosechas pasadas o mal almacenados.',
        'it':
            'Note stantie, di cartone o legnose associate all\'ossidazione o alla conservazione a lungo termine. Può anche derivare dai filtri di carta. Spesso presente in caffè di raccolti passati o conservati in modo improprio.',
        'pt':
            'Notas velhas, de papelão ou amadeiradas associadas à oxidação ou armazenamento a longo prazo. Também pode resultar de filtros de papel. Frequentemente encontrado em cafés de safras passadas ou armazenados incorretamente.',
        'pl':
            'Nieświeże, tekturowe lub drzewne nuty związane z utlenianiem lub długotrwałym przechowywaniem. Mogą również wynikać z filtrów papierowych. Często spotykane w kawach ze starych zbiorów lub niewłaściwie przechowywanych.',
        'nl':
            'Oudbakken, kartonachtige of houtachtige tonen geassocieerd met oxidatie of langdurige opslag. Kan ook het gevolg zijn van papieren filters. Vaak te vinden in koffiesoorten van de vorige oogst of onjuist bewaarde koffie.',
        'sv':
            'Gammal, kartongliknande eller träig not förknippad med oxidering eller långvarig lagring. Kan även bero på pappersfilter. Finns ofta i kaffe från tidigare skördar eller felaktigt lagrat kaffe.',
        'tr':
            'Oksidasyon veya uzun süreli depolama ile ilişkili bayat, kartonumsu veya odunsu notalar. Kağıt filtrelerden de kaynaklanabilir. Genellikle eski mahsul veya yanlış saklanmış kahvelerde bulunur.',
        'ja':
            '酸化や長期保管に関連する、古びた感じ、段ボール、あるいはウッディなノート。ペーパーフィルターに由来する場合もあります。オールドクロップ（旧産豆）や、不適切に保管されたコーヒーによく見られます。',
        'ko':
            '산화 또는 장기 보관과 관련된 오래된, 판지 같은 또는 우디한 노트입니다. 종이 필터로 인해 발생할 수도 있습니다. 지난 수확기 원두나 부적절하게 보관된 커피에서 자주 발견됩니다.',
        'zh': '陈旧、纸板或木质的气息，与氧化或长期储存有关。也可能由滤纸产生。常见于陈年豆或储存不当的咖啡中。',
        'ar':
            'نكهات قديمة أو تشبه الكرتون أو خشبية ترتبط بالأكسدة أو التخزين لفترات طويلة. يمكن أن تنتج أيضاً عن الفلاتر الورقية. غالباً ما توجد في محاصيل قديمة أو مخزنة بشكل غير صحيح.',
      },

      // --- SPECIFIC NOTES (Expanding to reach 80+) ---
      'wheel_note_blackberry': {
        'en':
            'Deep, dark berry sweetness with a slight tannic edge. Reminiscent of wild summer fruit. Characteristic of Kenyan coffees with high phosphorus soil.',
        'uk':
            'Глибока солодкість темних ягід з легким таніновим відтінком. Нагадує лісові літні плоди. Характерно для кенійської кави, вирощеної на ґрунтах з високим вмістом фосфору.',
        'de':
            'Tiefe, dunkle Beerensüße mit einer leichten Tanninnote. Erinnert an wilde Sommerfrüchte. Charakteristisch für kenianische Kaffees aus phosphorreichen Böden.',
        'fr':
            'Sucrosité profonde de baies noires avec une légère pointe tannique. Rappelle les fruits sauvages d\'été. Caractéristique des cafés kenyans provenant de sols riches en phosphore.',
        'es':
            'Dulzor profundo de bayas oscuras con un ligero toque tánico. Recuerda a los frutos silvestres de verano. Característico de los cafés kenianos de suelos ricos en fósforo.',
        'it':
            'Dolcezza profonda di frutti di bosco scuri con una leggera nota tannica. Ricorda i frutti estivi selvatici. Caratteristico dei caffè kenioti provenienti da terreni ricchi di fosforo.',
        'pt':
            'Doçura profunda de bagas escuras com um leve toque tânico. Lembra frutas silvestres de verão. Característico de cafés quenianos de solos ricos em fósforo.',
        'pl':
            'Głęboka słodycz ciemnych jagód z lekką nutą garbnikową. Przypomina dzikie letnie owoce. Charakterystyczne dla kaw kenijskich z gleb bogatych w fosfor.',
        'nl':
            'Diepe, donkere bessenzoetheid met een licht tannineus randje. Doet denken aan wilde zomerzware vruchten. Kenmerkend voor Keniaanse koffie van fosforrijke bodems.',
        'sv':
            'Djup, mörk bärsötma med en lätt tanninhaltig kant. Påminner om vilda sommarfrukter. Karaktäristiskt för kenyanskt kaffe från fosforrika jordar.',
        'tr':
            'Hafif tanenli bir kenara sahip derin, koyu meyve tatlılığı. Yabani yaz meyvelerini andırır. Fosfor oranı yüksek topraklardan gelen Kenya kahvelerinin özelliğidir.',
        'ja':
            'わずかなタンニンを感じさせる、深く濃いベリーの甘み。野生の夏の果実を思わせます。リンを豊富に含む土壌で育ったケニア産コーヒーの特徴です。',
        'ko':
            '약간의 탄닌감이 있는 깊고 진한 베리의 단맛입니다. 야생 여름 과일을 연상시킵니다. 인 함량이 높은 토양에서 재배된 케냐 커피의 전형적인 특징입니다.',
        'zh': '深沉、浓郁的浆果甜味，略带单宁感。让人联想到野生的夏季水果。是生长在高磷土壤中的肯尼亚咖啡的典型特征。',
        'ar':
            'حلاوة توت داكنة وعميقة مع لمحة تانينية طفيفة. تذكرنا بفواكه الصيف البرية. مميزة لأنواع القهوة الكينية من التربة الغنية بالفوسفور.',
      },
      'wheel_note_blueberry': {
        'en':
            'Intense, aromatic sweetness of ripe blueberries. Often accompanied by a distinct floral perfume. A signature note of high-quality Ethiopian naturals.',
        'uk':
            'Інтенсивна ароматна солодкість стиглої лохини. Часто супроводжується виразним квітковим ароматом. Фірмова нота високоякісної ефіопської кави натуральної обробки.',
        'de':
            'Intensive, aromatische Süße reifer Blaubeeren. Oft begleitet von einem ausgeprägten blumigen Duft. Eine Signaturnote hochwertiger äthiopischer Naturals.',
        'fr':
            'Sucrosité intense et aromatique de bleuets mûrs. Souvent accompagnée d\'un parfum floral distinct. Une note signature des naturels éthiopiens de haute qualité.',
        'es':
            'Dulzor intenso y aromático de arándanos maduros. A menudo acompañado de un perfume floral distinto. Una nota característica de los naturales etíopes de alta calidad.',
        'it':
            'Dolcezza intensa e aromatica di mirtilli maturi. Spesso accompagnata da un distinto profumo floreale. Una nota distintiva dei naturali etiopi di alta qualità.',
        'pt':
            'Doçura intensa e aromática de mirtilos maduros. Frequentemente acompanhada por um perfume floral distinto. Uma nota de assinatura de naturais etíopes de alta qualidade.',
        'pl':
            'Intensywna, aromatyczna słodycz dojrzałych jagód. Często towarzyszy jej wyraźny kwiatowy zapach. Charakterystyczna nuta wysokiej jakości etiopskich kaw naturalnych.',
        'nl':
            'Intense, aromatische zoetheid van rijpe blauwe bessen. Vaak vergezeld van een duidelijk bloemig parfum. Een kenmerkende noot van hoogwaardige Ethiopische naturals.',
        'sv':
            'Intensiv, aromatisk sötma av mogna blåbär. Ofta åtföljd av en tydlig blommig doft. En signaturnot för etiopiskt naturligt kaffe av hög kvalitet.',
        'tr':
            'Olgun yaban mersininin yoğun, aromatik tatlılığı. Genellikle belirgin bir çiçeksi parfüm eşlik eder. Yüksek kaliteli Etiyopya doğal kahvelerinin imza notasıdır.',
        'ja':
            '完熟したブルーベリーの強烈で芳醇な甘み。はっきりとした花の香りを伴うことが多いです。高品質なエチオピアのナチュラルプロセスの代表的なノートです。',
        'ko':
            '잘 익은 블루베리의 강렬하고 향긋한 단맛입니다. 종종 뚜렷한 꽃향기를 동반합니다. 고품질 에티오피아 내추럴 커피의 시그니처 노트입니다.',
        'zh': '熟透蓝莓的强烈芳香甜味。通常伴有明显的鲜花香气。是高品质埃塞俄比亚日晒咖啡的标志性风味。',
        'ar':
            'حلاوة عطرية مكثفة للتوت الأزرق الناضج. غالباً ما يصاحبها عطر زهري مميز. نكهة مميزة للقهوة الإثيوبية المعالجة طبيعياً عالية الجودة.',
      },
      'wheel_note_raspberry': {
        'en':
            'Tart, zesty berry acidity with a bright finish. Evokes the sharpness of fresh red raspberries. Common in high-altitude washed Kenyan lots.',
        'uk':
            'Терпка, пікантна ягідна кислотність з яскравим фінішем. Нагадує гостроту свіжої червоної малини. Зустрічається у високогірних кенійських лотах митої обробки.',
        'de':
            'Herbe, spritzige Beeren-Säure mit einem hellen Abgang. Erinnert an die Schärfe frischer roter Himbeeren. Häufig bei gewaschenen kenianischen Hochlandpartien.',
        'fr':
            'Acidité de baies acidulée et zestée avec une finale brillante. Évoque le tranchant des framboises rouges fraîches. Commun dans les lots kenyans lavés de haute altitude.',
        'es':
            'Acidez de baya ácida y cítrica con un final brillante. Evoca el picor de las frambuesas rojas frescas. Común en lotes lavados de gran altura de Kenia.',
        'it':
            'Acidità di frutti di bosco aspra e frizzante con un finale brillante. Evoca la vivacità dei lamponi rossi freschi. Comune nei lotti lavati kenioti ad alta quota.',
        'pt':
            'Acidez de bagas ácida e picante com um final brilhante. Evoca a vivacidade das framboesas vermelhas frescas. Comum em lotes quenianos lavados de alta altitude.',
        'pl':
            'Cierpka, pikantna kwasowość jagód z jasnym finiszem. Przywołuje ostrość świeżych czerwonych malin. Powszechne w mytych partiach kenijskich z dużych wysokości.',
        'nl':
            'Zure, frisse bessenaciditeit met een heldere afdronk. Roept de scherpte op van verse rode frambozen. Veelvoorkomend in gewassen Keniaanse partijen van grote hoogte.',
        'sv':
            'Syrlig, frisk bärsyra med en ljus finish. Frammanar skärpan hos färska röda hallon. Vanligt i tvättade kenyanska partier från hög höjd.',
        'tr':
            'Parlak bir bitişe sahip mayhoş, lezzetli meyve asiditesi. Taze kırmızı ahududuların keskinliğini andırır. Yüksek rakımlı yıkanmış Kenya lotlarında yaygındır.',
        'ja':
            '明るい後味を伴う、甘酸っぱく刺激的なベリーの酸味。新鮮な赤ラズベリーの鋭さを呼び起こします。高地で生産されたケニアのウォッシュドプロセスによく見られます。',
        'ko':
            '밝은 여운과 함께 톡 쏘는 베리의 산미입니다. 신선한 레드 라즈베리의 날카로움을 불러일으킵니다. 고지대 케냐 워시드 로트에서 흔히 볼 수 있습니다.',
        'zh': '酸甜爽口的浆果酸度，余味明亮。让人联想到新鲜红树莓的清脆。常见于高海拔肯尼亚水洗批次。',
        'ar':
            'حموضة توت لاذعة ومنعشة مع نهاية ساطعة. تستحضر حدة توت العليق الأحمر الطازج. شائعة في المحاصيل الكينية المغسولة المزروعة على ارتفاعات عالية.',
      },
      'wheel_note_strawberry': {
        'en':
            'Sweet, juicy, and jammy fruit note. Suggests ripe strawberries or strawberry preserves. Often indicative of careful natural processing.',
        'uk':
            'Солодка, соковита та джемова фруктова нота. Нагадує стиглу полуницю або полуничне варення. Часто вказує на ретельну натуральну обробку.',
        'de':
            'Süße, saftige und marmeladige Fruchnote. Erinnert an reife Erdbeeren oder Erdbeerkonfitüre. Oft ein Hinweis auf eine sorgfältige natürliche Aufbereitung.',
        'fr':
            'Note de fruit sucrée, juteuse et confiturée. Suggère des fraises mûres ou de la confiture de fraises. Souvent indicatif d\'un traitement naturel soigné.',
        'es':
            'Nota de fruta dulce, jugosa y amermelada. Sugiere fresas maduras o mermelada de fresa. A menudo indica un procesamiento natural cuidadoso.',
        'it':
            'Nota di frutta dolce, succosa e marmellatosa. Suggerisce fragole mature o confettura di fragole. Spesso indicativo di un attento processo naturale.',
        'pt':
            'Nota de fruta doce, suculenta e de compota. Sugere morangos maduros ou doce de morango. Frequentemente indicativo de um processamento natural cuidadoso.',
        'pl':
            'Słodka, soczysta i dżemowa nuta owocowa. Sugeruje dojrzałe truskawki lub konfiturę truskawkową. Często wskazuje na staranną obróbkę naturalną.',
        'nl':
            'Zoete, sappige en jam-achtige fruitnoot. Doet denken aan rijpe aardbeien of aardbeienjam. Vaak een indicatie van een zorgvuldige natuurlijke verwerking.',
        'sv':
            'Söt, saftig och syltliknande fruktnot. Antyder mogna jordgubbar eller jordgubbssylt. Tyder ofta på noggrann naturlig beredning.',
        'tr':
            'Tatlı, sulu ve reçelsi meyve notası. Olgun çilekleri veya çilek reçelini andırır. Genellikle özenli bir doğal işlemenin göstergesidir.',
        'ja':
            '甘くジューシーで、ジャムのような果実のノート。完熟したイチゴやイチゴの保存食を思わせます。丁寧なナチュラルプロセスの証であることが多いです。',
        'ko':
            '달콤하고 과즙이 풍부하며 잼 같은 과일 노트입니다. 잘 익은 딸기나 딸기 잼을 연상시킵니다. 정성스러운 내추럴 가공을 나타내는 경우가 많습니다.',
        'zh': '甜美、多汁且带有果酱感的水果味。让人联想到熟透的草莓或草莓酱。通常预示着精细的日晒处理。',
        'ar':
            'نكهة فاكهة حلوة وعصارية وتشبه المربى. توحي بالفراولة الناضجة أو مربى الفراولة. غالباً ما تشير إلى معالجة طبيعية دقيقة.',
      },
      'wheel_note_raisin': {
        'en':
            'Rich, dark, and concentrated sweetness. Evokes the dried-down sugars of sun-dried grapes. Characteristic of heavy-bodied Brazilian and Yemeni coffees.',
        'uk':
            'Багата, темна та концентрована солодкість. Нагадує висушений цукор винограду, висушеного на сонці. Характерно для насиченої кави з Бразилії та Ємену.',
        'de':
            'Reiche, dunkle und konzentrierte Süße. Erinnert an den getrockneten Zucker sonnengetrockneter Trauben. Charakteristisch für körperreiche brasilianische und jemenitische Kaffees.',
        'fr':
            'Sucrosité riche, sombre et concentrée. Évoque les sucres séchés de raisins séchés au soleil. Caractéristique des cafés brésiliens et yéménites au corps puissant.',
        'es':
            'Dulzor rico, oscuro y concentrado. Evoca los azúcares concentrados de uvas secadas al sol. Característico de los cafés brasileños y yemeníes de gran cuerpo.',
        'it':
            'Dolcezza ricca, scura e concentrata. Evoca gli zuccheri essiccati dell\'uva appassita al sole. Caratteristico dei caffè brasiliani e yemeniti di corpo robusto.',
        'pt':
            'Doçura rica, escura e concentrada. Evoca os açúcares concentrados de uvas secas ao sol. Característico de cafés brasileiros e iemenitas encorpados.',
        'pl':
            'Bogata, ciemna i skoncentrowana słodycz. Przywołuje wysuszone cukry winogron suszonych na słońcu. Charakterystyczne dla pełnych kaw brazylijskich i jemeńskich.',
        'nl':
            'Rijke, donkere en geconcentreerde zoetheid. Roept de gedroogde suikers op van zongedroogde druiven. Kenmerkend voor volle Braziliaanse en Jemenitische koffiesoorten.',
        'sv':
            'Rik, mörk och koncentrerad sötma. Frammanar det torkade sockret från soltorkade druvor. Karaktäristiskt för fylligt kaffe från Brasilien och Jemen.',
        'tr':
            'Zengin, koyu ve konsantre tatlılık. Güneşte kurutulmuş üzümlerin kurumuş şekerlerini andırır. Gövdeli Brezilya ve Yemen kahvelerinin özelliğidir.',
        'ja':
            '豊かで濃い、凝縮された甘み。天日干しされたブドウの乾燥した糖分を呼び起こします。コクのあるブラジル産やイエメン産コーヒーの特徴です。',
        'ko':
            '풍부하고 진하며 농축된 단맛입니다. 햇볕에 말린 포도의 건조된 당분을 연상시킵니다. 바디감이 묵직한 브라질 및 예멘 커피의 전형적인 특징입니다.',
        'zh': '醇厚、浓郁且浓缩的甜味。让人联想到日晒葡萄干中的糖分。是口感厚实的巴西和也门咖啡的特征。',
        'ar':
            'حلاوة غنية وداكنة ومركزة. تستحضر السكريات المجففة للعنب المجفف تحت الشمس. مميزة لأنواع القهوة البرازيلية واليمنية ذات القوام الممتلئ.',
      },
      'wheel_note_prune': {
        'en':
            'Deep, dark, and sticky fruit sweetness. Reminiscent of dried plums. Indicates high maturation levels or specific fermentation profiles.',
        'uk':
            'Глибока, темна та тягуча фруктова солодкість. Нагадує чорнослив. Вказує на високий рівень дозрівання або специфічні профілі ферментації.',
        'de':
            'Tiefe, dunkle und klebrige Fruchtsüße. Erinnert an getrocknete Pflaumen. Deutet auf einen hohen Reifegrad oder spezifische Fermentationsprofile hin.',
        'fr':
            'Sucrosité de fruit profonde, sombre et collante. Rappelle les pruneaux séchés. Indique des niveaux de maturation élevés ou des profils de fermentation spécifiques.',
        'es':
            'Dulzor de fruta profundo, oscuro y pegajoso. Recuerda a las ciruelas pasas. Indica altos niveles de maduración o perfiles de fermentación específicos.',
        'it':
            'Dolcezza di frutta profonda, scura e appiccicosa. Ricorda le prugne secche. Indica alti livelli di maturazione o specifici profili di fermentazione.',
        'pt':
            'Doçura de fruta profunda, escura e pegajosa. Lembra ameixas secas. Indica altos níveis de maturação ou perfis de fermentação específicos.',
        'pl':
            'Głęboka, ciemna i lepka słodycz owocowa. Przypomina suszone śliwki. Wskazuje na wysoki poziom dojrzałości lub specyficzne profile fermentacji.',
        'nl':
            'Diepe, donkere en plakkerige fruitzoetheid. Doet denken aan gedroogde pruimen. Duidt op een hoge rijpingsgraad of specifieke fermentatieprofielen.',
        'sv':
            'Djup, mörk och klibbig fruktsötma. Påminner om torkade plommon. Tyder på hög mognadsgrad eller specifika fermenteringsprofiler.',
        'tr':
            'Derin, koyu ve yapışkan meyve tatlılığı. Kuru eriği andırır. Yüksek olgunlaşma seviyelerini veya belirli fermantasyon profillerini işaret eder.',
        'ja':
            '深く濃い、ねっとりとした果実の甘み。乾燥させたプラム（プルーン）を思わせます。高い成熟度や、特定の乳酸発酵プロフィールの証です。',
        'ko':
            '깊고 진하며 끈적한 과일의 단맛입니다. 말린 자두(프룬)를 연상시킵니다. 높은 완숙도나 특정 발효 프로필을 나타냅니다.',
        'zh': '深沉、浓郁且带有粘性的水果甜味。让人联想到干李子。预示着极高的成熟度或特定的发酵特征。',
        'ar':
            'حلاوة فاكهة عميقة وداكنة ولزجة. تذكر بالبرقوق المجفف (القراصيا). تشير إلى مستويات نضج عالية أو ملفات تخمر محددة.',
      },
      'wheel_note_coconut': {
        'en':
            'Creamy, nutty, and tropical sweetness. Often associated with certain varieties or specific post-harvest treatments. Found in some high-quality Brazilian Pulped Naturals.',
        'uk':
            'Вершкова, горіхова та тропічна солодкість. Часто пов\'язана з певними сортами або специфічною обробкою після збору врожаю. Зустрічається в деяких високоякісних бразильських Pulped Naturals.',
        'de':
            'Cremige, nussige und tropische Süße. Oft verbunden mit bestimmten Varietäten oder spezifischen Behandlungen nach der Ernte. Zu finden in einigen hochwertigen brasilianischen Pulped Naturals.',
        'fr':
            'Sucrosité crémeuse, de noisette et tropicale. Souvent associé à certaines variétés ou à des traitements post-récolte spécifiques. Présent dans certains Pulped Naturals brésiliens de haute qualité.',
        'es':
            'Dulzor cremoso, a nuez y tropical. A menudo asociado con ciertas variedades o tratamientos específicos poscosecha. Se encuentra en algunos Pulped Naturals brasileños de alta calidad.',
        'it':
            'Dolcezza cremosa, di noce e tropicale. Spesso associata a determinate varietà o specifici trattamenti post-raccolta. Presente in alcuni Pulped Naturals brasiliani di alta qualità.',
        'pt':
            'Doçura cremosa, de nozes e tropical. Frequentemente associada a certas variedades ou tratamentos pós-colheita específicos. Encontrada em alguns Pulped Naturals brasileiros de alta qualidade.',
        'pl':
            'Kremowa, orzechowa i tropikalna słodycz. Często kojarzona z określonymi odmianami lub specyficzną obróbką po zbiorach. Spotykana w niektórych wysokiej jakości brazylijskich Pulped Naturals.',
        'nl':
            'Romige, nootachtige en tropische zoetheid. Vaak geassocieerd met bepaalde variëteiten of specifieke behandelingen na de oogst. Te vinden in sommige hoogwaardige Braziliaanse Pulped Naturals.',
        'sv':
            'Krämig, nötig och tropisk sötma. Ofta förknippad med vissa varieteter eller specifika behandlingar efter skörd. Finns i vissa brasilianska Pulped Naturals av hög kvalitet.',
        'tr':
            'Kremsi, fındıksı ve tropikal tatlılık. Genellikle belirli çeşitlerle veya hasat sonrası özel işlemlerle ilişkilendirilir. Bazı yüksek kaliteli Brezilya Pulped Natural kahvelerinde bulunur.',
        'ja':
            'クリーミーでナッツのような、トロピカルな甘み。特定の品種や、収穫後の特殊な処理に関連していることが多いです。高品質なブラジルのパルプドナチュラルに見られます。',
        'ko':
            '크리미하고 고소하며 열대 느낌의 단맛입니다. 특정 품종이나 특정 수확 후 처리와 관련된 경우가 많습니다. 일부 고품질 브라질 펄프드 내추럴에서 발견됩니다.',
        'zh': '奶香、坚果感且带有热带风情的甜味。通常与某些品种或特定的采后处理有关。存在于某些高品质的巴西半日晒咖啡中。',
        'ar':
            'حلاوة كريمية وجوزية واستوائية. ترتبط غالباً بأصناف معينة أو معالجات خاصة بعد الحصاد. توجد في بعض محاصيل "بالبد ناتشورال" البرازيلية عالية الجودة.',
      },
      'wheel_note_cherry': {
        'en':
            'Tart and sweet stone fruit note. Ranges from bright red cherry to deep black cherry. Typical of natural processing and certain Ethiopian varieties.',
        'uk':
            'Терпка та солодка нота кісточкових фруктів. Варіюється від яскраво-червоної до глибокої темної вишні. Типово для натуральної обробки та певних ефіопських сортів.',
        'de':
            'Herbe und süße Steinofrucht-Note. Reicht von hellroter Kirsche bis zu tiefer Schwarzkirsche. Typisch für natürliche Aufbereitung und bestimmte äthiopische Varietäten.',
        'fr':
            'Note de fruit à noyau acidulée et sucrée. Va de la cerise rouge vif à la cerise noire profonde. Typique du traitement naturel et de certaines variétés éthiopiennes.',
        'es':
            'Nota de fruta de hueso ácida y dulce. Varía desde cereza roja brillante hasta cereza negra profunda. Típico del procesamiento natural y ciertas variedades etíopes.',
        'it':
            'Nota di drupacee aspra e dolce. Spazia dalla ciliegia rosso brillante alla ciliegia nera profonda. Tipico del processo naturale e di alcune varietà etiopi.',
        'pt':
            'Nota de fruta de caroço ácida e doce. Varia de cereja vermelha brilhante a cereja preta profunda. Típico de processamento natural e certas variedades etíopes.',
        'pl':
            'Cierpka i słodka nuta owoców pestkowych. Obejmuje zakres od jasnoczerwonej po głęboką czarną wiśnię. Typowe dla obróbki naturalnej i niektórych odmian etiopskich.',
        'nl':
            'Zure en zoete steenvruchtnoot. Varieert van helderrode kers tot diepe zwarte kers. Typisch voor natuurlijke verwerking en bepaalde Ethiopische variëteiten.',
        'sv':
            'Syrlig och söt stenfruktsnot. Sträcker sig från ljusröda körsbär till djupa mörka körsbär. Typiskt för naturlig beredning och vissa etiopiska varieteter.',
        'tr':
            'Mayhoş ve tatlı çekirdekli meyve notası. Parlak kırmızı kirazdan derin siyah kiraza kadar değişir. Doğal işlemenin ve belirli Etiyopya çeşitlerinin özelliğidir.',
        'ja':
            '甘酸っぱい核果系のノート。明るい赤色のチェリーから、深い色味のブラックチェリーまで様々です。ナチュラルプロセスや特定のエチオピア品種によく見られます。',
        'ko':
            '새콤달콤한 핵과류 노트입니다. 밝은 레드 체리부터 진한 블랙 체리까지 다양합니다. 내추럴 가공과 특정 에티오피아 품종의 전형적인 특징입니다.',
        'zh': '酸甜交织的核果风味。从鲜红的樱桃到深邃的黑樱桃。是日晒处理和某些埃塞俄比亚品种的典型风味。',
        'ar':
            'نكهة فاكهة ذات نواة لاذعة وحلوة. تتراوح من الكرز الأحمر الزاهي إلى الكرز الأسود العميق. مميزة للمعالجة الطبيعية وأصناف إثيوبية معينة.',
      },
      'wheel_note_pomegranate': {
        'en':
            'Complex, tangy acidity with a sweet-tart balance. Evokes the unique profile of pomegranate seeds. Often found in vibrant East African coffees.',
        'uk':
            'Складна, пікантна кислотність зі збалансованою солодкістю та терпкістю. Нагадує унікальний профіль зерен граната. Часто зустрічається в яскравих східноафриканських лотах.',
        'de':
            'Komplexe, spritzige Säure mit einer süß-sauren Balance. Erinnert an das einzigartige Profil von Granatapfelkernen. Oft in lebendigen ostafrikanischen Kaffees zu finden.',
        'fr':
            'Acidité complexe et acidulée avec un équilibre sucré-salé. Évoque le profil unique des graines de grenade. Souvent présent dans les cafés vibrants d\'Afrique de l\'Est.',
        'es':
            'Acidez compleja y punzante con un equilibrio agridulce. Evoca el perfil único de las semillas de granada. A menudo se encuentra en cafés vibrantes de África Oriental.',
        'it':
            'Acidità complessa e frizzante con un equilibrio agrodolce. Evoca il profilo unico dei semi di melograno. Spesso presente nei vivaci caffè dell\'Africa orientale.',
        'pt':
            'Acidez complexa e picante com um equilíbrio agridoce. Evoca o perfil único das sementes de romã. Frequentemente encontrado em cafés vibrantes da África Oriental.',
        'pl':
            'Złożona, pikantna kwasowość ze słodko-cierpką równowagą. Przywołuje unikalny profil nasion granatu. Często spotykana w żywych kawach z Afryki Wschodniej.',
        'nl':
            'Complex, frisse aciditeit met een zoetzure balans. Roept het unieke profiel van granaatappelpitten op. Vaak te vinden in levendige Oost-Afrikaanse koffiesoorten.',
        'sv':
            'Komplex, frisk syra med en sötsur balans. Frammanar den unika profilen hos granatäppelkärnor. Finns ofta i livliga östafrikanska kaffesorter.',
        'tr':
            'Tatlı-mayhoş dengesine sahip karmaşık, keskin asidite. Nar tanelerinin benzersiz profilini andırır. Genellikle canlı Doğu Afrika kahvelerinde bulunur.',
        'ja':
            '甘みと酸味のバランスが取れた、複雑で刺激的な酸味。ザクロの種子の独特なプロフィールを呼び起こします。鮮やかな東アフリカ産コーヒーによく見られます。',
        'ko':
            '새콤달콤한 균형을 갖춘 복합적이고 톡 쏘는 산미입니다. 석류 씨앗의 독특한 프로필을 불러일으킵니다. 활기찬 동아프리카 커피에서 자주 발견됩니다.',
        'zh': '复杂的、带有刺痛感的酸度，具有良好的酸甜平衡。让人联想到石榴籽的独特风味。常见于充满活力的东非咖啡。',
        'ar':
            'حموضة معقدة ولاذعة مع توازن حلو وحامض. تستحضر الملف التعريفي الفريد لبذور الرمان. غالباً ما توجد في أنواع القهوة الحيوية من شرق أفريقيا.',
      },
      'wheel_note_pineapple': {
        'en':
            'Tropical, zesty, and highly acidic sweetness. Reminiscent of ripe pineapple. Often results from experimental anaerobic fermentation.',
        'uk':
            'Тропічна, пікантна та висококислотна солодкість. Нагадує стиглий ананас. Часто є результатом експериментальної анаеробної ферментації.',
        'de':
            'Tropische, spritzige und stark säurehaltige Süße. Erinnert an reife Ananas. Oft das Ergebnis experimenteller anaerober Fermentation.',
        'fr':
            'Sucrosité tropicale, zestée et très acide. Rappelle l\'ananas mûr. Résulte souvent d\'une fermentation anaérobie expérimentale.',
        'es':
            'Dulzor tropical, cítrico y altamente ácido. Recuerda a la piña madura. A menudo es el resultado de una fermentación anaeróbica experimental.',
        'it':
            'Dolcezza tropicale, frizzante e altamente acida. Ricorda l\'ananas maturo. Spesso deriva da fermentazioni anaerobiche sperimentali.',
        'pt':
            'Doçura tropical, picante e altamente ácida. Lembra abacaxi maduro. Frequentemente resulta de fermentação anaeróbica experimental.',
        'pl':
            'Tropikalna, pikantna i silnie kwaśna słodycz. Przypomina dojrzałego ananasa. Często wynika z eksperymentalnej fermentacji anaerobowej.',
        'nl':
            'Tropische, frisse en zeer zure zoetheid. Doet denken aan rijpe ananas. Vaak het resultaat van experimentele anaerobe fermentatie.',
        'sv':
            'Tropisk, frisk och mycket syrlig sötma. Påminner om mogen ananas. Ofta resultatet av experimentell anaerob fermentering.',
        'tr':
            'Tropikal, lezzetli ve yüksek asidik tatlılık. Olgun ananası andırır. Genellikle deneysel anaerobik fermantasyonun sonucudur.',
        'ja':
            'トロピカルで刺激的、そして高い酸味を伴う甘み。完熟したパイナップルを思わせます。実験的なアナエロビック（好気性）発酵によって生まれることが多いです。',
        'ko':
            '열대 느낌의 상큼하고 산도가 높은 단맛입니다. 잘 익은 파인애플을 연상시킵니다. 실험적인 무산소 발효의 결과인 경우가 많습니다.',
        'zh': '热带风情、清爽且高酸度的甜味。让人联想到熟透的凤梨。通常是实验性厌氧发酵的结果。',
        'ar':
            'حلاوة استوائية ومنعشة وعالية الحموضة. تذكر بالأناناس الناضج. غالباً ما تنتج عن التخمير اللاهوائي التجريبي.',
      },
      'wheel_note_grape': {
        'en':
            'Sweet and vinous fruit note. Ranging from green grape brightness to deep Concord grape sweetness. Linked to specific tartaric acid profiles.',
        'uk':
            'Солодка та винна фруктова нота. Варіюється від яскравості зеленого винограду до глибокої солодкості винограду Конкорд. Пов\'язана зі специфічними профілями винної кислоти.',
        'de':
            'Süße und weinige Fruchnote. Reicht von der Helligkeit grüner Trauben bis zur tiefen Süße von Concord-Trauben. Verbunden mit spezifischen Weinsäureprofilen.',
        'fr':
            'Note de fruit sucrée et vineuse. Va de l\'éclat du raisin vert à la sucrosité profonde du raisin Concord. Lié à des profils d\'acide tartrique spécifiques.',
        'es':
            'Nota de fruta dulce y vinosa. Varía desde el brillo de la uva verde hasta el dulzor profundo de la uva Concord. Vinculado a perfiles específicos de ácido tartárico.',
        'it':
            'Nota di frutta dolce e vinosa. Spazia dalla brillantezza dell\'uva verde alla profonda dolcezza dell\'uva Concord. Legato a specifici profili di acido tartarico.',
        'pt':
            'Nota de fruta doce e vinosa. Varia do brilho da uva verde à doçura profunda da uva Concord. Ligado a perfis específicos de ácido tartárico.',
        'pl':
            'Słodka i winna nuta owocowa. Obejmuje zakres od jasności zielonych winogron po głęboką słodycz winogron Concord. Związana ze specyficznymi profilami kwasu winowego.',
        'nl':
            'Zoete en wijnachtige fruitnoot. Varieert van de helderheid van groene druiven tot de diepe zoetheid van Concord-druiven. Gekoppeld aan specifieke wijnsteenzuurprofielen.',
        'sv':
            'Söt och vinös fruktnot. Sträcker sig från ljusstyrkan hos gröna druvor till den djupa sötman hos Concord-druvor. Kopplat till specifika vinsyraprofiler.',
        'tr':
            'Tatlı ve şarapsı meyve notası. Yeşil üzüm parlaklığından derin Concord üzümü tatlılığına kadar değişir. Belirli tartarik asit profilleriyle bağlantılıdır.',
        'ja':
            '甘くワインのような果実のノート。グリーンプレープの明るさから、コンコードグレープの深い甘みまで様々です。特定の酒石酸プロフィールに関連しています。',
        'ko':
            '달콤하고 와인 같은 과일 노트입니다. 청포도의 밝음부터 진한 콩코드 포도의 단맛까지 다양합니다. 특정 주석산 프로필과 관련이 있습니다.',
        'zh': '甜美且带有酒香的水果风味。从青葡萄的明快到康科德葡萄的深沉甜味。与特定的酒石酸特征有关。',
        'ar':
            'نكهة فاكهة حلوة وخمرية. تتراوح من إشراق العنب الأخضر إلى حلاوة عنب "كونكورد" العميقة. ترتبط بملفات تعريف حمض الطرطريك المحددة.',
      },
      'wheel_note_apple': {
        'en':
            'Crisp and refreshing malic acidity. Ranges from tart green apple to sweet red apple. Found in high-altitude coffees with clean washing processes.',
        'uk':
            'Хрустка та освіжаюча яблучна кислотність. Варіюється від терпкого зеленого яблука до солодкого червоного. Зустрічається у високогірній каві з чистою митою обробкою.',
        'de':
            'Knackige und erfrischende Apfelsäure. Reicht von herbem grünem Apfel bis zu süßem rotem Apfel. Zu finden in Hochlandkaffees mit sauberen Waschprozessen.',
        'fr':
            'Acidité malique croquante et rafraîchissante. Va de la pomme verte acidulée à la pomme rouge sucrée. Présent dans les cafés de haute altitude avec des processus de lavage propres.',
        'es':
            'Acidez málica crujiente y refrescante. Varía desde manzana verde ácida hasta manzana roja dulce. Se encuentra en cafés de gran altura con procesos de lavado limpios.',
        'it':
            'Acidità malica croccante e rinfrescante. Spazia dalla mela verde aspra alla mela rossa dolce. Presente nei caffè ad alta quota con processi di lavaggio accurati.',
        'pt':
            'Acidez málica crocante e refrescante. Varia de maçã verde ácida a maçã vermelha doce. Encontrada em cafés de alta altitude com processos de lavagem limpos.',
        'pl':
            'Chrupiąca i odświeżająca kwasowość jabłkowa. Obejmuje zakres od cierpkiego zielonego jabłka po słodkie czerwone jabłko. Spotykana w kawach wysokogórskich o czystej obróbce mytej.',
        'nl':
            'Frisse en verfrissende appelzuur-aciditeit. Varieert van zure groene appel tot zoete rode appel. Te vinden in koffie van grote hoogte met schone wasprocessen.',
        'sv':
            'Krispig och uppfriskande äppelsyra. Sträcker sig från syrliga gröna äpplen till söta röda äpplen. Finns i höghöjdskaffe med rena tvättprocesser.',
        'tr':
            'Gevrek ve ferahlatıcı malik asidite. Mayhoş yeşil elmadan tatlı kırmızı elmaya kadar değişir. Temiz yıkama işlemlerine sahip yüksek rakımlı kahvelerde bulunur.',
        'ja':
            'サクサクとして爽やかなリンゴの酸味。酸味のある青リンゴから甘い赤リンゴまで様々です。クリーンなウォッシュドプロセスを施した高地のコーヒーに見られます。',
        'ko':
            '아삭하고 청량한 사과산 산미입니다. 새콤한 청사과부터 달콤한 홍사과까지 다양합니다. 깨끗한 워시드 가공을 거친 고지대 커피에서 발견됩니다.',
        'zh': '清脆爽口的苹果酸。从酸爽的青苹果到甜美的红苹果。存在于经过精细水洗的高海拔咖啡中。',
        'ar':
            'حموضة تفاحية مقرمشة ومنعشة. تتراوح من التفاح الأخضر اللاذع إلى التفاح الأحمر الحلو. توجد في أنواع القهوة المزروعة على ارتفاعات عالية مع عمليات غسل نظيفة.',
      },
      'wheel_note_peach': {
        'en':
            'Soft, stone fruit sweetness with floral undertones. Reminiscent of ripe yellow or white peaches. Often indicates a high-quality washed process.',
        'uk':
            'М\'яка солодкість кісточкових фруктів з квітковими підтонами. Нагадує стиглі жовті або білі персики. Часто вказує на високоякісну миту обробку.',
        'de':
            'Zarte Steinofrucht-Süße mit blumigen Untertönen. Erinnert an reife gelbe oder weiße Pfirsiche. Oft ein Hinweis auf eine hochwertige gewaschene Aufbereitung.',
        'fr':
            'Sucrosité douce de fruit à noyau avec des nuances florales. Rappelle les pêches jaunes ou blanches mûres. Indique souvent un processus de lavage de haute qualité.',
        'es':
            'Dulzor suave de fruta de hueso con matices florales. Recuerda a los melocotones amarillos o blancos maduros. A menudo indica un proceso de lavado de alta calidad.',
        'it':
            'Dolcezza delicata di drupacee con sfumature floreali. Ricorda le pesche gialle o bianche mature. Spesso indicativo di un processo di lavaggio di alta qualità.',
        'pt':
            'Doçura suave de fruta de caroço com nuances florais. Lembra pêssegos amarelos ou brancos maduros. Frequentemente indica um processo de lavagem de alta qualidade.',
        'pl':
            'Delikatna słodycz owoców pestkowych z kwiatowymi tonami. Przypomina dojrzałe żółte lub białe brzoskwinie. Częсто wskazuje na wysokiej jakości obróbkę mytą.',
        'nl':
            'Zachte steenvruchtzoetheid met bloemige ondertonen. Doet denken aan rijpe gele of witte perziken. Vaak een indicatie van een hoogwaardig gewassen proces.',
        'sv':
            'Mjuk stenfruktssötma med blommiga undertoner. Påminner om mogna gula eller vita persikor. Tyder ofta på en tvättad process av hög kvalitet.',
        'tr':
            'Çiçeksi alt tonlara sahip yumuşak çekirdekli meyve tatlılığı. Olgun sarı veya beyaz şeftalileri andırır. Genellikle yüksek kaliteli yıkanmış bir işlemin göstergesidir.',
        'ja':
            '花のニュアンスを伴う、柔らかな核果系の甘み。完熟した黄桃や白桃を思わせます。高品質なウォッシュドプロセスの証であることが多いです。',
        'ko':
            '꽃의 뉘앙스가 있는 부드러운 핵과류의 단맛입니다. 잘 익은 황도나 백도를 연상시킵니다. 고품질 워시드 가공을 나타내는 경우가 많습니다.',
        'zh': '带有花香底蕴的柔和核果甜味。让人联想到熟透的黄桃或白桃。通常预示着高品质的水洗处理。',
        'ar':
            'حلاوة فاكهة ذات نواة ناعمة مع لمحات زهريّة. تذكر بالخوخ الأصفر أو الأبيض الناضج. غالباً ما تشير إلى عملية غسل عالية الجودة.',
      },
      'wheel_note_pear': {
        'en':
            'Subtle, grainy sweetness with a clean acidity. Evokes the mild profile of fresh pears. Typical of clean, balanced Central American washed coffees.',
        'uk':
            'Тонка, зерниста солодкість з чистою кислотністю. Нагадує м\'який профіль свіжих груш. Типово для чистої, збалансованої митої кави з Центральної Америки.',
        'de':
            'Subtile, körnige Süße mit einer sauberen Säure. Erinnert an das milde Profil frischer Birnen. Typisch für saubere, ausgewogene gewaschene Kaffees aus Zentralamerika.',
        'fr':
            'Sucrosité subtile et granuleuse avec une acidité propre. Évoque le profil doux des poires fraîches. Typique des cafés lavés d\'Amérique centrale propres et équilibrés.',
        'es':
            'Dulzor sutil y granulado con una acidez limpia. Evoca el perfil suave de las peras frescas. Típico de los cafés lavados centroamericanos limpios y equilibrados.',
        'it':
            'Dolcezza sottile e granulosa con un\'acidità pulita. Evoca il profilo delicato delle pere fresche. Tipico dei caffè lavati del Centro America, puliti ed equilibrati.',
        'pt':
            'Doçura sutil e granulada com uma acidez limpa. Evoca o perfil suave de peras frescas. Típico de cafés lavados da América Central limpos e equilibrados.',
        'pl':
            'Subtelna, ziarnista słodycz z czystą kwasowością. Przywołuje łagodny profil świeżych gruszek. Typowe dla czystych, zbalansowanych mytych kaw z Ameryki Środkowej.',
        'nl':
            'Subtiele, korrelige zoetheid met een schone aciditeit. Roept het milde profiel van verse peren op. Typisch voor schone, uitgebalanceerde gewassen koffiesoorten uit Centraal-Amerika.',
        'sv':
            'Subtil, kornig sötma med en ren syra. Frammanar den milda profilen hos färska päron. Typiskt för rena, balanserade tvättade kaffesorter från Centralamerika.',
        'tr':
            'Temiz bir asiditeye sahip hafif, taneli tatlılık. Taze armutların yumuşak profilini andırır. Temiz, dengeli Orta Amerika yıkanmış kahvelerinin özelliğidir.',
        'ja':
            'クリーンな酸味を伴う、ほのかなざらつきのある甘み。新鮮な洋梨の穏やかなプロフィールを呼び起こします。クリーンでバランスの取れた中米産のウォッシュドコーヒーに代表されます。',
        'ko':
            '깨끗한 산미와 함께 은은하고 입자감이 느껴지는 단맛입니다. 신선한 배의 부드러운 프로필을 불러일으킵니다. 깨끗하고 균형 잡힌 중앙 아메리카 워시드 커피의 전형적인 특징입니다.',
        'zh': '微妙的颗粒感甜味，带有纯净的酸度。让人联想到新鲜梨子的清淡风味。是纯净、平衡的中美洲水洗咖啡的典型风味。',
        'ar':
            'حلاوة خفيفة وحبيبية مع حموضة نظيفة. تستحضر الملف التعريفي المعتدل للاجاص (الكمثرى) الطازج. مميزة لأنواع القهوة المغسولة النظيفة والمتوازنة من أمريكا الوسطى.',
      },
      'wheel_note_grapefruit': {
        'en':
            'Bitter-sweet citrus note with a sharp edge. Evokes the complex acidity of fresh grapefruit. Common in high-altitude coffees with strong citric acid.',
        'uk':
            'Гірко-солодка цитрусова нота з гострим відтінком. Нагадує складну кислотність свіжого грейпфрута. Зустрічається у високогірній каві з сильною лимонною кислотою.',
        'de':
            'Bitter-süße Zitrusnote mit einer scharfen Kante. Erinnert an die komplexe Säure frischer Grapefruit. Häufig bei Hochlandkaffees mit starker Zitronensäure.',
        'fr':
            'Note d\'agrumes douce-amère avec un tranchant vif. Évoque l\'acidité complexe du pamplemousse frais. Commun dans les cafés de haute altitude à forte teneur en acide citrique.',
        'es':
            'Nota cítrica agridulce con un toque punzante. Evoca la complejidad ácida del pomelo fresco. Común en cafés de gran altura con un fuerte ácido cítrico.',
        'it':
            'Nota agrumata dolce-amara con una punta pungente. Evoca la complessa acidità del pompelmo fresco. Comune nei caffè ad alta quota con un forte acido citrico.',
        'pt':
            'Nota cítrica agridoce com um toque agudo. Evoca a acidez complexa da toranja fresca. Comum em cafés de alta altitude com forte ácido cítrico.',
        'pl':
            'Gorzko-słodka nuta cytrusowa z ostrą krawędzią. Przywołuje złożoną kwasowość świeżego grejpfruta. Powszechne w kawach wysokogórskich o silnym kwasie cytrynowym.',
        'nl':
            'Bitterzoete citrusnoot met een scherp randje. Roept de complexe aciditeit van verse grapefruit op. Veelvoorkomend in koffie van grote hoogte met een sterk citroenzuurgehalte.',
        'sv':
            'Bittersöt citrusnot med en skarp kant. Frammanar den komplexa syran hos färsk grapefrukt. Vanligt i höghöjdskaffe med stark citronsyra.',
        'tr':
            'Keskin bir kenara sahip acı-tatlı narenciye notası. Taze greyfurtun karmaşık asiditesini andırır. Güçlü sitrik asit içeren yüksek rakımlı kahvelerde yaygındır.',
        'ja':
            '鋭さを伴う、ほろ苦く甘い柑橘のノート。新鮮なグレープフルーツの複雑な酸味を呼び起こします。強いクエン酸を持つ高地のコーヒーによく見られます。',
        'ko':
            '날카로운 느낌이 있는 달콤쌉싸름한 시트러스 노트입니다. 신선한 그레이프프루트의 복합적인 산미를 불러일으킵니다. 시트르산이 강한 고지대 커피에서 자주 발견됩니다.',
        'zh': '略带辛辣的苦甜味柑橘气息。让人联想到新鲜葡萄柚的复杂酸度。常见于柠檬酸含量丰富的高海拔咖啡中。',
        'ar':
            'نكهة حمضية حلوة ومرة مع حدة واضحة. تستحضر الحموضة المعقدة للجريب فروت الطازج. شائعة في أنواع القهوة المزروعة على ارتفاعات عالية مع حمض ستريك قوي.',
      },
      'wheel_note_orange': {
        'en':
            'Bright and sweet citrus note. Ranges from zesty peel to juicy sweet orange flesh. Linked to balanced citric and sugar levels.',
        'uk':
            'Яскрава та солодка цитрусова нота. Варіюється від пікантної цедри до соковитої м\'якоті солодкого апельсина. Пов\'язана зі збалансованим рівнем лимонної кислоти та цукру.',
        'de':
            'Helle und süße Zitrusnote. Reicht von spritziger Schale bis zu saftigem süßem Orangen-Fruchtfleisch. Verbunden mit einem ausgewogenen Zitronensäure- und Zuckergehalt.',
        'fr':
            'Note d\'agrumes brillante et sucrée. Va du zeste piquant à la chair d\'orange douce et juteuse. Lié à des niveaux équilibrés d\'acide citrique et de sucre.',
        'es':
            'Nota cítrica brillante y dulce. Varía desde la cáscara cítrica hasta la jugosa pulpa de naranja dulce. Vinculado a niveles equilibrados de ácido cítrico y azúcar.',
        'it':
            'Nota agrumata brillante e dolce. Spazia dalla scorza frizzante alla succosa polpa d\'arancia dolce. Legato a livelli equilibrati di acido citrico e zuccheri.',
        'pt':
            'Nota cítrica brilhante e doce. Varia de casca picante a polpa suculenta de laranja doce. Ligado a níveis equilibrados de ácido cítrico e açúcar.',
        'pl':
            'Jasna i słodka nuta cytrusowa. Obejmuje zakres od pikantnej skórki po soczysty miąższ słodkiej pomarańczy. Związana ze zrównoważonym poziomem kwasu cytrynowego i cukru.',
        'nl':
            'Heldere en zoete citrusnoot. Varieert van frisse schil tot sappig zoet sinaasappelvruchtvlees. Gekoppeld aan een evenwichtig citroenzuur- en suikergehalte.',
        'sv':
            'Ljus och söt citrusnot. Sträcker sig från friskt skal till saftigt sött apelsinkött. Kopplat till balanserade citronsyra- och sockernivåer.',
        'tr':
            'Parlak ve tatlı narenciye notası. Lezzetli kabuktan sulu tatlı portakal etine kadar değişir. Dengeli sitrik asit ve şeker seviyeleriyle bağlantılıdır.',
        'ja':
            '明るく甘い柑橘のノート。刺激的な皮の感じから、ジューシーで甘いオレンジの果肉まで様々です。クエン酸と糖分のバランスが取れている証です。',
        'ko':
            '밝고 달콤한 시트러스 노트입니다. 톡 쏘는 껍질부터 과즙이 풍부하고 달콤한 아пель신(오렌지) 과육까지 다양합니다. 균형 잡힌 시트르산과 당도와 관련이 있습니다.',
        'zh': '明亮且甜美的柑橘气息。从芬芳的果皮到多汁的甜橙果肉。与平衡的柠檬酸和糖分含量有关。',
        'ar':
            'نكهة حمضية ساطعة وحلوة. تتراوح من قشر البرتقال المنعش إلى لب البرتقال الحلو العصاري. ترتبط بمستويات متوازنة من حمض الستريك والسكر.',
      },
      'wheel_note_lemon': {
        'en':
            'Sharp, zesty, and high-intensity acidity. Evokes the brightness of fresh yellow lemons. Characteristic of high-altitude beans with extreme citric clarity.',
        'uk':
            'Гостра, пікантна та висока інтенсивність кислотності. Нагадує яскравість свіжих жовтих лимонів. Характерно для високогірних зерен з екстремальною лимонною чистотою.',
        'de':
            'Scharfe, spritzige und hochintensive Säure. Erinnert an die Helligkeit frischer gelber Zitronen. Charakteristisch für Hochlandbohnen mit extremer Zitronen-Klarheit.',
        'fr':
            'Acidité tranchante, zestée et de haute intensité. Évoque l\'éclat des citrons jaunes frais. Caractéristique des grains de haute altitude avec une clarté citrique extrême.',
        'es':
            'Acidez punzante, cítrica y de alta intensidad. Evoca el brillo de los limones amarillos frescos. Característico de granos de gran altura con una claridad cítrica extrema.',
        'it':
            'Acidità pungente, frizzante e ad alta intensità. Evoca la brillantezza dei limoni gialli freschi. Caratteristico dei chicchi ad alta quota con estrema chiarezza citrica.',
        'pt':
            'Acidez aguda, picante e de alta intensidade. Evoca o brilho de limões amarelos frescos. Característico de grãos de alta altitude com extrema clareza cítrica.',
        'pl':
            'Ostra, pikantna i intensywna kwasowość. Przywołuje jasność świeżych żółtych cytryn. Charakterystyczne dla kaw wysokogórskich o ekstremalnej czystości cytrynowej.',
        'nl':
            'Scherpe, frisse en zeer intense aciditeit. Roept de helderheid van verse gele citroenen op. Kenmerkend voor bonen van grote hoogte met extreme citroen-helderheid.',
        'sv':
            'Skarp, frisk och högintensiv syra. Frammanar klarheten hos färska gula citroner. Karaktäristiskt för bönor från hög höjd med extrem citronsyraklarhet.',
        'tr':
            'Keskin, lezzetli ve yüksek yoğunluklu asidite. Taze sarı limonların parlaklığını andırır. Olağanüstü sitrik netliğe sahip yüksek rakımlı çekirdeklerin özelliğidir.',
        'ja': '鋭く刺激的、そして強度の高い酸味。新鮮なレモンの明るさを呼び起こします。極めて透明感のあるクエン酸を持つ高地の豆の特徴です。',
        'ko':
            '날카롭고 상큼하며 강도가 높은 산미입니다. 신선한 노란 레몬의 밝음을 불러일으킵니다. 시트르산의 투명도가 극도로 높은 고지대 생두의 전형적인 특징입니다.',
        'zh': '尖锐、清新且高强度的酸度。让人联想到新鲜黄柠檬的明亮。是柠檬酸清晰度极高的高海拔咖啡豆的特征。',
        'ar':
            'حموضة حادة ومنعشة وعالية الكثافة. تستحضر إشراق الليمون الأصفر الطازج. مميزة للحبوب المزروعة على ارتفاعات عالية مع وضوح حمضي ستريكي شديد.',
      },
      'wheel_note_lime': {
        'en':
            'Tart, zesty, and electric acidity. Distinct from lemon by its slightly bitter-sweet floral edge. Common in high-grown Ethiopian and Honduran coffees.',
        'uk':
            'Терпка, пікантна та "електрична" кислотність. Відрізняється від лимона своєю злегка гірко-солодкою квітковою ноткою. Зустрічається у високогірній каві з Ефіопії та Гондурасу.',
        'de':
            'Herbe, spritzige und "elektrische" Säure. Unterscheidet sich von Zitrone durch seine leicht bitter-süße blumige Note. Häufig bei äthiopischen und honduranischen Hochlandkaffees.',
        'fr':
            'Acidité acidulée, zestée et "électrique". Se distingue du citron par sa note florale légèrement douce-amère. Commun dans les cafés éthiopiens et honduriens de haute altitude.',
        'es':
            'Acidez ácida, cítrica y "eléctrica". Se distingue del limón por su toque floral ligeramente agridulce. Común en cafés etíopes y hondureños de gran altura.',
        'it':
            'Acidità aspra, frizzante ed "elettrica". Si distingue dal limone per la sua nota floreale leggermente dolce-amara. Comune nei caffè etiopi e honduregni coltivati ad alta quota.',
        'pt':
            'Acidez ácida, picante e "elétrica". Distingue-se do limão pelo seu toque floral levemente agridoce. Comum em cafés etíopes e hondurenhos cultivados em altitude.',
        'pl':
            'Cierpka, pikantna i "elektryczna" kwasowość. Różni się od cytryny lekko gorzko-słodką kwiatową nutą. Powszechne w kawach wysokogórskich z Etiopii i Hondurasu.',
        'nl':
            'Zure, frisse en "elektrische" aciditeit. Onderscheidt zich van citroen door zijn licht bitterzoete bloemige randje. Veelvoorkomend in hooggelegen Ethiopische en Hondurese koffiesoorten.',
        'sv':
            'Syrlig, frisk och "elektrisk" syra. Skiljer sig från citron genom sin något bittersöta blommiga kant. Vanligt i höghöjdskaffe från Etiopien och Honduras.',
        'tr':
            'Mayhoş, lezzetli ve "elektrikli" asidite. Hafif acı-tatlı çiçeksi kenarıyla limondan ayrılır. Yüksek rakımlı Etiyopya ve Honduras kahvelerinde yaygındır.',
        'ja':
            '酸味が強く刺激的で、しびれるような酸味。わずかにほろ苦く甘い花のニュアンスがある点でレモンと区別されます。高地で生産されたエチオピア産やホンジュラス産コーヒーによく見られます。',
        'ko':
            '새콤하고 상큼하며 강렬한 산미입니다. 약간 달콤쌉싸름한 꽃의 뉘앙스가 있다는 점에서 레몬과 구별됩니다. 고지대 에티오피아 및 온두라스 커피에서 흔히 볼 수 있습니다.',
        'zh': '酸甜爽口、充满活力的酸度。与柠檬的不同之处在于其带有轻微苦甜感的花香边缘。常见于高海拔埃塞俄比亚和洪都拉斯咖啡。',
        'ar':
            'حموضة لاذعة ومنعشة وقوية. تتميز عن الليمون بحافتها الزهريّة المرة والحلوة قليلاً. شائعة في أنواع القهوة الإثيوبية والهندوراسية المزروعة على ارتفاعات عالية.',
      },
      'wheel_note_black_tea': {
        'en':
            'Tannic, structured mouthfeel with a savory-sweet edge. Reminiscent of high-quality Pekoe tea. Characteristic of the Yirgacheffe region and many Kenyan lots.',
        'uk':
            'Танінне, структуроване відчуття в роті з пікантно-солодким відтінком. Нагадує високоякісний чай Пеко. Характерно для регіону Іргачеф та багатьох кенійських лотів.',
        'de':
            'Gerbstoffreich, strukturiertes Mundgefühl with einer würzig-süßen Note. Erinnert an hochwertigen Pekoe-Tee. Charakteristisch für die Region Yirgacheffe und viele kenianische Partien.',
        'fr':
            'Sensation en bouche tannique et structurée with une pointe de saveur sucrée-salée. Rappelle le thé Pekoe de haute qualité. Caractéristique de la région de Yirgacheffe et de nombreux lots kenyans.',
        'es':
            'Sensación en boca tánica y estructurada with un toque dulce-sabroso. Recuerda al té Pekoe de alta calidad. Característico de la región de Yirgacheffe y de muchos lotes kenianos.',
        'it':
            'Sensazione in bocca tannica e strutturata with un tocco sapido-dolce. Ricorda il tè Pekoe di alta qualità. Caratteristico della regione di Yirgacheffe e di molti lotti kenioti.',
        'pt':
            'Sensação tânica e estruturada na boca with um toque agridoce. Lembra chá Pekoe de alta qualidade. Característico da região de Yirgacheffe e de muitos lotes quenianos.',
        'pl':
            'Taninowe, strukturalne odczucie w ustach z wytrawno-słodką nutą. Przypomina wysokiej jakości herbatę Pekoe. Charakterystyczne dla regionu Yirgacheffe i wielu partii kenijskich.',
        'nl':
            'Tanninerijk, gestructureerd mondgevoel with een hartig-zoete rand. Doet denken aan hoogwaardige Pekoe-thee. Kenmerkend voor de Yirgacheffe-regio en veel Keniaanse partijen.',
        'sv':
            'Tanninrik, strukturerad munkänsla with en smakrik-söt kant. Påminner om högkvalitativt Pekoe-te. Karaktäristiskt för Yirgacheffe-regionen och många kenyanska partier.',
        'tr':
            'Tanenli, yapılı ağız hissi ve iştah açıcı tatlı bir kenar. Yüksek kaliteli Pekoe çayını anımsatır. Yirgacheffe bölgesi ve birçok Kenya lotunun özelliğidir.',
        'ja':
            'タンニンを感じる構造的な口当たりで、甘味とコクがあります。高品質なペコ茶を思わせます。イルガチェフェ地方や多くのケニアロットに特徴的です。',
        'ko':
            '탄닌감이 있는 구조적인 바디감과 달콤하면서도 풍부한 맛. 고급 페코 홍차를 연상시킵니다. 예가체프 지역과 많은 케냐 로트의 특징입니다.',
        'zh':
            '具有单宁感、有结构的口感，带有甜咸兼备的风味。令人联想到高品质的橙黄白毫（Pekoe）茶。是耶加雪菲产区和许多肯尼亚批次的特征。',
        'ar':
            'قوام تانيني منظم مع لمحة حلوة ومالحة. يذكرنا بشاي بيكو عالي الجودة. مميز لمنطقة ييرغاتشيفي والعديد من المحاصيل الكينية.',
      },
      'wheel_note_green_tea': {
        'en':
            'Fresh, herbal, and slightly astringent profile. Indicates very light roasting or specific high-altitude varieties. Common in delicate washed Ethiopian coffees.',
        'uk':
            "Свіжий, трав'яний та злегка в'яжучий профіль. Вказує на дуже світле обсмажування або специфічні високогірні сорти. Зустрічається в делікатних митих ефіопських лотах.",
        'de':
            'Frisches, kräuteriges und leicht herbes Profil. Deutet auf eine sehr helle Röstung oder spezifische Hochlandvarietäten hin. Häufig bei zarten gewaschenen äthiopischen Kaffees.',
        'fr':
            'Profil frais, herbacé et légèrement astringent. Indique une torréfaction très légère ou des variétés spécifiques de haute altitude. Courant dans les cafés éthiopiens lavés délicats.',
        'es':
            'Perfil fresco, herbal y ligeramente astringente. Indica un tueste muy ligero o variedades específicas de gran altitud. Común en cafés etíopes lavados delicados.',
        'it':
            "Profilo fresco, erbaceo e leggermente astringente. Indica una tostatura molto chiara o specifiche varietà d'alta quota. Comune nei delicati caffè etiopi lavati.",
        'pt':
            'Perfil fresco, herbal e levemente adstringente. Indica torra muito clara ou variedades específicas de alta altitude. Comum em cafés etíopes lavados delicados.',
        'pl':
            'Świeży, ziołowy i lekko cierpki profil. Wskazuje na bardzo jasne palenie lub specyficzne odmiany wysokogórskie. Powszechny w delikatnych mytych kawach etiopskich.',
        'nl':
            'Vers, kruidig en licht wrang profiel. Wijst op zeer lichte branding of specifieke variëteiten op grote hoogte. Veelvoorkomend in delicate gewassen Ethiopische koffies.',
        'sv':
            'Frisk, örtig och något sträv profil. Tyder på mycket ljus rostning eller specifika höghöjdsvarieteter. Vanligt i delikata våtprocessade etiopiska kaffesorter.',
        'tr':
            'Taze, bitkisel ve hafif buruk bir profil. Çok hafif kavurmayı veya belirli yüksek rakımlı çeşitleri gösterir. Hassas yıkanmış Etiyopya kahvelerinde yaygındır.',
        'ja':
            '新鮮でハーブのような、少し渋みのあるプロフィール。非常に浅い焙煎や特定の高地品種であることを示しています。繊細なウォッシュド・エチオピア・コーヒーによく見られます。',
        'ko':
            '신선하고 허브 느낌이 나며 약간의 수렴성이 있는 풍미. 매우 가벼운 로스팅이나 특정 고지대 품종임을 나타냅니다. 섬세한 워시드 에티오피아 커피에서 흔히 발견됩니다.',
        'zh': '清新、草本且略带涩味的风味。表明烘焙度极浅或属于特定的高海拔品种。常见于细腻的水洗埃塞俄比亚咖啡中。',
        'ar':
            'نكهة طازجة وعشبية وقابضة قليلاً. تشير إلى تحميص خفيف جداً أو أصناف معينة من المرتفعات العالية. شائع في القهوة الإثيوبية المغسولة الرقيقة.',
      },
      'wheel_note_chamomile': {
        'en':
            'Gentle, herbal and slightly honey-like sweetness. Indicates complex, low-acidity floral profiles. Often found in processed Nicaraguan coffees.',
        'uk':
            "Ніжна, трав'яна та злегка медова солодкість. Вказує на складні квіткові профілі з низькою кислотністю. Часто зустрічається в обробленій нікарагуанській каві.",
        'de':
            'Sanfte, kräuterige und leicht honigartige Süße. Deutet auf komplexe, säurearme blumige Profile hin. Oft in aufbereiteten nicaraguanischen Kaffees zu finden.',
        'fr':
            'Douceur délicate, herbacée et légèrement miellée. Indique des profils floraux complexes et peu acides. Souvent trouvé dans les cafés nicaraguayens traités.',
        'es':
            'Dulzura suave, herbal y ligeramente melosa. Indica perfiles florales complejos de baja acidez. A menudo se encuentra en cafés nicaragüenses procesados.',
        'it':
            'Dolcezza delicate, erbacea e leggermente mielata. Indica profili floreali complessi a bassa acidità. Spesso presente nei caffè nicaraguensi lavorati.',
        'pt':
            'Doçura suave, herbal e levemente melada. Indica perfis florais complexos de baixa acidez. Frequentemente encontrado em cafés nicaraguenses processados.',
        'pl':
            'Łagodna, ziołowa i lekko miodowa słodycz. Wskazuje na złożone, niskokwasowe profile kwiatowe. Często spotykana w kawach nikaraguańskich.',
        'nl':
            'Zachte, kruidige en licht honingachtige zoetheid. Wijst op complexe, bloemige profielen met een lage zuurgraad. Vaak te vinden in verwerkte Nicaraguaanse koffies.',
        'sv':
            'Mjuk, örtig och något honungslik sötma. Tyder på komplexa blommiga profiler med låg syrahalt. Hittas ofta i processat nicaraguanskt kaffe.',
        'tr':
            'Nazik, bitkisel ve hafif balımsı tatlılık. Karmaşık, düşük asitli çiçeksi profilleri gösterir. Genellikle işlenmiş Nikaragua kahvelerinde bulunur.',
        'ja':
            '穏やかでハーブのような、少し蜂蜜のような甘さ。複雑で低酸味のフローラルプロフィールを示しています。加工されたニカラグア産コーヒーによく見られます。',
        'ko':
            '부드럽고 허브 느낌이 나며 약간의 꿀 같은 단맛. 복합적이고 산도가 낮은 플로럴 프로필을 나타냅니다. 가공된 니카라과 커피에서 자주 발견됩니다.',
        'zh': '柔和、草本且略带蜂蜜般的甜味。表明复杂、低酸度的花香风味。常见于加工过的尼加拉瓜咖啡中。',
        'ar':
            'حلاوة لطيفة وعشبية تشبه العسل قليلاً. تشير إلى نكهات زهرية معقدة منخفضة الحموضة. توجد غالباً في القهوة النيكاراغوية المعالجة.',
      },
      'wheel_note_rose': {
        'en':
            'Soft, elegant floral sweetness. Associated with gentle roast profiles and high elevation. Found in delicate Pink Bourbon varieties.',
        'uk':
            "М'яка, елегантна квіткова солодкість. Асоціюється з м'якими профілями обсмаження та висотою. Зустрічається в делікатних сортах рожевого бурбону.",
        'de':
            'Zarte, elegante blumige Süße. Verbunden mit sanften Röstprofilen und großen Höhenlagen. Zu finden in delikaten Pink Bourbon-Varietäten.',
        'fr':
            'Douceur florale douce et élégante. Associée à des profils de torréfaction doux et à une altitude élevée. Trouvé dans les variétés délicates Pink Bourbon.',
        'es':
            'Dulzura floral suave y elegante. Asociada con perfiles de tueste suaves y gran altitud. Se encuentra en delicadas variedades Pink Bourbon.',
        'it':
            'Dolcezza floreale morbida ed elegante. Associata a profili di tostatura delicati e alta quota. Presente nelle delicate varietà Pink Bourbon.',
        'pt':
            'Doçura floral suave e elegante. Associada a perfis de torra suaves e alta altitude. Encontrado em variedades delicadas de Pink Bourbon.',
        'pl':
            'Miękka, elegancka kwiatowa słodycz. Związana z łagodnymi profilami palenia i dużymi wysokościami. Spotykana w delikatnych odmianach Pink Bourbon.',
        'nl':
            'Zachte, elegante bloemige zoetheid. Geassocieerd met zachte brandingsprofielen en grote hoogte. Te vinden in delicate Pink Bourbon-variëteiten.',
        'sv':
            'Mjuk, elegant blommig sötma. Förknippas med mjuka rostningsprofiler och hög höjd. Hittas i delikata Pink Bourbon-varieteter.',
        'tr':
            'Yumuşak, zarif çiçeksi tatlılık. Nazik kavurma profilleri ve yüksek rakım ile ilişkilendirilir. Hassas Pink Bourbon çeşitlerinde bulunur.',
        'ja': '柔らかく優雅なフローラルの甘さ。穏やかな焙煎プロフィールや高地に関連しています。繊細なピンクブルボン種に見られます。',
        'ko':
            '부드럽고 우아한 꽃의 단맛. 완만한 로스팅 프로필 및 고지대와 관련이 있습니다. 섬세한 핑크 버본 품종에서 발견됩니다.',
        'zh': '柔和、优雅的花香甜味。与温和的烘焙程度和高海拔有关。常见于细腻的粉红波旁（Pink Bourbon）品种中。',
        'ar':
            'حلاوة زهرية ناعمة وأنيقة. ترتبط بملفات تحميص لطيفة وارتفاعات عالية. توجد في أصناف البوربون الوردي الرقيقة.',
      },
      'wheel_note_jasmine': {
        'en':
            'Intensely floral and perfume-like aroma. Linked to high concentrations of linalool. The definitive note of Panamanian and Ethiopian Geshas.',
        'uk':
            'Інтенсивно квітковий аромат, подібний до парфумів. Пов\'язаний з високою концентрацією ліналоолу. Визначальна нота панамських та ефіопських Гейш.',
        'de':
            'Intensiv blumiges und parfümartiges Aroma. Verbunden mit hohen Linalool-Konzentrationen. Die definitive Note von panamaischen und äthiopischen Geshas.',
        'fr':
            'Arôme intensément floral et semblable à un parfum. Lié à des concentrations élevées de linalol. La note emblématique des Geshas du Panama et d\'Éthiopie.',
        'es':
            'Aroma intensamente floral y perfumado. Vinculado a altas concentraciones de linalool. La nota definitiva de los Geshas panameños y etíopes.',
        'it':
            'Aroma intensamente floreale e simile a un profumo. Legato ad alte concentrazioni di linalolo. La nota definitiva dei Gesha panamensi ed etiopi.',
        'pt':
            'Aroma intensamente floral e perfumado. Ligado a altas concentrações de linalol. A nota definitiva dos Geshas panamenhos e etíopes.',
        'pl':
            'Intensywnie kwiatowy i perfumowy aromat. Związany z wysokim stężeniem linalolu. Definitywna nuta panamskich i etiopskich kaw odmiany Gesha.',
        'nl':
            'Intens bloemig en parfumachtig aroma. Gekoppeld aan hoge concentraties linalool. De definitieve noot van Panamese en Ethiopische Gesha\'s.',
        'sv':
            'Intensivt blommig och parfymliknande arom. Kopplad till höga koncentrationer av linalool. Den definitiva karaktären i panamansk och etiopisk Gesha.',
        'tr':
            'Yoğun çiçeksi ve parfüm benzeri aroma. Yüksek linalool konsantrasyonuyla bağlantılıdır. Panama ve Etiyopya Gesha\'larının belirleyici notasıdır.',
        'ja':
            '非常にフローラルで香水のようなアロマ。高濃度のリナロールに関連しています。パナマ産およびエチオピア産ゲイシャ種の決定的なノートです。',
        'ko':
            '강렬한 꽃향기와 향수 같은 아로마. 고농도의 리날로올과 관련이 있습니다. 파나마 및 에티오피아 게이샤의 결정적인 노트입니다.',
        'zh': '浓郁的花香和如香水般的气息。与高浓度的芳樟醇有关。是巴拿马和埃塞俄比亚瑰夏咖啡的标志性风味。',
        'ar':
            'رائحة زهرية مكثفة تشبه العطر. مرتبطة بتركيزات عالية من اللينالول. النوتة المميزة لقهوة الغيشا البنمية والإثيوبية.',
      },
      'wheel_note_vanilla': {
        'en':
            'Sweet, creamy, and subtle aromatic note. Arises during the middle of the roasting process. Often found in high-grade washed Central American lots.',
        'uk':
            'Солодка, кремова та тонка ароматна нота. Виникає в середині процесу обсмажування. Часто зустрічається у висококласних митих центральноамериканських лотах.',
        'de':
            'Süße, cremige und subtile aromatische Note. Entsteht in der Mitte des Röstprozesses. Häufig in hochwertigen gewaschenen zentralamerikanischen Lots zu finden.',
        'fr':
            'Note aromatique sucrée, crémeuse et subtile. Apparaît au milieu du processus de torréfaction. Souvent présente dans les lots lavés de haute qualité d\'Amérique centrale.',
        'es':
            'Nota aromática dulce, cremosa y sutil. Surge a mitad del proceso de tueste. A menudo se encuentra en lotes lavados de alta calidad de América Central.',
        'it':
            'Nota aromatica dolce, cremosa e sottile. Emerge a metà del processo di tostatura. Spesso presente nei lotti lavati di alta qualità dell\'America Centrale.',
        'pt':
            'Nota aromática doce, cremosa e sutil. Surge no meio do processo de torra. Frequentemente encontrada em lotes lavados de alta qualidade da América Central.',
        'pl':
            'Słodka, kremowa i subtelna nuta aromatyczna. Pojawia się w połowie procesu palenia. Często spotykana w wysokiej klasy mytych partiach z Ameryki Środkowej.',
        'nl':
            'Zoete, romige en subtiele aromatische noot. Ontstaat halverwege het brandproces. Vaak te vinden in hoogwaardige gewassen Centraal-Amerikaanse kavels.',
        'sv':
            'Söt, krämig och subtil aromatisk not. Uppstår i mitten av rostningsprocessen. Hittas ofta i tvättade höghöjdspartier från Centralamerika.',
        'tr':
            'Tatlı, kremsi ve hafif aromatik nota. Kavurma işleminin ortasında ortaya çıkar. Genellikle yüksek kaliteli yıkanmış Orta Amerika partilerinde bulunur.',
        'ja': '甘くクリーミーで、繊細なアロマのノート。焙煎工程の中盤に生じます。高品質な中米産のウォッシュドロットによく見られます。',
        'ko':
            '달콤하고 크리미하며 미묘한 아로마 노트. 로스팅 과정 중간에 발생합니다. 고품질의 워시드 중앙아메리카 로트에서 자주 발견됩니다.',
        'zh': '甜美、柔滑且细腻的香气。产生于烘焙过程的中期。常见于优质的中美洲水洗咖啡中。',
        'ar':
            'نوتة عطرية حلوة وكريمية ورقيقة. تظهر في منتصف عملية التحميص. توجد غالباً في دفعات القهوة المغسولة عالية الجودة من أمريكا الوسطى.',
      },
      'wheel_note_vanilla_bean': {
        'en':
            'Intense, woodsy and oily sweetness. Represents a more concentrated aromatic profile than simple vanilla. Found in unique Bourbon-variety micro-lots.',
        'uk':
            'Інтенсивна, деревна та масляниста солодкість. Представляє більш концентрований ароматний профіль, ніж просто ваніль. Зустрічається в унікальних мікролотах сорту Бурбон.',
        'de':
            'Intensive, waldige und ölige Süße. Stellt ein konzentrierteres aromatisches Profil als einfache Vanille dar. In einzigartigen Bourbon-Varietät-Mikrolots zu finden.',
        'fr':
            'Douceur intense, boisée et huileuse. Représente un profil aromatique plus concentré que la simple vanille. Présente dans des micro-lots uniques de variété Bourbon.',
        'es':
            'Dulzura intensa, amaderada y aceitosa. Representa un perfil aromático más concentrado que la vainilla simple. Se encuentra en microlotes únicos de la variedad Bourbon.',
        'it':
            'Dolcezza intensa, legnosa e oleosa. Rappresenta un profilo aromatico più concentrato rispetto alla semplice vaniglia. Si trova in micro-lotti unici della varietà Bourbon.',
        'pt':
            'Doçura intensa, amadeirada e oleosa. Representa um perfil aromático mais concentrado do que a baunilha simples. Encontrada em microlotes únicos da variedade Bourbon.',
        'pl':
            'Intensywna, drzewna i oleista słodycz. Reprezentuje bardziej skoncentrowany profil aromatyczny niż zwykła wanilia. Spotykana w unikalnych mikropartiach odmiany Bourbon.',
        'nl':
            'Intense, houtachtige en olieachtige zoetheid. Vertegenwoordigt een geconcentreerder aromatisch profiel dan gewone vanille. Te vinden in unieke Bourbon-variëteit microlots.',
        'sv':
            'Intensiv, träig och oljig sötma. Representerar en mer koncentrerad aromatisk profil än vanlig vanilj. Finns i unika mikrolotter av Bourbon-varieteten.',
        'tr':
            'Yoğun, odunsu ve yağlı tatlılık. Basit vanilyadan daha konsantre bir aromatik profili temsil eder. Benzersiz Bourbon çeşidi mikro lotlarda bulunur.',
        'ja':
            '強烈でウッディ、かつオイルのような甘さ。単なるバニラよりも濃縮されたアロマプロファイルを特徴とします。独特なブルボン種のマイクロロットで見られます。',
        'ko':
            '강렬하고 나무 향이 나며 오일리한 달콤함. 단순한 바닐라보다 더 농축된 아로마 프로필을 나타냅니다. 독특한 버번 품종 마이크로 로트에서 발견됩니다.',
        'zh': '浓郁、木质且带有油脂感的甜美。代表了比普通香草更浓缩的香气特征。发现于独特的波旁品种微批次中。',
        'ar':
            'حلاوة مكثفة وخشبية وزيتية. تمثل ملفاً عطرياً أكثر تركيزاً من الفانيليا العادية. توجد في ميكرو-لوتات فريدة من نوع Bourbon.',
      },
      'wheel_note_molasses': {
        'en':
            'Thick, dark sugary sweetness with an earthy undertone. Result of high degree of caramelization. Signature of many Brazilian and Sumatran coffees.',
        'uk':
            'Густа, темна цукрова солодкість з землистим підтоном. Результат глибокої карамелізації. Характерна нота для багатьох бразильських та суматранських кав.',
        'de':
            'Dickflüssige, dunkle zuckrige Süße mit erdigem Unterton. Ergebnis einer starken Karamellisierung. Signatur vieler brasilianischer und sumatranischer Kaffees.',
        'fr':
            'Douceur sucrée épaisse et sombre avec une note terreuse. Résultat d\'un degré élevé de caramélisation. Signature de nombreux cafés du Brésil et de Sumatra.',
        'es':
            'Dulzura azucarada espesa y oscura con un trasfondo terroso. Resultado de un alto grado de caramelización. Firma de muchos cafés brasileños y de Sumatra.',
        'it':
            'Dolcezza zuccherina densa e scura con un sottofondo terroso. Risultato di un alto grado di caramellizzazione. Firma di molti caffè brasiliani e di Sumatra.',
        'pt':
            'Doçura açucarada espessa e escura com um subtom terroso. Resultado de um alto grau de caramelização. Assinatura de muitos cafés brasileiros e de Sumatra.',
        'pl':
            'Gęsta, ciemna cukrowa słodycz z ziemistym posmakiem. Wynik głębokiej karmelizacji. Charakterystyczna nuta dla wielu kaw brazylijskich i sumatrzańskich.',
        'nl':
            'Dikke, donkere suikerachtige zoetheid met een aardse ondertoon. Resultaat van een hoge graad van karamelisering. Kenmerkend voor veel Braziliaanse en Sumatraanse koffiesoorten.',
        'sv':
            'Tjock, mörk sockerhaltig sötma med en jordig underton. Resultatet av en hög grad av karamellisering. Signatur för många brasilianska och sumatranska kaffesorter.',
        'tr':
            'Topraksı alt tonlara sahip koyu, yoğun şekerli tatlılık. Yüksek derecede karamelizasyonun sonucudur. Birçok Brezilya ve Sumatra kahvesinin imzasıdır.',
        'ja':
            'とろりとした、土のようなニュアンスを伴うダークな甘さ。高度なキャラメル化の結果です。多くのブラジル産やスマトラ産のコーヒーを象徴するノートです。',
        'ko':
            '흙 내음이 감도는 진하고 어두운 설탕의 달콤함. 높은 단계의 캐러멜화 결과입니다. 많은 브라질 및 수마트라 커피의 특징입니다.',
        'zh': '浓厚、深沉且带有泥土气息的糖分甜美。是高度焦糖化的结果。是许多巴西和苏门答腊咖啡的标志性特征。',
        'ar':
            'حلاوة سكرية داكنة وكثيفة مع مسحة ترابية. ناتجة عن درجة عالية من الكرملة. سمة مميزة للعديد من أنواع القهوة البرازيلية والسومطرية.',
      },
      'wheel_note_maple_syrup': {
        'en':
            'Clean, woody and persistent sweetness. Represents high-quality, stable carbohydrate breakdown in the roast. Frequent in high-grade Guatemalan lots.',
        'uk':
            'Чиста, деревна та стійка солодкість. Представляє високоякісний, стабільний розпад вуглеводів під час обсмаження. Часто зустрічається у висококласних гватемальських лотах.',
        'de':
            'Klare, holzige und anhaltende Süße. Steht für einen hochwertigen, stabilen Kohlenhydratabbau bei der Röstung. Häufig in hochwertigen guatemaltekischen Lots zu finden.',
        'fr':
            'Douceur propre, boisée et persistante. Représente une décomposition stable et de haute qualité des glucides lors de la torréfaction. Fréquente dans les lots guatémaltèques de haute qualité.',
        'es':
            'Dulzura limpia, amaderada y persistente. Representa una degradación estable y de alta calidad de los carbohidratos durante el tueste. Frecuente en lotes guatemaltecos de alta calidad.',
        'it':
            'Dolcezza pulita, legnosa e persistente. Rappresenta una scomposizione stabile e di alta qualità dei carboidrati durante la tostatura. Frequente nei lotti guatemaltechi di alta qualità.',
        'pt':
            'Doçura limpa, amadeirada e persistente. Representa uma quebra estável e de alta qualidade de carboidratos durante a torra. Frequente em lotes guatemaltecos de alta qualidade.',
        'pl':
            'Czysta, drzewna i trwała słodycz. Reprezentuje wysokiej jakości, stabilny rozpad węglowodanów podczas palenia. Często spotykana w wysokiej klasy partiach z Gwatemali.',
        'nl':
            'Schone, houtachtige en aanhoudende zoetheid. Vertegenwoordigt hoogwaardige, stabiele koolhydraatafbraak in de branding. Komt vaak voor in hoogwaardige Guatemalteekse kavels.',
        'sv':
            'Ren, träig och ihållande sötma. Representerar en högkvalitativ, stabil kolhydratnedbrytning vid rostningen. Vanlig i högkvalitativa guatemalanska partier.',
        'tr':
            'Temiz, odunsu ve kalıcı tatlılık. Kavurma sırasında yüksek kaliteli, kararlı karbonhidrat parçalanmasını temsil eder. Yüksek kaliteli Guatemala partilerinde sık görülür.',
        'ja':
            'クリーンでウッディ、かつ持続的な甘さ。焙煎中の高品質で安定した炭水化物の分解を象徴します。高品質なグアテマラ産のロットによく見られます。',
        'ko':
            '깔끔하고 나무 향이 나며 지속적인 달콤함. 로스팅 중 고품질의 안정적인 탄수화물 분해를 나타냅니다. 고품질 과테말라 로트에서 자주 발견됩니다.',
        'zh': '纯净、带有木质气息且持久的甜味。代表了烘焙过程中高质量、稳定的碳水化合物分解。在优质瓜地马拉咖啡中很常见。',
        'ar':
            'حلاوة نظيفة وخشبية ومستمرة. تمثل تفككاً كربوهيدراتياً مستقراً وعالي الجودة أثناء التحميص. تتكرر في دفعات القهوة الغواتيمالية عالية الجودة.',
      },
      'wheel_note_caramel': {
        'en':
            'Rich, sugary browning note. Universal indicator of proper roast development. Present in sweet coffees from Guatemala to Brazil.',
        'uk':
            'Багата, цукрова нота карамелізації. Універсальний індикатор правильного розвитку обсмаження. Присутня в солодкій каві від Гватемали до Бразилії.',
        'de':
            'Reichhaltige, zuckrige Bräunungsnote. Universeller Indikator für eine ordnungsgemäße Röstentwicklung. In süßen Kaffees von Guatemala bis Brasilien vorhanden.',
        'fr':
            'Note de brunissement riche et sucrée. Indicateur universel d\'un bon développement de la torréfaction. Présente dans les cafés doux, du Guatemala au Brésil.',
        'es':
            'Rica nota de tostado azucarado. Indicador universal de un desarrollo adecuado del tueste. Presente en cafés dulces desde Guatemala hasta Brasil.',
        'it':
            'Ricca nota di doratura zuccherina. Indicatore universale di un corretto sviluppo della tostatura. Presente nei caffè dolci dal Guatemala al Brasile.',
        'pt':
            'Rica nota de tostagem açucarada. Indicador universal de um desenvolvimento adequado da torra. Presente em cafés doces da Guatemala ao Brasil.',
        'pl':
            'Bogata, cukrowa nuta brązowienia. Uniwersalny wskaźnik prawidłowego stopnia wypalenia. Obecna w słodkich kawach od Gwatemali po Brazylię.',
        'nl':
            'Rijke, suikerachtige bruiningsnoot. Universele indicator van een juiste branding. Aanwezig in zoete koffiesoorten van Guatemala tot Brazilië.',
        'sv':
            'Rik, sötaktig rostningsnot. Universell indikator på korrekt rostningsutveckling. Finns i söta kaffesorter från Guatemala till Brasilien.',
        'tr':
            'Zengin, şekerli kavrulma notası. Uygun kavurma gelişiminin evrensel göstergesidir. Guatemala\'dan Brezilya\'ya kadar tatlı kahvelerde bulunur.',
        'ja':
            '豊かな、砂糖を焦がしたようなブラウンノート。焙煎が適切に進行したことを示す普遍的な指標です。グアテマラからブラジルまで、甘いコーヒーに見られます。',
        'ko':
            '풍부하고 설탕을 졸인 듯한 브라우닝 노트. 적절한 로스팅 진행의 보편적인 지표입니다. 과테말라에서 브라질까지 달콤한 커피에서 나타납니다.',
        'zh': '浓郁、糖分褐变的气息。是烘焙程度恰到好处的普遍指标。存在于从瓜地马拉到巴西的各类甜味咖啡中。',
        'ar':
            'نوتة تحميص غنية وسكرية. مؤشر عالمي لتطور التحميص السليم. متوفرة في أنواع القهوة الحلوة من غواتيمالا إلى البرازيل.',
      },
      'wheel_note_honey': {
        'en':
            'Viscous, floral sweetness. Linked to high mucilage content and specific processing. Hallmarks of Costa Rican "Honey" processed lots.',
        'uk':
            'Густа, квіткова солодкість. Пов\'язана з високим вмістом клейковини та специфічною обробкою. Візитна картка кави з Коста-Ріки обробки "Honey".',
        'de':
            'Viskose, blumige Süße. Verbunden mit hohem Schleimgehalt und spezifischer Verarbeitung. Markenzeichen der costa-ricanischen "Honey"-verarbeiteten Lots.',
        'fr':
            'Douceur visqueuse et florale. Liée à une teneur élevée en mucilage et à un traitement spécifique. Caractéristique des lots du Costa Rica traités selon la méthode "Honey".',
        'es':
            'Dulzura viscosa y floral. Vinculada a un alto contenido de mucílago y un procesamiento específico. Sello distintivo de los lotes de Costa Rica procesados como "Honey".',
        'it':
            'Dolcezza viscosa e floreale. Legata all\'alto contenuto di mucillagine e a una lavorazione specifica. Marchio di fabbrica dei lotti costaricani lavorati con il metodo "Honey".',
        'pt':
            'Doçura viscosa e floral. Ligada ao alto teor de mucilagem e processamento específico. Marca registrada dos lotes da Costa Rica processados como "Honey".',
        'pl':
            'Lepka, kwiatowa słodycz. Związana z wysoką zawartością śluzu i specyficzną obróbką. Wizytówka kaw z Kostaryki z obróbki typu "Honey".',
        'nl':
            'Stroperige, bloemige zoetheid. Gekoppeld aan een hoog slijmstofgehalte en specifieke verwerking. Kenmerkend voor Costa Ricaanse "Honey" verwerkte kavels.',
        'sv':
            'Viskös, blommig sötma. Kopplad till hög slemhalt och specifik processning. Kännetecknande för costaricanska "Honey"-processade partier.',
        'tr':
            'Kıvamlı, çiçeksi tatlılık. Yüksek müsilaj içeriği ve özel işleme yöntemiyle bağlantılıdır. Kosta Rika "Honey" (bal) işlemli partilerin alametifarikasıdır.',
        'ja':
            '粘性のある、フローラルな甘さ。高いミュシレージ含有量と特定の精製方法に関連しています。コスタリカ産「ハニー」プロセスのロットの特徴です。',
        'ko':
            '점성이 있고 꽃향기가 나는 달콤함. 높은 점액질 함량과 특정 가공 방식과 관련이 있습니다. 코스타리카 "허니" 프로세싱 로트의 특징입니다.',
        'zh': '粘稠、花香般的甜美。与高果胶含量和特定的加工工艺有关。是哥斯大黎加“蜜处理”批次的标志。',
        'ar':
            'حلاوة لزجة وزهرية. مرتبطة بمحتوى عالٍ من المادة اللزجة ومعالجة محددة. من سمات دفعات القهوة الكوستاريكية المعالجة بطريقة "Honey".',
      },
      'wheel_note_peanuts': {
        'en':
            'Earthy, slightly oily and savory nut sweetness. Characteristic of many South American coffees and specific roast styles. Common in classic Brazilian lots.',
        'uk':
            'Землиста, злегка масляниста та пікантна горіхова солодкість. Характерно для багатьох південноамериканських кав та специфічних стилів обсмаження. Зустрічається у класичній Бразилії.',
        'de':
            'Erdige, leicht ölige und herzhafte Nuss-Süße. Charakteristisch für viele südamerikanische Kaffees und spezifische Röststile. Häufig in klassischen brasilianischen Lots.',
        'fr':
            'Douceur de noix terreuse, légèrement huileuse et savoureuse. Caractéristique de nombreux cafés d\'Amérique du Sud et de styles de torréfaction spécifiques. Courante dans les lots brésiliens classiques.',
        'es':
            'Dulzura de nuez terrosa, ligeramente aceitosa y sabrosa. Característica de muchos cafés sudamericanos y estilos de tueste específicos. Común en los lotes brasileños clásicos.',
        'it':
            'Dolcezza di frutta a guscio terrosa, leggermente oleosa e sapida. Caratteristica di molti caffè sudamericani e di specifici stili di tostatura. Comune nei classici lotti brasiliani.',
        'pt':
            'Doçura de nozes terrosa, ligeiramente oleosa e saborosa. Característica de muitos cafés sul-americanos e estilos de torra específicos. Comum em lotes brasileiros clássicos.',
        'pl':
            'Ziemista, nieco oleista i wytrawna orzechowa słodycz. Charakterystyczna dla wielu kaw z Ameryki Południowej i specyficznych stylów palenia. Powszechna w klasycznych partiach z Brazylii.',
        'nl':
            'Aardse, licht olieachtige en hartige nootzoetheid. Kenmerkend voor veel Zuid-Amerikaanse koffiesoorten en specifieke brandstijlen. Veelvoorkomend in klassieke Braziliaanse kavels.',
        'sv':
            'Jordig, något oljig och smakrik nötsötma. Karaktäristisk för många sydamerikanska kaffesorter och specifika rostningsstilar. Vanlig i klassiska brasilianska partier.',
        'tr':
            'Topraksı, hafif yağlı ve iştah açıcı fındıksı tatlılık. Birçok Güney Amerika kahvesinin ve özel kavurma stillerinin özelliğidir. Klasik Brezilya partilerinde yaygındır.',
        'ja':
            '土のような、わずかにオイル感のある香ばしいナッツの甘さ。多くの南米産コーヒーや特定の焙煎スタイルの特徴です。伝統的なブラジル産のロットによく見られます。',
        'ko':
            '흙 내음이 나고 약간 오일리하며 풍미 있는 견과류의 달콤함. 많은 남미 커피와 특정 로스팅 스타일의 특징입니다. 클래식한 브라질 로트에서 흔히 볼 수 있습니다.',
        'zh': '带有泥土气息、微油且具有风味的坚果甜美。是许多南美咖啡和特定烘焙风格的特征。常见于经典的巴西批次中。',
        'ar':
            'حلاوة مكسرات ترابية وزيتية قليلاً ولذيذة. مميزة للعديد من أنواع القهوة في أمريكا الجنوبية وأساليب تحميص معينة. شائعة في دفعات القهوة البرازيلية الكلاسيكية.',
      },
      'wheel_note_hazelnut': {
        'en':
            'Buttery, oily nut sweetness. Typical of medium roasts and stable varieties like Castillo or Caturra. Found throughout Latin America.',
        'uk':
            'Масляниста, горіхова солодкість. Типово для середнього обсмаження та стабільних сортів, таких як Кастільйо або Катурра. Зустрічається по всій Латинській Америці.',
        'de':
            'Buttrige, ölige Nuss-Süße. Typisch für mittlere Röstungen und stabile Varietäten wie Castillo oder Caturra. In ganz Lateinamerika zu finden.',
        'fr':
            'Douceur de noix beurrée et huileuse. Typique des torréfactions moyennes et des variétés stables comme le Castillo ou la Caturra. Présente dans toute l\'Amérique latine.',
        'es':
            'Dulzura de nuez mantecosa y aceitosa. Típica de tuestes medios y variedades estables como Castillo o Caturra. Se encuentra en toda América Latina.',
        'it':
            'Dolcezza di frutta a guscio burrosa e oleosa. Tipica delle tostature medie e di varietà stabili come Castillo o Caturra. Si trova in tutta l\'America Latina.',
        'pt':
            'Doçura de nozes amanteigada e oleosa. Típica de torras médias e variedades estáveis como Castillo ou Caturra. Encontrada em toda a América Latina.',
        'pl':
            'Maślana, oleista orzechowa słodycz. Typowa dla średniego stopnia palenia i stabilnych odmian, takich jak Castillo czy Caturra. Spotykana w całej Ameryce Łacińskiej.',
        'nl':
            'Boterachtige, olieachtige nootzoetheid. Typisch voor medium brandingen en stabiele variëteiten zoals Castillo of Caturra. Te vinden in heel Latijns-Amerika.',
        'sv':
            'Smörig, oljig nötsötma. Typisk för mellanrost och stabila varieteter som Castillo eller Caturra. Finns i hela Latinamerika.',
        'tr':
            'Tereyağımsı, yağlı fındık tatlılığı. Orta kavurmalar ve Castillo veya Caturra gibi istikrarlı çeşitler için tipiktir. Latin Amerika genelinde bulunur.',
        'ja':
            'バターのように濃厚でオイル感のあるナッツの甘さ。中煎りや、カスティージョ、カトゥーラといった安定した品種に典型的です。中南米全域で見られます。',
        'ko':
            '버터 향이 나고 오일리한 견과류의 달콤함. 미디엄 로스팅과 카스티요나 카투라 같은 안정적인 품종의 전형적인 특징입니다. 라틴 아메리카 전역에서 발견됩니다.',
        'zh':
            '如黄油般丝滑、多油的坚果甜美。是中度烘焙和卡斯蒂略（Castillo）或卡杜拉（Caturra）等稳定品种的典型特征。遍布拉丁美洲。',
        'ar':
            'حلاوة مكسرات زبدية وزيتية. نموذجية للتحميص المتوسط والأصناف المستقرة مثل Castillo أو Caturra. توجد في جميع أنحاء أمريكا اللاتينية.',
      },
      'wheel_note_almond': {
        'en':
            'Sweet, slightly bitter nut note with a marzipan-like edge. Linked to specific amino acid profiles. Common in clean, washed Honduran and Salvadoran coffees.',
        'uk':
            'Солодка, злегка гіркувата горіхова нота з відтінком марципану. Пов\'язана зі специфічними амінокислотними профілями. Зустрічається у чистих, митих лотах з Гондурасу та Сальвадору.',
        'de':
            'Süße, leicht bittere Nussnote mit einer marzipanähnlichen Note. Verbunden mit spezifischen Aminosäureprofilen. Häufig bei sauberen, gewaschenen honduranischen und salvadorianischen Kaffees.',
        'fr':
            'Note de noix sucrée et légèrement amère avec un côté massepain. Liée à des profils d\'acides aminés spécifiques. Courante dans les cafés lavés propres du Honduras et du Salvador.',
        'es':
            'Nota de nuez dulce, ligeramente amarga con un toque parecido al mazapán. Vinculada a perfiles de aminoácidos específicos. Común en cafés lavados limpios de Honduras y El Salvador.',
        'it':
            'Nota di frutta a guscio dolce, leggermente amara con una punta simile al marzapane. Legata a specifici profili di amminoacidi. Comune nei caffè lavati puliti dell\'Honduras e di El Salvador.',
        'pt':
            'Nota de nozes doce, ligeiramente amarga com um toque de maçapão. Ligada a perfis de aminoácidos específicos. Comum em cafés lavados limpos de Honduras e El Salvador.',
        'pl':
            'Słodka, lekko gorzkawa nuta orzechowa z posmakiem marcepanu. Związana ze specyficznymi profilami aminokwasowymi. Powszechna w czystych, mytych kawach z Hondurasu i Salwadoru.',
        'nl':
            'Zoete, licht bittere nootachtige noot met een marsepeinachtig randje. Gekoppeld aan specifieke aminozuurprofielen. Komt vaak voor in schone, gewassen Hondurese en Salvadoraanse koffiesoorten.',
        'sv':
            'Söt, något bitter nötsmak med en marsipanliknande karaktär. Kopplad till specifika aminosyraprofiler. Vanlig i rena, tvättade kaffesorter från Honduras och El Salvador.',
        'tr':
            'Tatlı, hafif acımtırak, badem ezmesi benzeri bir uca sahip fındık notası. Özel amino asit profilleriyle bağlantılıdır. Temiz, yıkanmış Honduras ve El Salvador kahvelerinde yaygındır.',
        'ja':
            '甘く、わずかに苦味のあるナッツのノートで、マジパンのようなニュアンスがあります。特定のアミノ酸プロファイルに関連しています。クリーンな水洗式のホンジュラス産やエルサルバドル産コーヒーによく見られます。',
        'ko':
            '달콤하고 약간 쌉쌀한 견과류 노트로 마지팬 같은 느낌이 있습니다. 특정 아미노산 프로필과 관련이 있습니다. 깔끔한 워시드 온두라스 및 엘살바도르 커피에서 흔히 볼 수 있습니다.',
        'zh': '甜美、微苦且带有类似杏仁糖气息的坚果味。与特定的氨基酸特征有关。在纯净的水洗洪都拉斯和萨尔瓦多咖啡中很常见。',
        'ar':
            'نوتة مكسرات حلوة ومرة قليلاً مع حافة تشبه المارزيبان. مرتبطة بملفات أحماض أمينية محددة. شائعة في أنواع القهوة المغسولة النظيفة من هندوراس والسلفادور.',
      },
      'wheel_note_chocolate': {
        'en':
            'Foundational cocoa sweetness. Result of browning reactions. Classic note for Brazilian, Indian, and Vietnamese high-quality robustas and arabicas.',
        'uk':
            'Основна какао-солодкість. Результат реакцій карамелізації. Класична нота для бразильської, індійської та в\'єтнамської високоякісної робусти та арабіки.',
        'de':
            'Grundlegende Kakao-Süße. Ergebnis von Bräunungsreaktionen. Klassische Note für hochwertige brasilianische, indische und vietnamesische Robustas und Arabicas.',
        'fr':
            'Douceur de cacao fondamentale. Résultat des réactions de brunissement. Note classique pour les robustas et arabicas de haute qualité du Brésil, de l\'Inde et du Vietnam.',
        'es':
            'Dulzura de cacao fundamental. Resultado de las reacciones de tostado. Nota clásica para robustas y arábicas de alta calidad de Brasil, India y Vietnam.',
        'it':
            'Dolcezza fondamentale del cacao. Risultato delle reazioni di doratura. Nota classica per i robusta e gli arabica di alta qualità brasiliani, indiani e vietnamiti.',
        'pt':
            'Doçura de cacau fundamental. Resultado de reações de tostagem. Nota clássica para robustas e arábicas de alta qualidade do Brasil, Índia e Vietnã.',
        'pl':
            'Podstawowa słodycz kakao. Wynik reakcji brązowienia. Klasyczna nuta dla wysokiej jakości kaw gatunku robusta i arabika z Brazylii, Indii i Wietnamu.',
        'nl':
            'Fundamentele cacao-zoetheid. Resultaat van bruiningsreacties. Klassieke noot voor Braziliaanse, Indiase en Vietnamese hoogwaardige robusta\'s en arabica\'s.',
        'sv':
            'Grundläggande kakaosötma. Resultatet av rostningsreaktioner. Klassisk not för högkvalitativa robusta- och arabikasorter från Brasilien, Indien och Vietnam.',
        'tr':
            'Temel kakao tatlılığı. Kavurma tepkimelerinin sonucudur. Brezilya, Hindistan ve Vietnam\'ın yüksek kaliteli robusta ve arabica kahveleri için klasik bir notadır.',
        'ja':
            '基礎的なカカオの甘さ。褐変反応の結果です。ブラジル産、インド産、ベトナム産の高品質なロブスタ種およびアラビカ種に典型的なノートです。',
        'ko':
            '기초적인 카카오의 달콤함. 브라우닝 반응의 결과입니다. 브라질, 인도, 베트남의 고품질 로부스타 및 아라비카의 클래식한 노트입니다.',
        'zh': '基础的可可甜美。是褐变反应的结果。是巴西、印度和越南优质罗布斯塔及阿拉比卡咖啡的经典风味。',
        'ar':
            'حلاوة الكاكاو الأساسية. ناتجة عن تفاعلات التحميص. نوتة كلاسيكية لأنواع القهوة عالية الجودة من الروبوستا والأرابيكا من البرازيل والهند وفيتنام.',
      },
      'wheel_note_dark_chocolate': {
        'en':
            'Intense, bitter-sweet cocoa richness. Marks high degree of development or specific terroir genetics. Constant in high-altitude Sumatran coffees.',
        'uk':
            'Інтенсивна, гірко-солодка насиченість какао. Вказує на високий ступінь розвитку або специфічну генетику терруару. Постійна нота у високогірній суматранській каві.',
        'de':
            'Intensive, bittersüße Kakao-Fülle. Zeichen für einen hohen Entwicklungsgrad oder spezifische Terroir-Genetik. Beständig in sumatranischen Hochlandkaffees.',
        'fr':
            'Richesse intense de cacao doux-amer. Marque un degré de développement élevé ou une génétique de terroir spécifique. Constante dans les cafés de haute altitude de Sumatra.',
        'es':
            'Intensa riqueza de cacao agridulce. Indica un alto grado de desarrollo o genética específica del terroir. Constante en los cafés de Sumatra de gran altura.',
        'it':
            'Intensa ricchezza di cacao agrodolce. Indica un alto grado di sviluppo o una genetica specifica del terroir. Costante nei caffè di Sumatra ad alta quota.',
        'pt':
            'Intensa riqueza de cacau agridoce. Indica um alto grau de desenvolvimento ou genética específica do terroir. Constante nos cafés de Sumatra de alta altitude.',
        'pl':
            'Intensywna, gorzko-słodka głębia kakao. Świadczy o wysokim stopniu wypalenia lub specyficznej genetyce terroir. Stała nuta w wysokogórskich kawach z Sumatry.',
        'nl':
            'Intense, bitterzoete cacao-rijkdom. Kenmerkt een hoge graad van ontwikkeling of specifieke terroir-genetica. Constant in Sumatraanse koffiesoorten op grote hoogte.',
        'sv':
            'Intensiv, bittersöt kakaofyllighet. Tyder på en hög grad av rostningsutveckling eller specifik terroir-genetik. Ständigt närvarande i sumatranskt höghöjdskaffe.',
        'tr':
            'Yoğun, acı-tatlı kakao zenginliği. Yüksek derecede gelişimi veya özel teruar genetiğini simgeler. Yüksek rakımlı Sumatra kahvelerinde sabittir.',
        'ja':
            '強烈で、ほろ苦いカカオの深み。高度な焙煎の進行、または特定のテロワールによる遺伝的特徴を示します。高地のスマトラ産コーヒーに不変のノートです。',
        'ko':
            '강렬하고 달콤하면서도 쌉쌀한 카카오의 풍부함. 높은 단계의 로스팅 진행 또는 특정 테루아의 유전적 특성을 나타냅니다. 고지대 수마트라 커피에서 항상 발견됩니다.',
        'zh': '浓郁、苦中带甜的可可风味。标志着高度的烘焙程度或特定的产地基因。在苏门答腊高海拔咖啡中非常稳定。',
        'ar':
            'غنى الكاكاو المكثف والمر والحلو. يشير إلى درجة عالية من التطور أو جينات معينة للتربة. ثابت في أنواع القهوة السومطرية المرتفعة.',
      },
      'wheel_note_clove': {
        'en':
            'Spicy, pungent note with a warm sensation. Result of specific phenolic compounds. Found in some Rwandan and Burundian coffees.',
        'uk':
            'Пряна, гостра нота з відчуттям тепла. Результат дії специфічних фенольних сполук. Зустрічається в деяких лотах з Руанди та Бурунді.',
        'de':
            'Würzige, stechende Note mit einem warmen Gefühl. Ergebnis spezifischer phenolischer Verbindungen. In einigen ruandischen und burundischen Kaffees zu finden.',
        'fr':
            'Note épicée et piquante avec une sensation de chaleur. Résultat de composés phénoliques spécifiques. Présente dans certains cafés rwandais et burundais.',
        'es':
            'Nota especiada y picante con una sensación cálida. Resultado de compuestos fenólicos específicos. Se encuentra en algunos cafés de Ruanda y Burundi.',
        'it':
            'Nota speziata e pungente con una sensazione calda. Risultato di specifici composti fenolici. Presente in alcuni caffè del Ruanda e del Burundi.',
        'pt':
            'Nota de especiarias picante com sensação de calor. Resultado de compostos fenólicos específicos. Encontrada em alguns cafés de Ruanda e Burundi.',
        'pl':
            'Korzenna, ostra nuta dająca uczucie ciepła. Wynik działania specyficznych związków fenolowych. Występuje w niektórych kawach z Rwandy i Burundi.',
        'nl':
            'Kruidige, scherpe noot met een warm gevoel. Resultaat van specifieke fenolische verbindingen. Te vinden in sommige Rwandese en Burundese koffiesoorten.',
        'sv':
            'Kryddig, stickande not med en varm känsla. Resultat av specifika fenoliska föreningar. Finns i vissa kaffesorter från Rwanda och Burundi.',
        'tr':
            'Sıcaklık hissi veren baharatlı, keskin nota. Özel fenolik bileşiklerin sonucudur. Bazı Ruanda ve Burundi kahvelerinde bulunur.',
        'ja':
            'スパイシーで刺激的、かつ温かみのあるノート。特定のフェノール化合物によるものです。ルワンダ産やブルンジ産の一部のコーヒーに見られます。',
        'ko':
            '따뜻한 느낌을 주는 톡 쏘는 스파이스 노트입니다. 특정 페놀 화합물의 결과입니다. 일부 르완다와 부룬디 커피에서 발견됩니다.',
        'zh': '具有温暖感的辛辣、刺鼻气息。是特定酚类化合物的结果。在一些卢旺达和布隆迪咖啡中可见。',
        'ar':
            'نوتة حريفة ولاذعة مع إحساس بالدفء. ناتجة عن مركبات فينولية معينة. توجد في بعض أنواع القهوة الرواندية والبوروندية.',
      },
      'wheel_note_cinnamon': {
        'en':
            'Sweet, woody spice note. Common in medium-light roasts of dense coffees. Frequent in Yemeni and some Ethiopian coffees.',
        'uk':
            'Солодка, деревна пряна нота. Поширена в середньо-світлому обсмаженні щільної кави. Часто зустрічається в єменській та деякій ефіопській каві.',
        'de':
            'Süße, holzige Gewürznote. Häufig bei mittelhellen Röstungen dichter Kaffees. Oft in jemenitischen und einigen äthiopischen Kaffees.',
        'fr':
            'Note d\'épice douce et boisée. Commune dans les torréfactions moyennes-claires de cafés denses. Fréquente dans les cafés yéménites et certains cafés éthiopiens.',
        'es':
            'Nota de especia dulce y amaderada. Común en tostados medios-claros de cafés densos. Frecuente en cafés yemeníes y algunos etíopes.',
        'it':
            'Nota di spezia dolce e legnosa. Comune nelle tostature medio-chiare di caffè densi. Frequente nei caffè yemeniti e in alcuni caffè etiopi.',
        'pt':
            'Nota de especiaria doce e amadeirada. Comum em torras médias-claras de cafés densos. Frequente em cafés iemenitas e alguns etíopes.',
        'pl':
            'Słodka, drzewna nuta przyprawowa. Często spotykana в średnio-jasnym paleniu gęstych kaw. Częsta в kawach jemeńskich i niektórych etiopskich.',
        'nl':
            'Zoete, houtachtige kruidige noot. Veelvoorkomend bij medium-lichte brandingen van koffie met een hoge dichtheid. Vaak in Jemenitische en sommige Ethiopische koffiesoorten.',
        'sv':
            'Söt, träig kryddnot. Vanlig i ljus mellanrost av täta kaffesorter. Förekommer ofta i jemenitiskt och visst etiopiskt kaffe.',
        'tr':
            'Tatlı, odunsu baharat notası. Yoğun kahvelerin orta-açık kavurmalarında yaygındır. Yemen ve bazı Etiyopya kahvelerinde sıklıkla görülür.',
        'ja':
            '甘く、ウッディなスパイスのノート。密度の高い豆の中浅煎りでよく見られます。イエメン産や一部のエチオピア産コーヒーに頻繁に現れます。',
        'ko':
            '달콤하고 우디한 스파이스 노트입니다. 밀도가 높은 생두의 미디엄-라이트 로스팅에서 흔히 발견됩니다. 예멘과 일부 에티오피아 커피에서자주 나타납니다.',
        'zh': '甜美的木质香料味。常见于高密度咖啡的中浅度烘焙。在也门和一些埃塞俄比亚咖啡中经常出现。',
        'ar':
            'نوتة توابل حلوة وخشبية. شائعة في التحميص المتوسط الفاتح للقهوة الكثيفة. تتكرر في أنواع القهوة اليمنية وبعض أنواع القهوة الإثيوبية.',
      },
      'wheel_note_nutmeg': {
        'en':
            'Earthy and warm spice profile. Often complements chocolate and nutty sweetness. Characteristic of high-grade Indonesian Arabicas.',
        'uk':
            'Землистий та теплий пряний профіль. Часто доповнює шоколадну та горіхову солодкість. Характерно для висококласних індонезійських арабік.',
        'de':
            'Erdiges und warmes Gewürzprofil. Ergänzt oft Schokolade und nussige Süße. Charakteristisch für hochwertige indonesische Arabicas.',
        'fr':
            'Profil d\'épices terreux et chaud. Complète souvent la douceur du chocolat et des noix. Caractéristique des Arabicas indonésiens de haute qualité.',
        'es':
            'Perfil de especias terroso y cálido. A menudo complementa el dulzor del chocolate y las nueces. Característico de los arábicas indonesios de alta calidad.',
        'it':
            'Profilo di spezie terroso e caldo. Spesso completa la dolcezza del cioccolato e della frutta a guscio. Caratteristico degli Arabica indonesiani di alta qualità.',
        'pt':
            'Perfil de especiarias terroso e quente. Frequentemente complementa a doçura do chocolate e das nozes. Característico dos Arábicas indonésios de alta qualidade.',
        'pl':
            'Ziemisty i ciepły profil przyprawowy. Często dopełnia czekoladową i orzechową słodycz. Charakterystyczny dla wysokiej klasy indonezyjskich arabik.',
        'nl':
            'Aards en warm kruidig profiel. Vult vaak de zoetheid van chocolade en noten aan. Kenmerkend voor hoogwaardige Indonesische Arabica\'s.',
        'sv':
            'Jordig och varm kryddprofil. Kompletterar ofta choklad och nötig sötma. Karaktäristiskt för indonesisk arabica av hög kvalitet.',
        'tr':
            'Topraksı ve sıcak baharat profili. Genellikle çikolata ve fındıksı tatlılığı tamamlar. Üst düzey Endonezya Arabica\'larının özelliğidir.',
        'ja':
            '土っぽく温かみのあるスパイスのプロフィール。チョコレートやナッツの甘さを補完することが多いです。高級なインドネシア産アラビカ種の特徴です。',
        'ko':
            '흙 내음이 나고 따뜻한 스파이스 프로파일입니다. 종종 초콜릿과 견과류의 달콤함을 보완합니다. 고급 인도네시아 아라비카의 특징입니다.',
        'zh': '泥土般温暖的香料风味。经常补充巧克力和坚果的甜味。是高品质印度尼西亚阿拉比卡咖啡的特征。',
        'ar':
            'ملف توابل ترابي ودافئ. غالباً ما يكمل حلاوة الشوكولاتة والمكسرات. مميز لأنواع الأرابيكا الإندونيسية عالية الجودة.',
      },
      'wheel_note_anise': {
        'en':
            'Cool, sweet and slightly medicinal spice note. Reminiscent of licorice. Found in some rare Yemeni and complex African lots.',
        'uk':
            'Прохолодна, солодка та злегка аптечна пряна нота. Нагадує лакрицю. Зустрічається у деяких рідкісних єменських та складних африканських лотах.',
        'de':
            'Kühle, süße und leicht medizinische Gewürznote. Erinnert an Lakritz. In einigen seltenen jemenitischen und komplexen afrikanischen Lots zu finden.',
        'fr':
            'Note d\'épice fraîche, douce et légèrement médicinale. Rappelle la réglisse. Présente dans certains lots yéménites rares et complexes d\'Afrique.',
        'es':
            'Nota de especia fresca, dulce y ligeramente medicinal. Recuerda al regaliz. Se encuentra en algunos lotes yemeníes raros y africanos complejos.',
        'it':
            'Nota di spezia fresca, dolce e leggermente medicinale. Ricorda la liquirizia. Presente in alcuni rari lotti yemeniti e complessi africani.',
        'pt':
            'Nota de especiaria fresca, doce e ligeiramente medicinal. Lembra alcaçuz. Encontrada em alguns lotes raros iemenitas e complexos africanos.',
        'pl':
            'Chłodna, słodka i nieco apteczna nuta przyprawowa. Przypomina lukrecję. Występuje в niektórych rzadkich jemeńskich i złożonych afrykańskich kawach.',
        'nl':
            'Frisse, zoete en licht medicinale kruidige noot. Doet denken aan drop. Te vinden in sommige zeldzame Jemenitische en complexe Afrikaanse kavels.',
        'sv':
            'Sval, söt och något medicinsk kryddnot. Påminner om lakrits. Finns i vissa sällsynta jemenitiska och komplexa afrikanska partier.',
        'tr':
            'Serin, tatlı ve hafif tıbbi baharat notası. Meyan kökünü andırır. Bazı nadir Yemen ve karmaşık Afrika lotlarında bulunur.',
        'ja':
            '清涼感があり甘く、わずかに薬のようなスパイスのノート。リコリス（甘草）を思わせます。希少なイエメン産や複雑なアフリカ産コーヒーに見られます。',
        'ko':
            '시원하고 달콤하며 약간의 약품 느낌이 있는 스파이스 노트입니다. 감초를 연상시킵니다. 일부 희귀한 예멘 및 복합적인 아프리카 커피에서 발견됩니다.',
        'zh': '清凉、甜美且略带药味的香料味。让人联想到甘草。在一些稀有的也门和复杂的非洲批次中可见。',
        'ar':
            'نوتة توابل باردة وحلوة وطبية قليلاً. تذكرنا بعرق السوس. توجد في بعض المحاصيل اليمنية النادرة والأفريقية المعقدة.',
      },
      'wheel_note_malt': {
        'en':
            'Sweet, grain-like note reminiscent of beer or freshly baked bread. Indicator of specific sugar-amino-acid reactions. Common in traditional Brazilian coffees.',
        'uk':
            'Солодка, зернова нота, що нагадує пиво або свіжоспечений хліб. Індикатор специфічних реакцій цукру та амінокислот. Зустрічається в традиційній бразильській каві.',
        'de':
            'Süße, getreideartige Note, die an Bier oder frisch gebackenes Brot erinnert. Indikator für spezifische Zucker-Aminosäure-Reaktionen. Häufig in traditionellen brasilianischen Kaffees.',
        'fr':
            'Note douce et céréalière rappelant la bière ou le pain fraîchement cuit. Indicateur de réactions spécifiques sucre-acides aminés. Commun dans les cafés brésiliens traditionnels.',
        'es':
            'Nota dulce y cereal que recuerda a la cerveza o al pan recién horneado. Indicador de reacciones específicas entre azúcares y aminoácidos. Común en los cafés brasileños tradicionales.',
        'it':
            'Nota dolce e di cereale che ricorda la birra o il pane appena sfornato. Indicatore di specifiche reazioni zucchero-aminoacidi. Comune nei caffè brasiliani tradizionali.',
        'pt':
            'Nota doce e de cereal que lembra cerveja ou pão acabado de cozer. Indicador de reacções específicas açúcar-aminoácidos. Comum nos cafés brasileiros tradicionais.',
        'pl':
            'Słodka, zbożowa nuta przypominająca piwo lub świeżo upieczony chleb. Wskaźnik specyficznych reakcji cukrów i aminokwasów. Częsta в tradycyjnych brazylijskich kawach.',
        'nl':
            'Zoete, graanachtige noot die doet denken aan bier of vers gebakken brood. Indicator voor specifieke suiker-aminozuurreacties. Veelvoorkomend in traditionele Braziliaanse koffiesoorten.',
        'sv':
            'Söt, spannmålsliknande not som påminner om öl eller nybakat bröd. Indikator på specifika socker-aminosyrareaktioner. Vanligt i traditionellt brasilianskt kaffe.',
        'tr':
            'Birayı veya taze pişmiş ekmeği andıran tatlı, tahıl benzeri nota. Özel şeker-amino asit reaksiyonlarının göstergesidir. Geleneksel Brezilya kahvelerinde yaygındır.',
        'ja':
            'ビールや焼きたてのパンを思わせる、甘く穀物のようなノート。特定の糖とアミノ酸の反応（メイラード反応）の指標です。伝統的なブラジル産コーヒーによく見られます。',
        'ko':
            '맥주나 갓 구운 빵을 연상시키는 달콤한 곡물 노트입니다. 특정 당-아미노산 반응의 지표입니다. 전통적인 브라질 커피에서 흔히 발견됩니다.',
        'zh': '甜美的谷物气息，让人联想到啤酒或新鲜出炉的面包。是特定糖-氨基酸反应的指标。在传统的巴西咖啡中很常见。',
        'ar':
            'نوتة حلوة وحبيبية تشبه البيرة أو الخبز الطازج. مؤشر على تفاعلات معينة بين السكر والأحماض الأمينية. شائعة في أنواع القهوة البرازيلية التقليدية.',
      },
      'wheel_note_grain': {
        'en':
            'Toasted, bread-like cereal note. Marks early development stages or high-density beans. Found in many high-quality commercial grade coffees.',
        'uk':
            'Ноти підсмажених злаків та хліба. Вказує на ранні стадії розвитку або високу щільність зерна. Зустрічається у багатьох високоякісних комерційних сортах кави.',
        'de':
            'Geröstete, brotähnliche Getreidenote. Markiert frühe Entwicklungsstadien oder Bohnen mit hoher Dichte. In vielen hochwertigen kommerziellen Kaffeesorten zu finden.',
        'fr':
            'Note de céréales grillées, semblable au pain. Marque les premières étapes du développement ou les grains à haute densité. Présente dans de nombreux cafés de qualité commerciale supérieure.',
        'es':
            'Nota de cereal tostado, similar al pan. Marca etapas tempranas de desarrollo o granos de alta densidad. Se encuentra en muchos cafés de grado comercial de alta calidad.',
        'it':
            'Nota di cereali tostati, simile al pane. Segna le prime fasi di sviluppo o chicchi ad alta densità. Si trova in molti caffè di qualità commerciale superiore.',
        'pt':
            'Nota de cereal torrado, semelhante a pão. Marca estágios iniciais de desenvolvimento ou grãos de alta densidade. Encontrada em muitos cafés de grau comercial de alta qualidade.',
        'pl':
            'Prażona, chlebowa nuta zbożowa. Świadczy o wczesnych etapach rozwoju lub ziarnach o wysokiej gęstości. Występuje в wielu wysokiej jakości kawach komercyjnych.',
        'nl':
            'Geroosterde, broodachtige graannoot. Markeert vroege ontwikkelingsstadia of bonen met een hoge dichtheid. Te vinden in veel commerciële koffiesoorten van hoge kwaliteit.',
        'sv':
            'Rostad, brödliknande spannmålsnot. Tyder på tidiga utvecklingsstadier eller bönor med hög densitet. Finns i många kommersiella kaffesorter av hög kvalitet.',
        'tr':
            'Kavrulmuş, ekmek benzeri tahıl notası. Erken gelişim aşamalarını veya yüksek yoğunluklu çekirdekleri işaret eder. Birçok yüksek kaliteli ticari sınıf kahvede bulunur.',
        'ja':
            'トーストしたパンのような穀物のノート。初期の焙煎進行や密度の高い豆を示します。多くの高品質なコマーシャルグレードのコーヒーに見られます。',
        'ko':
            '구운 빵 같은 곡물 노트입니다. 초기 발달 단계나 고밀도 생두를 나타냅니다. 많은 고품질 커머셜 등급 커피에서 발견됩니다.',
        'zh': '烘烤的面包般谷物香气。标志着早期烘焙阶段或高密度咖啡豆。在许多高质量的商业等级咖啡中可见。',
        'ar':
            'نوتة حبوب محمصة تشبه الخبز. تشير إلى مراحل التطوير المبكرة أو الحبوب عالية الكثافة. توجد في العديد من أنواع القهوة ذات الدرجة التجارية عالية الجودة.',
      },
      'wheel_note_smoky': {
        'en':
            'Distinctive aroma of wood smoke or charcoal. Result of intense roasting or bean surface scorching. Classic in dark-roasted blends.',
        'uk':
            'Інтенсивні ноти вугілля та деревного диму. Типово для профілів темного обсмаження, де домінує піроліз. Квінтесенція стилів південноіталійського еспресо.',
        'de':
            'Markantes Aroma von Holzrauch oder Holzkohle. Ergebnis intensiver Röstung oder Verbrennung der Bohnenoberfläche. Klassisch in dunklen Röstmischungen.',
        'fr':
            'Arôme distinctif de fumée de bois ou de charbon de bois. Résultat d\'une torréfaction intense ou d\'un brûlage de la surface des grains. Classique dans les mélanges à torréfaction foncée.',
        'es':
            'Aroma distintivo a humo de leña o carbón. Resultado de un tostado intenso o quemado superficial del grano. Clásico en mezclas de tostado oscuro.',
        'it':
            'Aroma distintivo di fumo di legna o carbone. Risultato di una tostatura intensa o di una bruciatura superficiale del chicco. Classico nelle miscele a tostatura scura.',
        'pt':
            'Aroma distinto de fumaça de madeira ou carvão. Resultado de torra intensa ou queima superficial do grão. Clássico em blends de torra escura.',
        'pl':
            'Wyraźny aromat dymu drzewnego lub węgla drzewnego. Wynik intensywnego palenia lub przypalenia powierzchni ziarna. Klasyk w ciemno palonych mieszankach.',
        'nl':
            'Kenmerkend aroma van houtrook of houtskool. Resultaat van intensief branden of verbranding van het boon-oppervlak. Klassiek in donkergebrande melanges.',
        'sv':
            'Karaktäristisk arom av vedrök eller kol. Resultat av intensiv rostning eller bränning av bönans yta. Klassiskt i mörkrostade blandningar.',
        'tr':
            'Odun dumanı veya odun kömürünün kendine özgü aroması. Yoğun kavurma veya çekirdek yüzeyinin yanmasının sonucudur. Koyu kavrulmuş karışımlarda klasiktir.',
        'ja': '木煙や炭の独特のアロマ。強火での焙煎や豆の表面の焦げの結果です。深煎りのブレンドでは定番の特徴です。',
        'ko':
            '장작 연기나 숯의 독특한 아로마입니다. 강한 로스팅이나 원두 표면이 그을린 결과입니다. 다크 로스팅 블렌드의 전형적인 특징입니다.',
        'zh': '木质烟熏或木炭的独特香气。是剧烈烘焙或豆表焦灼的结果。是深焙混合豆中的经典风味。',
        'ar':
            'رائحة مميزة لدخان الخشب أو الفحم. ناتجة عن التحميص المكثف أو احتراق سطح الحبوب. كلاسيكية في خلطات التحميص الداكنة.',
      },
      'wheel_note_ashy': {
        'en':
            'Dry, powdery scent of burnt wood or cold ash. Often indicates surface scorching during roast. Frequent in lower-quality dark roasts.',
        'uk':
            'Суха, вуглецева та мінеральна нота. Вказує на екстремальний вплив тепла під час обсмаження. Зустрічається в комерційних лотах темного обсмаження.',
        'de':
            'Trockener, pudriger Duft von verbranntem Holz oder kalter Asche. Weist oft auf Oberflächenverbrennungen während der Röstung hin.',
        'fr':
            'Odeur sèche et poudreuse de bois brûlé ou de cendre froide. Indique souvent un brûlage de surface pendant la torréfaction.',
        'es':
            'Olor seco y polvoriento a madera quemada o ceniza fría. A menudo indica quemado superficial durante el tostado.',
        'it':
            'Odore secco e polveroso di legno bruciato o cenere fredda. Spesso indica una bruciatura superficiale durante la tostatura.',
        'pt':
            'Cheiro seco e polveroso de madeira queimada ou cinza fria. Frequentemente indica queima superficial durante a torra.',
        'pl':
            'Suchy, pudrowy zapach spalonego drewna lub zimnego popiołu. Często wskazuje na przypalenie powierzchni podczas palenia.',
        'nl':
            'Droge, poederachtige geur van verbrand hout of koude as. Wijst vaak op oppervlakteverbranding tijdens het branden.',
        'sv':
            'Torr, pudrig doft av bränt trä oder kall aska. Tyder ofta på ytlig bränning under rostningen.',
        'tr':
            'Yanmış odun veya soğuk külün kuru, tozlu kokusu. Genellikle kavurma sırasında yüzeyin yanmasını gösterir.',
        'ja': '焼けた木や冷えた灰のような、乾燥した粉っぽい香り。焙煎中の表面の焦げを示していることが多いです。',
        'ko': '탄 나무나 찬 재의 건조하고 가루 같은 향입니다. 로스팅 중 표면이 그을렸음을 나타내는 경우가 많습니다.',
        'zh': '烧焦的木头或冷灰的干燥粉末味。通常预示着烘焙过程中的表面焦灼。',
        'ar':
            'رائحة جافة وترابية للخشب المحترق أو الرماد البارد. غالباً ما تشير إلى احتراق السطح أثناء التحميص.',
      },
      'wheel_note_olive_oil': {
        'en':
            'Distinctive, rich, and slightly savory oil note. Reminiscent of fresh extra virgin olive oil. Found in specific varieties or unique anaerobic processes.',
        'uk':
            'Характерна, багата та злегка пікантна олійна нота. Нагадує свіжу оливкову олію extra virgin. Зустрічається в специфічних сортах або при унікальній анаеробній обробці.',
        'de':
            'Markante, reiche und leicht herzhafte Ölnote. Erinnert an frisches natives Olivenöl extra. Zu finden in spezifischen Varietäten oder einzigartigen anaeroben Prozessen.',
        'fr':
            'Note huileuse distinctive, riche et légèrement savoureuse. Rappelle l\'huile d\'olive extra vierge fraîche. Présent dans des variétés spécifiques ou des processus anaérobies uniques.',
        'es':
            'Nota de aceite distintiva, rica y ligeramente sabrosa. Recuerda al aceite de oliva virgen extra fresco. Se encuentra en variedades específicas o procesos anaeróbicos únicos.',
        'it':
            'Nota oleosa distinta, ricca e leggermente sapida. Ricorda l\'olio extravergine di oliva fresco. Presente in varietà specifiche o processi anaerobici unici.',
        'pt':
            'Nota de óleo distinta, rica e levemente salgada. Lembra azeite virgen extra fresco. Encontrada em variedades específicas ou processos anaeróbicos únicos.',
        'pl':
            'Charakterystyczna, bogata i lekko pikantna nuta olejowa. Przypomina świeżą oliwę z oliwek extra virgin. Spotykana w określonych odmianach lub unikalnych procesach anaerobowych.',
        'nl':
            'Kenmerkende, rijke en licht hartige olienoot. Doet denken aan verse extra vergine olijfolie. Te vinden in specifieke variëteiten of unieke anaerobe processen.',
        'sv':
            'Karaktäristisk, rik och något fyllig oljenot. Påminner om färsk extra virgin olivolja. Finns i specifika varieteter eller unika anaerobiska processer.',
        'tr':
            'Ayırt edici, zengin ve hafif lezzetli yağ notası. Taze sızma zeytinyağını andırır. Belirli çeşitlerde veya benzersiz anaerobik işlemlerde bulunur.',
        'ja':
            '特徴的で豊か、そしてわずかに香ばしいオイルのノート。新鮮なエクストラバージンオリーブオイルを思わせます。特定の品種や、ユニークなアナエロビック（好気性）精製に見られます。',
        'ko':
            '독특하고 풍부하며 약간 고소한 오일 노트입니다. 신선한 엑스트라 버진 올리브 오일을 연상시킵니다. 특정 품종이나 독특한 무산소 발효 과정에서 발견됩니다.',
        'zh': '独特、浓郁且略带咸鲜感的油脂气息。让人联想到新鲜的特级初榨橄榄油。存在于特定品种或独特的厌氧处理中。',
        'ar':
            'نكهة زيتية مميزة وغنية ومالحة قليلاً. تذكر بزيت الزيتون البكر الممتاز الطازج. توجد في أصناف محددة أو عمليات تخمر لاهوائية فريدة.',
      },
      'wheel_note_raw': {
        'en':
            'Unprocessed, green seed flavor. Indicative of extreme under-roasting or very fresh harvest. Generally considered a defect in finished roasts.',
        'uk':
            'Смак необробленого зеленого насіння. Свідчить про екстремальне недообсмажування або дуже свіжий врожай. Загалом вважається дефектом у готовому обсмаженні.',
        'de':
            'Unverarbeiteter Geschmack grüner Samen. Deutet auf extrem helle Röstung oder sehr frische Ernte hin. Wird allgemein als Defekt in fertigen Röstungen angesehen.',
        'fr':
            'Saveur de graine verte non transformée. Indique une sous-torréfaction extrême ou une récolte très fraîche. Généralement considéré comme un défaut dans les torréfactions finies.',
        'es':
            'Sabor a semilla verde sin procesar. Indica un tueste extremadamente ligero o una cosecha muy fresca. Generalmente se considera un defecto en los tuestes terminados.',
        'it':
            'Sapore di seme verde non lavorato. Indica una tostatura estremamente chiara o un raccolto molto fresco. Generalmente considerato un difetto nelle tostature finite.',
        'pt':
            'Sabor de semente verde não processada. Indica uma torra extremamente leve ou uma colheita muito fresca. Geralmente considerado um defeito em torras terminadas.',
        'pl':
            'Smak nieprzetworzonych zielonych nasion. Wskazuje na ekstremalne niedopalenie lub bardzo świeże zbiory. Ogólnie uważane za defekt w gotowych wypałach.',
        'nl':
            'Onverwerkte smaak van groene zaden. Duidt op extreme onderbranding of een zeer verse oogst. Wordt over het algemeen beschouwd als een defect in de uiteindelijke branding.',
        'sv':
            'Oprocessad smak av gröna frön. Tyder på extrem underrostning eller mycket färsk skörd. Betraktas generellt som en defekt i färdigrostade bönor.',
        'tr':
            'İşlenmemiş, yeşil çekirdek tadı. Aşırı az kavurmayı veya çok taze hasadı işaret eder. Bitmiş kavurmalarda genellikle bir kusur olarak kabul edilir.',
        'ja':
            '加工されていない、生の種子のようなフレーバー。極端な焙煎不足や、非常に新鮮な収穫（ニュークロップ）を示します。通常、焙煎豆としては欠点と見なされます。',
        'ko':
            '가공되지 않은 생두 본연의 맛입니다. 극도의 로스팅 부족이나 매우 신선한 수확물을 나타냅니다. 일반적으로 완성된 로스팅에서는 결함으로 간주됩니다.',
        'zh': '未经处理的青草籽味。预示着极度烘焙不足或极新产季的咖啡豆。通常被视为烘焙成品中的缺陷。',
        'ar':
            'نكهة بذور خضراء غير معالجة. تشير إلى نقص شديد في التحميص أو حصاد طازج جداً. تعتبر عموماً عيباً في التحميص النهائي.',
      },
      'wheel_note_under_ripe': {
        'en':
            'Astringent and sharp notes of unripe fruit. Results from harvesting cherries before peak maturation. Common in low-grade commercial lots.',
        'uk':
            'В\'яжучі та гострі ноти недозрілих фруктів. Результат збору ягід до піку дозрівання. Зустрічається у низькосортних комерційних лотах.',
        'de':
            'Adstringierende und scharfe Noten unreifer Früchte. Resultiert aus der Ernte von Kirschen vor der vollen Reife. Häufig bei minderwertigen kommerziellen Partien.',
        'fr':
            'Notes astringentes et tranchantes de fruits non mûrs. Résulte de la récolte de cerises avant la pleine maturation. Commun dans les lots commerciaux de basse qualité.',
        'es':
            'Notas astringentes y punzantes de fruta verde. Resultado de cosechar cerezas antes de su maduración máxima. Común en lotes comerciales de baja calidad.',
        'it':
            'Note astringenti e pungenti di frutta acerba. Deriva dalla raccolta delle ciliegie prima della piena maturazione. Comune nei lotti commerciali di bassa qualità.',
        'pt':
            'Notas adstringentes e agudas de frutas verdes. Resulta da colheita de cerejas antes do pico de maturação. Comum em lotes comerciais de baixa qualidade.',
        'pl':
            'Cierpkie i ostre nuty niedojrzałych owoców. Wynikają ze zbioru wiśni przed osiągnięciem pełnej dojrzałości. Powszechne w niskiej jakości partiach komercyjnych.',
        'nl':
            'Wrange en scherpe tonen van onrijp fruit. Het resultaat van het oogsten van kersen voor de volledige rijping. Veelvoorkomend in commerciële partijen van lage kwaliteit.',
        'sv':
            'Sträva och skarpa noter av omogen frukt. Resultatet av att skörda körsbär före full mognad. Vanligt i kommersiella partier av lägre kvalitet.',
        'tr':
            'Olgunlaşmamış meyvelerin buruk ve keskin notaları. Kirazların tam olgunlaşmadan hasat edilmesinden kaynaklanır. Düşük kaliteli ticari lotlarda yaygındır.',
        'ja': '未熟な果実の、渋くて鋭いノート。完熟前に収穫されたコーヒーチェリーに由来します。低級なコマーシャルコーヒーによく見られます。',
        'ko':
            '잘 익지 않은 과일의 떫고 날카로운 노트입니다. 체리가 완전히 익기 전에 수확하여 발생합니다. 저급 커머셜 로트에서 흔히 볼 수 있습니다.',
        'zh': '未成熟水果的涩味和辛辣感。是由于在樱桃完全成熟前采摘造成的。常见于低等级的商业批次中。',
        'ar':
            'نكهات لاذعة وحادة لفاكهة غير ناضجة. ناتجة عن حصاد كرز القهوة قبل ذروة النضج. شائعة في المحاصيل التجارية منخفضة الجودة.',
      },
      'wheel_note_peapod': {
        'en':
            'Vegetal, leguminous note reminiscent of fresh peas. Often found in specific Central American varieties or underdeveloped roasts.',
        'uk':
            'Овочева, бобова нота, що нагадує свіжий горох. Часто зустрічається в специфічних центральноамериканських сортах або при недообсмажуванні.',
        'de':
            'Pflanzliche, hülsenfruchtartige Note, die an frische Erbsen erinnert. Oft in spezifischen mittelamerikanischen Varietäten oder unterentwickelten Röstungen zu finden.',
        'fr':
            'Note végétale et légumineuse rappelant les pois frais. Souvent présent dans des variétés spécifiques d\'Amérique centrale ou des torréfactions sous-développées.',
        'es':
            'Nota vegetal y leguminosa que recuerda a los guisantes frescos. A menudo se encuentra en variedades específicas de América Central o tuestes poco desarrollados.',
        'it':
            'Nota vegetale e leguminosa che ricorda i piselli freschi. Spesso presente in specifiche varietà dell\'America Centrale o tostature sottosviluppate.',
        'pt':
            'Nota vegetal e leguminosa que lembra ervilhas frescas. Frequentemente encontrada em variedades específicas da América Central ou torras pouco desenvolvidas.',
        'pl':
            'Warzywna, strączkowa nuta przypominająca świeży groszek. Często spotykana w określonych odmianach środkowoamerykańskich lub niedopalonych ziarnach.',
        'nl':
            'Plantaardige, peulvruchtachtige noot die doet denken aan verse doperwten. Vaak te vinden in specifieke Centraal-Amerikaanse variëteiten of onderontwikkelde brandingen.',
        'sv':
            'Vegetabilisk, baljväxtliknande not som påminner om färska ärtor. Finns ofta i specifika mellanamerikanska varieteter eller underutvecklade rostningar.',
        'tr':
            'Taze bezelyeyi andıran bitkisel, baklagil notası. Genellikle belirli Orta Amerika çeşitlerinde veya az kavrulmuş kahvelerde bulunur.',
        'ja': '新鮮なエンドウ豆を思わせる、植物系・豆類のノート。特定の中米品種や、焙煎不足の豆によく見られます。',
        'ko':
            '신선한 완두콩을 연상시키는 식물성, 콩류 노트입니다. 특정 중앙 아메리카 품종이나 로스팅이 덜 된 원두에서 자주 발견됩니다.',
        'zh': '蔬菜、豆类气息，让人联想到新鲜豌豆。常见于特定的中美洲品种或烘焙不足的咖啡豆中。',
        'ar':
            'نكهة نباتية وبقولية تذكر بالبسلة الطازجة. غالباً ما توجد في أصناف محددة من أمريكا الوسطى أو التحميص غير المتطور.',
      },
      'wheel_note_fresh': {
        'en':
            'Bright, leafy, and "green" sensation. Evokes the smell of fresh vegetation or clipped herbs. Characteristic of very light roasts.',
        'uk':
            'Яскраве, листяне та "зелене" відчуття. Нагадує запах свіжої рослинності або зрізаних трав. Характерно для дуже світлого обсмажування.',
        'de':
            'Helle, blattartige und "grüne" Empfindung. Erinnert an den Geruch frischer Vegetation oder geschnittener Kräuter. Charakteristisch für sehr helle Röstungen.',
        'fr':
            'Sensation brillante, feuillue et "verte". Évoque l\'odeur de la végétation fraîche ou des herbes coupées. Caractéristique des torréfactions très légères.',
        'es':
            'Sensación brillante, frondosa y "verde". Evoca el olor a vegetación fresca o hierbas cortadas. Característico de tuestes muy ligeros.',
        'it':
            'Sensazione brillante, fogliosa e "verde". Evoca l\'odore della vegetazione fresca o delle erbe tagliate. Caratteristico delle tostature molto chiare.',
        'pt':
            'Sensação brilhante, folhosa e "verde". Evoca o cheiro de vegetação fresca ou ervas cortadas. Característico de torras muito claras.',
        'pl':
            'Jasne, liściaste i "zielone" odczucie. Przywołuje zapach świeżej roślinności lub ściętych ziół. Charakterystyczne dla bardzo jasnych wypałów.',
        'nl':
            'Heldere, bladachtige en "groene" sensatie. Roept de geur op van verse vegetatie of gesneden kruiden. Kenmerkend voor zeer lichte brandingen.',
        'sv':
            'Ljus, bladig och "grön" känsla. Frammanar doften av färsk vegetation eller klippta örter. Karaktäristiskt för mycket ljusa rostningar.',
        'tr':
            'Parlak, yapraksı ve "yeşil" bir his. Taze bitki örtüsü veya kesilmiş otların kokusunu andırır. Çok hafif kavurmaların özelliğidir.',
        'ja': '明るく、葉のような「グリーン」な感覚。新鮮な植物や刈り取ったハーブの香りを呼び起こします。極浅煎りの焙煎豆の特徴です。',
        'ko':
            '밝고 잎사귀 같은 "그린" 느낌입니다. 신선한 식물이나 갓 자른 허브의 향을 불러일으킵니다. 극도의 라이트 로스팅에서 전형적으로 나타납니다.',
        'zh': '明亮、充满绿叶感的“青绿色”风味。让人联想到新鲜植被或剪碎的草本。是极浅度烘焙的特征。',
        'ar':
            'إحساس ساطع وورقي و "أخضر". يستحضر رائحة النباتات الطازجة أو الأعشاب المقطوفة. مميز للتحميص الفاتح جداً.',
      },
      'wheel_note_vegetative': {
        'en':
            'General plant-like flavor profile. Can range from sweet stalk to bitter leaf. Indicates specific variety traits or roast development levels.',
        'uk':
            'Загальний рослинний смаковий профіль. Може варіюватися від солодкого стебла до гіркого листя. Вказує на специфічні ознаки сорту або рівень розвитку обсмаження.',
        'de':
            'Allgemeines pflanzenartiges Geschmacksprofil. Kann von süßem Stängel bis zu bitterem Blatt reichen. Deutet auf spezifische Varietätseigenschaften oder Röstentwicklungsstufen hin.',
        'fr':
            'Profil de saveur végétal général. Peut aller de la tige sucrée à la feuille amère. Indique des traits de variété spécifiques ou des niveaux de développement de la torréfaction.',
        'es':
            'Perfil de sabor vegetal general. Puede ir desde tallo dulce hasta hoja amarga. Indica rasgos de variedad específicos o niveles de desarrollo del tueste.',
        'it':
            'Profilo aromatico vegetale generale. Può variare dal gambo dolce alla foglia amara. Indica tratti varietali specifici o livelli di sviluppo della tostatura.',
        'pt':
            'Perfil de sabor vegetal geral. Pode variar de caule doce a folha amarga. Indica traços de variedade específicos ou níveis de desenvolvimento da torra.',
        'pl':
            'Ogólny profil smakowy przypominający rośliny. Może obejmować zakres od słodkiej łodygi po gorzki liść. Wskazuje na specyficzne cechy odmiany lub poziom rozwoju wypału.',
        'nl':
            'Algemeen plantaardig smaakprofiel. Kan variëren van zoete stengel tot bitter blad. Duidt op specifieke variëteitskenmerken of brandingsniveaus.',
        'sv':
            'Allmän växtliknande smakprofil. Kan sträcka sig från söt stjälk till beskt blad. Tyder på specifika varietetdrag eller rostningsutvecklingsnivåer.',
        'tr':
            'Genel bitki benzeri tat profili. Tatlı saptan acı yaprağa kadar değişebilir. Belirli çeşit özelliklerini veya kavurma gelişim seviyelerini işaret eder.',
        'ja':
            '一般的な植物のようなフレーバープロフィール。甘みのある茎から苦い葉まで様々です。特定の品種特性や、焙煎のディベロップメントレベルを示します。',
        'ko':
            '일반적인 식물 같은 풍미 프로필입니다. 달콤한 줄기부터 쓴 잎까지 다양합니다. 특정 품종의 특성이나 로스팅 디벨롭먼트 단계를 나타냅니다.',
        'zh': '通用的植物类风味。从甜美的茎秆到苦涩的叶片。预示着特定的品种特征或烘焙发展程度。',
        'ar':
            'ملف نكهة نباتي عام. يمكن أن يتراوح من الساق الحلوة إلى الأوراق المرة. يشير إلى سمات أصناف محددة أو مستويات تطور التحميص.',
      },
      'wheel_note_hay_like': {
        'en':
            'Dry, grassy note reminiscent of cured hay. Often associated with past-crop coffees or storage issues. Generally indicates a loss of freshness.',
        'uk':
            'Суха трав\'яниста нота, що нагадує сушене сіно. Часто асоціюється з кавою минулого врожаю або проблемами зі зберіганням. Загалом вказує на втрату свіжості.',
        'de':
            'Trockene, grasige Note, die an getrocknetes Heu erinnert. Oft verbunden mit Kaffees aus der vorangegangenen Ernte oder Lagerungsproblemen. Deutet allgemein auf einen Frischeverlust hin.',
        'fr':
            'Note d\'herbe sèche rappelant le foin séché. Souvent associé aux cafés de récoltes passées ou aux problèmes de stockage. Indique généralement une perte de fraîcheur.',
        'es':
            'Nota de hierba seca que recuerda al heno curado. A menudo se asocia con cafés de cosechas pasadas o problemas de almacenamiento. Generalmente indica una pérdida de frescura.',
        'it':
            'Nota erbacea secca che ricorda il fieno stagionato. Spesso associata a caffè di raccolti passati o problemi di stoccaggio. Indica generalmente una perdita di freschezza.',
        'pt':
            'Nota de erva seca que lembra feno curado. Frequentemente associada a cafés de safras passadas ou problemas de armazenamento. Geralmente indica uma perda de frescura.',
        'pl':
            'Sucha, trawiasta nuta przypominająca suszone siano. Często kojarzona z kawami ze starych zbiorów lub problemami z przechowywaniem. Ogólnie wskazuje na utratę świeżości.',
        'nl':
            'Droge, grasachtige noot die doet denken aan gedroogd hooi. Vaak geassocieerd met koffie van de vorige oogst of opslagproblemen. Duidt over het algemeen op een verlies van versheid.',
        'sv':
            'Torr, gräsaktig not som påminner om torkat hö. Ofta förknippad med kaffe från tidigare skördar eller lagringsproblem. Tyder generellt på förlust av färskhet.',
        'tr':
            'Kurutulmuş samanı andıran kuru, otsu nota. Genellikle eski mahsul kahvelerle veya depolama sorunlarıyla ilişkilendirilir. Genellikle tazelik kaybını işaret eder.',
        'ja':
            '乾燥した干し草を思わせる、ドライで草っぽいノート。オールドクロップ（旧産豆）や保管上の問題に関連していることが多いです。一般に鮮度の低下を示します。',
        'ko':
            '말린 건초를 연상시키는 건조하고 풀 같은 노트입니다. 종종 지난 수확기 원두나 보관 문제와 관련이 있습니다. 일반적으로 신선도 저하를 나타냅니다.',
        'zh': '干草般干燥的草本气息。通常与陈年咖啡豆或储存问题有关。通常预示着鲜度的流失。',
        'ar':
            'نكهة عشبية جافة تذكر بالقش المجفف. ترتبط غالباً بمحاصيل القهوة القديمة أو مشاكل التخزين. تشير عموماً إلى فقدان الطزاجة.',
      },
      'wheel_note_herb_like': {
        'en':
            'Aromatic and savory herbal notes like sage or thyme. Characteristic of specific terroirs. Common in some high-altitude Indonesian and Central American coffees.',
        'uk':
            'Ароматні та пікантні трав\'яні ноти, такі як шавлія або чебрець. Характерно для певних терруарів. Зустрічається в деяких високогірних індонезійських та центральноамериканських лотах.',
        'de':
            'Aromatische und herzhafte Kräuternoten wie Salbei oder Thymian. Charakteristisch für spezifische Terroirs. Häufig bei einigen indonesischen und mittelamerikanischen Hochlandkaffees.',
        'fr':
            'Notes d\'herbes aromatiques et savoureuses comme la sauge ou le thym. Caractéristique de terroirs spécifiques. Commun dans certains cafés de haute altitude d\'Indonésie et d\'Amérique centrale.',
        'es':
            'Notas herbales aromáticas y sabrosas como salvia o tomillo. Característico de terroirs específicos. Común en algunos cafés de gran altura de Indonesia y América Central.',
        'it':
            'Note erbacee aromatiche e sapide come salvia o timo. Caratteristico di specifici terroir. Comune in alcuni caffè ad alta quota indonesiani e del Centro America.',
        'pt':
            'Notas herbais aromáticas e salgadas como sálvia ou tomilho. Característico de terroirs específicos. Comum em alguns cafés de alta altitude da Indonésia e América Central.',
        'pl':
            'Aromatyczne i pikantne nuty ziołowe, takie jak szałwia lub tymianek. Charakterystyczne dla określonych terroir. Powszechne w niektórych wysokogórskich kawach z Indonezji i Ameryki Środkowej.',
        'nl':
            'Aromatische en hartige kruidentonen zoals salie of tijm. Kenmerkend voor specifieke terroirs. Veelvoorkomend in sommige hooggelegen Indonesische en Centraal-Amerikaanse koffiesoorten.',
        'sv':
            'Aromatiska och fylliga örtnoter som salvia eller timjan. Karaktäristiskt för specifika terroirer. Vanligt i vissa höghöjdskaffesorter från Indonesien och Centralamerika.',
        'tr':
            'Adaçayı veya kekik gibi aromatik ve lezzetli otsu notalar. Belirli teruarlara özgüdür. Bazı yüksek rakımlı Endonezya ve Orta Amerika kahvelerinde yaygındır.',
        'ja':
            'セージやタイムのような、芳醇で香ばしいハーブのノート。特定のテロワールの特徴です。インドネシア産や中米産の高地産コーヒーによく見られます。',
        'ko':
            '세이지나 타임 같은 향긋하고 고소한 허브 노트입니다. 특정 테루아의 특징입니다. 일부 고지대 인도네시아 및 중앙 아메리카 커피에서 흔히 볼 수 있습니다.',
        'zh': '芳香且咸鲜的草本气息，如鼠尾草或百里香。是特定风土条件的特征。常见于某些高海拔印度尼西亚和中美洲咖啡中。',
        'ar':
            'نكهات عشبية عطرية ومالحة مثل الميرمية أو الزعتر. مميزة لبيئات زراعية محددة. شائعة في بعض أنواع القهوة الإندونيسية ومن أمريكا الوسطى المزروعة على ارتفاعات عالية.',
      },
      'wheel_note_sour_aromatics': {
        'en':
            'Complex, tangy scents that bridge acidity and aroma. Often results from prolonged fermentation. Found in experimental honey and natural processed lots.',
        'uk':
            'Складні, пікантні аромати, що поєднують кислотність та запах. Часто є результатом тривалої ферментації. Зустрічається в експериментальних лотах хані та натуральної обробки.',
        'de':
            'Komplexe, spritzige Düfte, die Säure und Aroma verbinden. Oft das Ergebnis einer längeren Fermentation. Zu finden in experimentellen Honey- und Natural-Partien.',
        'fr':
            'Parfums complexes et acidulés qui font le pont entre l\'acidité et l\'arôme. Résulte souvent d\'une fermentation prolongée. Présent dans les lots expérimentaux de type "honey" et naturels.',
        'es':
            'Aromas complejos y punzantes que unen acidez y aroma. A menudo resultado de una fermentación prolongada. Se encuentra en lotes experimentales de proceso honey y naturales.',
        'it':
            'Profumi complessi e frizzanti che uniscono acidità e aroma. Spesso deriva da fermentazioni prolungate. Presente nei lotti sperimentali honey e naturali.',
        'pt':
            'Aromas complexos e picantes que unem acidez e aroma. Frequentemente resultado de fermentação prolongada. Encontrado em lotes experimentais de processamento honey e naturais.',
        'pl':
            'Złożone, pikantne zapachy łączące kwasowość z aromatem. Często wynik przedłużonej fermentacji. Spotykane w eksperymentalnych partiach typu honey i naturalnych.',
        'nl':
            'Complex, frisse geuren die een brug slaan tussen aciditeit en aroma. Vaak het resultaat van langdurige fermentatie. Te vinden in experimentele honey en natural verwerkte partijen.',
        'sv':
            'Komplexa, friska dofter som förenar syra och arom. Ofta resultatet av förlängd fermentering. Finns i experimentella honey- och naturligt beredda partier.',
        'tr':
            'Asidite ve aromayı birleştiren karmaşık, keskin kokular. Genellikle uzun süreli fermantasyonun sonucudur. Deneysel honey ve doğal işlenmiş lotlarda bulunur.',
        'ja':
            '酸味と香りの橋渡しをするような、複雑で刺激的な香り。長期発酵によって生まれることが多いです。実験的なハニープロセスやナチュラルプロセスのロットに見られます。',
        'ko':
            '산미와 향을 이어주는 복합적이고 톡 쏘는 향입니다. 종종 장기 발효의 결과로 나타납니다. 실험적인 허니 및 내추럴 가공 로트에서 발견됩니다.',
        'zh': '复杂的、带有刺痛感的香气，连接了酸度和风味。通常是延长发酵时间的结果。存在于实验性的蜜处理和日晒批次中。',
        'ar':
            'روائح معقدة ولاذعة تربط بين الحموضة والأروما. تنتج غالباً عن التخمير المطول. توجد في محاصيل المعالجة العسلية والطبيعية التجريبية.',
      },
      'wheel_note_acetic_acid': {
        'en':
            'Sharp, vinegar-like acidity. In small amounts, adds "bite" to fruit notes; in excess, indicates over-fermentation. Typical of some high-funk experimental naturals.',
        'uk':
            'Гостра, оцтова кислотність. У невеликих кількостях додає "гостроти" фруктовим нотам; при надлишку вказує на переферментацію. Типово для деяких експериментальних лотів з високим рівнем "фанку".',
        'de':
            'Scharfe, essigartige Säure. In kleinen Mengen verleiht sie Fruchtnoten "Biss"; im Übermaß deutet sie auf Überfermentation hin. Typisch für einige experimentelle Naturals mit hohem "Funk"-Anteil.',
        'fr':
            'Acidité tranchante, semblable au vinaigre. En petites quantités, ajoute du "mordant" aux notes de fruits ; en excès, indique une sur-fermentation. Typique de certains naturels expérimentaux à fort "funk".',
        'es':
            'Acidez punzante, similar al vinagre. En pequeñas cantidades, añade "chispa" a las notas frutales; en exceso, indica sobrefermentación. Típico de algunos naturales experimentales con mucho "funk".',
        'it':
            'Acidità pungente, simile all\'aceto. In piccole quantità, aggiunge vivacità alle note di frutta; in eccesso, indica una sovrafermentazione. Tipico di alcuni naturali sperimentali ad alto "funk".',
        'pt':
            'Acidez aguda, semelhante ao vinagre. Em pequenas quantidades, adiciona vivacidade às notas frutadas; em excesso, indica fermentação excessiva. Típico de alguns naturais experimentais com muito "funk".',
        'pl':
            'Ostra, octowa kwasowość. W małych ilościach dodaje owocowym nutom "pazura"; w nadmiarze wskazuje na nadmierną fermentację. Typowe dla niektórych eksperymentalnych kaw naturalnych o wysokim poziomie "funku".',
        'nl':
            'Scherpe, azijnachtige aciditeit. In kleine hoeveelheden geeft het fruitnoten "beet"; in overmaat duidt het op overfermentatie. Typisch voor sommige experimentele naturals met veel "funk".',
        'sv':
            'Skarp, ättiksliknande syra. I små mängder ger den fruktnoterna ett "sting"; i övermått tyder det på överfermentering. Typiskt för vissa experimentella naturligt beredda partier med hög "funk"-faktor.',
        'tr':
            'Keskin, sirke benzeri asidite. Küçük miktarlarda meyve notalarına "canlılık" katar; aşırı olduğunda aşırı fermantasyonu işaret eder. Bazı yoğun "funk" içeren deneysel doğal kahvelerin özelliğidir.',
        'ja':
            '鋭い酢のような酸味。少量であればフルーツのノートに「パンチ」を加えますが、過剰な場合は過発酵を示します。強い発酵感（ファンク）を持つ一部の実験的ナチュラルロットの特徴です。',
        'ko':
            '날카롭고 식초 같은 산미입니다. 소량일 때는 과일 노트에 "엣지"를 더해주지만, 과도하면 과발효를 나타냅니다. 강한 발효감이 특징인 일부 실험적인 내추럴 커피에서 주로 나타납니다.',
        'zh': '尖锐的、类似醋的酸度。少量时能为水果风味增色；过度时则预示着过度发酵。是某些具有强烈发酵感的实验性日晒咖啡的典型特征。',
        'ar':
            'حموضة حادة تشبه الخل. بكميات صغيرة، تضيف "قوة" لنكهات الفاكهة؛ وعند زيادتها، تشير إلى تخمر زائد. نموذجية لبعض أنواع القهوة الطبيعية التجريبية ذات النكهات القوية.',
      },
      'wheel_note_butyric_acid': {
        'en':
            'Unpleasant, rancid notes reminiscent of soured milk or butter. A major processing defect resulting from poor fermentation control or sanitation.',
        'uk':
            'Неприємні, прогірклі ноти, що нагадують кисле молоко або масло. Серйозний дефект обробки, спричинений поганим контролем ферментації або антисанітарією.',
        'de':
            'Unangenehme, ranzige Noten, die an saure Milch oder Butter erinnern. Ein schwerer Verarbeitungsfehler, der aus mangelhafter Fermentationskontrolle oder unzureichender Hygiene resultiert.',
        'fr':
            'Notes désagréables et rances rappelant le lait ou le beurre tourné. Un défaut de traitement majeur résultant d\'un mauvais contrôle de la fermentation ou d\'un manque d\'hygiène.',
        'es':
            'Notas desagradables y rancias que recuerdan a la leche o mantequilla agria. Un defecto importante de procesamiento resultante de un mal control de la fermentación o falta de higiene.',
        'it':
            'Note sgradevoli e rancide che ricordano il latte o il burro acido. Un grave difetto di lavorazione derivante da uno scarso controllo della fermentazione o da scarsa igiene.',
        'pt':
            'Notas desagradáveis e rançosas que lembram leite ou manteiga azeda. Um grande defeito de processamento resultante de mau controle de fermentação ou falta de higiene.',
        'pl':
            'Nieprzyjemne, jełkie nuty przypominające kwaśne mleko lub masło. Poważny błąd w obróbce wynikający ze złej kontroli fermentacji lub braku higieny.',
        'nl':
            'Onplezierige, ranzige tonen die doen denken aan zure melk of boter. Een groot verwerkingsdefect als gevolg van slechte fermentatiecontrole of gebrekkige hygiëne.',
        'sv':
            'Obehagliga, härskna noter som påminner om sur mjölk eller smör. En allvarlig beredningsdefekt som beror på dålig fermenteringskontroll eller bristande sanitet.',
        'tr':
            'Ekşimiş süt veya tereyağını andıran hoş olmayan, bayat notalar. Kötü fermantasyon kontrolü veya yetersiz sanitasyonun neden olduğu önemli bir işleme kusurudur.',
        'ja': '酸っぱくなった牛乳やバターを思わせる、不快で酸敗したようなノート。発酵管理の不備や衛生上の問題から生じる重大な精製欠陥です。',
        'ko':
            '상한 우유나 버터를 연상시키는 불쾌하고 산패된 노트입니다. 발효 제어 부실이나 위생 문제로 인해 발생하는 주요 가공 결함입니다.',
        'zh': '令人不悦的酸败气息，让人联想到酸奶或酸黄油。由于发酵控制不力或卫生条件差而导致的重大处理缺陷。',
        'ar':
            'نكهات غير سارة وزنخة تذكر بالحليب أو الزبدة الحامضة. عيب معالجة رئيسي ناتج عن سوء التحكم في التخمير أو سوء النظافة.',
      },
      'wheel_note_isovaleric_acid': {
        'en':
            'Strong, sweaty, or cheesy notes. Another processing defect associated with improper fermentation or contamination during drying.',
        'uk':
            'Сильні ноти поту або сиру. Ще один дефект обробки, пов\'язаний із неправильною ферментацією або забрудненням під час сушіння.',
        'de':
            'Starke, schweißige oder käsige Noten. Ein weiterer Verarbeitungsfehler, der mit unsachgemäßer Fermentation oder Kontamination während der Trocknung einhergeht.',
        'fr':
            'Notes fortes de sueur ou de fromage. Un autre défaut de traitement associé à une fermentation inappropriée ou à une contamination pendant le séchage.',
        'es':
            'Notas fuertes a sudor o queso. Otro defecto de procesamiento asociado con una fermentación inadecuada o contaminación durante el secado.',
        'it':
            'Note forti di sudore o formaggio. Un altro difetto di lavorazione associato a una fermentazione impropria o a contaminazione durante l\'essiccamento.',
        'pt':
            'Notas fortes de suor ou queijo. Outro defeito de processamento associado à fermentação inadequada ou contaminação durante a secagem.',
        'pl':
            'Silne nuty potu lub sera. Kolejny błąd w obróbce związany z niewłaściwą fermentacją lub zanieczyszczeniem podczas suszenia.',
        'nl':
            'Sterke, zweterige of kaasachtige tonen. Nog een verwerkingsdefect geassocieerd met onjuiste fermentatie of verontreiniging tijdens het drogen.',
        'sv':
            'Starka noter av svett eller ost. Ännu en beredningsdefekt förknippad med felaktig fermentering eller kontaminering under torkning.',
        'tr':
            'Güçlü, terli veya peynirimsi notalar. Yanlış fermantasyon veya kurutma sırasındaki kontaminasyonla ilişkili başka bir işleme kusurudur.',
        'ja': '強い、汗臭い、あるいはチーズのようなノート。不適切な発酵や乾燥中の汚染に関連する、もう一つの精製欠陥です。',
        'ko': '강한 땀 냄새나 치즈 같은 노트입니다. 부적절한 발효나 건조 중 오염과 관련된 또 다른 가공 결함입니다.',
        'zh': '强烈的汗臭味或奶酪味。另一种由于发酵不当或干燥过程中污染而导致的处理缺陷。',
        'ar':
            'نكهات قوية تشبه العرق أو الجبن. عيب معالجة آخر يرتبط بالتخمير غير السليم أو التلوث أثناء التجفيف.',
      },
      'wheel_note_citric_acid': {
        'en':
            'Clean, sharp, and zesty acidity. The primary acid found in citrus fruits. Provides structure and brightness to high-grown Arabicas.',
        'uk':
            'Чиста, гостра та пікантна кислотність. Основна кислота, що міститься в цитрусових. Забезпечує структуру та яскравість високогірній арабіці.',
        'de':
            'Saubere, scharfe und spritzige Säure. Die primäre Säure in Zitrusfrüchten. Verleiht im Hochland angebauten Arabicas Struktur und Helligkeit.',
        'fr':
            'Acidité propre, tranchante et zestée. L\'acide principal présent dans les agrumes. Apporte structure et brillance aux Arabicas de haute altitude.',
        'es':
            'Acidez limpia, punzante y cítrica. El ácido principal que se encuentra en los cítricos. Aporta estructura y brillo a los Arábicas de gran altura.',
        'it':
            'Acidità pulita, pungente e frizzante. L\'acido principale presente negli agrumi. Fornisce struttura e brillantezza agli Arabica coltivati ad alta quota.',
        'pt':
            'Acidez limpa, aguda e picante. O principal ácido encontrado nas frutas cítricas. Proporciona estrutura e brilho a Arábicas cultivados em altitude.',
        'pl':
            'Czysta, ostra i pikantna kwasowość. Główny kwas występujący w cytrusach. Zapewnia strukturę i jasność wysokogórskim arabikom.',
        'nl':
            'Schone, scherpe en frisse aciditeit. Het primaire zuur in citrusvruchten. Geeft structuur en helderheid aan hooggelegen Arabica\'s.',
        'sv':
            'Ren, skarp och frisk syra. Den främsta syran i citrusfrukter. Ger struktur och klarhet till arabicabönor från hög höjd.',
        'tr':
            'Temiz, keskin ve lezzetli asidite. Narenciye meyvelerinde bulunan birincil asittir. Yüksek rakımlı Arabica\'lara yapı ve parlaklık kazandırır.',
        'ja': 'クリーンで鋭く、刺激的な酸味。柑橘類に含まれる主要な酸です。高地栽培されたアラビカ種に骨格と明るさを与えます。',
        'ko':
            '깨끗하고 날카로우며 상큼한 산미입니다. 시트러스 과일에 들어있는 주요 산입니다. 고지대 아라비카에 구조감과 밝음을 더해줍니다.',
        'zh': '纯净、尖锐且清新的酸度。柑橘类水果中的主要酸。为高海拔阿拉比卡咖啡提供骨架和明亮度。',
        'ar':
            'حموضة نظيفة وحادة ومنعشة. الحمض الأساسي الموجود في الحمضيات. يوفر قواماً وإشراقاً لأنواع الأرابيكا المزروعة على ارتفاعات عالية.',
      },
      'wheel_note_malic_acid': {
        'en':
            'Crisp, refreshing acidity reminiscent of apples or stone fruits. Provides a "round" and pleasant tartness. Common in clean washed processes.',
        'uk':
            'Хрустка, освіжаюча кислотність, що нагадує яблука або кісточкові фрукти. Забезпечує "округлу" та приємну терпкість. Зустрічається у чистій митій обробці.',
        'de':
            'Knackige, erfrischende Säure, die an Äpfel oder Steinobst erinnert. Verleiht eine "runde" und angenehme Herbe. Häufig bei sauberen gewaschenen Aufbereitungen.',
        'fr':
            'Acidité croquante et rafraîchissante rappelant les pommes ou les fruits à noyau. Apporte une acidité "ronde" et agréable. Commun dans les processus de lavage propres.',
        'es':
            'Acidez crujiente y refrescante que recuerda a manzanas o frutas de hueso. Aporta una acidez "redonda" y agradable. Común en procesos de lavado limpios.',
        'it':
            'Acidità croccante e rinfrescante che ricorda le mele o le drupacee. Fornisce un\'acidità "rotonda" e piacevole. Comune nei processi di lavaggio accurati.',
        'pt':
            'Acidez crocante e refrescante que lembra maçãs ou frutas de caroço. Proporciona uma acidez "redonda" e agradável. Comum em processos de lavagem limpos.',
        'pl':
            'Chrupiąca, odświeżająca kwasowość przypominająca jabłka lub owoce pestkowe. Zapewnia "okrągłą" i przyjemną cierpkość. Powszechna w czystych procesach mytych.',
        'nl':
            'Frisse, verfrissende aciditeit die doet denken aan appels of steenvruchten. Zorgt voor een "ronde" en aangename wrangheid. Veelvoorkomend in schone gewassen processen.',
        'sv':
            'Krispig, uppfriskande syra som påminner om äpplen eller stenfrukter. Ger en "rund" och behaglig syrlighet. Vanligt i rena tvättade processer.',
        'tr':
            'Elma veya çekirdekli meyveleri andıran gevrek, ferahlatıcı asidite. "Yuvarlak" ve hoş bir mayhoşluk sağlar. Temiz yıkama işlemlerinde yaygındır.',
        'ja':
            'リンゴや核果系を思わせる、サクサクとして爽やかな酸味。「丸み」のある心地よい甘酸っぱさを与えます。クリーンなウォッシュドプロセスによく見られます。',
        'ko':
            '사과나 핵과류를 연상시키는 아삭하고 청량한 산미입니다. "둥글고" 기분 좋은 새콤함을 제공합니다. 깨끗한 워시드 가공에서 흔히 볼 수 있습니다.',
        'zh': '清脆爽口的酸度，让人联想到苹果或核果。提供一种“圆润”且愉悦的酸甜感。常见于干净的水洗处理中。',
        'ar':
            'حموضة مقرمشة ومنعشة تذكر بالتفاح أو الفواكه ذات النواة. توفر حموضة "مستديرة" وممتعة. شائعة في عمليات الغسل النظيفة.',
      },
      'wheel_note_winey': {
        'en':
            'Complex, alcoholic sweetness with high acidity. Reminiscent of red wine. Typical of natural processing and prolonged fermentation.',
        'uk':
            'Складна, алкогольна солодкість з високою кислотністю. Нагадує червоне вино. Типово для натуральної обробки та тривалої ферментації.',
        'de':
            'Komplexe, alkoholische Süße mit hoher Säure. Erinnert an Rotwein. Typisch für natürliche Aufbereitung und längere Fermentation.',
        'fr':
            'Sucrosité complexe et alcoolisée avec une forte acidité. Rappelle le vin rouge. Typique du traitement naturel et de la fermentation prolongée.',
        'es':
            'Dulzor complejo y alcohólico con alta acidez. Recuerda al vino tinto. Típico del procesamiento natural y la fermentación prolongada.',
        'it':
            'Dolcezza complessa e alcolica con alta acidità. Ricorda il vino rosso. Tipico del processo naturale e della fermentazione prolungata.',
        'pt':
            'Doçura complexa e alcoólica com alta acidez. Lembra vinho tinto. Típico de processamento natural e fermentação prolongada.',
        'pl':
            'Złożona, alkoholowa słodycz o wysokiej kwasowości. Przypomina czerwone wino. Typowe dla obróbki naturalnej i przedłużonej fermentacji.',
        'nl':
            'Complex, alcoholische zoetheid met een hoge aciditeit. Doet denken aan rode wijn. Typisch voor natuurlijke verwerking en langdurige fermentatie.',
        'sv':
            'Komplex, alkoholisk sötma med hög syra. Påminner om rött vin. Typiskt för naturlig beredning och förlängd fermentering.',
        'tr':
            'Yüksek asiditeli karmaşık, alkollü tatlılık. Kırmızı şarabı andırır. Doğal işlemenin ve uzun süreli fermantasyonun özelliğidir.',
        'ja': '高い酸味を伴う、複雑でアルコールのような甘み。赤ワインを思わせます。ナチュラルプロセスや長期発酵の典型的な特徴です。',
        'ko':
            '높은 산미를 동반한 복합적이고 알코올 느낌의 단맛입니다. 레드 와인을 연상시킵니다. 내추럴 가공과 장기 발효의 전형적인 특징입니다.',
        'zh': '复杂的、带有酒精感的甜味，酸度较高。让人联想到红葡萄酒。是日晒处理和延长发酵时间的典型特征。',
        'ar':
            'حلاوة معقدة وكحولية مع حموضة عالية. تذكر بالنبيذ الأحمر. مميزة للمعالجة الطبيعية والتخمير المطول.',
      },
      'wheel_note_whiskey': {
        'en':
            'Intense, boozy, and oaky notes. Results from specific anaerobic or spirit-barrel aging processes. A modern experimental specialty trait.',
        'uk':
            'Інтенсивні, алкогольні та дубові ноти. Результат специфічних анаеробних процесів або витримки в бочках з-під спиртних напоїв. Сучасна експериментальна ознака спешелті.',
        'de':
            'Intensive, alkoholische und eichenartige Noten. Resultat spezifischer anaerober Prozesse oder der Reifung in Spirituosenfässern. Ein modernes experimentelles Specialty-Merkmal.',
        'fr':
            'Notes intenses, alcoolisées et boisées. Résulte de processus anaérobies spécifiques ou d\'un vieillissement en fûts de spiritueux. Un trait de spécialité expérimental moderne.',
        'es':
            'Notas intensas, alcohólicas y amaderadas. Resultado de procesos anaeróbicos específicos o envejecimiento en barricas de licores. Un rasgo de especialidad experimental moderno.',
        'it':
            'Note intense, alcoliche e legnose. Risultato di specifici processi anaerobici o invecchiamento in botti di liquore. Un tratto moderno di specialità sperimentale.',
        'pt':
            'Notas intensas, alcoólicas e amadeiradas. Resulta de processos anaeróbicos específicos ou envelhecimento em barris de destilados. Um traço moderno de especialidade experimental.',
        'pl':
            'Intensywne, alkoholowe i dębowe nuty. Wynik specyficznych procesów anaerobowych lub starzenia w beczkach po alkoholu. Nowoczesna eksperymentalna cecha specialty.',
        'nl':
            'Intense, alcoholische en eikenhouten tonen. Het resultaat van specifieke anaerobe processen of rijping in vaten voor sterke drank. Een modern experimenteel specialty-kenmerk.',
        'sv':
            'Intensiva, alkoholhaltiga och ekiga noter. Resultatet av specifika anaerobiska processer eller lagring på spritfat. Ett modernt experimentellt specialty-drag.',
        'tr':
            'Yoğun, içkili ve meşemsi notalar. Belirli anaerobik işlemlerin veya içki fıçılarında bekletme süreçlerinin sonucudur. Modern bir deneysel nitelikli kahve özelliğidir.',
        'ja':
            '強烈でアルコール感のある、オーク（樫）のようなノート。特定のアナエロビック（好気性）精製や、酒樽での熟成から生まれます。現代的な実験的スペシャリティの特性です。',
        'ko':
            '강렬하고 술 기운이 느껴지며 오크 향이 나는 노트입니다. 특정 무산소 발효나 주류 오크통 숙성 과정의 결과입니다. 현대적인 실험적 스페셜티의 특징입니다.',
        'zh': '强烈的、带有酒味和橡木气息的风味。是特定的厌氧处理或酒桶陈化工艺的结果。一种现代实验性的精品咖啡特征。',
        'ar':
            'نكهات مكثفة وكحولية وخشبية. ناتجة عن عمليات تخمر لاهوائية محددة أو التعتيق في براميل المشروبات الروحية. سمة تجريبية حديثة للقهوة المختصة.',
      },
      'wheel_note_over_ripe': {
        'en':
            'Heavy, cloying sweetness with ferment notes. Results from delayed harvesting or slow drying. Can be desirable in some contexts but often borders on defect.',
        'uk':
            'Важка, нудотна солодкість з нотами ферментації. Результат запізнілого збору врожаю або повільного сушіння. Може бути бажаною в деяких контекстах, але часто межує з дефектом.',
        'de':
            'Schwere, klebrige Süße mit Fermentationsnoten. Resultiert aus verzögerter Ernte oder langsamer Trocknung. Kann in einigen Kontexten wünschenswert sein, grenzt aber oft an einen Defekt.',
        'fr':
            'Sucrosité lourde et écœurante avec des notes de fermentation. Résulte d\'une récolte retardée ou d\'un séchage lent. Peut être souhaitable dans certains contextes mais frise souvent le défaut.',
        'es':
            'Dulzor pesado y empalagoso con notas de fermentación. Resultado de una cosecha tardía o secado lento. Puede ser deseable en algunos contextos, pero a menudo roza el defecto.',
        'it':
            'Dolcezza pesante e stucchevole con note di fermentazione. Deriva da una raccolta tardiva o da un essiccamento lento. Può essere desiderabile in alcuni contesti, ma spesso rasenta il difetto.',
        'pt':
            'Doçura pesada e enjoativa com notas de fermentação. Resulta de colheita tardia ou secagem lenta. Pode ser desejável em alguns contextos, mas frequentemente beira o defeito.',
        'pl':
            'Ciężka, mdląca słodycz z nutami fermentacji. Wynik opóźnionego zbioru lub powolnego suszenia. Może być pożądana w niektórych kontekstach, ale często graniczy z defektem.',
        'nl':
            'Zware, mierzoete zoetheid met fermentatietonen. Het resultaat van uitgestelde oogst of langzame droging. Kan in sommige contexten wenselijk zijn, maar grenst vaak aan een defect.',
        'sv':
            'Tung, sliskig sötma med fermenteringsnoter. Resultatet av försenad skörd eller långsam torkning. Kan vara önskvärt i vissa sammanhang men gränsar ofta till defekt.',
        'tr':
            'Fermantasyon notalarına sahip ağır, bayıcı tatlılık. Gecikmiş hasat veya yavaş kurutmadan kaynaklanır. Bazı bağlamlarda arzu edilebilir olsa da genellikle kusur sınırındadır.',
        'ja':
            '発酵のニュアンスを伴う、重くしつこい甘み。収穫の遅れや乾燥の遅れによって生まれます。文脈によっては好まれることもありますが、多くの場合、欠点（欠点豆）の境界にあります。',
        'ko':
            '발효 노트와 함께 무겁고 들큰한 단맛입니다. 수확 지연이나 느린 건조로 인해 발생합니다. 일부 상황에서는 바람직할 수 있지만 종종 결함에 가깝습니다.',
        'zh': '厚重的、过于甜腻且带有发酵感的甜味。由于延迟采摘或缓慢干燥造成的。在某些情况下可能是理想的，但通常接近缺陷。',
        'ar':
            'حلاوة ثقيلة ومنفرة مع نكهات تخمر. ناتجة عن تأخير الحصاد أو التجفيف البطيء. يمكن أن تكون مرغوبة في بعض السياقات ولكنها غالباً ما تقترب من كونها عيباً.',
      },
      'wheel_note_rubber': {
        'en':
            'Strong, synthetic odor of heated rubber. A severe defect usually caused by high moisture storage or specific contamination. Common in low-grade Robustas.',
        'uk':
            'Сильний синтетичний запах нагрітої гуми. Серйозний дефект, зазвичай спричинений зберіганням при високій вологості або специфічним забрудненням. Зустрічається у низькосортній робусті.',
        'de':
            'Starker, synthetischer Geruch von erhitztem Gummi. Ein schwerer Defekt, der meist durch Lagerung bei hoher Feuchtigkeit oder spezifische Kontamination verursacht wird. Häufig bei minderwertigen Robustas.',
        'fr':
            'Forte odeur synthétique de caoutchouc chauffé. Un défaut grave généralement causé par un stockage à forte humidité ou une contamination spécifique. Commun dans les Robustas de basse qualité.',
        'es':
            'Fuerte olor sintético a caucho calentado. Un defecto grave generalmente causado por el almacenamiento con alta humedad o contaminación específica. Común en Robustas de baja calidad.',
        'it':
            'Forte odore sintetico di gomma riscaldata. Un grave difetto solitamente causato dallo stoccaggio in condizioni di alta umidità o da contaminazioni specifiche. Comune nelle Robusta di bassa qualità.',
        'pt':
            'Forte odor sintético de borracha aquecida. Um defeito grave geralmente causado por armazenamento com alta umidade ou contaminação específica. Comum em Robustas de baixa qualidade.',
        'pl':
            'Silny, syntetyczny zapach podgrzanej gumy. Poważny defekt zazwyczaj spowodowany przechowywaniem w warunkach wysokiej wilgotności lub specyficznym zanieczyszczeniem. Powszechny w niskiej jakości robustach.',
        'nl':
            'Sterke, synthetische geur van verhit rubber. Een ernstig defect dat meestal wordt veroorzaakt door opslag bij een hoge luchtvochtigheid of specifieke verontreiniging. Veelvoorkomend in Robustas van lage kwaliteit.',
        'sv':
            'Stark, syntetisk doft av uppvärmt gummi. En allvarlig defekt som vanligtvis orsakas av lagring vid hög fuktighet eller specifik kontaminering. Vanligt i robustabönor av lägre kvalitet.',
        'tr':
            'Isınmış kauçuğun güçlü, sentetik kokusu. Genellikle yüksek nemli depolama veya belirli kontaminasyonlardan kaynaklanan ciddi bir kusurdur. Düşük kaliteli Robusta\'larda yaygındır.',
        'ja':
            '加熱されたゴムのような、強い合成的な臭い。通常、高湿度での保管や特定の汚染によって引き起こされる重大な欠点です。低級なロブスタ種によく見られます。',
        'ko':
            '가열된 고무의 강한 합성 냄새입니다. 일반적으로 높은 습도에서의 보관이나 특정 오염으로 인해 발생하는 심각한 결함입니다. 저급 로부스타에서 흔히 볼 수 있습니다.',
        'zh': '强烈的、加热橡胶般的合成气味。一种严重的缺陷，通常由于高湿度储存或特定的污染造成。常见于低等级的罗布斯塔咖啡中。',
        'ar':
            'رائحة اصطناعية قوية للمطاط المسخن. عيب شديد ينتج عادة عن التخزين في رطوبة عالية أو تلوث معين. شائع في محاصيل الروبوستا منخفضة الجودة.',
      },
      'wheel_note_petroleum': {
        'en':
            'Industrial or oily odor reminiscent of fuel. A major contamination defect, often occurring during transport or due to improper drying infrastructure.',
        'uk':
            'Індустріальний або олійний запах, що нагадує паливо. Серйозний дефект забруднення, що часто виникає під час транспортування або через неправильну інфраструктуру сушіння.',
        'de':
            'Industrieller oder öliger Geruch, der an Kraftstoff erinnert. Ein schwerer Kontaminationsdefekt, der oft während des Transports oder durch mangelhafte Trocknungsinfrastruktur auftritt.',
        'fr':
            'Odeur industrielle ou huileuse rappelant le carburant. Un défaut de contamination majeur, survenant souvent pendant le transport ou en raison d\'une infrastructure de séchage inappropriée.',
        'es':
            'Olor industrial u oleoso que recuerda al combustible. Un defecto de contaminación importante, que a menudo ocurre durante el transporte o debido a una infraestructura de secado inadecuada.',
        'it':
            'Odore industriale o oleoso che ricorda il carburante. Un grave difetto di contaminazione, che si verifica spesso durante il trasporto o a causa di infrastrutture di essiccamento improprie.',
        'pt':
            'Odor industrial ou oleoso que lembra combustível. Um grande defeito de contaminação, ocorrendo frequentemente durante o transporte ou devido a infraestrutura de secagem inadequada.',
        'pl':
            'Przemysłowy lub oleisty zapach przypominający paliwo. Poważny defekt zanieczyszczenia, często występujący podczas transportu lub z powodu niewłaściwej infrastruktury suszenia.',
        'nl':
            'Industriële of olieachtige geur die doet denken aan brandstof. Een groot verontreinigingsdefect, dat vaak optreedt tijdens transport of door onjuiste drooginfrastructuur.',
        'sv':
            'Industriell eller oljig doft som påminner om bränsle. En allvarlig kontamineringsdefekt som ofta uppstår under transport eller på grund av felaktig torkningsinfrastruktur.',
        'tr':
            'Yakıtı andıran endüstriyel veya yağlı koku. Genellikle nakliye sırasında veya yetersiz kurutma altyapısı nedeniyle oluşan önemli bir kontaminasyon kusurudur.',
        'ja': '燃料を思わせる、工業的または油っぽい臭い。輸送中や不適切な乾燥設備によって引き起こされることが多い、重大な汚染欠点です。',
        'ko':
            '연료를 연상시키는 산업적 또는 기름진 냄새입니다. 운송 중이나 부적절한 건조 시설로 인해 종종 발생하는 주요 오염 결함입니다.',
        'zh': '让人联想到燃料的工业或油脂味。一种重大的污染缺陷，通常发生在运输过程中或由于不当的干燥设施造成。',
        'ar':
            'رائحة صناعية أو زيتية تذكر بالوقود. عيب تلوث رئيسي، يحدث غالباً أثناء النقل أو بسبب بنية تحتية غير سليمة للتجفيف.',
      },
      'wheel_note_medicinal': {
        'en':
            'Chemical or antiseptic note. Usually the result of phenol contamination or mold. A definitive defect in specialty coffee scoring.',
        'uk':
            'Хімічна або антисептична нота. Зазвичай результат забруднення фенолом або пліснявою. Однозначний дефект при оцінюванні спешелті-кави.',
        'de':
            'Chemische oder antiseptische Note. Meist das Ergebnis von Phenolkontamination oder Schimmel. Ein eindeutiger Defekt bei der Bewertung von Specialty Coffee.',
        'fr':
            'Note chimique ou antiseptique. Généralement le résultat d\'une contamination par le phénol ou de moisissures. Un défaut définitif dans la notation du café de spécialité.',
        'es':
            'Nota química o antiséptica. Suele ser el resultado de la contaminación por fenol o moho. Un defecto definitivo en la puntuación del café de especialidad.',
        'it':
            'Nota chimica o antisettica. Solitamente il risultato di contaminazione da fenolo o muffa. Un difetto definitivo nel punteggio del caffè specialty.',
        'pt':
            'Nota química ou antisséptica. Geralmente o resultado de contaminação por fenol ou mofo. Um defeito definitivo na pontuação do café de especialidade.',
        'pl':
            'Chemiczna lub antyseptyczna nuta. Zazwyczaj wynik zanieczyszczenia fenolem lub pleśnią. Zdecydowany defekt w ocenie kawy specialty.',
        'nl':
            'Chemische of antiseptische noot. Meestal het resultaat van fenolverontreiniging of schimmel. Een definitief defect in de beoordeling van specialty koffie.',
        'sv':
            'Kemisk eller antiseptisk not. Vanligtvis resultatet av fenolkontaminering eller mögel. En definitiv defekt vid poängsättning av specialty-kaffe.',
        'tr':
            'Kimyasal veya antiseptik nota. Genellikle fenol kontaminasyonu veya küfün sonucudur. Nitelikli kahve puanlamasında kesin bir kusurdur.',
        'ja':
            '化学的または防腐剤のようなノート。通常、フェノール汚染やカビの結果です。スペシャルティコーヒーの採点においては決定的な欠点となります。',
        'ko':
            '화학적이거나 소독약 같은 노트입니다. 일반적으로 페놀 오염이나 곰팡이의 결과입니다. 스페셜티 커피 채점에서 결정적인 결함입니다.',
        'zh': '化学味或防腐剂味。通常是由于苯酚污染或发霉造成的。在精品咖啡评分中属于确定性的缺陷。',
        'ar':
            'نكهة كيميائية أو مطهرة. عادة ما تكون نتيجة تلوث بالفينول أو العفن. عيب قطعي في تقييم القهوة المختصة.',
      },
      'wheel_note_stale': {
        'en':
            'Flat, dull flavor lacking vibrant acidity. Indicates long-term storage or oxidation of roasted beans. A hallmark of past-crop or old roasted coffee.',
        'uk':
            'Плоский, тьмяний смак без яскравої кислотності. Вказує на тривале зберігання або окислення обсмажених зерен. Ознака кави минулого врожаю або старого обсмажування.',
        'de':
            'Flacher, matter Geschmack ohne lebendige Säure. Deutet auf langfristige Lagerung oder Oxidation gerösteter Bohnen hin. Ein Kennzeichen für Kaffees aus der vorangegangenen Ernte oder altgerösteten Kaffee.',
        'fr':
            'Saveur plate et terne manquant d\'acidité vibrante. Indique un stockage à long terme ou une oxydation des grains torréfiés. Une marque de fabrique des récoltes passées ou du vieux café torréfié.',
        'es':
            'Sabor plano y apagado que carece de acidez vibrante. Indica almacenamiento prolongado u oxidación de los granos tostados. Un sello distintivo de cosechas pasadas o café tostado viejo.',
        'it':
            'Sapore piatto e scialbo privo di acidità vibrante. Indica una conservazione a lungo termine o l\'ossidazione dei chicchi tostati. Un segno distintivo di raccolti passati o caffè tostato vecchio.',
        'pt':
            'Sabor plano e sem brilho, com falta de acidez vibrante. Indica armazenamento a longo prazo ou oxidação de grãos torrados. Uma marca característica de safras passadas ou café torrado velho.',
        'pl':
            'Płaski, mdły smak bez żywej kwasowości. Wskazuje na długotrwałe przechowywanie lub utlenienie palonych ziaren. Cecha charakterystyczna starych zbiorów lub dawno palonej kawy.',
        'nl':
            'Vlakke, doffe smaak zonder levendige aciditeit. Duidt op langdurige opslag of oxidatie van gebrande bonen. Een kenmerk van koffie van de vorige oogst of oud gebrande koffie.',
        'sv':
            'Platt, tråkig smak som saknar livlig syra. Tyder på långvarig lagring eller oxidering av rostade bönor. Ett kännetecken för kaffe från tidigare skördar eller gammalt rostat kaffe.',
        'tr':
            'Canlı asiditeden yoksun düz, sönük tat. Kavrulmuş çekirdeklerin uzun süreli depolanmasını veya oksidasyonunu işaret eder. Eski mahsul veya bayat kavrulmuş kahvenin ayırt edici özelliğidir.',
        'ja':
            '鮮やかな酸味を欠いた、平坦で退屈なフレーバー。焙煎豆の長期保管や酸化を示します。オールドクロップや、焙煎から時間が経過しすぎたコーヒーの特徴です。',
        'ko':
            '활기찬 산미가 없는 밋밋하고 둔한 맛입니다. 원두의 장기 보관 또는 산화를 나타냅니다. 지난 수확기 원두나 오래된 로스팅 원두의 전형적인 특징입니다.',
        'zh': '平淡、乏味且缺乏活力的酸度。预示着烘焙豆的长期储存或氧化。是旧产季咖啡或陈旧烘焙咖啡的标志。',
        'ar':
            'نكهة مسطحة وباهتة تفتقر للحموضة الحيوية. تشير إلى التخزين لفترات طويلة أو أكسدة الحبوب المحمصة. علامة مميزة للمحاصيل القديمة أو القهوة المحمصة منذ فترة طويلة.',
      },
      'wheel_note_musty': {
        'en':
            'Damp, cellar-like odor. Usually results from high humidity during drying or storage, leading to mold development. A significant defect.',
        'uk':
            'Запах вогкості, схожий на підвальний. Зазвичай результат високої вологості під час сушіння або зберігання, що призводить до розвитку плісняви. Значний дефект.',
        'de':
            'Muffiger, kellerartiger Geruch. Resultiert meist aus hoher Luftfeuchtigkeit während der Trocknung oder Lagerung, was zu Schimmelbildung führt. Ein erheblicher Defekt.',
        'fr':
            'Odeur d\'humidité, comme celle d\'une cave. Résulte généralement d\'une humidité élevée pendant le séchage ou le stockage, entraînant le développement de moisissures. Un défaut important.',
        'es':
            'Olor a humedad, tipo sótano. Suele ser el resultado de una alta humedad durante el secado o el almacenamiento, lo que provoca el desarrollo de moho. Un defecto significativo.',
        'it':
            'Odore di umido, tipo cantina. Solitamente deriva da un\'elevata umidità durante l\'essiccamento o lo stoccaggio, che porta allo sviluppo di muffe. Un difetto significativo.',
        'pt':
            'Odor de umidade, tipo porão. Geralmente resulta de alta umidade durante a secagem ou armazenamento, levando ao desenvolvimento de mofo. Um defeito significativo.',
        'pl':
            'Zapach wilgoci, przypominający piwnicę. Zazwyczaj wynik wysokiej wilgotności podczas suszenia lub przechowywania, prowadzącej do rozwoju pleśni. Znaczny defekt.',
        'nl':
            'Muffe, kelderachtige geur. Meestal het resultaat van een hoge luchtvochtigheid tijdens het drogen of opslaan, wat leidt tot schimmelontwikkeling. Een aanzienlijk defect.',
        'sv':
            'Munken, källarliknande doft. Beror vanligtvis på hög luftfuktighet under torkning eller lagring, vilket leder till mögelutveckling. En betydande defekt.',
        'tr':
            'Nemli, mahzen benzeri koku. Genellikle kurutma veya depolama sırasındaki yüksek nemden kaynaklanır ve küf gelişimine yol açar. Önemli bir kusurdur.',
        'ja': '湿った、地下室のような臭い。通常、乾燥中や保管中の高湿度によってカビが発生した結果です。重大な欠点です。',
        'ko':
            '축축하고 지하실 같은 냄새입니다. 일반적으로 건조나 보관 중 높은 습도로 인해 곰팡이가 번식한 결과입니다. 중대한 결함입니다.',
        'zh': '潮湿、类似地窖的气味。通常由于干燥或储存过程中湿度过高导致发霉所致。一种重大的缺陷。',
        'ar':
            'رائحة رطوبة تشبه القبو. تنتج عادة عن الرطوبة العالية أثناء التجفيف أو التخزين، مما يؤدي إلى نمو العفن. عيب كبير.',
      },
      'wheel_note_dusty': {
        'en':
            'Dry, powdery sensation reminiscent of old warehouses. Often associated with improper storage or lack of climate control in origin facilities.',
        'uk':
            'Сухе, порошкоподібне відчуття, що нагадує старі склади. Часто асоціюється з неналежним зберіганням або відсутністю клімат-контролю на підприємствах походження.',
        'de':
            'Trockenes, pudriges Gefühl, das an alte Lagerhäuser erinnert. Oft verbunden mit unsachgemäßer Lagerung oder fehlender Klimatisierung in den Ursprungseinrichtungen.',
        'fr':
            'Sensation sèche et poudreuse rappelant les vieux entrepôts. Souvent associé à un stockage inapproprié ou à un manque de contrôle climatique dans les installations d\'origine.',
        'es':
            'Sensación seca y polvorienta que recuerda a los viejos almacenes. A menudo se asocia con un almacenamiento inadecuado o falta de control climático en las instalaciones de origen.',
        'it':
            'Sensazione secca e polverosa che ricorda i vecchi magazzini. Spesso associata a uno stoccaggio improprio o alla mancanza di controllo climatico nelle strutture d\'origine.',
        'pt':
            'Sensação seca e em pó que lembra armazéns antigos. Frequentemente associada a armazenamento inadequado ou falta de controle climático nas instalações de origem.',
        'pl':
            'Suche, pudrowe odczucie przypominające stare magazyny. Często kojarzone z niewłaściwym przechowywaniem lub brakiem kontroli klimatu w zakładach w kraju pochodzenia.',
        'nl':
            'Droge, poederachtige sensatie die doet denken aan oude magazijnen. Vaak geassocieerd met onjuiste opslag of gebrek aan klimaatbeheersing in de faciliteiten van herkomst.',
        'sv':
            'Torr, pudrig känsla som påminner om gamla lagerlokaler. Ofta förknippad med felaktig lagring eller brist på klimatkontroll i ursprungsanläggningarna.',
        'tr':
            'Eski depoları andıran kuru, tozlu bir his. Genellikle yetersiz depolama veya orijin tesislerindeki iklim kontrolü eksikliği ile ilişkilendirilir.',
        'ja': '古い倉庫を思わせる、ドライで粉っぽい感覚。不適切な保管や、産地の施設における温度・湿度管理の欠如に関連していることが多いです。',
        'ko':
            '오래된 창고를 연상시키는 건조하고 가루 같은 느낌입니다. 종종 부적절한 보관이나 산지 시설의 기후 조절 부족과 관련이 있습니다.',
        'zh': '干燥、带有粉尘感的气息，让人联想到旧仓库。通常与储存不当或产地设施缺乏环境控制有关。',
        'ar':
            'إحساس جاف ومغبّر يذكر بالمستودعات القديمة. يرتبط غالباً بالتخزين غير السليم أو نقص التحكم في المناخ في مرافق المنشأ.',
      },
    };

    return descriptions[key]?[locale] ??
        descriptions[key]?['en'] ??
        (locale == 'uk'
            ? 'Опис скоро з\'явиться...'
            : 'Description coming soon...');
  }
}
