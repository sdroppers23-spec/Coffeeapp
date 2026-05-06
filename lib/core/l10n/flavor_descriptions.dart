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
        'zh':
            '独特而清晰的花香。通常这些是在非常新鲜的咖啡或浅烘焙咖啡中发现的主要香气。是高品质埃塞俄比亚和巴拿马批次的特征。',
        'ar':
            'روائح زهرية متميزة وواضحة. وعادة ما تكون هذه هي الروائح الأساسية الموجودة في القهوة الطازجة جداً أو القهوة المحمصة بشكل خفيف. مميزة للمحاصيل الإثيوبية والبنمانية عالية الجودة.',
      },
      'wheel_cat_fruity': {
        'en':
            'A wide range of sweet and tart notes from berries to stone fruits. These are typically associated with organic acids like citric and malic, often enhanced by natural or anaerobic processing. Common in African and Central American coffees.',
        'uk':
            'Широкий спектр солодких та кислих нот від ягід до кісточкових фруктів. Зазвичай вони пов\'язані з органічними кислотами, такими як лимонна та яблучна, часто посилюються натуральною або анаеробною обробкою. Типово для африканської та центральноамериканської кави.',
        'de': 'Fruchtige Noten von Beeren, Steinobst oder Zitrusfrüchten.',
        'fr': 'Notes fruitées de baies, de fruits à noyau ou d\'agrumes.',
        'es': 'Notas frutales de bayas, frutas de hueso o cítricos.',
        'it': 'Note fruttate di bacche, drupacee o agrumi.',
        'pt': 'Notas frutadas de bagas, frutas de caroço ou citrinos.',
        'pl': 'Owocowe nuty jagód, owoców pestkowych lub cytrusów.',
        'nl': 'Fruitige tonen van bessen, steenvruchten of citrusvruchten.',
        'sv': 'Fruktiga toner av bär, stenfrukter eller citrusfrukter.',
        'tr': 'Meyvemsi böğürtlen, çekirdekli meyve veya narenciye notaları.',
        'ja': 'ベリー、核果、柑橘類などのフルーティーなノート。',
        'ko': '베리, 핵과류, 시트러스 등의 과일 노트입니다.',
        'zh': '浆果、核果或柑橘类水果的果香。',
        'ar': 'نكهات فاكهية من التوت أو الفواكه ذات النواة أو الحمضيات.',
      },
      'wheel_cat_sour_fermented': {
        'en':
            'Complex notes that can range from pleasant tangy acids to intense fermented funk. These flavors result from metabolic processes during coffee processing (like prolonged fermentation). Often found in experimental processing lots from Colombia and Costa Rica.',
        'uk':
            'Комплексні ноти, що можуть варіюватися від приємних гострих кислот до інтенсивного ферментованого "фанку". Ці смаки є результатом метаболічних процесів під час обробки кави (наприклад, тривала ферментація). Часто зустрічається в лотах з експериментальною обробкою з Колумбії та Коста-Ріки.',
        'de': 'Säuerliche oder fermentierte Aromen.',
        'fr': 'Arômes acides ou fermentés.',
        'es': 'Aromas ácidos o fermentados.',
        'it': 'Aromi acidi o fermentati.',
        'pt': 'Aromas ácidos ou fermentados.',
        'pl': 'Kwaśne lub sfermentowane aromaty.',
        'nl': 'Zure of gefermenteerde aroma\'s.',
        'sv': 'Syrliga eller fermenterade aromer.',
        'tr': 'Ekşi veya fermente aromalar.',
        'ja': '酸味のある、または発酵したアロマ。',
        'ko': '산미가 있거나 발효된 향입니다.',
        'zh': '酸味或发酵后的风味。',
        'ar': 'نكهات حامضة أو متخمرة.',
      },
      'wheel_cat_green_veg': {
        'en':
            'Herbal or vegetal notes that evoke fresh-cut grass or raw vegetables. These can indicate a lighter roast profile or specific varieties that retain "green" characteristics. Common in some Indonesian or under-roasted high-density beans.',
        'uk':
            'Трав\'янисті або овочеві ноти, що нагадують свіжоскошену траву або сирі овочі. Вони можуть вказувати на світлий профіль обсмаження або специфічні сорти, що зберігають "зелені" характеристики. Зустрічається в деяких індонезійських лотах або при світлому обсмаженні щільних зерен.',
        'de': 'Frische, pflanzliche oder grasige Noten.',
        'fr': 'Notes fraîches, végétales ou herbacées.',
        'es': 'Notas frescas, vegetales o herbáceas.',
        'it': 'Note fresche, vegetali o erbacee.',
        'pt': 'Notas frescas, vegetais ou herbáceas.',
        'pl': 'Świeże, roślinne lub trawiaste nuty.',
        'nl': 'Verse, plantaardige of grazige tonen.',
        'sv': 'Fräscha, vegetabiliska eller gräsiga toner.',
        'tr': 'Taze, bitkisel veya otsu notalar.',
        'ja': '新鮮な、植物的または草のようなノート。',
        'ko': '신선하고 식물적이거나 풀 같은 노트입니다.',
        'zh': '新鲜、植物或草本的气息。',
        'ar': 'نكهات طازجة أو نباتية أو عشبية.',
      },
      'wheel_cat_roasted': {
        'en':
            'Savory and deep notes resulting from the Maillard reaction and caramelization during roasting. These range from toasted bread to smoky accents. Typically associated with medium to dark roast profiles from Brazil or India.',
        'uk':
            'Пікантні та глибокі ноти, що виникають внаслідок реакції Майяра та карамелізації під час обсмажування. Вони варіюються від підсмаженого хліба до димних акцентів. Зазвичай асоціюються з профілями середнього та темного обсмаження з Бразилії чи Індії.',
        'de': 'Röstaromen von Getreide bis Tabak.',
        'fr': 'Arômes de torréfaction, des céréales au tabac.',
        'es': 'Aromas de tueste, desde cereales hasta tabaco.',
        'it': 'Aromi di tostatura, dai cereali al tabacco.',
        'pt': 'Aromas de torra, de cereais a tabaco.',
        'pl': 'Aromaty palenia, od zbóż po tytoń.',
        'nl': 'Brandaroma\'s van granen tot tabak.',
        'sv': 'Rostade aromer från spannmål till tobak.',
        'tr': 'Tahıldan tütüne kadar kavrulmuş aromalar.',
        'ja': '穀物からタバコまでのロースト香。',
        'ko': '곡물에서 담배에 이르는 로스트 향입니다.',
        'zh': '从谷物到烟草的烘焙香气.',
        'ar': 'نكهات محمصة من الحبوب إلى التبغ.',
      },
      'wheel_cat_spices': {
        'en':
            'Warm, pungent, or sweet spice notes like pepper, clove, or cinnamon. These often emerge during the middle stages of roasting. Frequently found in Sumatran coffees or spicy varieties from Rwanda.',
        'uk':
            'Теплі, гострі або солодкі пряні ноти, такі як перець, гвоздика або кориця. Вони часто проявляються на середніх етапах обсмажування. Часто зустрічаються в суматранській каві або пряних сортах з Руанди.',
        'de': 'Würzige Noten wie Pfeffer oder Zimt.',
        'fr': 'Notes épicées comme le poivre ou la cannelle.',
        'es': 'Notas especiadas como pimienta o canela.',
        'it': 'Note speziate come pepe o cannella.',
        'pt': 'Notas de especiarias como pimenta ou canela.',
        'pl': 'Przyprawowe nuty, takie jak pieprz lub cynamon.',
        'nl': 'Kruidige tonen zoals peper of kaneel.',
        'sv': 'Kryddiga toner som peppar eller kanel.',
        'tr': 'Biber veya tarçın gibi baharatlı notalar.',
        'ja': '胡椒やシナモンのようなスパイスのノート。',
        'ko': '후추나 시나몬 같은 스파이스 노트입니다.',
        'zh': '胡椒或肉桂般的辛香。',
        'ar': 'نكهات توابل مثل الفلفل أو القرفة.',
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
        'zh':
            '咖啡的基础甜感，范围从白糖到复杂的糖蜜。源于烘焙过程中碳水化合物的分解。几乎存在于所有平衡的精品咖啡中。',
        'ar':
            'الحلاوة الأساسية في القهوة، من السكر الأبيض إلى دبس السكر المعقد. تأتي من تكسر الكربوهيدرات أثناء التحميص. موجودة في جميع أنواع القهوة المختصة المتوازنة تقريباً.',
      },
      'wheel_cat_others': {
        'en':
            "A category for unique or unconventional notes that don't fit elsewhere, often reflecting rare chemical artifacts of processing or storage.",
        'uk':
            'Категорія для унікальних або нетрадиційних нот, які не вписуються в інші розділи, часто відображаючи рідкісні хімічні особливості обробки або зберігання.',
        'de': 'Andere Noten, oft chemisch oder papierartig.',
        'fr': 'Autres notes, souvent chimiques ou de papier.',
        'es': 'Otras notas, a menudo químicas o de papel.',
        'it': 'Altre note, spesso chimiche o cartacee.',
        'pt': 'Outras notas, frequentemente químicas ou de papel.',
        'pl': 'Inne nuty, często chemiczne lub papierowe.',
        'nl': 'Andere tonen, vaak chemisch of papierachtig.',
        'sv': 'Andra toner, ofta kemiska eller pappersaktiga.',
        'tr': 'Genellikle kimyasal veya kağıdımsı diğer notalar.',
        'ja': 'その他のノート。化学的または紙のようなことが多い。',
        'ko': '화학적이거나 종이 같은 느낌의 기타 노트입니다.',
        'zh': '其他特征，通常是化学或纸张味。',
        'ar': 'نكهات أخرى، غالباً ما تكون كيميائية أو ورقية.',
      },

      // --- SUB-CATEGORIES ---
      'wheel_sub_berry': {
        'en':
            'Vibrant and sweet-tart notes of small fruits. Derived from concentrated anthocyanins. Typical of Ethiopian natural coffees and Kenyan SL-varieties.',
        'uk':
            'Яскраві солодкувато-кислі ноти дрібних плодів. Походять від концентрованих антоціанів. Типово для ефіопської кави натуральної обробки та кенійських сортів SL.',
        'de': 'Süße und säuerliche Beerenaromen.',
        'fr': 'Arômes de baies sucrés et acidulés.',
        'es': 'Aromas de bayas dulces y ácidos.',
        'it': 'Aromi di bacche dolci e aciduli.',
        'pt': 'Aromas de bagas doces e ácidos.',
        'pl':
            'Vibrant and sweet-tart notes of small fruits. Derived from concentrated anthocyanins. Typical of Ethiopian natural coffees and Kenyan SL-varieties.',
        'nl': 'Zoete en rinse bessenaroma\'s.',
        'sv': 'Söta och syrliga bäraromer.',
        'tr': 'Tatlı ve ekşi böğürtlen aromaları.',
        'ja':
            'Vibrant and sweet-tart notes of small fruits. Derived from concentrated anthocyanins. Typical of Ethiopian natural coffees and Kenyan SL-varieties.',
        'ko': '달콤하고 산미 있는 베리 향입니다.',
        'zh':
            'Vibrant and sweet-tart notes of small fruits. Derived from concentrated anthocyanins. Typical of Ethiopian natural coffees and Kenyan SL-varieties.',
        'ar': 'نكهات توت حلوة ولاذعة.',
      },
      'wheel_sub_dried_fruit': {
        'en':
            'Concentrated, jammy sweetness reminiscent of raisins or dates. Often the result of over-ripening or natural sun-drying. Common in Yemen Moka and processed lots from Brazil.',
        'uk':
            'Концентрована, джемова солодкість, що нагадує родзинки або фініки. Часто є результатом перезрівання або натуральної сушки на сонці. Зустрічається в єменській каві Мока та оброблених лотах з Бразилії.',
        'de':
            'Concentrated, jammy sweetness reminiscent of raisins or dates. Often the result of over-ripening or natural sun-drying. Common in Yemen Moka and processed lots from Brazil.',
        'fr':
            'Concentrated, jammy sweetness reminiscent of raisins or dates. Often the result of over-ripening or natural sun-drying. Common in Yemen Moka and processed lots from Brazil.',
        'es':
            'Concentrated, jammy sweetness reminiscent of raisins or dates. Often the result of over-ripening or natural sun-drying. Common in Yemen Moka and processed lots from Brazil.',
        'it':
            'Concentrated, jammy sweetness reminiscent of raisins or dates. Often the result of over-ripening or natural sun-drying. Common in Yemen Moka and processed lots from Brazil.',
        'pt':
            'Concentrated, jammy sweetness reminiscent of raisins or dates. Often the result of over-ripening or natural sun-drying. Common in Yemen Moka and processed lots from Brazil.',
        'pl':
            'Concentrated, jammy sweetness reminiscent of raisins or dates. Often the result of over-ripening or natural sun-drying. Common in Yemen Moka and processed lots from Brazil.',
        'nl':
            'Concentrated, jammy sweetness reminiscent of raisins or dates. Often the result of over-ripening or natural sun-drying. Common in Yemen Moka and processed lots from Brazil.',
        'sv':
            'Concentrated, jammy sweetness reminiscent of raisins or dates. Often the result of over-ripening or natural sun-drying. Common in Yemen Moka and processed lots from Brazil.',
        'tr':
            'Concentrated, jammy sweetness reminiscent of raisins or dates. Often the result of over-ripening or natural sun-drying. Common in Yemen Moka and processed lots from Brazil.',
        'ja':
            'Concentrated, jammy sweetness reminiscent of raisins or dates. Often the result of over-ripening or natural sun-drying. Common in Yemen Moka and processed lots from Brazil.',
        'ko':
            'Concentrated, jammy sweetness reminiscent of raisins or dates. Often the result of over-ripening or natural sun-drying. Common in Yemen Moka and processed lots from Brazil.',
        'zh':
            'Concentrated, jammy sweetness reminiscent of raisins or dates. Often the result of over-ripening or natural sun-drying. Common in Yemen Moka and processed lots from Brazil.',
        'ar':
            'Concentrated, jammy sweetness reminiscent of raisins or dates. Often the result of over-ripening or natural sun-drying. Common in Yemen Moka and processed lots from Brazil.',
      },
      'wheel_sub_citrus': {
        'en':
            'Zesty and acidic notes providing brightness and "sparkle". Linked to high citric acid content. Signature profile of high-grown Colombian and Honduran coffees.',
        'uk':
            'Цедрові та кислі ноти, що забезпечують яскравість та "іскристість". Пов\'язані з високим вмістом лимонної кислоти. Фірмовий профіль високогірної колумбійської та гондураської кави.',
        'de': 'Spritzige Zitrusnoten wie Zitrone oder Orange.',
        'fr': 'Notes d\'agrumes vives comme le citron ou l\'orange.',
        'es': 'Notas cítricas vibrantes como limón o naranja.',
        'it': 'Note agrumate vivaci come limone o arancia.',
        'pt': 'Notas cítricas vibrantes como limão ou laranja.',
        'pl':
            'Zesty and acidic notes providing brightness and "sparkle". Linked to high citric acid content. Signature profile of high-grown Colombian and Honduran coffees.',
        'nl': 'Frisse citrusnoten zoals citroen of sinaasappel.',
        'sv': 'Friska citrusnoter som citron eller apelsin.',
        'tr': 'Limon veya portakal gibi canlı narenciye notaları.',
        'ja':
            'Zesty and acidic notes providing brightness and "sparkle". Linked to high citric acid content. Signature profile of high-grown Colombian and Honduran coffees.',
        'ko': '레몬이나 오렌지 같은 상큼한 시트러스 노트입니다.',
        'zh':
            'Zesty and acidic notes providing brightness and "sparkle". Linked to high citric acid content. Signature profile of high-grown Colombian and Honduran coffees.',
        'ar': 'نكهات حمضيات حيوية مثل الليمون أو البرتقال.',
      },
      'wheel_sub_other_fruit': {
        'en':
            'Tropical or temperate fruit notes like apple, pear, or mango. Represents intermediate acidity levels. Characteristic of Costa Rican and Salvadoran coffees.',
        'uk':
            'Ноти тропічних або фруктів помірного клімату, таких як яблуко, груша або манго. Представляє середні рівні кислотності. Характерно для кави з Коста-Ріки та Сальвадору.',
        'de':
            'Tropical or temperate fruit notes like apple, pear, or mango. Represents intermediate acidity levels. Characteristic of Costa Rican and Salvadoran coffees.',
        'fr':
            'Tropical or temperate fruit notes like apple, pear, or mango. Represents intermediate acidity levels. Characteristic of Costa Rican and Salvadoran coffees.',
        'es':
            'Tropical or temperate fruit notes like apple, pear, or mango. Represents intermediate acidity levels. Characteristic of Costa Rican and Salvadoran coffees.',
        'it':
            'Tropical or temperate fruit notes like apple, pear, or mango. Represents intermediate acidity levels. Characteristic of Costa Rican and Salvadoran coffees.',
        'pt':
            'Tropical or temperate fruit notes like apple, pear, or mango. Represents intermediate acidity levels. Characteristic of Costa Rican and Salvadoran coffees.',
        'pl':
            'Tropical or temperate fruit notes like apple, pear, or mango. Represents intermediate acidity levels. Characteristic of Costa Rican and Salvadoran coffees.',
        'nl':
            'Tropical or temperate fruit notes like apple, pear, or mango. Represents intermediate acidity levels. Characteristic of Costa Rican and Salvadoran coffees.',
        'sv':
            'Tropical or temperate fruit notes like apple, pear, or mango. Represents intermediate acidity levels. Characteristic of Costa Rican and Salvadoran coffees.',
        'tr':
            'Tropical or temperate fruit notes like apple, pear, or mango. Represents intermediate acidity levels. Characteristic of Costa Rican and Salvadoran coffees.',
        'ja':
            'Tropical or temperate fruit notes like apple, pear, or mango. Represents intermediate acidity levels. Characteristic of Costa Rican and Salvadoran coffees.',
        'ko':
            'Tropical or temperate fruit notes like apple, pear, or mango. Represents intermediate acidity levels. Characteristic of Costa Rican and Salvadoran coffees.',
        'zh':
            'Tropical or temperate fruit notes like apple, pear, or mango. Represents intermediate acidity levels. Characteristic of Costa Rican and Salvadoran coffees.',
        'ar':
            'Tropical or temperate fruit notes like apple, pear, or mango. Represents intermediate acidity levels. Characteristic of Costa Rican and Salvadoran coffees.',
      },
      'wheel_sub_sour': {
        'en':
            'Direct and sharp acidic notes. When balanced, it provides structure; when excessive, it indicates under-extraction or high organic acid concentration.',
        'uk':
            'Прямі та гострі кислі ноти. У збалансованому вигляді це забезпечує структуру; при надлишку вказує на недоекстракцію або високу концентрацію органічних кислот.',
        'de':
            'Direct and sharp acidic notes. When balanced, it provides structure; when excessive, it indicates under-extraction or high organic acid concentration.',
        'fr':
            'Direct and sharp acidic notes. When balanced, it provides structure; when excessive, it indicates under-extraction or high organic acid concentration.',
        'es':
            'Direct and sharp acidic notes. When balanced, it provides structure; when excessive, it indicates under-extraction or high organic acid concentration.',
        'it':
            'Direct and sharp acidic notes. When balanced, it provides structure; when excessive, it indicates under-extraction or high organic acid concentration.',
        'pt':
            'Direct and sharp acidic notes. When balanced, it provides structure; when excessive, it indicates under-extraction or high organic acid concentration.',
        'pl':
            'Direct and sharp acidic notes. When balanced, it provides structure; when excessive, it indicates under-extraction or high organic acid concentration.',
        'nl':
            'Direct and sharp acidic notes. When balanced, it provides structure; when excessive, it indicates under-extraction or high organic acid concentration.',
        'sv':
            'Direct and sharp acidic notes. When balanced, it provides structure; when excessive, it indicates under-extraction or high organic acid concentration.',
        'tr':
            'Direct and sharp acidic notes. When balanced, it provides structure; when excessive, it indicates under-extraction or high organic acid concentration.',
        'ja':
            'Direct and sharp acidic notes. When balanced, it provides structure; when excessive, it indicates under-extraction or high organic acid concentration.',
        'ko':
            'Direct and sharp acidic notes. When balanced, it provides structure; when excessive, it indicates under-extraction or high organic acid concentration.',
        'zh':
            'Direct and sharp acidic notes. When balanced, it provides structure; when excessive, it indicates under-extraction or high organic acid concentration.',
        'ar':
            'Direct and sharp acidic notes. When balanced, it provides structure; when excessive, it indicates under-extraction or high organic acid concentration.',
      },
      'wheel_sub_alcohol_fermented': {
        'en':
            'Heady and winey notes resulting from anaerobic or yeast-assisted fermentation. Reminiscent of spirits or cider. Typical of modern experimental lots from Colombia.',
        'uk':
            'П\'янкі та винні ноти, що виникають внаслідок анаеробної або дріжджової ферментації. Нагадує міцні напої або сидр. Типово для сучасних експериментальних лотів з Колумбії.',
        'de':
            'Heady and winey notes resulting from anaerobic or yeast-assisted fermentation. Reminiscent of spirits or cider. Typical of modern experimental lots from Colombia.',
        'fr':
            'Heady and winey notes resulting from anaerobic or yeast-assisted fermentation. Reminiscent of spirits or cider. Typical of modern experimental lots from Colombia.',
        'es':
            'Heady and winey notes resulting from anaerobic or yeast-assisted fermentation. Reminiscent of spirits or cider. Typical of modern experimental lots from Colombia.',
        'it':
            'Heady and winey notes resulting from anaerobic or yeast-assisted fermentation. Reminiscent of spirits or cider. Typical of modern experimental lots from Colombia.',
        'pt':
            'Heady and winey notes resulting from anaerobic or yeast-assisted fermentation. Reminiscent of spirits or cider. Typical of modern experimental lots from Colombia.',
        'pl':
            'Heady and winey notes resulting from anaerobic or yeast-assisted fermentation. Reminiscent of spirits or cider. Typical of modern experimental lots from Colombia.',
        'nl':
            'Heady and winey notes resulting from anaerobic or yeast-assisted fermentation. Reminiscent of spirits or cider. Typical of modern experimental lots from Colombia.',
        'sv':
            'Heady and winey notes resulting from anaerobic or yeast-assisted fermentation. Reminiscent of spirits or cider. Typical of modern experimental lots from Colombia.',
        'tr':
            'Heady and winey notes resulting from anaerobic or yeast-assisted fermentation. Reminiscent of spirits or cider. Typical of modern experimental lots from Colombia.',
        'ja':
            'Heady and winey notes resulting from anaerobic or yeast-assisted fermentation. Reminiscent of spirits or cider. Typical of modern experimental lots from Colombia.',
        'ko':
            'Heady and winey notes resulting from anaerobic or yeast-assisted fermentation. Reminiscent of spirits or cider. Typical of modern experimental lots from Colombia.',
        'zh':
            'Heady and winey notes resulting from anaerobic or yeast-assisted fermentation. Reminiscent of spirits or cider. Typical of modern experimental lots from Colombia.',
        'ar':
            'Heady and winey notes resulting from anaerobic or yeast-assisted fermentation. Reminiscent of spirits or cider. Typical of modern experimental lots from Colombia.',
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
        'zh':
            '深沉的黑巧克力风味。在烘焙过程中较长的发展阶段出现。是巴西和印度季风马拉巴咖啡豆的典型风味。',
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
        'zh':
            '烘焙坚果的泥土味和咸鲜感。源于氨基酸与糖的反应。常见于经典的南美风味中。',
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
        'ja':
            '豊かなキャラメルやシロップの甘み。複雑な糖の褐色化の結果です。適切に焙煎されたミディアムプロフィールの多くに見られます。',
        'ko':
            '풍부한 카라멜과 시럽의 단맛입니다. 복합적인 당의 갈변 반응 결과입니다. 잘 로스팅된 미디엄 프로필에서 보편적으로 나타납니다.',
        'zh':
            '浓郁的焦糖和糖浆甜感。糖分复杂褐变反应的结果。在烘焙良好的中度风味中非常普遍。',
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
        'zh':
            '带有草本底蕴的清爽、有结构的口感。与高海拔豆类中的特定多酚有关。是耶加雪菲和高级肯尼亚批次的标志。',
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
        'zh':
            '香气扑鼻、令人愉悦的味道，如香草或香料。源于美拉德反应的后期阶段。是中美洲高品质阿拉比卡咖啡豆的典型特征。',
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
        'zh':
            '随着糖分焦糖化而产生的温暖、甜美的香料味。富含酚类化合物。是苏门答腊和卢旺达咖啡的特征。',
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
            'Nuty prażonego ziarna i chleba. Wskazują на wczesne etapy palenia lub specyficzną gęstość ziarna. Występują w wielu brazylijskich i indyjskich partiach kawy.',
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
        'zh':
            '烘烤谷物和面包般的香气。预示着烘焙早期阶段或特定的咖啡豆密度。在许多巴西和印度批次中很常见。',
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
            'Intense, rokerige en verkoolde aroma\'s. Resultaat van diep branden oder verbranding van het boon-oppervlak. Kenmerkend voor Italiaanse en Franse brandingsprofielen.',
        'sv':
            'Intensiva, rökiga och brända aromer. Resultat av djup rostning eller bränning av bönans yta. Karaktäristiskt för italienska och franska rostningsprofiler.',
        'tr':
            'Yoğun, isli ve yanık aromalar. Derin kavurmanın veya çekirdek yüzeyinin yanmasının sonucudur. İtalyan ve Fransız kavurma profillerinin özelliğidir.',
        'ja':
            '強烈で、スモーキー、そして焦げたようなアロマ。深煎りや豆の表面の焦げの結果です。イタリアンローストやフレンチローストの特徴です。',
        'ko':
            '강렬하고 스모키하며 탄 듯한 아로마입니다. 딥 로스팅이나 원두 표면이 그을린 결과입니다. 이탈리안 및 프렌치 로스팅 프로파일의 특징입니다.',
        'zh':
            '强烈、烟熏和烧焦的香气。是深度烘焙或豆表焦灼的结果。是意式和法式烘焙风格的特征。',
        'ar':
            'روائح مكثفة ومدخنة ومتفحمة. ناتجة عن التحميص العميق أو احتراق سطح الحبوب. مميزة لملفات التحميص الإيطالية والفرنسية.',
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
        'zh':
            '新鲜、青草和植物般的气息。通常预示着烘焙程度不足或特定的产地特征。在一些高海拔的中美洲批次中很常见。',
        'ar':
            'نوتات طازجة وعشبية ونباتية. غالباً ما تشير إلى نقص تطوير التحميص أو سمات تربة معينة. شائعة في بعض المحاصيل المرتفعة من أمريكا الوسطى.',
      },
      'wheel_sub_chemical': {
        'en':
            'Sharp, artificial, or medicinal aromas. Can indicate processing defects or external contamination. Usually considered a negative trait in specialty coffee.',
        'uk':
            'Різкі, штучні або медичні аромати. Можуть вказувати на дефекти обробки або стороннє забруднення. Зазвичай вважаються негативним фактором у спешелті-каві.',
        'de':
            'Scharfe, künstliche oder medizinische Aromen. Können auf Verarbeitungsfehler oder externe Kontamination hinweisen. Gelten im Specialty Coffee meist als negativer Faktor.',
        'fr':
            'Arômes vifs, artificiels ou médicinaux. Peut indiquer des défauts de traitement ou une contamination externe. Généralement considéré comme un trait négatif dans le café de spécialité.',
        'es':
            'Aromas punzantes, artificiales o medicinales. Pueden indicar defectos de procesamiento o contaminación externa. Generalmente se consideran un rasgo negativo en el café de especialidad.',
        'it':
            'Aromi pungenti, artificiali o medicinali. Possono indicare difetti di lavorazione o contaminazione esterna. Solitamente considerati un tratto negativo nel caffè specialty.',
        'pt':
            'Aromas nítidos, artificiais ou medicinais. Podem indicar defeitos de processamento ou contaminação externa. Geralmente considerados um traço negativo no café especial.',
        'pl':
            'Ostre, sztuczne lub medyczne aromaty. Mogą wskazywać на wady obróbki lub zanieczyszczenie zewnętrzne. Zazwyczaj uważane za negatywną cechę в kawie specialty.',
        'nl':
            'Scherpe, kunstmatige of medicinale aroma\'s. Kunnen duiden op verwerkingsfouten of externe besmetting. Wordt meestal als een negatief kenmerk beschouwd in specialty coffee.',
        'sv':
            'Skarpa, konstgjorda eller medicinska aromer. Kan tyda på bearbetningsdefekter eller extern förorening. Betraktas vanligtvis som ett negativt drag i specialty coffee.',
        'tr':
            'Keskin, yapay veya tıbbi aromalar. İşleme kusurlarını veya dış kirlenmeyi gösterebilir. Nitelikli kahvede genellikle olumsuz bir özellik olarak kabul edilir.',
        'ja':
            '鋭く、人工的、または薬のようなアロマ。精製過程の欠陥や外部の汚染を示すことがあります。スペシャリティコーヒーでは通常、ネガティブな特徴とされます。',
        'ko':
            '날카롭고 인공적이거나 약품 같은 아로마입니다. 가공 결함이나 외부 오염을 나타낼 수 있습니다. 스페셜티 커피에서는 보통 결점으로 간주됩니다.',
        'zh':
            '尖锐、人造或药用气味。可能预示着加工缺陷或外部污染。在精品咖啡中通常被视为负面特征。',
        'ar':
            'روائح حادة أو اصطناعية أو طبية. قد تشير إلى عيوب في المعالجة أو تلوث خارجي. تعتبر عادةً سمة سلبية في القهوة المختصة.',
      },
      'wheel_sub_papery': {
        'en':
            'Dry notes reminiscent of cardboard or old wood. Often a sign of green bean aging or freshness loss during storage.',
        'uk':
            'Сухі ноти, що нагадують картон або стару деревину. Часто є ознакою старіння зеленого зерна або втрати свіжості при зберіганні.',
        'de':
            'Trockene Noten, die an Pappe oder altes Holz erinnern. Oft ein Zeichen für die Alterung von Rohkaffee oder Frischeverlust bei der Lagerung.',
        'fr':
            'Notes sèches rappelant le carton ou le vieux bois. Souvent un signe de vieillissement du grain vert ou d\'une perte de fraîcheur lors du stockage.',
        'es':
            'Notas secas que recuerdan al cartón o a la madera vieja. A menudo es un signo de envejecimiento del grano verde o pérdida de frescura durante el almacenamiento.',
        'it':
            'Note secche che ricordano il cartone o il legno vecchio. Spesso segno di invecchiamento del chicco verde o perdita di freschezza durante lo stoccaggio.',
        'pt':
            'Notas secas que lembram papelão ou madeira velha. Muitas vezes um sinal de envelhecimento do grão verde ou perda de frescor durante o armazenamento.',
        'pl':
            'Suche nuty przypominające karton lub stare drewno. Często są oznaką starzenia się zielonego ziarna lub utraty świeżości podczas przechowywania.',
        'nl':
            'Droge tonen die doen denken aan karton of oud hout. Vaak een teken van veroudering van de groene boon of versheidsverlies tijdens opslag.',
        'sv':
            'Torra noter som påminner om kartong eller gammalt trä. Ofta ett tecken på att det gröna kaffet har åldrats eller förlorat sin färskhet under lagring.',
        'tr':
            'Karton veya eski odunu andıran kuru notalar. Genellikle yeşil çekirdeğin yaşlanmasının veya depolama sırasında tazelik kaybının bir işaretidir.',
        'ja':
            '段ボールや古い木を思わせるドライなノート。生豆の経年劣化や保管中の鮮度喪失の兆候であることが多いです。',
        'ko':
            '판지나 오래된 나무를 연상시키는 건조한 노트입니다. 종종 생두의 노화나 보관 중 신선도 상실의 징후입니다.',
        'zh':
            '让人联想到纸板或老旧木材的干涩气息。通常是生豆老化或储存期间失去新鲜感的迹象。',
        'ar':
            'نوتات جافة تشبه الورق المقوى أو الخشب القديم. غالباً ما تكون علامة على تقادم الحبوب الخضراء أو فقدان الطزاجة أثناء التخزين.',
      },

      // --- SPECIFIC NOTES (Expanding to reach 80+) ---
      'wheel_note_blackberry': {
        'en':
            'Deep, dark berry sweetness with a slight tannic edge. Reminiscent of wild summer fruit. Characteristic of Kenyan coffees with high phosphorus soil.',
        'uk':
            'Глибока солодкість темних ягід з легким таніновим відтінком. Нагадує лісові літні плоди. Характерно для кенійської кави, вирощеної на ґрунтах з високим вмістом фосфору.',
        'de':
            'Deep, dark berry sweetness with a slight tannic edge. Reminiscent of wild summer fruit. Characteristic of Kenyan coffees with high phosphorus soil.',
        'fr':
            'Deep, dark berry sweetness with a slight tannic edge. Reminiscent of wild summer fruit. Characteristic of Kenyan coffees with high phosphorus soil.',
        'es':
            'Deep, dark berry sweetness with a slight tannic edge. Reminiscent of wild summer fruit. Characteristic of Kenyan coffees with high phosphorus soil.',
        'it':
            'Deep, dark berry sweetness with a slight tannic edge. Reminiscent of wild summer fruit. Characteristic of Kenyan coffees with high phosphorus soil.',
        'pt':
            'Deep, dark berry sweetness with a slight tannic edge. Reminiscent of wild summer fruit. Characteristic of Kenyan coffees with high phosphorus soil.',
        'pl':
            'Deep, dark berry sweetness with a slight tannic edge. Reminiscent of wild summer fruit. Characteristic of Kenyan coffees with high phosphorus soil.',
        'nl':
            'Deep, dark berry sweetness with a slight tannic edge. Reminiscent of wild summer fruit. Characteristic of Kenyan coffees with high phosphorus soil.',
        'sv':
            'Deep, dark berry sweetness with a slight tannic edge. Reminiscent of wild summer fruit. Characteristic of Kenyan coffees with high phosphorus soil.',
        'tr':
            'Deep, dark berry sweetness with a slight tannic edge. Reminiscent of wild summer fruit. Characteristic of Kenyan coffees with high phosphorus soil.',
        'ja':
            'Deep, dark berry sweetness with a slight tannic edge. Reminiscent of wild summer fruit. Characteristic of Kenyan coffees with high phosphorus soil.',
        'ko':
            'Deep, dark berry sweetness with a slight tannic edge. Reminiscent of wild summer fruit. Characteristic of Kenyan coffees with high phosphorus soil.',
        'zh':
            'Deep, dark berry sweetness with a slight tannic edge. Reminiscent of wild summer fruit. Characteristic of Kenyan coffees with high phosphorus soil.',
        'ar':
            'Deep, dark berry sweetness with a slight tannic edge. Reminiscent of wild summer fruit. Characteristic of Kenyan coffees with high phosphorus soil.',
      },
      'wheel_note_blueberry': {
        'en':
            'A distinct "jammy" and sweet berry note. Often indicates a clean natural process. The hallmark of Ethiopian Yirgacheffe and Sidamo naturals.',
        'uk':
            'Виражена "джемова" і солодка ягідна нота. Часто вказує на чисту натуральну обробку. Візитна картка ефіопських сортів Іргачеф та Сідамо.',
        'de':
            'A distinct "jammy" and sweet berry note. Often indicates a clean natural process. The hallmark of Ethiopian Yirgacheffe and Sidamo naturals.',
        'fr':
            'A distinct "jammy" and sweet berry note. Often indicates a clean natural process. The hallmark of Ethiopian Yirgacheffe and Sidamo naturals.',
        'es':
            'A distinct "jammy" and sweet berry note. Often indicates a clean natural process. The hallmark of Ethiopian Yirgacheffe and Sidamo naturals.',
        'it':
            'A distinct "jammy" and sweet berry note. Often indicates a clean natural process. The hallmark of Ethiopian Yirgacheffe and Sidamo naturals.',
        'pt':
            'A distinct "jammy" and sweet berry note. Often indicates a clean natural process. The hallmark of Ethiopian Yirgacheffe and Sidamo naturals.',
        'pl':
            'A distinct "jammy" and sweet berry note. Often indicates a clean natural process. The hallmark of Ethiopian Yirgacheffe and Sidamo naturals.',
        'nl':
            'A distinct "jammy" and sweet berry note. Often indicates a clean natural process. The hallmark of Ethiopian Yirgacheffe and Sidamo naturals.',
        'sv':
            'A distinct "jammy" and sweet berry note. Often indicates a clean natural process. The hallmark of Ethiopian Yirgacheffe and Sidamo naturals.',
        'tr':
            'A distinct "jammy" and sweet berry note. Often indicates a clean natural process. The hallmark of Ethiopian Yirgacheffe and Sidamo naturals.',
        'ja':
            'A distinct "jammy" and sweet berry note. Often indicates a clean natural process. The hallmark of Ethiopian Yirgacheffe and Sidamo naturals.',
        'ko':
            'A distinct "jammy" and sweet berry note. Often indicates a clean natural process. The hallmark of Ethiopian Yirgacheffe and Sidamo naturals.',
        'zh':
            'A distinct "jammy" and sweet berry note. Often indicates a clean natural process. The hallmark of Ethiopian Yirgacheffe and Sidamo naturals.',
        'ar':
            'A distinct "jammy" and sweet berry note. Often indicates a clean natural process. The hallmark of Ethiopian Yirgacheffe and Sidamo naturals.',
      },
      'wheel_note_raspberry': {
        'en':
            'Bright, tart berry note with floral undertones. High malic and citric acidity. Often found in high-altitude Rwandan and Burundian coffees.',
        'uk':
            'Яскрава, терпка ягідна нота з квітковими відтінками. Висока яблучна та лимонна кислотність. Часто зустрічається у високогірній каві Руанди та Бурунді.',
        'de':
            'Bright, tart berry note with floral undertones. High malic and citric acidity. Often found in high-altitude Rwandan and Burundian coffees.',
        'fr':
            'Bright, tart berry note with floral undertones. High malic and citric acidity. Often found in high-altitude Rwandan and Burundian coffees.',
        'es':
            'Bright, tart berry note with floral undertones. High malic and citric acidity. Often found in high-altitude Rwandan and Burundian coffees.',
        'it':
            'Bright, tart berry note with floral undertones. High malic and citric acidity. Often found in high-altitude Rwandan and Burundian coffees.',
        'pt':
            'Bright, tart berry note with floral undertones. High malic and citric acidity. Often found in high-altitude Rwandan and Burundian coffees.',
        'pl':
            'Bright, tart berry note with floral undertones. High malic and citric acidity. Often found in high-altitude Rwandan and Burundian coffees.',
        'nl':
            'Bright, tart berry note with floral undertones. High malic and citric acidity. Often found in high-altitude Rwandan and Burundian coffees.',
        'sv':
            'Bright, tart berry note with floral undertones. High malic and citric acidity. Often found in high-altitude Rwandan and Burundian coffees.',
        'tr':
            'Bright, tart berry note with floral undertones. High malic and citric acidity. Often found in high-altitude Rwandan and Burundian coffees.',
        'ja':
            'Bright, tart berry note with floral undertones. High malic and citric acidity. Often found in high-altitude Rwandan and Burundian coffees.',
        'ko':
            'Bright, tart berry note with floral undertones. High malic and citric acidity. Often found in high-altitude Rwandan and Burundian coffees.',
        'zh':
            'Bright, tart berry note with floral undertones. High malic and citric acidity. Often found in high-altitude Rwandan and Burundian coffees.',
        'ar':
            'Bright, tart berry note with floral undertones. High malic and citric acidity. Often found in high-altitude Rwandan and Burundian coffees.',
      },
      'wheel_note_strawberry': {
        'en':
            'Sweet, fragrant red fruit note. Often accompanied by creamy body. Result of slow fermentation in high-sugar cherries like Bourbon or SL28.',
        'uk':
            'Солодка, ароматна нота червоних плодів. Часто супроводжується кремовим тілом. Результат повільної ферментації солодких ягід, таких як Бурбон або SL28.',
        'de':
            'Sweet, fragrant red fruit note. Often accompanied by creamy body. Result of slow fermentation in high-sugar cherries like Bourbon or SL28.',
        'fr':
            'Sweet, fragrant red fruit note. Often accompanied by creamy body. Result of slow fermentation in high-sugar cherries like Bourbon or SL28.',
        'es':
            'Sweet, fragrant red fruit note. Often accompanied by creamy body. Result of slow fermentation in high-sugar cherries like Bourbon or SL28.',
        'it':
            'Sweet, fragrant red fruit note. Often accompanied by creamy body. Result of slow fermentation in high-sugar cherries like Bourbon or SL28.',
        'pt':
            'Sweet, fragrant red fruit note. Often accompanied by creamy body. Result of slow fermentation in high-sugar cherries like Bourbon or SL28.',
        'pl':
            'Sweet, fragrant red fruit note. Often accompanied by creamy body. Result of slow fermentation in high-sugar cherries like Bourbon or SL28.',
        'nl':
            'Sweet, fragrant red fruit note. Often accompanied by creamy body. Result of slow fermentation in high-sugar cherries like Bourbon or SL28.',
        'sv':
            'Sweet, fragrant red fruit note. Often accompanied by creamy body. Result of slow fermentation in high-sugar cherries like Bourbon or SL28.',
        'tr':
            'Sweet, fragrant red fruit note. Often accompanied by creamy body. Result of slow fermentation in high-sugar cherries like Bourbon or SL28.',
        'ja':
            'Sweet, fragrant red fruit note. Often accompanied by creamy body. Result of slow fermentation in high-sugar cherries like Bourbon or SL28.',
        'ko':
            'Sweet, fragrant red fruit note. Often accompanied by creamy body. Result of slow fermentation in high-sugar cherries like Bourbon or SL28.',
        'zh':
            'Sweet, fragrant red fruit note. Often accompanied by creamy body. Result of slow fermentation in high-sugar cherries like Bourbon or SL28.',
        'ar':
            'Sweet, fragrant red fruit note. Often accompanied by creamy body. Result of slow fermentation in high-sugar cherries like Bourbon or SL28.',
      },
      'wheel_note_raisin': {
        'en':
            'Intense sun-dried sweetness with a slightly fermented edge. Reminiscent of concentrated grape sugars. Common in Yemeni and sun-dried Ethiopian lots.',
        'uk':
            'Інтенсивна солодкість сушених на сонці плодів з легким ферментованим відтінком. Нагадує концентрований виноградний цукор. Зустрічається в єменських та ефіопських лотах натуральної сушки.',
        'de':
            'Intense sun-dried sweetness with a slightly fermented edge. Reminiscent of concentrated grape sugars. Common in Yemeni and sun-dried Ethiopian lots.',
        'fr':
            'Intense sun-dried sweetness with a slightly fermented edge. Reminiscent of concentrated grape sugars. Common in Yemeni and sun-dried Ethiopian lots.',
        'es':
            'Intense sun-dried sweetness with a slightly fermented edge. Reminiscent of concentrated grape sugars. Common in Yemeni and sun-dried Ethiopian lots.',
        'it':
            'Intense sun-dried sweetness with a slightly fermented edge. Reminiscent of concentrated grape sugars. Common in Yemeni and sun-dried Ethiopian lots.',
        'pt':
            'Intense sun-dried sweetness with a slightly fermented edge. Reminiscent of concentrated grape sugars. Common in Yemeni and sun-dried Ethiopian lots.',
        'pl':
            'Intense sun-dried sweetness with a slightly fermented edge. Reminiscent of concentrated grape sugars. Common in Yemeni and sun-dried Ethiopian lots.',
        'nl':
            'Intense sun-dried sweetness with a slightly fermented edge. Reminiscent of concentrated grape sugars. Common in Yemeni and sun-dried Ethiopian lots.',
        'sv':
            'Intense sun-dried sweetness with a slightly fermented edge. Reminiscent of concentrated grape sugars. Common in Yemeni and sun-dried Ethiopian lots.',
        'tr':
            'Intense sun-dried sweetness with a slightly fermented edge. Reminiscent of concentrated grape sugars. Common in Yemeni and sun-dried Ethiopian lots.',
        'ja':
            'Intense sun-dried sweetness with a slightly fermented edge. Reminiscent of concentrated grape sugars. Common in Yemeni and sun-dried Ethiopian lots.',
        'ko':
            'Intense sun-dried sweetness with a slightly fermented edge. Reminiscent of concentrated grape sugars. Common in Yemeni and sun-dried Ethiopian lots.',
        'zh':
            'Intense sun-dried sweetness with a slightly fermented edge. Reminiscent of concentrated grape sugars. Common in Yemeni and sun-dried Ethiopian lots.',
        'ar':
            'Intense sun-dried sweetness with a slightly fermented edge. Reminiscent of concentrated grape sugars. Common in Yemeni and sun-dried Ethiopian lots.',
      },
      'wheel_note_prune': {
        'en':
            'Deep, dark dried fruit sweetness. Often indicates a more complex, heavy-bodied natural process. Typical of Brazilian pulp-naturals.',
        'uk':
            'Глибока солодкість темних сухофруктів. Часто вказує на більш складну, солідну натуральну обробку. Типово для бразильських "pulp-natural" лотів.',
        'de':
            'Deep, dark dried fruit sweetness. Often indicates a more complex, heavy-bodied natural process. Typical of Brazilian pulp-naturals.',
        'fr':
            'Deep, dark dried fruit sweetness. Often indicates a more complex, heavy-bodied natural process. Typical of Brazilian pulp-naturals.',
        'es':
            'Deep, dark dried fruit sweetness. Often indicates a more complex, heavy-bodied natural process. Typical of Brazilian pulp-naturals.',
        'it':
            'Deep, dark dried fruit sweetness. Often indicates a more complex, heavy-bodied natural process. Typical of Brazilian pulp-naturals.',
        'pt':
            'Deep, dark dried fruit sweetness. Often indicates a more complex, heavy-bodied natural process. Typical of Brazilian pulp-naturals.',
        'pl':
            'Deep, dark dried fruit sweetness. Often indicates a more complex, heavy-bodied natural process. Typical of Brazilian pulp-naturals.',
        'nl':
            'Deep, dark dried fruit sweetness. Often indicates a more complex, heavy-bodied natural process. Typical of Brazilian pulp-naturals.',
        'sv':
            'Deep, dark dried fruit sweetness. Often indicates a more complex, heavy-bodied natural process. Typical of Brazilian pulp-naturals.',
        'tr':
            'Deep, dark dried fruit sweetness. Often indicates a more complex, heavy-bodied natural process. Typical of Brazilian pulp-naturals.',
        'ja':
            'Deep, dark dried fruit sweetness. Often indicates a more complex, heavy-bodied natural process. Typical of Brazilian pulp-naturals.',
        'ko':
            'Deep, dark dried fruit sweetness. Often indicates a more complex, heavy-bodied natural process. Typical of Brazilian pulp-naturals.',
        'zh':
            'Deep, dark dried fruit sweetness. Often indicates a more complex, heavy-bodied natural process. Typical of Brazilian pulp-naturals.',
        'ar':
            'Deep, dark dried fruit sweetness. Often indicates a more complex, heavy-bodied natural process. Typical of Brazilian pulp-naturals.',
      },
      'wheel_note_coconut': {
        'en':
            'Creamy, nutty sweetness with a tropical aromatic profile. Often emerges in anaerobic or yeast-processed honey lots. Signature of modern Costa Rican micro-lots.',
        'uk':
            'Кремова, горіхова солодкість з тропічним ароматним профілем. Часто проявляється в анаеробних або дріжджових лотах обробки "Honey". Знакова нота для сучасних мікролотів з Коста-Ріки.',
        'de':
            'Creamy, nutty sweetness with a tropical aromatic profile. Often emerges in anaerobic or yeast-processed honey lots. Signature of modern Costa Rican micro-lots.',
        'fr':
            'Creamy, nutty sweetness with a tropical aromatic profile. Often emerges in anaerobic or yeast-processed honey lots. Signature of modern Costa Rican micro-lots.',
        'es':
            'Creamy, nutty sweetness with a tropical aromatic profile. Often emerges in anaerobic or yeast-processed honey lots. Signature of modern Costa Rican micro-lots.',
        'it':
            'Creamy, nutty sweetness with a tropical aromatic profile. Often emerges in anaerobic or yeast-processed honey lots. Signature of modern Costa Rican micro-lots.',
        'pt':
            'Creamy, nutty sweetness with a tropical aromatic profile. Often emerges in anaerobic or yeast-processed honey lots. Signature of modern Costa Rican micro-lots.',
        'pl':
            'Creamy, nutty sweetness with a tropical aromatic profile. Often emerges in anaerobic or yeast-processed honey lots. Signature of modern Costa Rican micro-lots.',
        'nl':
            'Creamy, nutty sweetness with a tropical aromatic profile. Often emerges in anaerobic or yeast-processed honey lots. Signature of modern Costa Rican micro-lots.',
        'sv':
            'Creamy, nutty sweetness with a tropical aromatic profile. Often emerges in anaerobic or yeast-processed honey lots. Signature of modern Costa Rican micro-lots.',
        'tr':
            'Creamy, nutty sweetness with a tropical aromatic profile. Often emerges in anaerobic or yeast-processed honey lots. Signature of modern Costa Rican micro-lots.',
        'ja':
            'Creamy, nutty sweetness with a tropical aromatic profile. Often emerges in anaerobic or yeast-processed honey lots. Signature of modern Costa Rican micro-lots.',
        'ko':
            'Creamy, nutty sweetness with a tropical aromatic profile. Often emerges in anaerobic or yeast-processed honey lots. Signature of modern Costa Rican micro-lots.',
        'zh':
            'Creamy, nutty sweetness with a tropical aromatic profile. Often emerges in anaerobic or yeast-processed honey lots. Signature of modern Costa Rican micro-lots.',
        'ar':
            'Creamy, nutty sweetness with a tropical aromatic profile. Often emerges in anaerobic or yeast-processed honey lots. Signature of modern Costa Rican micro-lots.',
      },
      'wheel_note_cherry': {
        'en':
            'Classic stone fruit sweetness with systemic acidity. Relates to the coffee fruit itself. Found in many Central American washed coffees.',
        'uk':
            'Класична солодкість кісточкових фруктів з системною кислотністю. Пов\'язана з самим плодом кави. Зустрічається в багатьох центральноамериканських митих лотах.',
        'de':
            'Classic stone fruit sweetness with systemic acidity. Relates to the coffee fruit itself. Found in many Central American washed coffees.',
        'fr':
            'Classic stone fruit sweetness with systemic acidity. Relates to the coffee fruit itself. Found in many Central American washed coffees.',
        'es':
            'Classic stone fruit sweetness with systemic acidity. Relates to the coffee fruit itself. Found in many Central American washed coffees.',
        'it':
            'Classic stone fruit sweetness with systemic acidity. Relates to the coffee fruit itself. Found in many Central American washed coffees.',
        'pt':
            'Classic stone fruit sweetness with systemic acidity. Relates to the coffee fruit itself. Found in many Central American washed coffees.',
        'pl':
            'Classic stone fruit sweetness with systemic acidity. Relates to the coffee fruit itself. Found in many Central American washed coffees.',
        'nl':
            'Classic stone fruit sweetness with systemic acidity. Relates to the coffee fruit itself. Found in many Central American washed coffees.',
        'sv':
            'Classic stone fruit sweetness with systemic acidity. Relates to the coffee fruit itself. Found in many Central American washed coffees.',
        'tr':
            'Classic stone fruit sweetness with systemic acidity. Relates to the coffee fruit itself. Found in many Central American washed coffees.',
        'ja':
            'Classic stone fruit sweetness with systemic acidity. Relates to the coffee fruit itself. Found in many Central American washed coffees.',
        'ko':
            'Classic stone fruit sweetness with systemic acidity. Relates to the coffee fruit itself. Found in many Central American washed coffees.',
        'zh':
            'Classic stone fruit sweetness with systemic acidity. Relates to the coffee fruit itself. Found in many Central American washed coffees.',
        'ar':
            'Classic stone fruit sweetness with systemic acidity. Relates to the coffee fruit itself. Found in many Central American washed coffees.',
      },
      'wheel_note_pomegranate': {
        'en':
            'Complex tartness with a dry, slight bitterness. High antioxidant and acid profile. Typical of bright Kenyan and high-end Ethiopian lots.',
        'uk':
            'Комплексна терпкість з сухою, легкою гірчинкою. Високий вміст антиоксидантів та кислотний профіль. Типово для яскравих кенійських та дорогих ефіопських лотів.',
        'de':
            'Complex tartness with a dry, slight bitterness. High antioxidant and acid profile. Typical of bright Kenyan and high-end Ethiopian lots.',
        'fr':
            'Complex tartness with a dry, slight bitterness. High antioxidant and acid profile. Typical of bright Kenyan and high-end Ethiopian lots.',
        'es':
            'Complex tartness with a dry, slight bitterness. High antioxidant and acid profile. Typical of bright Kenyan and high-end Ethiopian lots.',
        'it':
            'Complex tartness with a dry, slight bitterness. High antioxidant and acid profile. Typical of bright Kenyan and high-end Ethiopian lots.',
        'pt':
            'Complex tartness with a dry, slight bitterness. High antioxidant and acid profile. Typical of bright Kenyan and high-end Ethiopian lots.',
        'pl':
            'Complex tartness with a dry, slight bitterness. High antioxidant and acid profile. Typical of bright Kenyan and high-end Ethiopian lots.',
        'nl':
            'Complex tartness with a dry, slight bitterness. High antioxidant and acid profile. Typical of bright Kenyan and high-end Ethiopian lots.',
        'sv':
            'Complex tartness with a dry, slight bitterness. High antioxidant and acid profile. Typical of bright Kenyan and high-end Ethiopian lots.',
        'tr':
            'Complex tartness with a dry, slight bitterness. High antioxidant and acid profile. Typical of bright Kenyan and high-end Ethiopian lots.',
        'ja':
            'Complex tartness with a dry, slight bitterness. High antioxidant and acid profile. Typical of bright Kenyan and high-end Ethiopian lots.',
        'ko':
            'Complex tartness with a dry, slight bitterness. High antioxidant and acid profile. Typical of bright Kenyan and high-end Ethiopian lots.',
        'zh':
            'Complex tartness with a dry, slight bitterness. High antioxidant and acid profile. Typical of bright Kenyan and high-end Ethiopian lots.',
        'ar':
            'Complex tartness with a dry, slight bitterness. High antioxidant and acid profile. Typical of bright Kenyan and high-end Ethiopian lots.',
      },
      'wheel_note_pineapple': {
        'en':
            'Explosive tropical sweetness and high acidity. Result of anaerobic or prolonged lactic fermentation. Common in experimental micro-lots.',
        'uk':
            'Вибухова тропічна солодкість і висока кислотність. Результат анаеробної або тривалої молочної ферментації. Зустрічається в експериментальних мікролотах.',
        'de':
            'Explosive tropical sweetness and high acidity. Result of anaerobic or prolonged lactic fermentation. Common in experimental micro-lots.',
        'fr':
            'Explosive tropical sweetness and high acidity. Result of anaerobic or prolonged lactic fermentation. Common in experimental micro-lots.',
        'es':
            'Explosive tropical sweetness and high acidity. Result of anaerobic or prolonged lactic fermentation. Common in experimental micro-lots.',
        'it':
            'Explosive tropical sweetness and high acidity. Result of anaerobic or prolonged lactic fermentation. Common in experimental micro-lots.',
        'pt':
            'Explosive tropical sweetness and high acidity. Result of anaerobic or prolonged lactic fermentation. Common in experimental micro-lots.',
        'pl':
            'Explosive tropical sweetness and high acidity. Result of anaerobic or prolonged lactic fermentation. Common in experimental micro-lots.',
        'nl':
            'Explosive tropical sweetness and high acidity. Result of anaerobic or prolonged lactic fermentation. Common in experimental micro-lots.',
        'sv':
            'Explosive tropical sweetness and high acidity. Result of anaerobic or prolonged lactic fermentation. Common in experimental micro-lots.',
        'tr':
            'Explosive tropical sweetness and high acidity. Result of anaerobic or prolonged lactic fermentation. Common in experimental micro-lots.',
        'ja':
            'Explosive tropical sweetness and high acidity. Result of anaerobic or prolonged lactic fermentation. Common in experimental micro-lots.',
        'ko':
            'Explosive tropical sweetness and high acidity. Result of anaerobic or prolonged lactic fermentation. Common in experimental micro-lots.',
        'zh':
            'Explosive tropical sweetness and high acidity. Result of anaerobic or prolonged lactic fermentation. Common in experimental micro-lots.',
        'ar':
            'Explosive tropical sweetness and high acidity. Result of anaerobic or prolonged lactic fermentation. Common in experimental micro-lots.',
      },
      'wheel_note_grape': {
        'en':
            'Juicy sweetness ranging from green to dark purple grapes. Tartaric acid dominance. Characteristic of varieties like Castillo in Colombia.',
        'uk':
            'Соковита солодкість, що варіюється від зеленого до темно-фіолетового винограду. Домінування винної кислоти. Характерно для таких сортів, як Кастільйо в Колумбії.',
        'de':
            'Juicy sweetness ranging from green to dark purple grapes. Tartaric acid dominance. Characteristic of varieties like Castillo in Colombia.',
        'fr':
            'Juicy sweetness ranging from green to dark purple grapes. Tartaric acid dominance. Characteristic of varieties like Castillo in Colombia.',
        'es':
            'Juicy sweetness ranging from green to dark purple grapes. Tartaric acid dominance. Characteristic of varieties like Castillo in Colombia.',
        'it':
            'Juicy sweetness ranging from green to dark purple grapes. Tartaric acid dominance. Characteristic of varieties like Castillo in Colombia.',
        'pt':
            'Juicy sweetness ranging from green to dark purple grapes. Tartaric acid dominance. Characteristic of varieties like Castillo in Colombia.',
        'pl':
            'Juicy sweetness ranging from green to dark purple grapes. Tartaric acid dominance. Characteristic of varieties like Castillo in Colombia.',
        'nl':
            'Juicy sweetness ranging from green to dark purple grapes. Tartaric acid dominance. Characteristic of varieties like Castillo in Colombia.',
        'sv':
            'Juicy sweetness ranging from green to dark purple grapes. Tartaric acid dominance. Characteristic of varieties like Castillo in Colombia.',
        'tr':
            'Juicy sweetness ranging from green to dark purple grapes. Tartaric acid dominance. Characteristic of varieties like Castillo in Colombia.',
        'ja':
            'Juicy sweetness ranging from green to dark purple grapes. Tartaric acid dominance. Characteristic of varieties like Castillo in Colombia.',
        'ko':
            'Juicy sweetness ranging from green to dark purple grapes. Tartaric acid dominance. Characteristic of varieties like Castillo in Colombia.',
        'zh':
            'Juicy sweetness ranging from green to dark purple grapes. Tartaric acid dominance. Characteristic of varieties like Castillo in Colombia.',
        'ar':
            'Juicy sweetness ranging from green to dark purple grapes. Tartaric acid dominance. Characteristic of varieties like Castillo in Colombia.',
      },
      'wheel_note_apple': {
        'en':
            'Clean, crisp sweetness linked to malic acid. Reminiscent of green or red apples depending on density. Found in many washed Ethiopian and Mexican coffees.',
        'uk':
            'Чиста, хрустка солодкість, пов\'язана з яблучною кислотою. Нагадує зелені або червоні яблука залежно від щільності. Зустрічається в багатьох митих ефіопських та мексиканських лотах.',
        'de':
            'Clean, crisp sweetness linked to malic acid. Reminiscent of green or red apples depending on density. Found in many washed Ethiopian and Mexican coffees.',
        'fr':
            'Clean, crisp sweetness linked to malic acid. Reminiscent of green or red apples depending on density. Found in many washed Ethiopian and Mexican coffees.',
        'es':
            'Clean, crisp sweetness linked to malic acid. Reminiscent of green or red apples depending on density. Found in many washed Ethiopian and Mexican coffees.',
        'it':
            'Clean, crisp sweetness linked to malic acid. Reminiscent of green or red apples depending on density. Found in many washed Ethiopian and Mexican coffees.',
        'pt':
            'Clean, crisp sweetness linked to malic acid. Reminiscent of green or red apples depending on density. Found in many washed Ethiopian and Mexican coffees.',
        'pl':
            'Clean, crisp sweetness linked to malic acid. Reminiscent of green or red apples depending on density. Found in many washed Ethiopian and Mexican coffees.',
        'nl':
            'Clean, crisp sweetness linked to malic acid. Reminiscent of green or red apples depending on density. Found in many washed Ethiopian and Mexican coffees.',
        'sv':
            'Clean, crisp sweetness linked to malic acid. Reminiscent of green or red apples depending on density. Found in many washed Ethiopian and Mexican coffees.',
        'tr':
            'Clean, crisp sweetness linked to malic acid. Reminiscent of green or red apples depending on density. Found in many washed Ethiopian and Mexican coffees.',
        'ja':
            'Clean, crisp sweetness linked to malic acid. Reminiscent of green or red apples depending on density. Found in many washed Ethiopian and Mexican coffees.',
        'ko':
            'Clean, crisp sweetness linked to malic acid. Reminiscent of green or red apples depending on density. Found in many washed Ethiopian and Mexican coffees.',
        'zh':
            'Clean, crisp sweetness linked to malic acid. Reminiscent of green or red apples depending on density. Found in many washed Ethiopian and Mexican coffees.',
        'ar':
            'Clean, crisp sweetness linked to malic acid. Reminiscent of green or red apples depending on density. Found in many washed Ethiopian and Mexican coffees.',
      },
      'wheel_note_peach': {
        'en':
            'Delicate, fuzzy sweetness with a smooth mouthfeel. Intermediate acidity. Hallmark of high-quality Ethiopian washed lots and some Salvadoran Pacamaras.',
        'uk':
            'Ніжна солодкість з гладким відчуттям у роті. Середня кислотність. Візитна картка високоякісних ефіопських митих лотів та деяких сальвадорських пакамар.',
        'de':
            'Delicate, fuzzy sweetness with a smooth mouthfeel. Intermediate acidity. Hallmark of high-quality Ethiopian washed lots and some Salvadoran Pacamaras.',
        'fr':
            'Delicate, fuzzy sweetness with a smooth mouthfeel. Intermediate acidity. Hallmark of high-quality Ethiopian washed lots and some Salvadoran Pacamaras.',
        'es':
            'Delicate, fuzzy sweetness with a smooth mouthfeel. Intermediate acidity. Hallmark of high-quality Ethiopian washed lots and some Salvadoran Pacamaras.',
        'it':
            'Delicate, fuzzy sweetness with a smooth mouthfeel. Intermediate acidity. Hallmark of high-quality Ethiopian washed lots and some Salvadoran Pacamaras.',
        'pt':
            'Delicate, fuzzy sweetness with a smooth mouthfeel. Intermediate acidity. Hallmark of high-quality Ethiopian washed lots and some Salvadoran Pacamaras.',
        'pl':
            'Delicate, fuzzy sweetness with a smooth mouthfeel. Intermediate acidity. Hallmark of high-quality Ethiopian washed lots and some Salvadoran Pacamaras.',
        'nl':
            'Delicate, fuzzy sweetness with a smooth mouthfeel. Intermediate acidity. Hallmark of high-quality Ethiopian washed lots and some Salvadoran Pacamaras.',
        'sv':
            'Delicate, fuzzy sweetness with a smooth mouthfeel. Intermediate acidity. Hallmark of high-quality Ethiopian washed lots and some Salvadoran Pacamaras.',
        'tr':
            'Delicate, fuzzy sweetness with a smooth mouthfeel. Intermediate acidity. Hallmark of high-quality Ethiopian washed lots and some Salvadoran Pacamaras.',
        'ja':
            'Delicate, fuzzy sweetness with a smooth mouthfeel. Intermediate acidity. Hallmark of high-quality Ethiopian washed lots and some Salvadoran Pacamaras.',
        'ko':
            'Delicate, fuzzy sweetness with a smooth mouthfeel. Intermediate acidity. Hallmark of high-quality Ethiopian washed lots and some Salvadoran Pacamaras.',
        'zh':
            'Delicate, fuzzy sweetness with a smooth mouthfeel. Intermediate acidity. Hallmark of high-quality Ethiopian washed lots and some Salvadoran Pacamaras.',
        'ar':
            'Delicate, fuzzy sweetness with a smooth mouthfeel. Intermediate acidity. Hallmark of high-quality Ethiopian washed lots and some Salvadoran Pacamaras.',
      },
      'wheel_note_pear': {
        'en':
            'Soft, grainy sweetness with subtle acidity. Often associated with clean, elegant washed profiles. Typical of Mexican and Honduran Arabicas.',
        'uk':
            'М\'яка солодкість з тонкими відтінками кислотності. Часто асоціюється з чистими, елегантними митими профілями. Типово для мексиканських та гондураських арабік.',
        'de':
            'Soft, grainy sweetness with subtle acidity. Often associated with clean, elegant washed profiles. Typical of Mexican and Honduran Arabicas.',
        'fr':
            'Soft, grainy sweetness with subtle acidity. Often associated with clean, elegant washed profiles. Typical of Mexican and Honduran Arabicas.',
        'es':
            'Soft, grainy sweetness with subtle acidity. Often associated with clean, elegant washed profiles. Typical of Mexican and Honduran Arabicas.',
        'it':
            'Soft, grainy sweetness with subtle acidity. Often associated with clean, elegant washed profiles. Typical of Mexican and Honduran Arabicas.',
        'pt':
            'Soft, grainy sweetness with subtle acidity. Often associated with clean, elegant washed profiles. Typical of Mexican and Honduran Arabicas.',
        'pl':
            'Soft, grainy sweetness with subtle acidity. Often associated with clean, elegant washed profiles. Typical of Mexican and Honduran Arabicas.',
        'nl':
            'Soft, grainy sweetness with subtle acidity. Often associated with clean, elegant washed profiles. Typical of Mexican and Honduran Arabicas.',
        'sv':
            'Soft, grainy sweetness with subtle acidity. Often associated with clean, elegant washed profiles. Typical of Mexican and Honduran Arabicas.',
        'tr':
            'Soft, grainy sweetness with subtle acidity. Often associated with clean, elegant washed profiles. Typical of Mexican and Honduran Arabicas.',
        'ja':
            'Soft, grainy sweetness with subtle acidity. Often associated with clean, elegant washed profiles. Typical of Mexican and Honduran Arabicas.',
        'ko':
            'Soft, grainy sweetness with subtle acidity. Often associated with clean, elegant washed profiles. Typical of Mexican and Honduran Arabicas.',
        'zh':
            'Soft, grainy sweetness with subtle acidity. Often associated with clean, elegant washed profiles. Typical of Mexican and Honduran Arabicas.',
        'ar':
            'Soft, grainy sweetness with subtle acidity. Often associated with clean, elegant washed profiles. Typical of Mexican and Honduran Arabicas.',
      },
      'wheel_note_grapefruit': {
        'en':
            'Zesty citrus note with a pleasant, tonic-like bitterness. Linked to high phosphorus soils. Common in high-acid Kenyan and Rwandan coffees.',
        'uk':
            'Цедрова цитрусова нота з приємною гірчинкою, схожою на тонік. Пов\'язана з ґрунтами з високим вмістом фосфору. Зустрічається у висококислотній кенійській та руандійській каві.',
        'de':
            'Zesty citrus note with a pleasant, tonic-like bitterness. Linked to high phosphorus soils. Common in high-acid Kenyan and Rwandan coffees.',
        'fr':
            'Zesty citrus note with a pleasant, tonic-like bitterness. Linked to high phosphorus soils. Common in high-acid Kenyan and Rwandan coffees.',
        'es':
            'Zesty citrus note with a pleasant, tonic-like bitterness. Linked to high phosphorus soils. Common in high-acid Kenyan and Rwandan coffees.',
        'it':
            'Zesty citrus note with a pleasant, tonic-like bitterness. Linked to high phosphorus soils. Common in high-acid Kenyan and Rwandan coffees.',
        'pt':
            'Zesty citrus note with a pleasant, tonic-like bitterness. Linked to high phosphorus soils. Common in high-acid Kenyan and Rwandan coffees.',
        'pl':
            'Zesty citrus note with a pleasant, tonic-like bitterness. Linked to high phosphorus soils. Common in high-acid Kenyan and Rwandan coffees.',
        'nl':
            'Zesty citrus note with a pleasant, tonic-like bitterness. Linked to high phosphorus soils. Common in high-acid Kenyan and Rwandan coffees.',
        'sv':
            'Zesty citrus note with a pleasant, tonic-like bitterness. Linked to high phosphorus soils. Common in high-acid Kenyan and Rwandan coffees.',
        'tr':
            'Zesty citrus note with a pleasant, tonic-like bitterness. Linked to high phosphorus soils. Common in high-acid Kenyan and Rwandan coffees.',
        'ja':
            'Zesty citrus note with a pleasant, tonic-like bitterness. Linked to high phosphorus soils. Common in high-acid Kenyan and Rwandan coffees.',
        'ko':
            'Zesty citrus note with a pleasant, tonic-like bitterness. Linked to high phosphorus soils. Common in high-acid Kenyan and Rwandan coffees.',
        'zh':
            'Zesty citrus note with a pleasant, tonic-like bitterness. Linked to high phosphorus soils. Common in high-acid Kenyan and Rwandan coffees.',
        'ar':
            'Zesty citrus note with a pleasant, tonic-like bitterness. Linked to high phosphorus soils. Common in high-acid Kenyan and Rwandan coffees.',
      },
      'wheel_note_orange': {
        'en':
            'Sweet, balanced citrus note with soft acidity. Reminiscent of orange juice or zest. Characteristic of Colombian and Salvadoran Arabicas.',
        'uk':
            'Солодка, збалансована цитрусова нота з м\'якою кислотністю. Нагадує апельсиновий сік або цедру. Характерно для колумбійських та сальвадорських арабік.',
        'de':
            'Sweet, balanced citrus note with soft acidity. Reminiscent of orange juice or zest. Characteristic of Colombian and Salvadoran Arabicas.',
        'fr':
            'Sweet, balanced citrus note with soft acidity. Reminiscent of orange juice or zest. Characteristic of Colombian and Salvadoran Arabicas.',
        'es':
            'Sweet, balanced citrus note with soft acidity. Reminiscent of orange juice or zest. Characteristic of Colombian and Salvadoran Arabicas.',
        'it':
            'Sweet, balanced citrus note with soft acidity. Reminiscent of orange juice or zest. Characteristic of Colombian and Salvadoran Arabicas.',
        'pt':
            'Sweet, balanced citrus note with soft acidity. Reminiscent of orange juice or zest. Characteristic of Colombian and Salvadoran Arabicas.',
        'pl':
            'Sweet, balanced citrus note with soft acidity. Reminiscent of orange juice or zest. Characteristic of Colombian and Salvadoran Arabicas.',
        'nl':
            'Sweet, balanced citrus note with soft acidity. Reminiscent of orange juice or zest. Characteristic of Colombian and Salvadoran Arabicas.',
        'sv':
            'Sweet, balanced citrus note with soft acidity. Reminiscent of orange juice or zest. Characteristic of Colombian and Salvadoran Arabicas.',
        'tr':
            'Sweet, balanced citrus note with soft acidity. Reminiscent of orange juice or zest. Characteristic of Colombian and Salvadoran Arabicas.',
        'ja':
            'Sweet, balanced citrus note with soft acidity. Reminiscent of orange juice or zest. Characteristic of Colombian and Salvadoran Arabicas.',
        'ko':
            'Sweet, balanced citrus note with soft acidity. Reminiscent of orange juice or zest. Characteristic of Colombian and Salvadoran Arabicas.',
        'zh':
            'Sweet, balanced citrus note with soft acidity. Reminiscent of orange juice or zest. Characteristic of Colombian and Salvadoran Arabicas.',
        'ar':
            'Sweet, balanced citrus note with soft acidity. Reminiscent of orange juice or zest. Characteristic of Colombian and Salvadoran Arabicas.',
      },
      'wheel_note_lemon': {
        'en':
            'Sharp, bright, and refreshing citric note. Typical of high-density beans grown in volcanic soil. Frequent in Guatemalan Huehuetenango.',
        'uk':
            'Гостра, яскрава та освіжаюча лимонна нота. Типово для щільних зерен, вирощених на вулканічних ґрунтах. Часто зустрічається в гватемальському регоіні Уеуетенанго.',
        'de':
            'Sharp, bright, and refreshing citric note. Typical of high-density beans grown in volcanic soil. Frequent in Guatemalan Huehuetenango.',
        'fr':
            'Sharp, bright, and refreshing citric note. Typical of high-density beans grown in volcanic soil. Frequent in Guatemalan Huehuetenango.',
        'es':
            'Sharp, bright, and refreshing citric note. Typical of high-density beans grown in volcanic soil. Frequent in Guatemalan Huehuetenango.',
        'it':
            'Sharp, bright, and refreshing citric note. Typical of high-density beans grown in volcanic soil. Frequent in Guatemalan Huehuetenango.',
        'pt':
            'Sharp, bright, and refreshing citric note. Typical of high-density beans grown in volcanic soil. Frequent in Guatemalan Huehuetenango.',
        'pl':
            'Sharp, bright, and refreshing citric note. Typical of high-density beans grown in volcanic soil. Frequent in Guatemalan Huehuetenango.',
        'nl':
            'Sharp, bright, and refreshing citric note. Typical of high-density beans grown in volcanic soil. Frequent in Guatemalan Huehuetenango.',
        'sv':
            'Sharp, bright, and refreshing citric note. Typical of high-density beans grown in volcanic soil. Frequent in Guatemalan Huehuetenango.',
        'tr':
            'Sharp, bright, and refreshing citric note. Typical of high-density beans grown in volcanic soil. Frequent in Guatemalan Huehuetenango.',
        'ja':
            'Sharp, bright, and refreshing citric note. Typical of high-density beans grown in volcanic soil. Frequent in Guatemalan Huehuetenango.',
        'ko':
            'Sharp, bright, and refreshing citric note. Typical of high-density beans grown in volcanic soil. Frequent in Guatemalan Huehuetenango.',
        'zh':
            'Sharp, bright, and refreshing citric note. Typical of high-density beans grown in volcanic soil. Frequent in Guatemalan Huehuetenango.',
        'ar':
            'Sharp, bright, and refreshing citric note. Typical of high-density beans grown in volcanic soil. Frequent in Guatemalan Huehuetenango.',
      },
      'wheel_note_lime': {
        'en':
            'The sharpest, most intense citrus acid. Provides a "zingy" finish. Common in extremely high-altitude lots or specific varieties like Geisha.',
        'uk':
            'Найгостріша, найбільш інтенсивна цитрусова кислота. Забезпечує "іскристий" посмак. Зустрічається у надзвичайно високогірних лотах або специфічних сортах, таких як Гейша.',
        'de':
            'The sharpest, most intense citrus acid. Provides a "zingy" finish. Common in extremely high-altitude lots or specific varieties like Geisha.',
        'fr':
            'The sharpest, most intense citrus acid. Provides a "zingy" finish. Common in extremely high-altitude lots or specific varieties like Geisha.',
        'es':
            'The sharpest, most intense citrus acid. Provides a "zingy" finish. Common in extremely high-altitude lots or specific varieties like Geisha.',
        'it':
            'The sharpest, most intense citrus acid. Provides a "zingy" finish. Common in extremely high-altitude lots or specific varieties like Geisha.',
        'pt':
            'The sharpest, most intense citrus acid. Provides a "zingy" finish. Common in extremely high-altitude lots or specific varieties like Geisha.',
        'pl':
            'The sharpest, most intense citrus acid. Provides a "zingy" finish. Common in extremely high-altitude lots or specific varieties like Geisha.',
        'nl':
            'The sharpest, most intense citrus acid. Provides a "zingy" finish. Common in extremely high-altitude lots or specific varieties like Geisha.',
        'sv':
            'The sharpest, most intense citrus acid. Provides a "zingy" finish. Common in extremely high-altitude lots or specific varieties like Geisha.',
        'tr':
            'The sharpest, most intense citrus acid. Provides a "zingy" finish. Common in extremely high-altitude lots or specific varieties like Geisha.',
        'ja':
            'The sharpest, most intense citrus acid. Provides a "zingy" finish. Common in extremely high-altitude lots or specific varieties like Geisha.',
        'ko':
            'The sharpest, most intense citrus acid. Provides a "zingy" finish. Common in extremely high-altitude lots or specific varieties like Geisha.',
        'zh':
            'The sharpest, most intense citrus acid. Provides a "zingy" finish. Common in extremely high-altitude lots or specific varieties like Geisha.',
        'ar':
            'The sharpest, most intense citrus acid. Provides a "zingy" finish. Common in extremely high-altitude lots or specific varieties like Geisha.',
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
        'zh':
            '清新、草本且略带涩味的风味。表明烘焙度极浅或属于特定的高海拔品种。常见于细腻的水洗埃塞俄比亚咖啡中。',
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
        'zh':
            '柔和、草本且略带蜂蜜般的甜味。表明复杂、低酸度的花香风味。常见于加工过的尼加拉瓜咖啡中。',
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
        'ja':
            '柔らかく優雅なフローラルの甘さ。穏やかな焙煎プロフィールや高地に関連しています。繊細なピンクブルボン種に見られます。',
        'ko':
            '부드럽고 우아한 꽃의 단맛. 완만한 로스팅 프로필 및 고지대와 관련이 있습니다. 섬세한 핑크 버본 품종에서 발견됩니다.',
        'zh':
            '柔和、优雅的花香甜味。与温和的烘焙程度和高海拔有关。常见于细腻的粉红波旁（Pink Bourbon）品种中。',
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
        'zh':
            '浓郁的花香和如香水般的气息。与高浓度的芳樟醇有关。是巴拿马和埃塞俄比亚瑰夏咖啡的标志性风味。',
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
        'ja':
            '甘くクリーミーで、繊細なアロマのノート。焙煎工程の中盤に生じます。高品質な中米産のウォッシュドロットによく見られます。',
        'ko':
            '달콤하고 크리미하며 미묘한 아로마 노트. 로스팅 과정 중간에 발생합니다. 고품질의 워시드 중앙아메리카 로트에서 자주 발견됩니다.',
        'zh':
            '甜美、柔滑且细腻的香气。产生于烘焙过程的中期。常见于优质的中美洲水洗咖啡中。',
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
        'zh':
            '浓郁、木质且带有油脂感的甜美。代表了比普通香草更浓缩的香气特征。发现于独特的波旁品种微批次中。',
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
        'zh':
            '浓厚、深沉且带有泥土气息的糖分甜美。是高度焦糖化的结果。是许多巴西和苏门答腊咖啡的标志性特征。',
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
        'zh':
            '纯净、带有木质气息且持久的甜味。代表了烘焙过程中高质量、稳定的碳水化合物分解。在优质瓜地马拉咖啡中很常见。',
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
        'zh':
            '浓郁、糖分褐变的气息。是烘焙程度恰到好处的普遍指标。存在于从瓜地马拉到巴西的各类甜味咖啡中。',
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
        'zh':
            '粘稠、花香般的甜美。与高果胶含量和特定的加工工艺有关。是哥斯大黎加“蜜处理”批次的标志。',
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
        'zh':
            '带有泥土气息、微油且具有风味的坚果甜美。是许多南美咖啡和特定烘焙风格的特征。常见于经典的巴西批次中。',
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
        'zh':
            '甜美、微苦且带有类似杏仁糖气息的坚果味。与特定的氨基酸特征有关。在纯净的水洗洪都拉斯和萨尔瓦多咖啡中很常见。',
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
        'zh':
            '基础的可可甜美。是褐变反应的结果。是巴西、印度和越南优质罗布斯塔及阿拉比卡咖啡的经典风味。',
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
        'zh':
            '浓郁、苦中带甜的可可风味。标志着高度的烘焙程度或特定的产地基因。在苏门答腊高海拔咖啡中非常稳定。',
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
        'zh':
            '具有温暖感的辛辣、刺鼻气息。是特定酚类化合物的结果。在一些卢旺达和布隆迪咖啡中可见。',
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
        'zh':
            '甜美的木质香料味。常见于高密度咖啡的中浅度烘焙。在也门和一些埃塞俄比亚咖啡中经常出现。',
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
        'zh':
            '泥土般温暖的香料风味。经常补充巧克力和坚果的甜味。是高品质印度尼西亚阿拉比卡咖啡的特征。',
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
        'zh':
            '清凉、甜美且略带药味的香料味。让人联想到甘草。在一些稀有的也门和复杂的非洲批次中可见。',
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
        'zh':
            '甜美的谷物气息，让人联想到啤酒或新鲜出炉的面包。是特定糖-氨基酸反应的指标。在传统的巴西咖啡中很常见。',
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
        'zh':
            '烘烤的面包般谷物香气。标志着早期烘焙阶段或高密度咖啡豆。在许多高质量的商业等级咖啡中可见。',
        'ar':
            'نوتة حبوب محمصة تشبه الخبز. تشير إلى مراحل التطوير المبكرة أو الحبوب عالية الكثافة. توجد في العديد من أنواع القهوة ذات الدرجة التجارية عالية الجودة.',
      },
      'wheel_note_smoky': {
        'en':
            'Intense char and wood-smoke notes. Typical of dark-roast profiles where pyrolysis dominates. Quintessential for South Italian espresso styles.',
        'uk':
            'Інтенсивні ноти вугілля та деревного диму. Типово для профілів темного обсмаження, де домінує піроліз. Квінтесенція стилів південноіталійського еспресо.',
        'de':
            'Intense char and wood-smoke notes. Typical of dark-roast profiles where pyrolysis dominates. Quintessential for South Italian espresso styles.',
        'fr':
            'Intense char and wood-smoke notes. Typical of dark-roast profiles where pyrolysis dominates. Quintessential for South Italian espresso styles.',
        'es':
            'Intense char and wood-smoke notes. Typical of dark-roast profiles where pyrolysis dominates. Quintessential for South Italian espresso styles.',
        'it':
            'Intense char and wood-smoke notes. Typical of dark-roast profiles where pyrolysis dominates. Quintessential for South Italian espresso styles.',
        'pt':
            'Intense char and wood-smoke notes. Typical of dark-roast profiles where pyrolysis dominates. Quintessential for South Italian espresso styles.',
        'pl':
            'Intense char and wood-smoke notes. Typical of dark-roast profiles where pyrolysis dominates. Quintessential for South Italian espresso styles.',
        'nl':
            'Intense char and wood-smoke notes. Typical of dark-roast profiles where pyrolysis dominates. Quintessential for South Italian espresso styles.',
        'sv':
            'Intense char and wood-smoke notes. Typical of dark-roast profiles where pyrolysis dominates. Quintessential for South Italian espresso styles.',
        'tr':
            'Intense char and wood-smoke notes. Typical of dark-roast profiles where pyrolysis dominates. Quintessential for South Italian espresso styles.',
        'ja':
            'Intense char and wood-smoke notes. Typical of dark-roast profiles where pyrolysis dominates. Quintessential for South Italian espresso styles.',
        'ko':
            'Intense char and wood-smoke notes. Typical of dark-roast profiles where pyrolysis dominates. Quintessential for South Italian espresso styles.',
        'zh':
            'Intense char and wood-smoke notes. Typical of dark-roast profiles where pyrolysis dominates. Quintessential for South Italian espresso styles.',
        'ar':
            'Intense char and wood-smoke notes. Typical of dark-roast profiles where pyrolysis dominates. Quintessential for South Italian espresso styles.',
      },
      'wheel_note_ashy': {
        'en':
            'Dry, carbonaceous and mineral-like note. Indicates extreme roast exposure. Found in commercial-grade dark roasts.',
        'uk':
            'Суха, вуглецева та мінеральна нота. Вказує на екстремальний вплив тепла під час обсмаження. Зустрічається в комерційних лотах темного обсмаження.',
        'de':
            'Dry, carbonaceous and mineral-like note. Indicates extreme roast exposure. Found in commercial-grade dark roasts.',
        'fr':
            'Dry, carbonaceous and mineral-like note. Indicates extreme roast exposure. Found in commercial-grade dark roasts.',
        'es':
            'Dry, carbonaceous and mineral-like note. Indicates extreme roast exposure. Found in commercial-grade dark roasts.',
        'it':
            'Dry, carbonaceous and mineral-like note. Indicates extreme roast exposure. Found in commercial-grade dark roasts.',
        'pt':
            'Dry, carbonaceous and mineral-like note. Indicates extreme roast exposure. Found in commercial-grade dark roasts.',
        'pl':
            'Dry, carbonaceous and mineral-like note. Indicates extreme roast exposure. Found in commercial-grade dark roasts.',
        'nl':
            'Dry, carbonaceous and mineral-like note. Indicates extreme roast exposure. Found in commercial-grade dark roasts.',
        'sv':
            'Dry, carbonaceous and mineral-like note. Indicates extreme roast exposure. Found in commercial-grade dark roasts.',
        'tr':
            'Dry, carbonaceous and mineral-like note. Indicates extreme roast exposure. Found in commercial-grade dark roasts.',
        'ja':
            'Dry, carbonaceous and mineral-like note. Indicates extreme roast exposure. Found in commercial-grade dark roasts.',
        'ko':
            'Dry, carbonaceous and mineral-like note. Indicates extreme roast exposure. Found in commercial-grade dark roasts.',
        'zh':
            'Dry, carbonaceous and mineral-like note. Indicates extreme roast exposure. Found in commercial-grade dark roasts.',
        'ar':
            'Dry, carbonaceous and mineral-like note. Indicates extreme roast exposure. Found in commercial-grade dark roasts.',
      },
      'wheel_note_olive_oil': {
        'en':
            'Unique, buttery and slightly vegetal mouthfeel. Reflects high concentration of specific lipids. Arises in certain Peruvian and Ecuadorian micro-lots.',
        'uk':
            'Унікальне, маслянисте та злегка рослинне відчуття в роті. Відображає високу концентрацію специфічних ліпідів. Проявляється в певних перуанських та еквадорських мікролотах.',
        'de':
            'Unique, buttery and slightly vegetal mouthfeel. Reflects high concentration of specific lipids. Arises in certain Peruvian and Ecuadorian micro-lots.',
        'fr':
            'Unique, buttery and slightly vegetal mouthfeel. Reflects high concentration of specific lipids. Arises in certain Peruvian and Ecuadorian micro-lots.',
        'es':
            'Unique, buttery and slightly vegetal mouthfeel. Reflects high concentration of specific lipids. Arises in certain Peruvian and Ecuadorian micro-lots.',
        'it':
            'Unique, buttery and slightly vegetal mouthfeel. Reflects high concentration of specific lipids. Arises in certain Peruvian and Ecuadorian micro-lots.',
        'pt':
            'Unique, buttery and slightly vegetal mouthfeel. Reflects high concentration of specific lipids. Arises in certain Peruvian and Ecuadorian micro-lots.',
        'pl':
            'Unique, buttery and slightly vegetal mouthfeel. Reflects high concentration of specific lipids. Arises in certain Peruvian and Ecuadorian micro-lots.',
        'nl':
            'Unique, buttery and slightly vegetal mouthfeel. Reflects high concentration of specific lipids. Arises in certain Peruvian and Ecuadorian micro-lots.',
        'sv':
            'Unique, buttery and slightly vegetal mouthfeel. Reflects high concentration of specific lipids. Arises in certain Peruvian and Ecuadorian micro-lots.',
        'tr':
            'Unique, buttery and slightly vegetal mouthfeel. Reflects high concentration of specific lipids. Arises in certain Peruvian and Ecuadorian micro-lots.',
        'ja':
            'Unique, buttery and slightly vegetal mouthfeel. Reflects high concentration of specific lipids. Arises in certain Peruvian and Ecuadorian micro-lots.',
        'ko':
            'Unique, buttery and slightly vegetal mouthfeel. Reflects high concentration of specific lipids. Arises in certain Peruvian and Ecuadorian micro-lots.',
        'zh':
            'Unique, buttery and slightly vegetal mouthfeel. Reflects high concentration of specific lipids. Arises in certain Peruvian and Ecuadorian micro-lots.',
        'ar':
            'Unique, buttery and slightly vegetal mouthfeel. Reflects high concentration of specific lipids. Arises in certain Peruvian and Ecuadorian micro-lots.',
      },
      'wheel_note_raw': {
        'en':
            'Undeveloped, grassy note indicating short roast time or low moisture loss. Common in very fast light roasts.',
        'uk':
            'Недорозвинена, злакова нота, що вказує на короткий час обсмажування або низьку втрату вологи. Зустрічається у дуже швидких світлих профілях.',
        'de':
            'Undeveloped, grassy note indicating short roast time or low moisture loss. Common in very fast light roasts.',
        'fr':
            'Undeveloped, grassy note indicating short roast time or low moisture loss. Common in very fast light roasts.',
        'es':
            'Undeveloped, grassy note indicating short roast time or low moisture loss. Common in very fast light roasts.',
        'it':
            'Undeveloped, grassy note indicating short roast time or low moisture loss. Common in very fast light roasts.',
        'pt':
            'Undeveloped, grassy note indicating short roast time or low moisture loss. Common in very fast light roasts.',
        'pl':
            'Undeveloped, grassy note indicating short roast time or low moisture loss. Common in very fast light roasts.',
        'nl':
            'Undeveloped, grassy note indicating short roast time or low moisture loss. Common in very fast light roasts.',
        'sv':
            'Undeveloped, grassy note indicating short roast time or low moisture loss. Common in very fast light roasts.',
        'tr':
            'Undeveloped, grassy note indicating short roast time or low moisture loss. Common in very fast light roasts.',
        'ja':
            'Undeveloped, grassy note indicating short roast time or low moisture loss. Common in very fast light roasts.',
        'ko':
            'Undeveloped, grassy note indicating short roast time or low moisture loss. Common in very fast light roasts.',
        'zh':
            'Undeveloped, grassy note indicating short roast time or low moisture loss. Common in very fast light roasts.',
        'ar':
            'Undeveloped, grassy note indicating short roast time or low moisture loss. Common in very fast light roasts.',
      },
      'wheel_note_under_ripe': {
        'en':
            'Sharp, green acidity reminiscent of unripe fruit. Indicates non-uniform cherry harvesting. Present in some commercial-grade mixed lots.',
        'uk':
            'Гостра, зелена кислотність, що нагадує недозрілі фрукти. Вказує на неоднорідний збір ягід. Присутня у деяких комерційних змішаних лотах.',
        'de':
            'Sharp, green acidity reminiscent of unripe fruit. Indicates non-uniform cherry harvesting. Present in some commercial-grade mixed lots.',
        'fr':
            'Sharp, green acidity reminiscent of unripe fruit. Indicates non-uniform cherry harvesting. Present in some commercial-grade mixed lots.',
        'es':
            'Sharp, green acidity reminiscent of unripe fruit. Indicates non-uniform cherry harvesting. Present in some commercial-grade mixed lots.',
        'it':
            'Sharp, green acidity reminiscent of unripe fruit. Indicates non-uniform cherry harvesting. Present in some commercial-grade mixed lots.',
        'pt':
            'Sharp, green acidity reminiscent of unripe fruit. Indicates non-uniform cherry harvesting. Present in some commercial-grade mixed lots.',
        'pl':
            'Sharp, green acidity reminiscent of unripe fruit. Indicates non-uniform cherry harvesting. Present in some commercial-grade mixed lots.',
        'nl':
            'Sharp, green acidity reminiscent of unripe fruit. Indicates non-uniform cherry harvesting. Present in some commercial-grade mixed lots.',
        'sv':
            'Sharp, green acidity reminiscent of unripe fruit. Indicates non-uniform cherry harvesting. Present in some commercial-grade mixed lots.',
        'tr':
            'Sharp, green acidity reminiscent of unripe fruit. Indicates non-uniform cherry harvesting. Present in some commercial-grade mixed lots.',
        'ja':
            'Sharp, green acidity reminiscent of unripe fruit. Indicates non-uniform cherry harvesting. Present in some commercial-grade mixed lots.',
        'ko':
            'Sharp, green acidity reminiscent of unripe fruit. Indicates non-uniform cherry harvesting. Present in some commercial-grade mixed lots.',
        'zh':
            'Sharp, green acidity reminiscent of unripe fruit. Indicates non-uniform cherry harvesting. Present in some commercial-grade mixed lots.',
        'ar':
            'Sharp, green acidity reminiscent of unripe fruit. Indicates non-uniform cherry harvesting. Present in some commercial-grade mixed lots.',
      },
      'wheel_note_peapod': {
        'en':
            'Savory, vegetal note reminiscent of fresh peas. Often reflects specific soil minerals or light roasting of high-density beans. Common in Rwandans.',
        'uk':
            'Пікантна, рослинна нота, що нагадує свіжий горох. Часто відображає специфічні мінерали ґрунту або світле обсмаження щільних зерен. Зустрічається в Руанді.',
        'de':
            'Savory, vegetal note reminiscent of fresh peas. Often reflects specific soil minerals or light roasting of high-density beans. Common in Rwandans.',
        'fr':
            'Savory, vegetal note reminiscent of fresh peas. Often reflects specific soil minerals or light roasting of high-density beans. Common in Rwandans.',
        'es':
            'Savory, vegetal note reminiscent of fresh peas. Often reflects specific soil minerals or light roasting of high-density beans. Common in Rwandans.',
        'it':
            'Savory, vegetal note reminiscent of fresh peas. Often reflects specific soil minerals or light roasting of high-density beans. Common in Rwandans.',
        'pt':
            'Savory, vegetal note reminiscent of fresh peas. Often reflects specific soil minerals or light roasting of high-density beans. Common in Rwandans.',
        'pl':
            'Savory, vegetal note reminiscent of fresh peas. Often reflects specific soil minerals or light roasting of high-density beans. Common in Rwandans.',
        'nl':
            'Savory, vegetal note reminiscent of fresh peas. Often reflects specific soil minerals or light roasting of high-density beans. Common in Rwandans.',
        'sv':
            'Savory, vegetal note reminiscent of fresh peas. Often reflects specific soil minerals or light roasting of high-density beans. Common in Rwandans.',
        'tr':
            'Savory, vegetal note reminiscent of fresh peas. Often reflects specific soil minerals or light roasting of high-density beans. Common in Rwandans.',
        'ja':
            'Savory, vegetal note reminiscent of fresh peas. Often reflects specific soil minerals or light roasting of high-density beans. Common in Rwandans.',
        'ko':
            'Savory, vegetal note reminiscent of fresh peas. Often reflects specific soil minerals or light roasting of high-density beans. Common in Rwandans.',
        'zh':
            'Savory, vegetal note reminiscent of fresh peas. Often reflects specific soil minerals or light roasting of high-density beans. Common in Rwandans.',
        'ar':
            'Savory, vegetal note reminiscent of fresh peas. Often reflects specific soil minerals or light roasting of high-density beans. Common in Rwandans.',
      },
      'wheel_note_fresh': {
        'en':
            'Vibrant, green and bright profile. Positive vegetal note indicating fresh-crop beans and light processing. Common in high-grown Peruvians.',
        'uk':
            'Яскравий, зелений та чистий профіль. Позитивна рослинна нота, що вказує на свіжий врожай та світлу обробку. Зустрічається у високогірній каві з Перу.',
        'de':
            'Vibrant, green and bright profile. Positive vegetal note indicating fresh-crop beans and light processing. Common in high-grown Peruvians.',
        'fr':
            'Vibrant, green and bright profile. Positive vegetal note indicating fresh-crop beans and light processing. Common in high-grown Peruvians.',
        'es':
            'Vibrant, green and bright profile. Positive vegetal note indicating fresh-crop beans and light processing. Common in high-grown Peruvians.',
        'it':
            'Vibrant, green and bright profile. Positive vegetal note indicating fresh-crop beans and light processing. Common in high-grown Peruvians.',
        'pt':
            'Vibrant, green and bright profile. Positive vegetal note indicating fresh-crop beans and light processing. Common in high-grown Peruvians.',
        'pl':
            'Vibrant, green and bright profile. Positive vegetal note indicating fresh-crop beans and light processing. Common in high-grown Peruvians.',
        'nl':
            'Vibrant, green and bright profile. Positive vegetal note indicating fresh-crop beans and light processing. Common in high-grown Peruvians.',
        'sv':
            'Vibrant, green and bright profile. Positive vegetal note indicating fresh-crop beans and light processing. Common in high-grown Peruvians.',
        'tr':
            'Vibrant, green and bright profile. Positive vegetal note indicating fresh-crop beans and light processing. Common in high-grown Peruvians.',
        'ja':
            'Vibrant, green and bright profile. Positive vegetal note indicating fresh-crop beans and light processing. Common in high-grown Peruvians.',
        'ko':
            'Vibrant, green and bright profile. Positive vegetal note indicating fresh-crop beans and light processing. Common in high-grown Peruvians.',
        'zh':
            'Vibrant, green and bright profile. Positive vegetal note indicating fresh-crop beans and light processing. Common in high-grown Peruvians.',
        'ar':
            'Vibrant, green and bright profile. Positive vegetal note indicating fresh-crop beans and light processing. Common in high-grown Peruvians.',
      },
      'wheel_note_vegetative': {
        'en':
            'Broad herbal profile encompassing leaves and stems. Reflects high levels of specific pyrazines. Characteristic of Indonesian Mandheling.',
        'uk':
            'Широкий трав\'яний профіль, що охоплює листя та стебла. Відображає високий рівень специфічних піразинів. Характерно для індонезійського сорту Манделінг.',
        'de':
            'Broad herbal profile encompassing leaves and stems. Reflects high levels of specific pyrazines. Characteristic of Indonesian Mandheling.',
        'fr':
            'Broad herbal profile encompassing leaves and stems. Reflects high levels of specific pyrazines. Characteristic of Indonesian Mandheling.',
        'es':
            'Broad herbal profile encompassing leaves and stems. Reflects high levels of specific pyrazines. Characteristic of Indonesian Mandheling.',
        'it':
            'Broad herbal profile encompassing leaves and stems. Reflects high levels of specific pyrazines. Characteristic of Indonesian Mandheling.',
        'pt':
            'Broad herbal profile encompassing leaves and stems. Reflects high levels of specific pyrazines. Characteristic of Indonesian Mandheling.',
        'pl':
            'Broad herbal profile encompassing leaves and stems. Reflects high levels of specific pyrazines. Characteristic of Indonesian Mandheling.',
        'nl':
            'Broad herbal profile encompassing leaves and stems. Reflects high levels of specific pyrazines. Characteristic of Indonesian Mandheling.',
        'sv':
            'Broad herbal profile encompassing leaves and stems. Reflects high levels of specific pyrazines. Characteristic of Indonesian Mandheling.',
        'tr':
            'Broad herbal profile encompassing leaves and stems. Reflects high levels of specific pyrazines. Characteristic of Indonesian Mandheling.',
        'ja':
            'Broad herbal profile encompassing leaves and stems. Reflects high levels of specific pyrazines. Characteristic of Indonesian Mandheling.',
        'ko':
            'Broad herbal profile encompassing leaves and stems. Reflects high levels of specific pyrazines. Characteristic of Indonesian Mandheling.',
        'zh':
            'Broad herbal profile encompassing leaves and stems. Reflects high levels of specific pyrazines. Characteristic of Indonesian Mandheling.',
        'ar':
            'Broad herbal profile encompassing leaves and stems. Reflects high levels of specific pyrazines. Characteristic of Indonesian Mandheling.',
      },
      'wheel_note_hay_like': {
        'en':
            'Dry, sweet grass and straw profile. Often indicates early signs of bean aging or specific terroir dryness. Frequent in processed Brazilian lots.',
        'uk':
            'Профіль сухої, солодкої трави та соломи. Часто вказує на перші ознаки старіння зерен або специфічну сухість терруару. Часто зустрічається в обробленій Бразилії.',
        'de':
            'Dry, sweet grass and straw profile. Often indicates early signs of bean aging or specific terroir dryness. Frequent in processed Brazilian lots.',
        'fr':
            'Dry, sweet grass and straw profile. Often indicates early signs of bean aging or specific terroir dryness. Frequent in processed Brazilian lots.',
        'es':
            'Dry, sweet grass and straw profile. Often indicates early signs of bean aging or specific terroir dryness. Frequent in processed Brazilian lots.',
        'it':
            'Dry, sweet grass and straw profile. Often indicates early signs of bean aging or specific terroir dryness. Frequent in processed Brazilian lots.',
        'pt':
            'Dry, sweet grass and straw profile. Often indicates early signs of bean aging or specific terroir dryness. Frequent in processed Brazilian lots.',
        'pl':
            'Dry, sweet grass and straw profile. Often indicates early signs of bean aging or specific terroir dryness. Frequent in processed Brazilian lots.',
        'nl':
            'Dry, sweet grass and straw profile. Often indicates early signs of bean aging or specific terroir dryness. Frequent in processed Brazilian lots.',
        'sv':
            'Dry, sweet grass and straw profile. Often indicates early signs of bean aging or specific terroir dryness. Frequent in processed Brazilian lots.',
        'tr':
            'Dry, sweet grass and straw profile. Often indicates early signs of bean aging or specific terroir dryness. Frequent in processed Brazilian lots.',
        'ja':
            'Dry, sweet grass and straw profile. Often indicates early signs of bean aging or specific terroir dryness. Frequent in processed Brazilian lots.',
        'ko':
            'Dry, sweet grass and straw profile. Often indicates early signs of bean aging or specific terroir dryness. Frequent in processed Brazilian lots.',
        'zh':
            'Dry, sweet grass and straw profile. Often indicates early signs of bean aging or specific terroir dryness. Frequent in processed Brazilian lots.',
        'ar':
            'Dry, sweet grass and straw profile. Often indicates early signs of bean aging or specific terroir dryness. Frequent in processed Brazilian lots.',
      },
      'wheel_note_herb_like': {
        'en':
            'Savory herb notes like rosemary or thyme. Correlated with specific volcanic soil profiles. Hallmark of specialty lots from Timor and Bali.',
        'uk':
            'Ноти пряних трав, таких як розмарин або чебрець. Корелює зі специфічними вулканічними ґрунтами. Візитна картка спешелті-лотів з Тімору та Балі.',
        'de':
            'Savory herb notes like rosemary or thyme. Correlated with specific volcanic soil profiles. Hallmark of specialty lots from Timor and Bali.',
        'fr':
            'Savory herb notes like rosemary or thyme. Correlated with specific volcanic soil profiles. Hallmark of specialty lots from Timor and Bali.',
        'es':
            'Savory herb notes like rosemary or thyme. Correlated with specific volcanic soil profiles. Hallmark of specialty lots from Timor and Bali.',
        'it':
            'Savory herb notes like rosemary or thyme. Correlated with specific volcanic soil profiles. Hallmark of specialty lots from Timor and Bali.',
        'pt':
            'Savory herb notes like rosemary or thyme. Correlated with specific volcanic soil profiles. Hallmark of specialty lots from Timor and Bali.',
        'pl':
            'Savory herb notes like rosemary or thyme. Correlated with specific volcanic soil profiles. Hallmark of specialty lots from Timor and Bali.',
        'nl':
            'Savory herb notes like rosemary or thyme. Correlated with specific volcanic soil profiles. Hallmark of specialty lots from Timor and Bali.',
        'sv':
            'Savory herb notes like rosemary or thyme. Correlated with specific volcanic soil profiles. Hallmark of specialty lots from Timor and Bali.',
        'tr':
            'Savory herb notes like rosemary or thyme. Correlated with specific volcanic soil profiles. Hallmark of specialty lots from Timor and Bali.',
        'ja':
            'Savory herb notes like rosemary or thyme. Correlated with specific volcanic soil profiles. Hallmark of specialty lots from Timor and Bali.',
        'ko':
            'Savory herb notes like rosemary or thyme. Correlated with specific volcanic soil profiles. Hallmark of specialty lots from Timor and Bali.',
        'zh':
            'Savory herb notes like rosemary or thyme. Correlated with specific volcanic soil profiles. Hallmark of specialty lots from Timor and Bali.',
        'ar':
            'Savory herb notes like rosemary or thyme. Correlated with specific volcanic soil profiles. Hallmark of specialty lots from Timor and Bali.',
      },
      'wheel_note_sour_aromatics': {
        'en':
            'Tangy and complex acidic scents. Essential for structure in high-grown coffees. Present in almost all high-attribute Central Americans.',
        'uk':
            'Гострі та складні кислі запахи. Важливі для структури високогірної кави. Присутні майже у всіх високопродуктивних лотах з Центральної Америки.',
        'de':
            'Tangy and complex acidic scents. Essential for structure in high-grown coffees. Present in almost all high-attribute Central Americans.',
        'fr':
            'Tangy and complex acidic scents. Essential for structure in high-grown coffees. Present in almost all high-attribute Central Americans.',
        'es':
            'Tangy and complex acidic scents. Essential for structure in high-grown coffees. Present in almost all high-attribute Central Americans.',
        'it':
            'Tangy and complex acidic scents. Essential for structure in high-grown coffees. Present in almost all high-attribute Central Americans.',
        'pt':
            'Tangy and complex acidic scents. Essential for structure in high-grown coffees. Present in almost all high-attribute Central Americans.',
        'pl':
            'Tangy and complex acidic scents. Essential for structure in high-grown coffees. Present in almost all high-attribute Central Americans.',
        'nl':
            'Tangy and complex acidic scents. Essential for structure in high-grown coffees. Present in almost all high-attribute Central Americans.',
        'sv':
            'Tangy and complex acidic scents. Essential for structure in high-grown coffees. Present in almost all high-attribute Central Americans.',
        'tr':
            'Tangy and complex acidic scents. Essential for structure in high-grown coffees. Present in almost all high-attribute Central Americans.',
        'ja':
            'Tangy and complex acidic scents. Essential for structure in high-grown coffees. Present in almost all high-attribute Central Americans.',
        'ko':
            'Tangy and complex acidic scents. Essential for structure in high-grown coffees. Present in almost all high-attribute Central Americans.',
        'zh':
            'Tangy and complex acidic scents. Essential for structure in high-grown coffees. Present in almost all high-attribute Central Americans.',
        'ar':
            'Tangy and complex acidic scents. Essential for structure in high-grown coffees. Present in almost all high-attribute Central Americans.',
      },
      'wheel_note_acetic_acid': {
        'en':
            'Sharp, vinegar-like acidity. Normal at low levels; indicates over-fermentation if aggressive. Found in long-fermented "Funky" Colombian lots.',
        'uk':
            'Гостра, схожа на оцет кислотність. Нормальна при низьких рівнях; вказує на надмірну ферментацію, якщо агресивна. Зустрічається у "Funky" колумбійських лотах тривалої ферментації.',
        'de':
            'Sharp, vinegar-like acidity. Normal at low levels; indicates over-fermentation if aggressive. Found in long-fermented "Funky" Colombian lots.',
        'fr':
            'Sharp, vinegar-like acidity. Normal at low levels; indicates over-fermentation if aggressive. Found in long-fermented "Funky" Colombian lots.',
        'es':
            'Sharp, vinegar-like acidity. Normal at low levels; indicates over-fermentation if aggressive. Found in long-fermented "Funky" Colombian lots.',
        'it':
            'Sharp, vinegar-like acidity. Normal at low levels; indicates over-fermentation if aggressive. Found in long-fermented "Funky" Colombian lots.',
        'pt':
            'Sharp, vinegar-like acidity. Normal at low levels; indicates over-fermentation if aggressive. Found in long-fermented "Funky" Colombian lots.',
        'pl':
            'Sharp, vinegar-like acidity. Normal at low levels; indicates over-fermentation if aggressive. Found in long-fermented "Funky" Colombian lots.',
        'nl':
            'Sharp, vinegar-like acidity. Normal at low levels; indicates over-fermentation if aggressive. Found in long-fermented "Funky" Colombian lots.',
        'sv':
            'Sharp, vinegar-like acidity. Normal at low levels; indicates over-fermentation if aggressive. Found in long-fermented "Funky" Colombian lots.',
        'tr':
            'Sharp, vinegar-like acidity. Normal at low levels; indicates over-fermentation if aggressive. Found in long-fermented "Funky" Colombian lots.',
        'ja':
            'Sharp, vinegar-like acidity. Normal at low levels; indicates over-fermentation if aggressive. Found in long-fermented "Funky" Colombian lots.',
        'ko':
            'Sharp, vinegar-like acidity. Normal at low levels; indicates over-fermentation if aggressive. Found in long-fermented "Funky" Colombian lots.',
        'zh':
            'Sharp, vinegar-like acidity. Normal at low levels; indicates over-fermentation if aggressive. Found in long-fermented "Funky" Colombian lots.',
        'ar':
            'Sharp, vinegar-like acidity. Normal at low levels; indicates over-fermentation if aggressive. Found in long-fermented "Funky" Colombian lots.',
      },
      'wheel_note_butyric_acid': {
        'en':
            'Heady and pungent acid profile reminiscent of Greek yogurt or cheese. Result of intensive metabolic processing. Signature of modern experimental ferments.',
        'uk':
            'П\'янкий та гострий кислотний профіль, що нагадує грецький йогурт або сир. Результат інтенсивної метаболічної обробки. Знакова нота для сучасних експериментальних ферментацій.',
        'de':
            'Heady and pungent acid profile reminiscent of Greek yogurt or cheese. Result of intensive metabolic processing. Signature of modern experimental ferments.',
        'fr':
            'Heady and pungent acid profile reminiscent of Greek yogurt or cheese. Result of intensive metabolic processing. Signature of modern experimental ferments.',
        'es':
            'Heady and pungent acid profile reminiscent of Greek yogurt or cheese. Result of intensive metabolic processing. Signature of modern experimental ferments.',
        'it':
            'Heady and pungent acid profile reminiscent of Greek yogurt or cheese. Result of intensive metabolic processing. Signature of modern experimental ferments.',
        'pt':
            'Heady and pungent acid profile reminiscent of Greek yogurt or cheese. Result of intensive metabolic processing. Signature of modern experimental ferments.',
        'pl':
            'Heady and pungent acid profile reminiscent of Greek yogurt or cheese. Result of intensive metabolic processing. Signature of modern experimental ferments.',
        'nl':
            'Heady and pungent acid profile reminiscent of Greek yogurt or cheese. Result of intensive metabolic processing. Signature of modern experimental ferments.',
        'sv':
            'Heady and pungent acid profile reminiscent of Greek yogurt or cheese. Result of intensive metabolic processing. Signature of modern experimental ferments.',
        'tr':
            'Heady and pungent acid profile reminiscent of Greek yogurt or cheese. Result of intensive metabolic processing. Signature of modern experimental ferments.',
        'ja':
            'Heady and pungent acid profile reminiscent of Greek yogurt or cheese. Result of intensive metabolic processing. Signature of modern experimental ferments.',
        'ko':
            'Heady and pungent acid profile reminiscent of Greek yogurt or cheese. Result of intensive metabolic processing. Signature of modern experimental ferments.',
        'zh':
            'Heady and pungent acid profile reminiscent of Greek yogurt or cheese. Result of intensive metabolic processing. Signature of modern experimental ferments.',
        'ar':
            'Heady and pungent acid profile reminiscent of Greek yogurt or cheese. Result of intensive metabolic processing. Signature of modern experimental ferments.',
      },
      'wheel_note_isovaleric_acid': {
        'en':
            'Strong, cheese-like or sweaty acid note. Characteristic of extremely long anaerobic fermentations. Often polarizing but sought after in modern competitions.',
        'uk':
            'Сильна, схожа на сир або піт кислотна нота. Характерно для надзвичайно тривалих анаеробних ферментацій. Часто викликає суперечки, але цінується на сучасних чемпіонатах.',
        'de':
            'Strong, cheese-like or sweaty acid note. Characteristic of extremely long anaerobic fermentations. Often polarizing but sought after in modern competitions.',
        'fr':
            'Strong, cheese-like or sweaty acid note. Characteristic of extremely long anaerobic fermentations. Often polarizing but sought after in modern competitions.',
        'es':
            'Strong, cheese-like or sweaty acid note. Characteristic of extremely long anaerobic fermentations. Often polarizing but sought after in modern competitions.',
        'it':
            'Strong, cheese-like or sweaty acid note. Characteristic of extremely long anaerobic fermentations. Often polarizing but sought after in modern competitions.',
        'pt':
            'Strong, cheese-like or sweaty acid note. Characteristic of extremely long anaerobic fermentations. Often polarizing but sought after in modern competitions.',
        'pl':
            'Strong, cheese-like or sweaty acid note. Characteristic of extremely long anaerobic fermentations. Often polarizing but sought after in modern competitions.',
        'nl':
            'Strong, cheese-like or sweaty acid note. Characteristic of extremely long anaerobic fermentations. Often polarizing but sought after in modern competitions.',
        'sv':
            'Strong, cheese-like or sweaty acid note. Characteristic of extremely long anaerobic fermentations. Often polarizing but sought after in modern competitions.',
        'tr':
            'Strong, cheese-like or sweaty acid note. Characteristic of extremely long anaerobic fermentations. Often polarizing but sought after in modern competitions.',
        'ja':
            'Strong, cheese-like or sweaty acid note. Characteristic of extremely long anaerobic fermentations. Often polarizing but sought after in modern competitions.',
        'ko':
            'Strong, cheese-like or sweaty acid note. Characteristic of extremely long anaerobic fermentations. Often polarizing but sought after in modern competitions.',
        'zh':
            'Strong, cheese-like or sweaty acid note. Characteristic of extremely long anaerobic fermentations. Often polarizing but sought after in modern competitions.',
        'ar':
            'Strong, cheese-like or sweaty acid note. Characteristic of extremely long anaerobic fermentations. Often polarizing but sought after in modern competitions.',
      },
      'wheel_note_citric_acid': {
        'en':
            'Pure, refreshing and bright acidity. The primary acid in most specialty coffees. Quintessential Kenyan and Colombian profile.',
        'uk':
            'Чиста, освіжаюча та яскрава кислотність. Основна кислота в більшості спешелті-кави. Квінтесенція профілю Кенії та Колумбії.',
        'de':
            'Pure, refreshing and bright acidity. The primary acid in most specialty coffees. Quintessential Kenyan and Colombian profile.',
        'fr':
            'Pure, refreshing and bright acidity. The primary acid in most specialty coffees. Quintessential Kenyan and Colombian profile.',
        'es':
            'Pure, refreshing and bright acidity. The primary acid in most specialty coffees. Quintessential Kenyan and Colombian profile.',
        'it':
            'Pure, refreshing and bright acidity. The primary acid in most specialty coffees. Quintessential Kenyan and Colombian profile.',
        'pt':
            'Pure, refreshing and bright acidity. The primary acid in most specialty coffees. Quintessential Kenyan and Colombian profile.',
        'pl':
            'Pure, refreshing and bright acidity. The primary acid in most specialty coffees. Quintessential Kenyan and Colombian profile.',
        'nl':
            'Pure, refreshing and bright acidity. The primary acid in most specialty coffees. Quintessential Kenyan and Colombian profile.',
        'sv':
            'Pure, refreshing and bright acidity. The primary acid in most specialty coffees. Quintessential Kenyan and Colombian profile.',
        'tr':
            'Pure, refreshing and bright acidity. The primary acid in most specialty coffees. Quintessential Kenyan and Colombian profile.',
        'ja':
            'Pure, refreshing and bright acidity. The primary acid in most specialty coffees. Quintessential Kenyan and Colombian profile.',
        'ko':
            'Pure, refreshing and bright acidity. The primary acid in most specialty coffees. Quintessential Kenyan and Colombian profile.',
        'zh':
            'Pure, refreshing and bright acidity. The primary acid in most specialty coffees. Quintessential Kenyan and Colombian profile.',
        'ar':
            'Pure, refreshing and bright acidity. The primary acid in most specialty coffees. Quintessential Kenyan and Colombian profile.',
      },
      'wheel_note_malic_acid': {
        'en':
            'Crisp and structural acidity that provides body and sweetness. Common in heavy coffee varieties like Bourbon. Hallmarks of Burundian coffees.',
        'uk':
            'Хрустка та структурна кислотність, що забезпечує тіло та солодкість. Поширена у важких сортах кави, таких як Бурбон. Візитна картка кави з Бурунді.',
        'de':
            'Crisp and structural acidity that provides body and sweetness. Common in heavy coffee varieties like Bourbon. Hallmarks of Burundian coffees.',
        'fr':
            'Crisp and structural acidity that provides body and sweetness. Common in heavy coffee varieties like Bourbon. Hallmarks of Burundian coffees.',
        'es':
            'Crisp and structural acidity that provides body and sweetness. Common in heavy coffee varieties like Bourbon. Hallmarks of Burundian coffees.',
        'it':
            'Crisp and structural acidity that provides body and sweetness. Common in heavy coffee varieties like Bourbon. Hallmarks of Burundian coffees.',
        'pt':
            'Crisp and structural acidity that provides body and sweetness. Common in heavy coffee varieties like Bourbon. Hallmarks of Burundian coffees.',
        'pl':
            'Crisp and structural acidity that provides body and sweetness. Common in heavy coffee varieties like Bourbon. Hallmarks of Burundian coffees.',
        'nl':
            'Crisp and structural acidity that provides body and sweetness. Common in heavy coffee varieties like Bourbon. Hallmarks of Burundian coffees.',
        'sv':
            'Crisp and structural acidity that provides body and sweetness. Common in heavy coffee varieties like Bourbon. Hallmarks of Burundian coffees.',
        'tr':
            'Crisp and structural acidity that provides body and sweetness. Common in heavy coffee varieties like Bourbon. Hallmarks of Burundian coffees.',
        'ja':
            'Crisp and structural acidity that provides body and sweetness. Common in heavy coffee varieties like Bourbon. Hallmarks of Burundian coffees.',
        'ko':
            'Crisp and structural acidity that provides body and sweetness. Common in heavy coffee varieties like Bourbon. Hallmarks of Burundian coffees.',
        'zh':
            'Crisp and structural acidity that provides body and sweetness. Common in heavy coffee varieties like Bourbon. Hallmarks of Burundian coffees.',
        'ar':
            'Crisp and structural acidity that provides body and sweetness. Common in heavy coffee varieties like Bourbon. Hallmarks of Burundian coffees.',
      },
      'wheel_note_winey': {
        'en':
            'Heady, fruity acidity reminiscent of red wine. Result of controlled fruit fermentation. Iconic for natural Ethiopians and Colombian anaerobic lots.',
        'uk':
            'П\'янка, фруктова кислотність, що нагадує червоне вино. Результат контрольованої ферментації плодів. Знакова для натуральної Ефіопії та колумбійських анаеробних лотів.',
        'de':
            'Heady, fruity acidity reminiscent of red wine. Result of controlled fruit fermentation. Iconic for natural Ethiopians and Colombian anaerobic lots.',
        'fr':
            'Heady, fruity acidity reminiscent of red wine. Result of controlled fruit fermentation. Iconic for natural Ethiopians and Colombian anaerobic lots.',
        'es':
            'Heady, fruity acidity reminiscent of red wine. Result of controlled fruit fermentation. Iconic for natural Ethiopians and Colombian anaerobic lots.',
        'it':
            'Heady, fruity acidity reminiscent of red wine. Result of controlled fruit fermentation. Iconic for natural Ethiopians and Colombian anaerobic lots.',
        'pt':
            'Heady, fruity acidity reminiscent of red wine. Result of controlled fruit fermentation. Iconic for natural Ethiopians and Colombian anaerobic lots.',
        'pl':
            'Heady, fruity acidity reminiscent of red wine. Result of controlled fruit fermentation. Iconic for natural Ethiopians and Colombian anaerobic lots.',
        'nl':
            'Heady, fruity acidity reminiscent of red wine. Result of controlled fruit fermentation. Iconic for natural Ethiopians and Colombian anaerobic lots.',
        'sv':
            'Heady, fruity acidity reminiscent of red wine. Result of controlled fruit fermentation. Iconic for natural Ethiopians and Colombian anaerobic lots.',
        'tr':
            'Heady, fruity acidity reminiscent of red wine. Result of controlled fruit fermentation. Iconic for natural Ethiopians and Colombian anaerobic lots.',
        'ja':
            'Heady, fruity acidity reminiscent of red wine. Result of controlled fruit fermentation. Iconic for natural Ethiopians and Colombian anaerobic lots.',
        'ko':
            'Heady, fruity acidity reminiscent of red wine. Result of controlled fruit fermentation. Iconic for natural Ethiopians and Colombian anaerobic lots.',
        'zh':
            'Heady, fruity acidity reminiscent of red wine. Result of controlled fruit fermentation. Iconic for natural Ethiopians and Colombian anaerobic lots.',
        'ar':
            'Heady, fruity acidity reminiscent of red wine. Result of controlled fruit fermentation. Iconic for natural Ethiopians and Colombian anaerobic lots.',
      },
      'wheel_note_whiskey': {
        'en':
            'Complex, alcoholic and woody notes. Indicates intense, prolonged fermentation. Typical of experimental "Spirit-process" lots.',
        'uk':
            'Комплексні, алкогольні та деревні ноти. Вказує на інтенсивну, тривалу ферментацію. Типово для експериментальних лотів "Spirit-process".',
        'de':
            'Complex, alcoholic and woody notes. Indicates intense, prolonged fermentation. Typical of experimental "Spirit-process" lots.',
        'fr':
            'Complex, alcoholic and woody notes. Indicates intense, prolonged fermentation. Typical of experimental "Spirit-process" lots.',
        'es':
            'Complex, alcoholic and woody notes. Indicates intense, prolonged fermentation. Typical of experimental "Spirit-process" lots.',
        'it':
            'Complex, alcoholic and woody notes. Indicates intense, prolonged fermentation. Typical of experimental "Spirit-process" lots.',
        'pt':
            'Complex, alcoholic and woody notes. Indicates intense, prolonged fermentation. Typical of experimental "Spirit-process" lots.',
        'pl':
            'Complex, alcoholic and woody notes. Indicates intense, prolonged fermentation. Typical of experimental "Spirit-process" lots.',
        'nl':
            'Complex, alcoholic and woody notes. Indicates intense, prolonged fermentation. Typical of experimental "Spirit-process" lots.',
        'sv':
            'Complex, alcoholic and woody notes. Indicates intense, prolonged fermentation. Typical of experimental "Spirit-process" lots.',
        'tr':
            'Complex, alcoholic and woody notes. Indicates intense, prolonged fermentation. Typical of experimental "Spirit-process" lots.',
        'ja':
            'Complex, alcoholic and woody notes. Indicates intense, prolonged fermentation. Typical of experimental "Spirit-process" lots.',
        'ko':
            'Complex, alcoholic and woody notes. Indicates intense, prolonged fermentation. Typical of experimental "Spirit-process" lots.',
        'zh':
            'Complex, alcoholic and woody notes. Indicates intense, prolonged fermentation. Typical of experimental "Spirit-process" lots.',
        'ar':
            'Complex, alcoholic and woody notes. Indicates intense, prolonged fermentation. Typical of experimental "Spirit-process" lots.',
      },
      'wheel_note_over_ripe': {
        'en':
            'Deep, slightly boozy sweetness of fruit just past its prime. Adds weight to natural processed lots. Common in Brazilian naturals.',
        'uk':
            'Глибока, злегка хмільна солодкість фруктів, що щойно минули пік стиглості. Додає ваги лотам натуральної обробки. Поширено в бразильських натуральних лотах.',
        'de':
            'Deep, slightly boozy sweetness of fruit just past its prime. Adds weight to natural processed lots. Common in Brazilian naturals.',
        'fr':
            'Deep, slightly boozy sweetness of fruit just past its prime. Adds weight to natural processed lots. Common in Brazilian naturals.',
        'es':
            'Deep, slightly boozy sweetness of fruit just past its prime. Adds weight to natural processed lots. Common in Brazilian naturals.',
        'it':
            'Deep, slightly boozy sweetness of fruit just past its prime. Adds weight to natural processed lots. Common in Brazilian naturals.',
        'pt':
            'Deep, slightly boozy sweetness of fruit just past its prime. Adds weight to natural processed lots. Common in Brazilian naturals.',
        'pl':
            'Deep, slightly boozy sweetness of fruit just past its prime. Adds weight to natural processed lots. Common in Brazilian naturals.',
        'nl':
            'Deep, slightly boozy sweetness of fruit just past its prime. Adds weight to natural processed lots. Common in Brazilian naturals.',
        'sv':
            'Deep, slightly boozy sweetness of fruit just past its prime. Adds weight to natural processed lots. Common in Brazilian naturals.',
        'tr':
            'Deep, slightly boozy sweetness of fruit just past its prime. Adds weight to natural processed lots. Common in Brazilian naturals.',
        'ja':
            'Deep, slightly boozy sweetness of fruit just past its prime. Adds weight to natural processed lots. Common in Brazilian naturals.',
        'ko':
            'Deep, slightly boozy sweetness of fruit just past its prime. Adds weight to natural processed lots. Common in Brazilian naturals.',
        'zh':
            'Deep, slightly boozy sweetness of fruit just past its prime. Adds weight to natural processed lots. Common in Brazilian naturals.',
        'ar':
            'Deep, slightly boozy sweetness of fruit just past its prime. Adds weight to natural processed lots. Common in Brazilian naturals.',
      },
      'wheel_note_rubber': {
        'en':
            'Dense, pungent note often associated with the genetics of Robusta. Can appear in some intense Brazilian clones. Rare in Arabica.',
        'uk':
            'Щільна, гостра нота, що часто асоціюється з генетикою робусти. Може з\'являтися у деяких інтенсивних бразильських клонах. Рідко зустрічається в арабіці.',
        'de':
            'Dense, pungent note often associated with the genetics of Robusta. Can appear in some intense Brazilian clones. Rare in Arabica.',
        'fr':
            'Dense, pungent note often associated with the genetics of Robusta. Can appear in some intense Brazilian clones. Rare in Arabica.',
        'es':
            'Dense, pungent note often associated with the genetics of Robusta. Can appear in some intense Brazilian clones. Rare in Arabica.',
        'it':
            'Dense, pungent note often associated with the genetics of Robusta. Can appear in some intense Brazilian clones. Rare in Arabica.',
        'pt':
            'Dense, pungent note often associated with the genetics of Robusta. Can appear in some intense Brazilian clones. Rare in Arabica.',
        'pl':
            'Dense, pungent note often associated with the genetics of Robusta. Can appear in some intense Brazilian clones. Rare in Arabica.',
        'nl':
            'Dense, pungent note often associated with the genetics of Robusta. Can appear in some intense Brazilian clones. Rare in Arabica.',
        'sv':
            'Dense, pungent note often associated with the genetics of Robusta. Can appear in some intense Brazilian clones. Rare in Arabica.',
        'tr':
            'Dense, pungent note often associated with the genetics of Robusta. Can appear in some intense Brazilian clones. Rare in Arabica.',
        'ja':
            'Dense, pungent note often associated with the genetics of Robusta. Can appear in some intense Brazilian clones. Rare in Arabica.',
        'ko':
            'Dense, pungent note often associated with the genetics of Robusta. Can appear in some intense Brazilian clones. Rare in Arabica.',
        'zh':
            'Dense, pungent note often associated with the genetics of Robusta. Can appear in some intense Brazilian clones. Rare in Arabica.',
        'ar':
            'Dense, pungent note often associated with the genetics of Robusta. Can appear in some intense Brazilian clones. Rare in Arabica.',
      },
      'wheel_note_petroleum': {
        'en':
            'Sharp, industrial aromatic note. Usually indicates contamination or major storage faults. Unacceptable in specialty coffee.',
        'uk':
            'Гостра, технічна ароматна нота. Зазвичай вказує на забруднення або серйозні помилки зберігання. Неприпустимо для спешелті-кави.',
        'de':
            'Sharp, industrial aromatic note. Usually indicates contamination or major storage faults. Unacceptable in specialty coffee.',
        'fr':
            'Sharp, industrial aromatic note. Usually indicates contamination or major storage faults. Unacceptable in specialty coffee.',
        'es':
            'Sharp, industrial aromatic note. Usually indicates contamination or major storage faults. Unacceptable in specialty coffee.',
        'it':
            'Sharp, industrial aromatic note. Usually indicates contamination or major storage faults. Unacceptable in specialty coffee.',
        'pt':
            'Sharp, industrial aromatic note. Usually indicates contamination or major storage faults. Unacceptable in specialty coffee.',
        'pl':
            'Sharp, industrial aromatic note. Usually indicates contamination or major storage faults. Unacceptable in specialty coffee.',
        'nl':
            'Sharp, industrial aromatic note. Usually indicates contamination or major storage faults. Unacceptable in specialty coffee.',
        'sv':
            'Sharp, industrial aromatic note. Usually indicates contamination or major storage faults. Unacceptable in specialty coffee.',
        'tr':
            'Sharp, industrial aromatic note. Usually indicates contamination or major storage faults. Unacceptable in specialty coffee.',
        'ja':
            'Sharp, industrial aromatic note. Usually indicates contamination or major storage faults. Unacceptable in specialty coffee.',
        'ko':
            'Sharp, industrial aromatic note. Usually indicates contamination or major storage faults. Unacceptable in specialty coffee.',
        'zh':
            'Sharp, industrial aromatic note. Usually indicates contamination or major storage faults. Unacceptable in specialty coffee.',
        'ar':
            'Sharp, industrial aromatic note. Usually indicates contamination or major storage faults. Unacceptable in specialty coffee.',
      },
      'wheel_note_medicinal': {
        'en':
            'Iodine or phenol-like scent. Often result of water-borne pathogens during processing. Indicator of poor quality control.',
        'uk':
            'Запах йоду або фенолу. Часто є результатом дії патогенів у воді під час обробки. Індикатор низького контролю якості.',
        'de':
            'Iodine or phenol-like scent. Often result of water-borne pathogens during processing. Indicator of poor quality control.',
        'fr':
            'Iodine or phenol-like scent. Often result of water-borne pathogens during processing. Indicator of poor quality control.',
        'es':
            'Iodine or phenol-like scent. Often result of water-borne pathogens during processing. Indicator of poor quality control.',
        'it':
            'Iodine or phenol-like scent. Often result of water-borne pathogens during processing. Indicator of poor quality control.',
        'pt':
            'Iodine or phenol-like scent. Often result of water-borne pathogens during processing. Indicator of poor quality control.',
        'pl':
            'Iodine or phenol-like scent. Often result of water-borne pathogens during processing. Indicator of poor quality control.',
        'nl':
            'Iodine or phenol-like scent. Often result of water-borne pathogens during processing. Indicator of poor quality control.',
        'sv':
            'Iodine or phenol-like scent. Often result of water-borne pathogens during processing. Indicator of poor quality control.',
        'tr':
            'Iodine or phenol-like scent. Often result of water-borne pathogens during processing. Indicator of poor quality control.',
        'ja':
            'Iodine or phenol-like scent. Often result of water-borne pathogens during processing. Indicator of poor quality control.',
        'ko':
            'Iodine or phenol-like scent. Often result of water-borne pathogens during processing. Indicator of poor quality control.',
        'zh':
            'Iodine or phenol-like scent. Often result of water-borne pathogens during processing. Indicator of poor quality control.',
        'ar':
            'Iodine or phenol-like scent. Often result of water-borne pathogens during processing. Indicator of poor quality control.',
      },
      'wheel_note_stale': {
        'en':
            'Flat, dull profile lacking aromatics. Direct indicator of oxidation and lack of freshness. Common in old warehouse stocks.',
        'uk':
            'Плоский, тьмяний профіль без ароматики. Прямий індикатор окислення та відсутності свіжості. Часто зустрічається на старих складських залишках.',
        'de':
            'Flat, dull profile lacking aromatics. Direct indicator of oxidation and lack of freshness. Common in old warehouse stocks.',
        'fr':
            'Flat, dull profile lacking aromatics. Direct indicator of oxidation and lack of freshness. Common in old warehouse stocks.',
        'es':
            'Flat, dull profile lacking aromatics. Direct indicator of oxidation and lack of freshness. Common in old warehouse stocks.',
        'it':
            'Flat, dull profile lacking aromatics. Direct indicator of oxidation and lack of freshness. Common in old warehouse stocks.',
        'pt':
            'Flat, dull profile lacking aromatics. Direct indicator of oxidation and lack of freshness. Common in old warehouse stocks.',
        'pl':
            'Flat, dull profile lacking aromatics. Direct indicator of oxidation and lack of freshness. Common in old warehouse stocks.',
        'nl':
            'Flat, dull profile lacking aromatics. Direct indicator of oxidation and lack of freshness. Common in old warehouse stocks.',
        'sv':
            'Flat, dull profile lacking aromatics. Direct indicator of oxidation and lack of freshness. Common in old warehouse stocks.',
        'tr':
            'Flat, dull profile lacking aromatics. Direct indicator of oxidation and lack of freshness. Common in old warehouse stocks.',
        'ja':
            'Flat, dull profile lacking aromatics. Direct indicator of oxidation and lack of freshness. Common in old warehouse stocks.',
        'ko':
            'Flat, dull profile lacking aromatics. Direct indicator of oxidation and lack of freshness. Common in old warehouse stocks.',
        'zh':
            'Flat, dull profile lacking aromatics. Direct indicator of oxidation and lack of freshness. Common in old warehouse stocks.',
        'ar':
            'Flat, dull profile lacking aromatics. Direct indicator of oxidation and lack of freshness. Common in old warehouse stocks.',
      },
      'wheel_note_musty': {
        'en':
            'Damp and earthy fault associated with moisture damage. Result of fungal growth during drying. Defect associated with poor processing.',
        'uk':
            'Вологий та землистий дефект, пов\'язаний пошкодженням вологою. Результат росту грибків під час сушіння. Дефект, пов\'язаний з поганою обробкою.',
        'de':
            'Damp and earthy fault associated with moisture damage. Result of fungal growth during drying. Defect associated with poor processing.',
        'fr':
            'Damp and earthy fault associated with moisture damage. Result of fungal growth during drying. Defect associated with poor processing.',
        'es':
            'Damp and earthy fault associated with moisture damage. Result of fungal growth during drying. Defect associated with poor processing.',
        'it':
            'Damp and earthy fault associated with moisture damage. Result of fungal growth during drying. Defect associated with poor processing.',
        'pt':
            'Damp and earthy fault associated with moisture damage. Result of fungal growth during drying. Defect associated with poor processing.',
        'pl':
            'Damp and earthy fault associated with moisture damage. Result of fungal growth during drying. Defect associated with poor processing.',
        'nl':
            'Damp and earthy fault associated with moisture damage. Result of fungal growth during drying. Defect associated with poor processing.',
        'sv':
            'Damp and earthy fault associated with moisture damage. Result of fungal growth during drying. Defect associated with poor processing.',
        'tr':
            'Damp and earthy fault associated with moisture damage. Result of fungal growth during drying. Defect associated with poor processing.',
        'ja':
            'Damp and earthy fault associated with moisture damage. Result of fungal growth during drying. Defect associated with poor processing.',
        'ko':
            'Damp and earthy fault associated with moisture damage. Result of fungal growth during drying. Defect associated with poor processing.',
        'zh':
            'Damp and earthy fault associated with moisture damage. Result of fungal growth during drying. Defect associated with poor processing.',
        'ar':
            'Damp and earthy fault associated with moisture damage. Result of fungal growth during drying. Defect associated with poor processing.',
      },
      'wheel_note_dusty': {
        'en':
            'Dry, mineral-like flatness. Often indicates improper cleaning of the lot or exposure to fine particulates. Found in lower-grade commercial lots.',
        'uk':
            'Суха, мінеральна плоскість. Часто вказує на неналежне очищення лоту або вплив дрібних часток. Зустрічається у комерційних лотах нижчого сорту.',
        'de':
            'Dry, mineral-like flatness. Often indicates improper cleaning of the lot or exposure to fine particulates. Found in lower-grade commercial lots.',
        'fr':
            'Dry, mineral-like flatness. Often indicates improper cleaning of the lot or exposure to fine particulates. Found in lower-grade commercial lots.',
        'es':
            'Dry, mineral-like flatness. Often indicates improper cleaning of the lot or exposure to fine particulates. Found in lower-grade commercial lots.',
        'it':
            'Dry, mineral-like flatness. Often indicates improper cleaning of the lot or exposure to fine particulates. Found in lower-grade commercial lots.',
        'pt':
            'Dry, mineral-like flatness. Often indicates improper cleaning of the lot or exposure to fine particulates. Found in lower-grade commercial lots.',
        'pl':
            'Dry, mineral-like flatness. Often indicates improper cleaning of the lot or exposure to fine particulates. Found in lower-grade commercial lots.',
        'nl':
            'Dry, mineral-like flatness. Often indicates improper cleaning of the lot or exposure to fine particulates. Found in lower-grade commercial lots.',
        'sv':
            'Dry, mineral-like flatness. Often indicates improper cleaning of the lot or exposure to fine particulates. Found in lower-grade commercial lots.',
        'tr':
            'Dry, mineral-like flatness. Often indicates improper cleaning of the lot or exposure to fine particulates. Found in lower-grade commercial lots.',
        'ja':
            'Dry, mineral-like flatness. Often indicates improper cleaning of the lot or exposure to fine particulates. Found in lower-grade commercial lots.',
        'ko':
            'Dry, mineral-like flatness. Often indicates improper cleaning of the lot or exposure to fine particulates. Found in lower-grade commercial lots.',
        'zh':
            'Dry, mineral-like flatness. Often indicates improper cleaning of the lot or exposure to fine particulates. Found in lower-grade commercial lots.',
        'ar':
            'Dry, mineral-like flatness. Often indicates improper cleaning of the lot or exposure to fine particulates. Found in lower-grade commercial lots.',
      },
    };

    return descriptions[key]?[locale] ??
        descriptions[key]?['en'] ??
        (locale == 'uk'
            ? 'Опис скоро з\'явиться...'
            : 'Description coming soon...');
  }
}
