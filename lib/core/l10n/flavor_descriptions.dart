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
        'de': 'Noten von Schokolade und Nüssen.',
        'fr': 'Notes de chocolat et de noisettes.',
        'es': 'Notas de chocolate y frutos secos.',
        'it': 'Note di cioccolato e frutta a guscio.',
        'pt': 'Notas de chocolate e nozes.',
        'pl': 'Nuty czekolady i orzechów.',
        'nl': 'Tonen van chocolade en noten.',
        'sv': 'Toner av choklad och nötter.',
        'tr': 'Çikolata ve fındık notaları.',
        'ja': 'チョコレートやナッツのノート。',
        'ko': '초콜릿과 견과류의 노트입니다.',
        'zh': '巧克力和坚果的味道。',
        'ar': 'نكهات الشوكولاتة والمكسرات.',
      },
      'wheel_cat_sweet': {
        'en':
            'The foundational sweetness in coffee, ranging from white sugar to complex molasses. It comes from the breakdown of carbohydrates during roasting. Present in almost all balanced, specialty coffees.',
        'uk':
            'Основна солодкість кави, від білого цукру до складних патокових відтінків. Вона походить від розпаду вуглеводів під час обсмажування. Присутня майже у всій збалансованій спешелті-каві.',
        'de': 'Süße Aromen von Zucker bis Karamell.',
        'fr': 'Arômes sucrés allant du sucre au caramel.',
        'es': 'Aromas dulces que van desde el azúcar hasta el caramelo.',
        'it': 'Aromi dolci che vanno dallo zucchero al caramello.',
        'pt': 'Aromas doces que variam do açúcar ao caramelo.',
        'pl': 'Słodkie aromaty od cukru po karmel.',
        'nl': 'Zoete aroma\'s variërend van suiker tot karamel.',
        'sv': 'Söta aromer från socker till karamell.',
        'tr': 'Şekerden karamele kadar tatlı aromalar.',
        'ja': '砂糖からキャラメルまでの甘いアロマ。',
        'ko': '설탕에서 카라멜에 이르는 달콤한 향입니다.',
        'zh': '从糖到焦糖的甜味香气。',
        'ar': 'نكهات حلوة تتراوح من السكر إلى الكراميل.',
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
        'de': 'Reiche Schokoladen- und Kakaoaromen.',
        'fr': 'Riches arômes de chocolat et de cacao.',
        'es': 'Ricos aromas de chocolate y cacao.',
        'it': 'Ricchi aromi di cioccolato e cacao.',
        'pt': 'Ricos aromas de chocolate e cacau.',
        'pl':
            'Deep, dark chocolate profiles. Emerges during prolonged development in the roast. Quintessential Brazil and Indian Monsoon Malabar notes.',
        'nl': 'Rijke chocolade- en cacao-aroma\'s.',
        'sv': 'Richa choklad- och kakaoaromer.',
        'tr': 'Zengin çikolata ve kakao aromaları.',
        'ja':
            'Deep, dark chocolate profiles. Emerges during prolonged development in the roast. Quintessential Brazil and Indian Monsoon Malabar notes.',
        'ko': '풍부한 초콜릿과 코코아 향입니다.',
        'zh':
            'Deep, dark chocolate profiles. Emerges during prolonged development in the roast. Quintessential Brazil and Indian Monsoon Malabar notes.',
        'ar': 'نكهات شوكولاتة وكاكاو غنية.',
      },
      'wheel_sub_nutty': {
        'en':
            'Earthy and savory notes of roasted nuts. Comes from amino acids reacting with sugars. Found in Classic South American profiles.',
        'uk':
            'Землисті та пікантні ноти смажених горіхів. Походять від реакції амінокислот із цукрами. Зустрічаються в класичних південноамериканських профілях.',
        'de': 'Aromen von gerösteten Nüssen.',
        'fr': 'Arômes de fruits secs torréfiés.',
        'es': 'Aromas de frutos secos tostados.',
        'it': 'Aromi di frutta a guscio tostata.',
        'pt': 'Aromas de nozes torradas.',
        'pl':
            'Earthy and savory notes of roasted nuts. Comes from amino acids reacting with sugars. Found in Classic South American profiles.',
        'nl': 'Aroma\'s van geroosterde noten.',
        'sv': 'Aromer av rostade nötter.',
        'tr': 'Kavrulmuş fındık aromaları.',
        'ja':
            'Earthy and savory notes of roasted nuts. Comes from amino acids reacting with sugars. Found in Classic South American profiles.',
        'ko': '구운 견과류의 향입니다.',
        'zh':
            'Earthy and savory notes of roasted nuts. Comes from amino acids reacting with sugars. Found in Classic South American profiles.',
        'ar': 'نكهات مكسرات محمصة.',
      },
      'wheel_sub_sugar_brown': {
        'en':
            'Rich caramel and syrup sweetness. The result of complex sugar browning. Universal in well-roasted medium profiles.',
        'uk':
            'Багата карамельна та сиропна солодкість. Результат складного карамелізації цукрів. Універсальна нота для добре обсмажених середніх профілів.',
        'de':
            'Rich caramel and syrup sweetness. The result of complex sugar browning. Universal in well-roasted medium profiles.',
        'fr':
            'Rich caramel and syrup sweetness. The result of complex sugar browning. Universal in well-roasted medium profiles.',
        'es':
            'Rich caramel and syrup sweetness. The result of complex sugar browning. Universal in well-roasted medium profiles.',
        'it':
            'Rich caramel and syrup sweetness. The result of complex sugar browning. Universal in well-roasted medium profiles.',
        'pt':
            'Rich caramel and syrup sweetness. The result of complex sugar browning. Universal in well-roasted medium profiles.',
        'pl':
            'Rich caramel and syrup sweetness. The result of complex sugar browning. Universal in well-roasted medium profiles.',
        'nl':
            'Rich caramel and syrup sweetness. The result of complex sugar browning. Universal in well-roasted medium profiles.',
        'sv':
            'Rich caramel and syrup sweetness. The result of complex sugar browning. Universal in well-roasted medium profiles.',
        'tr':
            'Rich caramel and syrup sweetness. The result of complex sugar browning. Universal in well-roasted medium profiles.',
        'ja':
            'Rich caramel and syrup sweetness. The result of complex sugar browning. Universal in well-roasted medium profiles.',
        'ko':
            'Rich caramel and syrup sweetness. The result of complex sugar browning. Universal in well-roasted medium profiles.',
        'zh':
            'Rich caramel and syrup sweetness. The result of complex sugar browning. Universal in well-roasted medium profiles.',
        'ar':
            'Rich caramel and syrup sweetness. The result of complex sugar browning. Universal in well-roasted medium profiles.',
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
            'Fragrant, comforting scents like vanilla or spice. Derived from late-stage Maillard reactions. Typical of high-quality Arabicas from Central America.',
        'fr':
            'Fragrant, comforting scents like vanilla or spice. Derived from late-stage Maillard reactions. Typical of high-quality Arabicas from Central America.',
        'es':
            'Fragrant, comforting scents like vanilla or spice. Derived from late-stage Maillard reactions. Typical of high-quality Arabicas from Central America.',
        'it':
            'Fragrant, comforting scents like vanilla or spice. Derived from late-stage Maillard reactions. Typical of high-quality Arabicas from Central America.',
        'pt':
            'Fragrant, comforting scents like vanilla or spice. Derived from late-stage Maillard reactions. Typical of high-quality Arabicas from Central America.',
        'pl':
            'Fragrant, comforting scents like vanilla or spice. Derived from late-stage Maillard reactions. Typical of high-quality Arabicas from Central America.',
        'nl':
            'Fragrant, comforting scents like vanilla or spice. Derived from late-stage Maillard reactions. Typical of high-quality Arabicas from Central America.',
        'sv':
            'Fragrant, comforting scents like vanilla or spice. Derived from late-stage Maillard reactions. Typical of high-quality Arabicas from Central America.',
        'tr':
            'Fragrant, comforting scents like vanilla or spice. Derived from late-stage Maillard reactions. Typical of high-quality Arabicas from Central America.',
        'ja':
            'Fragrant, comforting scents like vanilla or spice. Derived from late-stage Maillard reactions. Typical of high-quality Arabicas from Central America.',
        'ko':
            'Fragrant, comforting scents like vanilla or spice. Derived from late-stage Maillard reactions. Typical of high-quality Arabicas from Central America.',
        'zh':
            'Fragrant, comforting scents like vanilla or spice. Derived from late-stage Maillard reactions. Typical of high-quality Arabicas from Central America.',
        'ar':
            'Fragrant, comforting scents like vanilla or spice. Derived from late-stage Maillard reactions. Typical of high-quality Arabicas from Central America.',
      },
      'wheel_sub_brown_spice': {
        'en':
            'Warm, sweet spice notes that develop as sugars caramelize. Rich in phenolic compounds. Characteristic of Sumatran and Rwandan coffees.',
        'uk':
            'Теплі, солодкі пряні ноти, що розвиваються при карамелізації цукрів. Багаті на фенольні сполуки. Характерно для суматранської та руандійської кави.',
        'de':
            'Warm, sweet spice notes that develop as sugars caramelize. Rich in phenolic compounds. Characteristic of Sumatran and Rwandan coffees.',
        'fr':
            'Warm, sweet spice notes that develop as sugars caramelize. Rich in phenolic compounds. Characteristic of Sumatran and Rwandan coffees.',
        'es':
            'Warm, sweet spice notes that develop as sugars caramelize. Rich in phenolic compounds. Characteristic of Sumatran and Rwandan coffees.',
        'it':
            'Warm, sweet spice notes that develop as sugars caramelize. Rich in phenolic compounds. Characteristic of Sumatran and Rwandan coffees.',
        'pt':
            'Warm, sweet spice notes that develop as sugars caramelize. Rich in phenolic compounds. Characteristic of Sumatran and Rwandan coffees.',
        'pl':
            'Warm, sweet spice notes that develop as sugars caramelize. Rich in phenolic compounds. Characteristic of Sumatran and Rwandan coffees.',
        'nl':
            'Warm, sweet spice notes that develop as sugars caramelize. Rich in phenolic compounds. Characteristic of Sumatran and Rwandan coffees.',
        'sv':
            'Warm, sweet spice notes that develop as sugars caramelize. Rich in phenolic compounds. Characteristic of Sumatran and Rwandan coffees.',
        'tr':
            'Warm, sweet spice notes that develop as sugars caramelize. Rich in phenolic compounds. Characteristic of Sumatran and Rwandan coffees.',
        'ja':
            'Warm, sweet spice notes that develop as sugars caramelize. Rich in phenolic compounds. Characteristic of Sumatran and Rwandan coffees.',
        'ko':
            'Warm, sweet spice notes that develop as sugars caramelize. Rich in phenolic compounds. Characteristic of Sumatran and Rwandan coffees.',
        'zh':
            'Warm, sweet spice notes that develop as sugars caramelize. Rich in phenolic compounds. Characteristic of Sumatran and Rwandan coffees.',
        'ar':
            'Warm, sweet spice notes that develop as sugars caramelize. Rich in phenolic compounds. Characteristic of Sumatran and Rwandan coffees.',
      },
      'wheel_sub_cereal': {
        'en':
            'Toasted grain and bread-like notes. Indicative of early roast stages or specific bean density. Common in many Brazilian and Indian lots.',
        'uk':
            'Ноти підсмаженого зерна та хліба. Вказують на ранні стадії обсмажування або специфічну щільність зерна. Зустрічається в багатьох бразильських та індійських лотах.',
        'de':
            'Toasted grain and bread-like notes. Indicative of early roast stages or specific bean density. Common in many Brazilian and Indian lots.',
        'fr':
            'Toasted grain and bread-like notes. Indicative of early roast stages or specific bean density. Common in many Brazilian and Indian lots.',
        'es':
            'Toasted grain and bread-like notes. Indicative of early roast stages or specific bean density. Common in many Brazilian and Indian lots.',
        'it':
            'Toasted grain and bread-like notes. Indicative of early roast stages or specific bean density. Common in many Brazilian and Indian lots.',
        'pt':
            'Toasted grain and bread-like notes. Indicative of early roast stages or specific bean density. Common in many Brazilian and Indian lots.',
        'pl':
            'Toasted grain and bread-like notes. Indicative of early roast stages or specific bean density. Common in many Brazilian and Indian lots.',
        'nl':
            'Toasted grain and bread-like notes. Indicative of early roast stages or specific bean density. Common in many Brazilian and Indian lots.',
        'sv':
            'Toasted grain and bread-like notes. Indicative of early roast stages or specific bean density. Common in many Brazilian and Indian lots.',
        'tr':
            'Toasted grain and bread-like notes. Indicative of early roast stages or specific bean density. Common in many Brazilian and Indian lots.',
        'ja':
            'Toasted grain and bread-like notes. Indicative of early roast stages or specific bean density. Common in many Brazilian and Indian lots.',
        'ko':
            'Toasted grain and bread-like notes. Indicative of early roast stages or specific bean density. Common in many Brazilian and Indian lots.',
        'zh':
            'Toasted grain and bread-like notes. Indicative of early roast stages or specific bean density. Common in many Brazilian and Indian lots.',
        'ar':
            'Toasted grain and bread-like notes. Indicative of early roast stages or specific bean density. Common in many Brazilian and Indian lots.',
      },
      'wheel_sub_burnt': {
        'en':
            'Intense smoky or carbonized notes. Result of high-temperature pyrolysis during roasting. Hallmarks of dark roast profiles.',
        'uk':
            'Інтенсивні димні або обвуглені ноти. Результат високотемпературного піролізу під час обсмажування. Візитна картка профілів темного обсмаження.',
        'de':
            'Intense smoky or carbonized notes. Result of high-temperature pyrolysis during roasting. Hallmarks of dark roast profiles.',
        'fr':
            'Intense smoky or carbonized notes. Result of high-temperature pyrolysis during roasting. Hallmarks of dark roast profiles.',
        'es':
            'Intense smoky or carbonized notes. Result of high-temperature pyrolysis during roasting. Hallmarks of dark roast profiles.',
        'it':
            'Intense smoky or carbonized notes. Result of high-temperature pyrolysis during roasting. Hallmarks of dark roast profiles.',
        'pt':
            'Intense smoky or carbonized notes. Result of high-temperature pyrolysis during roasting. Hallmarks of dark roast profiles.',
        'pl':
            'Intense smoky or carbonized notes. Result of high-temperature pyrolysis during roasting. Hallmarks of dark roast profiles.',
        'nl':
            'Intense smoky or carbonized notes. Result of high-temperature pyrolysis during roasting. Hallmarks of dark roast profiles.',
        'sv':
            'Intense smoky or carbonized notes. Result of high-temperature pyrolysis during roasting. Hallmarks of dark roast profiles.',
        'tr':
            'Intense smoky or carbonized notes. Result of high-temperature pyrolysis during roasting. Hallmarks of dark roast profiles.',
        'ja':
            'Intense smoky or carbonized notes. Result of high-temperature pyrolysis during roasting. Hallmarks of dark roast profiles.',
        'ko':
            'Intense smoky or carbonized notes. Result of high-temperature pyrolysis during roasting. Hallmarks of dark roast profiles.',
        'zh':
            'Intense smoky or carbonized notes. Result of high-temperature pyrolysis during roasting. Hallmarks of dark roast profiles.',
        'ar':
            'Intense smoky or carbonized notes. Result of high-temperature pyrolysis during roasting. Hallmarks of dark roast profiles.',
      },
      'wheel_sub_green_vegetative': {
        'en':
            'Herbal and grassy notes associated with fresh plant matter. Can reflect terroir or light roasting. Typical of under-developed high-density beans.',
        'uk':
            'Трав\'янисті та злакові ноти, пов\'язані зі свіжою рослинною матерією. Можуть відображати терруар або світле обсмаження. Типово для недорозвинених щільних зерен.',
        'de':
            'Herbal and grassy notes associated with fresh plant matter. Can reflect terroir or light roasting. Typical of under-developed high-density beans.',
        'fr':
            'Herbal and grassy notes associated with fresh plant matter. Can reflect terroir or light roasting. Typical of under-developed high-density beans.',
        'es':
            'Herbal and grassy notes associated with fresh plant matter. Can reflect terroir or light roasting. Typical of under-developed high-density beans.',
        'it':
            'Herbal and grassy notes associated with fresh plant matter. Can reflect terroir or light roasting. Typical of under-developed high-density beans.',
        'pt':
            'Herbal and grassy notes associated with fresh plant matter. Can reflect terroir or light roasting. Typical of under-developed high-density beans.',
        'pl':
            'Herbal and grassy notes associated with fresh plant matter. Can reflect terroir or light roasting. Typical of under-developed high-density beans.',
        'nl':
            'Herbal and grassy notes associated with fresh plant matter. Can reflect terroir or light roasting. Typical of under-developed high-density beans.',
        'sv':
            'Herbal and grassy notes associated with fresh plant matter. Can reflect terroir or light roasting. Typical of under-developed high-density beans.',
        'tr':
            'Herbal and grassy notes associated with fresh plant matter. Can reflect terroir or light roasting. Typical of under-developed high-density beans.',
        'ja':
            'Herbal and grassy notes associated with fresh plant matter. Can reflect terroir or light roasting. Typical of under-developed high-density beans.',
        'ko':
            'Herbal and grassy notes associated with fresh plant matter. Can reflect terroir or light roasting. Typical of under-developed high-density beans.',
        'zh':
            'Herbal and grassy notes associated with fresh plant matter. Can reflect terroir or light roasting. Typical of under-developed high-density beans.',
        'ar':
            'Herbal and grassy notes associated with fresh plant matter. Can reflect terroir or light roasting. Typical of under-developed high-density beans.',
      },
      'wheel_sub_chemical': {
        'en':
            'Pungent or medicinal notes often resulting from processing defects or improper storage. Rare in specialty lots.',
        'uk':
            'Гострі або аптечні ноти, що часто є результатом дефектів обробки або неправильного зберігання. Рідко зустрічаються в спешелті-лотах.',
        'de':
            'Pungent or medicinal notes often resulting from processing defects or improper storage. Rare in specialty lots.',
        'fr':
            'Pungent or medicinal notes often resulting from processing defects or improper storage. Rare in specialty lots.',
        'es':
            'Pungent or medicinal notes often resulting from processing defects or improper storage. Rare in specialty lots.',
        'it':
            'Pungent or medicinal notes often resulting from processing defects or improper storage. Rare in specialty lots.',
        'pt':
            'Pungent or medicinal notes often resulting from processing defects or improper storage. Rare in specialty lots.',
        'pl':
            'Pungent or medicinal notes often resulting from processing defects or improper storage. Rare in specialty lots.',
        'nl':
            'Pungent or medicinal notes often resulting from processing defects or improper storage. Rare in specialty lots.',
        'sv':
            'Pungent or medicinal notes often resulting from processing defects or improper storage. Rare in specialty lots.',
        'tr':
            'Pungent or medicinal notes often resulting from processing defects or improper storage. Rare in specialty lots.',
        'ja':
            'Pungent or medicinal notes often resulting from processing defects or improper storage. Rare in specialty lots.',
        'ko':
            'Pungent or medicinal notes often resulting from processing defects or improper storage. Rare in specialty lots.',
        'zh':
            'Pungent or medicinal notes often resulting from processing defects or improper storage. Rare in specialty lots.',
        'ar':
            'Pungent or medicinal notes often resulting from processing defects or improper storage. Rare in specialty lots.',
      },
      'wheel_sub_papery': {
        'en':
            'Dry, woody or stale notes reminiscent of cardboard. Often indicates old-crop beans or moisture loss during storage.',
        'uk':
            'Сухі, деревні або залежалі ноти, що нагадують картон. Часто вказує на старий врожай або втрату вологи під час зберігання.',
        'de':
            'Dry, woody or stale notes reminiscent of cardboard. Often indicates old-crop beans or moisture loss during storage.',
        'fr':
            'Dry, woody or stale notes reminiscent of cardboard. Often indicates old-crop beans or moisture loss during storage.',
        'es':
            'Dry, woody or stale notes reminiscent of cardboard. Often indicates old-crop beans or moisture loss during storage.',
        'it':
            'Dry, woody or stale notes reminiscent of cardboard. Often indicates old-crop beans or moisture loss during storage.',
        'pt':
            'Dry, woody or stale notes reminiscent of cardboard. Often indicates old-crop beans or moisture loss during storage.',
        'pl':
            'Dry, woody or stale notes reminiscent of cardboard. Often indicates old-crop beans or moisture loss during storage.',
        'nl':
            'Dry, woody or stale notes reminiscent of cardboard. Often indicates old-crop beans or moisture loss during storage.',
        'sv':
            'Dry, woody or stale notes reminiscent of cardboard. Often indicates old-crop beans or moisture loss during storage.',
        'tr':
            'Dry, woody or stale notes reminiscent of cardboard. Often indicates old-crop beans or moisture loss during storage.',
        'ja':
            'Dry, woody or stale notes reminiscent of cardboard. Often indicates old-crop beans or moisture loss during storage.',
        'ko':
            'Dry, woody or stale notes reminiscent of cardboard. Often indicates old-crop beans or moisture loss during storage.',
        'zh':
            'Dry, woody or stale notes reminiscent of cardboard. Often indicates old-crop beans or moisture loss during storage.',
        'ar':
            'Dry, woody or stale notes reminiscent of cardboard. Often indicates old-crop beans or moisture loss during storage.',
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
            'Intensely floral and perfume-like aroma. Linked to high concentrations of linalool. The definitive note of Panamanian and Ethiopian Geshas.',
        'fr':
            'Intensely floral and perfume-like aroma. Linked to high concentrations of linalool. The definitive note of Panamanian and Ethiopian Geshas.',
        'es':
            'Intensely floral and perfume-like aroma. Linked to high concentrations of linalool. The definitive note of Panamanian and Ethiopian Geshas.',
        'it':
            'Intensely floral and perfume-like aroma. Linked to high concentrations of linalool. The definitive note of Panamanian and Ethiopian Geshas.',
        'pt':
            'Intensely floral and perfume-like aroma. Linked to high concentrations of linalool. The definitive note of Panamanian and Ethiopian Geshas.',
        'pl':
            'Intensely floral and perfume-like aroma. Linked to high concentrations of linalool. The definitive note of Panamanian and Ethiopian Geshas.',
        'nl':
            'Intensely floral and perfume-like aroma. Linked to high concentrations of linalool. The definitive note of Panamanian and Ethiopian Geshas.',
        'sv':
            'Intensely floral and perfume-like aroma. Linked to high concentrations of linalool. The definitive note of Panamanian and Ethiopian Geshas.',
        'tr':
            'Intensely floral and perfume-like aroma. Linked to high concentrations of linalool. The definitive note of Panamanian and Ethiopian Geshas.',
        'ja':
            'Intensely floral and perfume-like aroma. Linked to high concentrations of linalool. The definitive note of Panamanian and Ethiopian Geshas.',
        'ko':
            'Intensely floral and perfume-like aroma. Linked to high concentrations of linalool. The definitive note of Panamanian and Ethiopian Geshas.',
        'zh':
            'Intensely floral and perfume-like aroma. Linked to high concentrations of linalool. The definitive note of Panamanian and Ethiopian Geshas.',
        'ar':
            'Intensely floral and perfume-like aroma. Linked to high concentrations of linalool. The definitive note of Panamanian and Ethiopian Geshas.',
      },
      'wheel_note_vanilla': {
        'en':
            'Sweet, creamy, and subtle aromatic note. Arises during the middle of the roasting process. Often found in high-grade washed Central American lots.',
        'uk':
            'Солодка, кремова та тонка ароматна нота. Виникає в середині процесу обсмажування. Часто зустрічається у висококласних митих центральноамериканських лотах.',
        'de':
            'Sweet, creamy, and subtle aromatic note. Arises during the middle of the roasting process. Often found in high-grade washed Central American lots.',
        'fr':
            'Sweet, creamy, and subtle aromatic note. Arises during the middle of the roasting process. Often found in high-grade washed Central American lots.',
        'es':
            'Sweet, creamy, and subtle aromatic note. Arises during the middle of the roasting process. Often found in high-grade washed Central American lots.',
        'it':
            'Sweet, creamy, and subtle aromatic note. Arises during the middle of the roasting process. Often found in high-grade washed Central American lots.',
        'pt':
            'Sweet, creamy, and subtle aromatic note. Arises during the middle of the roasting process. Often found in high-grade washed Central American lots.',
        'pl':
            'Sweet, creamy, and subtle aromatic note. Arises during the middle of the roasting process. Often found in high-grade washed Central American lots.',
        'nl':
            'Sweet, creamy, and subtle aromatic note. Arises during the middle of the roasting process. Often found in high-grade washed Central American lots.',
        'sv':
            'Sweet, creamy, and subtle aromatic note. Arises during the middle of the roasting process. Often found in high-grade washed Central American lots.',
        'tr':
            'Sweet, creamy, and subtle aromatic note. Arises during the middle of the roasting process. Often found in high-grade washed Central American lots.',
        'ja':
            'Sweet, creamy, and subtle aromatic note. Arises during the middle of the roasting process. Often found in high-grade washed Central American lots.',
        'ko':
            'Sweet, creamy, and subtle aromatic note. Arises during the middle of the roasting process. Often found in high-grade washed Central American lots.',
        'zh':
            'Sweet, creamy, and subtle aromatic note. Arises during the middle of the roasting process. Often found in high-grade washed Central American lots.',
        'ar':
            'Sweet, creamy, and subtle aromatic note. Arises during the middle of the roasting process. Often found in high-grade washed Central American lots.',
      },
      'wheel_note_vanilla_bean': {
        'en':
            'Intense, woodsy and oily sweetness. Represents a more concentrated aromatic profile than simple vanilla. Found in unique Bourbon-variety micro-lots.',
        'uk':
            'Інтенсивна, деревна та масляниста солодкість. Представляє більш концентрований ароматний профіль, ніж просто ваніль. Зустрічається в унікальних мікролотах сорту Бурбон.',
        'de':
            'Intense, woodsy and oily sweetness. Represents a more concentrated aromatic profile than simple vanilla. Found in unique Bourbon-variety micro-lots.',
        'fr':
            'Intense, woodsy and oily sweetness. Represents a more concentrated aromatic profile than simple vanilla. Found in unique Bourbon-variety micro-lots.',
        'es':
            'Intense, woodsy and oily sweetness. Represents a more concentrated aromatic profile than simple vanilla. Found in unique Bourbon-variety micro-lots.',
        'it':
            'Intense, woodsy and oily sweetness. Represents a more concentrated aromatic profile than simple vanilla. Found in unique Bourbon-variety micro-lots.',
        'pt':
            'Intense, woodsy and oily sweetness. Represents a more concentrated aromatic profile than simple vanilla. Found in unique Bourbon-variety micro-lots.',
        'pl':
            'Intense, woodsy and oily sweetness. Represents a more concentrated aromatic profile than simple vanilla. Found in unique Bourbon-variety micro-lots.',
        'nl':
            'Intense, woodsy and oily sweetness. Represents a more concentrated aromatic profile than simple vanilla. Found in unique Bourbon-variety micro-lots.',
        'sv':
            'Intense, woodsy and oily sweetness. Represents a more concentrated aromatic profile than simple vanilla. Found in unique Bourbon-variety micro-lots.',
        'tr':
            'Intense, woodsy and oily sweetness. Represents a more concentrated aromatic profile than simple vanilla. Found in unique Bourbon-variety micro-lots.',
        'ja':
            'Intense, woodsy and oily sweetness. Represents a more concentrated aromatic profile than simple vanilla. Found in unique Bourbon-variety micro-lots.',
        'ko':
            'Intense, woodsy and oily sweetness. Represents a more concentrated aromatic profile than simple vanilla. Found in unique Bourbon-variety micro-lots.',
        'zh':
            'Intense, woodsy and oily sweetness. Represents a more concentrated aromatic profile than simple vanilla. Found in unique Bourbon-variety micro-lots.',
        'ar':
            'Intense, woodsy and oily sweetness. Represents a more concentrated aromatic profile than simple vanilla. Found in unique Bourbon-variety micro-lots.',
      },
      'wheel_note_molasses': {
        'en':
            'Thick, dark sugary sweetness with an earthy undertone. Result of high degree of caramelization. Signature of many Brazilian and Sumatran coffees.',
        'uk':
            'Густа, темна цукрова солодкість з землистим підтоном. Результат глибокої карамелізації. Характерна нота для багатьох бразильських та суматранських кав.',
        'de':
            'Thick, dark sugary sweetness with an earthy undertone. Result of high degree of caramelization. Signature of many Brazilian and Sumatran coffees.',
        'fr':
            'Thick, dark sugary sweetness with an earthy undertone. Result of high degree of caramelization. Signature of many Brazilian and Sumatran coffees.',
        'es':
            'Thick, dark sugary sweetness with an earthy undertone. Result of high degree of caramelization. Signature of many Brazilian and Sumatran coffees.',
        'it':
            'Thick, dark sugary sweetness with an earthy undertone. Result of high degree of caramelization. Signature of many Brazilian and Sumatran coffees.',
        'pt':
            'Thick, dark sugary sweetness with an earthy undertone. Result of high degree of caramelization. Signature of many Brazilian and Sumatran coffees.',
        'pl':
            'Thick, dark sugary sweetness with an earthy undertone. Result of high degree of caramelization. Signature of many Brazilian and Sumatran coffees.',
        'nl':
            'Thick, dark sugary sweetness with an earthy undertone. Result of high degree of caramelization. Signature of many Brazilian and Sumatran coffees.',
        'sv':
            'Thick, dark sugary sweetness with an earthy undertone. Result of high degree of caramelization. Signature of many Brazilian and Sumatran coffees.',
        'tr':
            'Thick, dark sugary sweetness with an earthy undertone. Result of high degree of caramelization. Signature of many Brazilian and Sumatran coffees.',
        'ja':
            'Thick, dark sugary sweetness with an earthy undertone. Result of high degree of caramelization. Signature of many Brazilian and Sumatran coffees.',
        'ko':
            'Thick, dark sugary sweetness with an earthy undertone. Result of high degree of caramelization. Signature of many Brazilian and Sumatran coffees.',
        'zh':
            'Thick, dark sugary sweetness with an earthy undertone. Result of high degree of caramelization. Signature of many Brazilian and Sumatran coffees.',
        'ar':
            'Thick, dark sugary sweetness with an earthy undertone. Result of high degree of caramelization. Signature of many Brazilian and Sumatran coffees.',
      },
      'wheel_note_maple_syrup': {
        'en':
            'Clean, woody and persistent sweetness. Represents high-quality, stable carbohydrate breakdown in the roast. Frequent in high-grade Guatemalan lots.',
        'uk':
            'Чиста, деревна та стійка солодкість. Представляє високоякісний, стабільний розпад вуглеводів під час обсмаження. Часто зустрічається у висококласних гватемальських лотах.',
        'de':
            'Clean, woody and persistent sweetness. Represents high-quality, stable carbohydrate breakdown in the roast. Frequent in high-grade Guatemalan lots.',
        'fr':
            'Clean, woody and persistent sweetness. Represents high-quality, stable carbohydrate breakdown in the roast. Frequent in high-grade Guatemalan lots.',
        'es':
            'Clean, woody and persistent sweetness. Represents high-quality, stable carbohydrate breakdown in the roast. Frequent in high-grade Guatemalan lots.',
        'it':
            'Clean, woody and persistent sweetness. Represents high-quality, stable carbohydrate breakdown in the roast. Frequent in high-grade Guatemalan lots.',
        'pt':
            'Clean, woody and persistent sweetness. Represents high-quality, stable carbohydrate breakdown in the roast. Frequent in high-grade Guatemalan lots.',
        'pl':
            'Clean, woody and persistent sweetness. Represents high-quality, stable carbohydrate breakdown in the roast. Frequent in high-grade Guatemalan lots.',
        'nl':
            'Clean, woody and persistent sweetness. Represents high-quality, stable carbohydrate breakdown in the roast. Frequent in high-grade Guatemalan lots.',
        'sv':
            'Clean, woody and persistent sweetness. Represents high-quality, stable carbohydrate breakdown in the roast. Frequent in high-grade Guatemalan lots.',
        'tr':
            'Clean, woody and persistent sweetness. Represents high-quality, stable carbohydrate breakdown in the roast. Frequent in high-grade Guatemalan lots.',
        'ja':
            'Clean, woody and persistent sweetness. Represents high-quality, stable carbohydrate breakdown in the roast. Frequent in high-grade Guatemalan lots.',
        'ko':
            'Clean, woody and persistent sweetness. Represents high-quality, stable carbohydrate breakdown in the roast. Frequent in high-grade Guatemalan lots.',
        'zh':
            'Clean, woody and persistent sweetness. Represents high-quality, stable carbohydrate breakdown in the roast. Frequent in high-grade Guatemalan lots.',
        'ar':
            'Clean, woody and persistent sweetness. Represents high-quality, stable carbohydrate breakdown in the roast. Frequent in high-grade Guatemalan lots.',
      },
      'wheel_note_caramel': {
        'en':
            'Rich, sugary browning note. Universal indicator of proper roast development. Present in sweet coffees from Guatemala to Brazil.',
        'uk':
            'Багата, цукрова нота карамелізації. Універсальний індикатор правильного розвитку обсмаження. Присутня в солодкій каві від Гватемали до Бразилії.',
        'de':
            'Rich, sugary browning note. Universal indicator of proper roast development. Present in sweet coffees from Guatemala to Brazil.',
        'fr':
            'Rich, sugary browning note. Universal indicator of proper roast development. Present in sweet coffees from Guatemala to Brazil.',
        'es':
            'Rich, sugary browning note. Universal indicator of proper roast development. Present in sweet coffees from Guatemala to Brazil.',
        'it':
            'Rich, sugary browning note. Universal indicator of proper roast development. Present in sweet coffees from Guatemala to Brazil.',
        'pt':
            'Rich, sugary browning note. Universal indicator of proper roast development. Present in sweet coffees from Guatemala to Brazil.',
        'pl':
            'Rich, sugary browning note. Universal indicator of proper roast development. Present in sweet coffees from Guatemala to Brazil.',
        'nl':
            'Rich, sugary browning note. Universal indicator of proper roast development. Present in sweet coffees from Guatemala to Brazil.',
        'sv':
            'Rich, sugary browning note. Universal indicator of proper roast development. Present in sweet coffees from Guatemala to Brazil.',
        'tr':
            'Rich, sugary browning note. Universal indicator of proper roast development. Present in sweet coffees from Guatemala to Brazil.',
        'ja':
            'Rich, sugary browning note. Universal indicator of proper roast development. Present in sweet coffees from Guatemala to Brazil.',
        'ko':
            'Rich, sugary browning note. Universal indicator of proper roast development. Present in sweet coffees from Guatemala to Brazil.',
        'zh':
            'Rich, sugary browning note. Universal indicator of proper roast development. Present in sweet coffees from Guatemala to Brazil.',
        'ar':
            'Rich, sugary browning note. Universal indicator of proper roast development. Present in sweet coffees from Guatemala to Brazil.',
      },
      'wheel_note_honey': {
        'en':
            'Viscous, floral sweetness. Linked to high mucilage content and specific processing. Hallmarks of Costa Rican "Honey" processed lots.',
        'uk':
            'Густа, квіткова солодкість. Пов\'язана з високим вмістом клейковини та специфічною обробкою. Візитна картка кави з Коста-Ріки обробки "Honey".',
        'de':
            'Viscous, floral sweetness. Linked to high mucilage content and specific processing. Hallmarks of Costa Rican "Honey" processed lots.',
        'fr':
            'Viscous, floral sweetness. Linked to high mucilage content and specific processing. Hallmarks of Costa Rican "Honey" processed lots.',
        'es':
            'Viscous, floral sweetness. Linked to high mucilage content and specific processing. Hallmarks of Costa Rican "Honey" processed lots.',
        'it':
            'Viscous, floral sweetness. Linked to high mucilage content and specific processing. Hallmarks of Costa Rican "Honey" processed lots.',
        'pt':
            'Viscous, floral sweetness. Linked to high mucilage content and specific processing. Hallmarks of Costa Rican "Honey" processed lots.',
        'pl':
            'Viscous, floral sweetness. Linked to high mucilage content and specific processing. Hallmarks of Costa Rican "Honey" processed lots.',
        'nl':
            'Viscous, floral sweetness. Linked to high mucilage content and specific processing. Hallmarks of Costa Rican "Honey" processed lots.',
        'sv':
            'Viscous, floral sweetness. Linked to high mucilage content and specific processing. Hallmarks of Costa Rican "Honey" processed lots.',
        'tr':
            'Viscous, floral sweetness. Linked to high mucilage content and specific processing. Hallmarks of Costa Rican "Honey" processed lots.',
        'ja':
            'Viscous, floral sweetness. Linked to high mucilage content and specific processing. Hallmarks of Costa Rican "Honey" processed lots.',
        'ko':
            'Viscous, floral sweetness. Linked to high mucilage content and specific processing. Hallmarks of Costa Rican "Honey" processed lots.',
        'zh':
            'Viscous, floral sweetness. Linked to high mucilage content and specific processing. Hallmarks of Costa Rican "Honey" processed lots.',
        'ar':
            'Viscous, floral sweetness. Linked to high mucilage content and specific processing. Hallmarks of Costa Rican "Honey" processed lots.',
      },
      'wheel_note_peanuts': {
        'en':
            'Earthy, slightly oily and savory nut sweetness. Characteristic of many South American coffees and specific roast styles. Common in classic Brazilian lots.',
        'uk':
            'Землиста, злегка масляниста та пікантна горіхова солодкість. Характерно для багатьох південноамериканських кав та специфічних стилів обсмаження. Зустрічається у класичній Бразилії.',
        'de':
            'Earthy, slightly oily and savory nut sweetness. Characteristic of many South American coffees and specific roast styles. Common in classic Brazilian lots.',
        'fr':
            'Earthy, slightly oily and savory nut sweetness. Characteristic of many South American coffees and specific roast styles. Common in classic Brazilian lots.',
        'es':
            'Earthy, slightly oily and savory nut sweetness. Characteristic of many South American coffees and specific roast styles. Common in classic Brazilian lots.',
        'it':
            'Earthy, slightly oily and savory nut sweetness. Characteristic of many South American coffees and specific roast styles. Common in classic Brazilian lots.',
        'pt':
            'Earthy, slightly oily and savory nut sweetness. Characteristic of many South American coffees and specific roast styles. Common in classic Brazilian lots.',
        'pl':
            'Earthy, slightly oily and savory nut sweetness. Characteristic of many South American coffees and specific roast styles. Common in classic Brazilian lots.',
        'nl':
            'Earthy, slightly oily and savory nut sweetness. Characteristic of many South American coffees and specific roast styles. Common in classic Brazilian lots.',
        'sv':
            'Earthy, slightly oily and savory nut sweetness. Characteristic of many South American coffees and specific roast styles. Common in classic Brazilian lots.',
        'tr':
            'Earthy, slightly oily and savory nut sweetness. Characteristic of many South American coffees and specific roast styles. Common in classic Brazilian lots.',
        'ja':
            'Earthy, slightly oily and savory nut sweetness. Characteristic of many South American coffees and specific roast styles. Common in classic Brazilian lots.',
        'ko':
            'Earthy, slightly oily and savory nut sweetness. Characteristic of many South American coffees and specific roast styles. Common in classic Brazilian lots.',
        'zh':
            'Earthy, slightly oily and savory nut sweetness. Characteristic of many South American coffees and specific roast styles. Common in classic Brazilian lots.',
        'ar':
            'Earthy, slightly oily and savory nut sweetness. Characteristic of many South American coffees and specific roast styles. Common in classic Brazilian lots.',
      },
      'wheel_note_hazelnut': {
        'en':
            'Buttery, oily nut sweetness. Typical of medium roasts and stable varieties like Castillo or Caturra. Found throughout Latin America.',
        'uk':
            'Масляниста, горіхова солодкість. Типово для середнього обсмаження та стабільних сортів, таких як Кастільйо або Катурра. Зустрічається по всій Латинській Америці.',
        'de':
            'Buttery, oily nut sweetness. Typical of medium roasts and stable varieties like Castillo or Caturra. Found throughout Latin America.',
        'fr':
            'Buttery, oily nut sweetness. Typical of medium roasts and stable varieties like Castillo or Caturra. Found throughout Latin America.',
        'es':
            'Buttery, oily nut sweetness. Typical of medium roasts and stable varieties like Castillo or Caturra. Found throughout Latin America.',
        'it':
            'Buttery, oily nut sweetness. Typical of medium roasts and stable varieties like Castillo or Caturra. Found throughout Latin America.',
        'pt':
            'Buttery, oily nut sweetness. Typical of medium roasts and stable varieties like Castillo or Caturra. Found throughout Latin America.',
        'pl':
            'Buttery, oily nut sweetness. Typical of medium roasts and stable varieties like Castillo or Caturra. Found throughout Latin America.',
        'nl':
            'Buttery, oily nut sweetness. Typical of medium roasts and stable varieties like Castillo or Caturra. Found throughout Latin America.',
        'sv':
            'Buttery, oily nut sweetness. Typical of medium roasts and stable varieties like Castillo or Caturra. Found throughout Latin America.',
        'tr':
            'Buttery, oily nut sweetness. Typical of medium roasts and stable varieties like Castillo or Caturra. Found throughout Latin America.',
        'ja':
            'Buttery, oily nut sweetness. Typical of medium roasts and stable varieties like Castillo or Caturra. Found throughout Latin America.',
        'ko':
            'Buttery, oily nut sweetness. Typical of medium roasts and stable varieties like Castillo or Caturra. Found throughout Latin America.',
        'zh':
            'Buttery, oily nut sweetness. Typical of medium roasts and stable varieties like Castillo or Caturra. Found throughout Latin America.',
        'ar':
            'Buttery, oily nut sweetness. Typical of medium roasts and stable varieties like Castillo or Caturra. Found throughout Latin America.',
      },
      'wheel_note_almond': {
        'en':
            'Sweet, slightly bitter nut note with a marzipan-like edge. Linked to specific amino acid profiles. Common in clean, washed Honduran and Salvadoran coffees.',
        'uk':
            'Солодка, злегка гіркувата горіхова нота з відтінком марципану. Пов\'язана зі специфічними амінокислотними профілями. Зустрічається у чистих, митих лотах з Гондурасу та Сальвадору.',
        'de':
            'Sweet, slightly bitter nut note with a marzipan-like edge. Linked to specific amino acid profiles. Common in clean, washed Honduran and Salvadoran coffees.',
        'fr':
            'Sweet, slightly bitter nut note with a marzipan-like edge. Linked to specific amino acid profiles. Common in clean, washed Honduran and Salvadoran coffees.',
        'es':
            'Sweet, slightly bitter nut note with a marzipan-like edge. Linked to specific amino acid profiles. Common in clean, washed Honduran and Salvadoran coffees.',
        'it':
            'Sweet, slightly bitter nut note with a marzipan-like edge. Linked to specific amino acid profiles. Common in clean, washed Honduran and Salvadoran coffees.',
        'pt':
            'Sweet, slightly bitter nut note with a marzipan-like edge. Linked to specific amino acid profiles. Common in clean, washed Honduran and Salvadoran coffees.',
        'pl':
            'Sweet, slightly bitter nut note with a marzipan-like edge. Linked to specific amino acid profiles. Common in clean, washed Honduran and Salvadoran coffees.',
        'nl':
            'Sweet, slightly bitter nut note with a marzipan-like edge. Linked to specific amino acid profiles. Common in clean, washed Honduran and Salvadoran coffees.',
        'sv':
            'Sweet, slightly bitter nut note with a marzipan-like edge. Linked to specific amino acid profiles. Common in clean, washed Honduran and Salvadoran coffees.',
        'tr':
            'Sweet, slightly bitter nut note with a marzipan-like edge. Linked to specific amino acid profiles. Common in clean, washed Honduran and Salvadoran coffees.',
        'ja':
            'Sweet, slightly bitter nut note with a marzipan-like edge. Linked to specific amino acid profiles. Common in clean, washed Honduran and Salvadoran coffees.',
        'ko':
            'Sweet, slightly bitter nut note with a marzipan-like edge. Linked to specific amino acid profiles. Common in clean, washed Honduran and Salvadoran coffees.',
        'zh':
            'Sweet, slightly bitter nut note with a marzipan-like edge. Linked to specific amino acid profiles. Common in clean, washed Honduran and Salvadoran coffees.',
        'ar':
            'Sweet, slightly bitter nut note with a marzipan-like edge. Linked to specific amino acid profiles. Common in clean, washed Honduran and Salvadoran coffees.',
      },
      'wheel_note_chocolate': {
        'en':
            'Foundational cocoa sweetness. Result of browning reactions. Classic note for Brazilian, Indian, and Vietnamese high-quality robustas and arabicas.',
        'uk':
            'Основна какао-солодкість. Результат реакцій карамелізації. Класична нота для бразильської, індійської та в\'єтнамської високоякісної робусти та арабіки.',
        'de':
            'Foundational cocoa sweetness. Result of browning reactions. Classic note for Brazilian, Indian, and Vietnamese high-quality robustas and arabicas.',
        'fr':
            'Foundational cocoa sweetness. Result of browning reactions. Classic note for Brazilian, Indian, and Vietnamese high-quality robustas and arabicas.',
        'es':
            'Foundational cocoa sweetness. Result of browning reactions. Classic note for Brazilian, Indian, and Vietnamese high-quality robustas and arabicas.',
        'it':
            'Foundational cocoa sweetness. Result of browning reactions. Classic note for Brazilian, Indian, and Vietnamese high-quality robustas and arabicas.',
        'pt':
            'Foundational cocoa sweetness. Result of browning reactions. Classic note for Brazilian, Indian, and Vietnamese high-quality robustas and arabicas.',
        'pl':
            'Foundational cocoa sweetness. Result of browning reactions. Classic note for Brazilian, Indian, and Vietnamese high-quality robustas and arabicas.',
        'nl':
            'Foundational cocoa sweetness. Result of browning reactions. Classic note for Brazilian, Indian, and Vietnamese high-quality robustas and arabicas.',
        'sv':
            'Foundational cocoa sweetness. Result of browning reactions. Classic note for Brazilian, Indian, and Vietnamese high-quality robustas and arabicas.',
        'tr':
            'Foundational cocoa sweetness. Result of browning reactions. Classic note for Brazilian, Indian, and Vietnamese high-quality robustas and arabicas.',
        'ja':
            'Foundational cocoa sweetness. Result of browning reactions. Classic note for Brazilian, Indian, and Vietnamese high-quality robustas and arabicas.',
        'ko':
            'Foundational cocoa sweetness. Result of browning reactions. Classic note for Brazilian, Indian, and Vietnamese high-quality robustas and arabicas.',
        'zh':
            'Foundational cocoa sweetness. Result of browning reactions. Classic note for Brazilian, Indian, and Vietnamese high-quality robustas and arabicas.',
        'ar':
            'Foundational cocoa sweetness. Result of browning reactions. Classic note for Brazilian, Indian, and Vietnamese high-quality robustas and arabicas.',
      },
      'wheel_note_dark_chocolate': {
        'en':
            'Intense, bitter-sweet cocoa richness. Marks high degree of development or specific terroir genetics. Constant in high-altitude Sumatran coffees.',
        'uk':
            'Інтенсивна, гірко-солодка насиченість какао. Вказує на високий ступінь розвитку або специфічну генетику терруару. Постійна нота у високогірній суматранській каві.',
        'de':
            'Intense, bitter-sweet cocoa richness. Marks high degree of development or specific terroir genetics. Constant in high-altitude Sumatran coffees.',
        'fr':
            'Intense, bitter-sweet cocoa richness. Marks high degree of development or specific terroir genetics. Constant in high-altitude Sumatran coffees.',
        'es':
            'Intense, bitter-sweet cocoa richness. Marks high degree of development or specific terroir genetics. Constant in high-altitude Sumatran coffees.',
        'it':
            'Intense, bitter-sweet cocoa richness. Marks high degree of development or specific terroir genetics. Constant in high-altitude Sumatran coffees.',
        'pt':
            'Intense, bitter-sweet cocoa richness. Marks high degree of development or specific terroir genetics. Constant in high-altitude Sumatran coffees.',
        'pl':
            'Intense, bitter-sweet cocoa richness. Marks high degree of development or specific terroir genetics. Constant in high-altitude Sumatran coffees.',
        'nl':
            'Intense, bitter-sweet cocoa richness. Marks high degree of development or specific terroir genetics. Constant in high-altitude Sumatran coffees.',
        'sv':
            'Intense, bitter-sweet cocoa richness. Marks high degree of development or specific terroir genetics. Constant in high-altitude Sumatran coffees.',
        'tr':
            'Intense, bitter-sweet cocoa richness. Marks high degree of development or specific terroir genetics. Constant in high-altitude Sumatran coffees.',
        'ja':
            'Intense, bitter-sweet cocoa richness. Marks high degree of development or specific terroir genetics. Constant in high-altitude Sumatran coffees.',
        'ko':
            'Intense, bitter-sweet cocoa richness. Marks high degree of development or specific terroir genetics. Constant in high-altitude Sumatran coffees.',
        'zh':
            'Intense, bitter-sweet cocoa richness. Marks high degree of development or specific terroir genetics. Constant in high-altitude Sumatran coffees.',
        'ar':
            'Intense, bitter-sweet cocoa richness. Marks high degree of development or specific terroir genetics. Constant in high-altitude Sumatran coffees.',
      },
      'wheel_note_clove': {
        'en':
            'Spicy, pungent note with a warm sensation. Result of specific phenolic compounds. Found in some Rwandan and Burundian coffees.',
        'uk':
            'Пряна, гостра нота з відчуттям тепла. Результат дії специфічних фенольних сполук. Зустрічається в деяких лотах з Руанди та Бурунді.',
        'de':
            'Spicy, pungent note with a warm sensation. Result of specific phenolic compounds. Found in some Rwandan and Burundian coffees.',
        'fr':
            'Spicy, pungent note with a warm sensation. Result of specific phenolic compounds. Found in some Rwandan and Burundian coffees.',
        'es':
            'Spicy, pungent note with a warm sensation. Result of specific phenolic compounds. Found in some Rwandan and Burundian coffees.',
        'it':
            'Spicy, pungent note with a warm sensation. Result of specific phenolic compounds. Found in some Rwandan and Burundian coffees.',
        'pt':
            'Spicy, pungent note with a warm sensation. Result of specific phenolic compounds. Found in some Rwandan and Burundian coffees.',
        'pl':
            'Spicy, pungent note with a warm sensation. Result of specific phenolic compounds. Found in some Rwandan and Burundian coffees.',
        'nl':
            'Spicy, pungent note with a warm sensation. Result of specific phenolic compounds. Found in some Rwandan and Burundian coffees.',
        'sv':
            'Spicy, pungent note with a warm sensation. Result of specific phenolic compounds. Found in some Rwandan and Burundian coffees.',
        'tr':
            'Spicy, pungent note with a warm sensation. Result of specific phenolic compounds. Found in some Rwandan and Burundian coffees.',
        'ja':
            'Spicy, pungent note with a warm sensation. Result of specific phenolic compounds. Found in some Rwandan and Burundian coffees.',
        'ko':
            'Spicy, pungent note with a warm sensation. Result of specific phenolic compounds. Found in some Rwandan and Burundian coffees.',
        'zh':
            'Spicy, pungent note with a warm sensation. Result of specific phenolic compounds. Found in some Rwandan and Burundian coffees.',
        'ar':
            'Spicy, pungent note with a warm sensation. Result of specific phenolic compounds. Found in some Rwandan and Burundian coffees.',
      },
      'wheel_note_cinnamon': {
        'en':
            'Sweet, woody spice note. Common in medium-light roasts of dense coffees. Frequent in Yemeni and some Ethiopian coffees.',
        'uk':
            'Солодка, деревна пряна нота. Поширена в середньо-світлому обсмаженні щільної кави. Часто зустрічається в єменській та деякій ефіопській каві.',
        'de':
            'Sweet, woody spice note. Common in medium-light roasts of dense coffees. Frequent in Yemeni and some Ethiopian coffees.',
        'fr':
            'Sweet, woody spice note. Common in medium-light roasts of dense coffees. Frequent in Yemeni and some Ethiopian coffees.',
        'es':
            'Sweet, woody spice note. Common in medium-light roasts of dense coffees. Frequent in Yemeni and some Ethiopian coffees.',
        'it':
            'Sweet, woody spice note. Common in medium-light roasts of dense coffees. Frequent in Yemeni and some Ethiopian coffees.',
        'pt':
            'Sweet, woody spice note. Common in medium-light roasts of dense coffees. Frequent in Yemeni and some Ethiopian coffees.',
        'pl':
            'Sweet, woody spice note. Common in medium-light roasts of dense coffees. Frequent in Yemeni and some Ethiopian coffees.',
        'nl':
            'Sweet, woody spice note. Common in medium-light roasts of dense coffees. Frequent in Yemeni and some Ethiopian coffees.',
        'sv':
            'Sweet, woody spice note. Common in medium-light roasts of dense coffees. Frequent in Yemeni and some Ethiopian coffees.',
        'tr':
            'Sweet, woody spice note. Common in medium-light roasts of dense coffees. Frequent in Yemeni and some Ethiopian coffees.',
        'ja':
            'Sweet, woody spice note. Common in medium-light roasts of dense coffees. Frequent in Yemeni and some Ethiopian coffees.',
        'ko':
            'Sweet, woody spice note. Common in medium-light roasts of dense coffees. Frequent in Yemeni and some Ethiopian coffees.',
        'zh':
            'Sweet, woody spice note. Common in medium-light roasts of dense coffees. Frequent in Yemeni and some Ethiopian coffees.',
        'ar':
            'Sweet, woody spice note. Common in medium-light roasts of dense coffees. Frequent in Yemeni and some Ethiopian coffees.',
      },
      'wheel_note_nutmeg': {
        'en':
            'Earthy and warm spice profile. Often complements chocolate and nutty sweetness. Characteristic of high-grade Indonesian Arabicas.',
        'uk':
            'Землистий та теплий пряний профіль. Часто доповнює шоколадну та горіхову солодкість. Характерно для висококласних індонезійських арабік.',
        'de':
            'Earthy and warm spice profile. Often complements chocolate and nutty sweetness. Characteristic of high-grade Indonesian Arabicas.',
        'fr':
            'Earthy and warm spice profile. Often complements chocolate and nutty sweetness. Characteristic of high-grade Indonesian Arabicas.',
        'es':
            'Earthy and warm spice profile. Often complements chocolate and nutty sweetness. Characteristic of high-grade Indonesian Arabicas.',
        'it':
            'Earthy and warm spice profile. Often complements chocolate and nutty sweetness. Characteristic of high-grade Indonesian Arabicas.',
        'pt':
            'Earthy and warm spice profile. Often complements chocolate and nutty sweetness. Characteristic of high-grade Indonesian Arabicas.',
        'pl':
            'Earthy and warm spice profile. Often complements chocolate and nutty sweetness. Characteristic of high-grade Indonesian Arabicas.',
        'nl':
            'Earthy and warm spice profile. Often complements chocolate and nutty sweetness. Characteristic of high-grade Indonesian Arabicas.',
        'sv':
            'Earthy and warm spice profile. Often complements chocolate and nutty sweetness. Characteristic of high-grade Indonesian Arabicas.',
        'tr':
            'Earthy and warm spice profile. Often complements chocolate and nutty sweetness. Characteristic of high-grade Indonesian Arabicas.',
        'ja':
            'Earthy and warm spice profile. Often complements chocolate and nutty sweetness. Characteristic of high-grade Indonesian Arabicas.',
        'ko':
            'Earthy and warm spice profile. Often complements chocolate and nutty sweetness. Characteristic of high-grade Indonesian Arabicas.',
        'zh':
            'Earthy and warm spice profile. Often complements chocolate and nutty sweetness. Characteristic of high-grade Indonesian Arabicas.',
        'ar':
            'Earthy and warm spice profile. Often complements chocolate and nutty sweetness. Characteristic of high-grade Indonesian Arabicas.',
      },
      'wheel_note_anise': {
        'en':
            'Cool, sweet and slightly medicinal spice note. Reminiscent of licorice. Found in some rare Yemeni and complex African lots.',
        'uk':
            'Прохолодна, солодка та злегка аптечна пряна нота. Нагадує лакрицю. Зустрічається у деяких рідкісних єменських та складних африканських лотах.',
        'de':
            'Cool, sweet and slightly medicinal spice note. Reminiscent of licorice. Found in some rare Yemeni and complex African lots.',
        'fr':
            'Cool, sweet and slightly medicinal spice note. Reminiscent of licorice. Found in some rare Yemeni and complex African lots.',
        'es':
            'Cool, sweet and slightly medicinal spice note. Reminiscent of licorice. Found in some rare Yemeni and complex African lots.',
        'it':
            'Cool, sweet and slightly medicinal spice note. Reminiscent of licorice. Found in some rare Yemeni and complex African lots.',
        'pt':
            'Cool, sweet and slightly medicinal spice note. Reminiscent of licorice. Found in some rare Yemeni and complex African lots.',
        'pl':
            'Cool, sweet and slightly medicinal spice note. Reminiscent of licorice. Found in some rare Yemeni and complex African lots.',
        'nl':
            'Cool, sweet and slightly medicinal spice note. Reminiscent of licorice. Found in some rare Yemeni and complex African lots.',
        'sv':
            'Cool, sweet and slightly medicinal spice note. Reminiscent of licorice. Found in some rare Yemeni and complex African lots.',
        'tr':
            'Cool, sweet and slightly medicinal spice note. Reminiscent of licorice. Found in some rare Yemeni and complex African lots.',
        'ja':
            'Cool, sweet and slightly medicinal spice note. Reminiscent of licorice. Found in some rare Yemeni and complex African lots.',
        'ko':
            'Cool, sweet and slightly medicinal spice note. Reminiscent of licorice. Found in some rare Yemeni and complex African lots.',
        'zh':
            'Cool, sweet and slightly medicinal spice note. Reminiscent of licorice. Found in some rare Yemeni and complex African lots.',
        'ar':
            'Cool, sweet and slightly medicinal spice note. Reminiscent of licorice. Found in some rare Yemeni and complex African lots.',
      },
      'wheel_note_malt': {
        'en':
            'Sweet, grain-like note reminiscent of beer or freshly baked bread. Indicator of specific sugar-amino-acid reactions. Common in traditional Brazilian coffees.',
        'uk':
            'Солодка, зернова нота, що нагадує пиво або свіжоспечений хліб. Індикатор специфічних реакцій цукру та амінокислот. Зустрічається в традиційній бразильській каві.',
        'de':
            'Sweet, grain-like note reminiscent of beer or freshly baked bread. Indicator of specific sugar-amino-acid reactions. Common in traditional Brazilian coffees.',
        'fr':
            'Sweet, grain-like note reminiscent of beer or freshly baked bread. Indicator of specific sugar-amino-acid reactions. Common in traditional Brazilian coffees.',
        'es':
            'Sweet, grain-like note reminiscent of beer or freshly baked bread. Indicator of specific sugar-amino-acid reactions. Common in traditional Brazilian coffees.',
        'it':
            'Sweet, grain-like note reminiscent of beer or freshly baked bread. Indicator of specific sugar-amino-acid reactions. Common in traditional Brazilian coffees.',
        'pt':
            'Sweet, grain-like note reminiscent of beer or freshly baked bread. Indicator of specific sugar-amino-acid reactions. Common in traditional Brazilian coffees.',
        'pl':
            'Sweet, grain-like note reminiscent of beer or freshly baked bread. Indicator of specific sugar-amino-acid reactions. Common in traditional Brazilian coffees.',
        'nl':
            'Sweet, grain-like note reminiscent of beer or freshly baked bread. Indicator of specific sugar-amino-acid reactions. Common in traditional Brazilian coffees.',
        'sv':
            'Sweet, grain-like note reminiscent of beer or freshly baked bread. Indicator of specific sugar-amino-acid reactions. Common in traditional Brazilian coffees.',
        'tr':
            'Sweet, grain-like note reminiscent of beer or freshly baked bread. Indicator of specific sugar-amino-acid reactions. Common in traditional Brazilian coffees.',
        'ja':
            'Sweet, grain-like note reminiscent of beer or freshly baked bread. Indicator of specific sugar-amino-acid reactions. Common in traditional Brazilian coffees.',
        'ko':
            'Sweet, grain-like note reminiscent of beer or freshly baked bread. Indicator of specific sugar-amino-acid reactions. Common in traditional Brazilian coffees.',
        'zh':
            'Sweet, grain-like note reminiscent of beer or freshly baked bread. Indicator of specific sugar-amino-acid reactions. Common in traditional Brazilian coffees.',
        'ar':
            'Sweet, grain-like note reminiscent of beer or freshly baked bread. Indicator of specific sugar-amino-acid reactions. Common in traditional Brazilian coffees.',
      },
      'wheel_note_grain': {
        'en':
            'Basic, foundational toasted cereal note. Often reflects terroir or specific harvest conditions. Found in many Latin American Arabicas.',
        'uk':
            'Базова, основна нота підсмажених злаків. Часто відображає терруар або специфічні умови врожаю. Зустрічається в багатьох латиноамериканських арабіках.',
        'de':
            'Basic, foundational toasted cereal note. Often reflects terroir or specific harvest conditions. Found in many Latin American Arabicas.',
        'fr':
            'Basic, foundational toasted cereal note. Often reflects terroir or specific harvest conditions. Found in many Latin American Arabicas.',
        'es':
            'Basic, foundational toasted cereal note. Often reflects terroir or specific harvest conditions. Found in many Latin American Arabicas.',
        'it':
            'Basic, foundational toasted cereal note. Often reflects terroir or specific harvest conditions. Found in many Latin American Arabicas.',
        'pt':
            'Basic, foundational toasted cereal note. Often reflects terroir or specific harvest conditions. Found in many Latin American Arabicas.',
        'pl':
            'Basic, foundational toasted cereal note. Often reflects terroir or specific harvest conditions. Found in many Latin American Arabicas.',
        'nl':
            'Basic, foundational toasted cereal note. Often reflects terroir or specific harvest conditions. Found in many Latin American Arabicas.',
        'sv':
            'Basic, foundational toasted cereal note. Often reflects terroir or specific harvest conditions. Found in many Latin American Arabicas.',
        'tr':
            'Basic, foundational toasted cereal note. Often reflects terroir or specific harvest conditions. Found in many Latin American Arabicas.',
        'ja':
            'Basic, foundational toasted cereal note. Often reflects terroir or specific harvest conditions. Found in many Latin American Arabicas.',
        'ko':
            'Basic, foundational toasted cereal note. Often reflects terroir or specific harvest conditions. Found in many Latin American Arabicas.',
        'zh':
            'Basic, foundational toasted cereal note. Often reflects terroir or specific harvest conditions. Found in many Latin American Arabicas.',
        'ar':
            'Basic, foundational toasted cereal note. Often reflects terroir or specific harvest conditions. Found in many Latin American Arabicas.',
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
