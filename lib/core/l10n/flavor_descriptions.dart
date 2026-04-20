class FlavorDescriptions {
  static String getDescription(String key, String locale) {
    final Map<String, Map<String, String>> descriptions = {
      // --- CATEGORIES ---
      'wheel_cat_floral': {
        'en': 'Delicate and aromatic notes reminiscent of blossoms. These flavors often come from high-altitude environments where slow maturation concentrates volatile aromatic compounds. Characteristic of Ethiopian heirlooms and Gesha varieties.',
        'uk': 'Делікатні та ароматні ноти, що нагадують цвітіння. Ці смаки часто виникають завдяки високогірним умовам, де повільне дозрівання концентрує летючі ароматичні сполуки. Характерно для ефіопської спадщини та сортів Гейша.',
      },
      'wheel_cat_fruity': {
        'en': 'A wide range of sweet and tart notes from berries to stone fruits. These are typically associated with organic acids like citric and malic, often enhanced by natural or anaerobic processing. Common in African and Central American coffees.',
        'uk': 'Широкий спектр солодких та кислих нот від ягід до кісточкових фруктів. Зазвичай вони пов\'язані з органічними кислотами, такими як лимонна та яблучна, часто посилюються натуральною або анаеробною обробкою. Типово для африканської та центральноамериканської кави.',
      },
      'wheel_cat_sour_fermented': {
        'en': 'Complex notes that can range from pleasant tangy acids to intense fermented funk. These flavors result from metabolic processes during coffee processing (like prolonged fermentation). Often found in experimental processing lots from Colombia and Costa Rica.',
        'uk': 'Комплексні ноти, що можуть варіюватися від приємних гострих кислот до інтенсивного ферментованого "фанку". Ці смаки є результатом метаболічних процесів під час обробки кави (наприклад, тривала ферментація). Часто зустрічається в лотах з експериментальною обробкою з Колумбії та Коста-Ріки.',
      },
      'wheel_cat_green_veg': {
        'en': 'Herbal or vegetal notes that evoke fresh-cut grass or raw vegetables. These can indicate a lighter roast profile or specific varieties that retain "green" characteristics. Common in some Indonesian or under-roasted high-density beans.',
        'uk': 'Трав\'янисті або овочеві ноти, що нагадують свіжоскошену траву або сирі овочі. Вони можуть вказувати на світлий профіль обсмаження або специфічні сорти, що зберігають "зелені" характеристики. Зустрічається в деяких індонезійських лотах або при світлому обсмаженні щільних зерен.',
      },
      'wheel_cat_roasted': {
        'en': 'Savory and deep notes resulting from the Maillard reaction and caramelization during roasting. These range from toasted bread to smoky accents. Typically associated with medium to dark roast profiles from Brazil or India.',
        'uk': 'Пікантні та глибокі ноти, що виникають внаслідок реакції Майяра та карамелізації під час обсмажування. Вони варіюються від підсмаженого хліба до димних акцентів. Зазвичай асоціюються з профілями середнього та темного обсмаження з Бразилії чи Індії.',
      },
      'wheel_cat_spices': {
        'en': 'Warm, pungent, or sweet spice notes like pepper, clove, or cinnamon. These often emerge during the middle stages of roasting. Frequently found in Sumatran coffees or spicy varieties from Rwanda.',
        'uk': 'Теплі, гострі або солодкі пряні ноти, такі як перець, гвоздика або кориця. Вони часто проявляються на середніх етапах обсмажування. Часто зустрічаються в суматранській каві або пряних сортах з Руанди.',
      },
      'wheel_cat_nutty_cocoa': {
        'en': 'Comforting notes of chocolate, nuts, and cocoa. These result from stable sugars and oils that develop early in the roast. The standard profile for many high-quality Arabicas from Brazil, Guatemala, and Vietnam.',
        'uk': 'Приємні ноти шоколаду, горіхів та какао. Вони виникають завдяки стабільним цукрам та оліям, що розвиваються на початку обсмаження. Звичайний профіль для багатьох високоякісних арабік з Бразилії, Гватемали та В\'єтнаму.',
      },
      'wheel_cat_sweet': {
        'en': 'The foundational sweetness in coffee, ranging from white sugar to complex molasses. It comes from the breakdown of carbohydrates during roasting. Present in almost all balanced, specialty coffees.',
        'uk': 'Основна солодкість кави, від білого цукру до складних патокових відтінків. Вона походить від розпаду вуглеводів під час обсмажування. Присутня майже у всій збалансованій спешелті-каві.',
      },
      'wheel_cat_others': {
        'en': 'A category for unique or unconventional notes that don\'t fit elsewhere, often reflecting rare chemical artifacts of processing or storage.',
        'uk': 'Категорія для унікальних або нетрадиційних нот, які не вписуються в інші розділи, часто відображаючи рідкісні хімічні особливості обробки або зберігання.',
      },

      // --- SUB-CATEGORIES ---
      'wheel_sub_berry': {
        'en': 'Vibrant and sweet-tart notes of small fruits. Derived from concentrated anthocyanins. Typical of Ethiopian natural coffees and Kenyan SL-varieties.',
        'uk': 'Яскраві солодкувато-кислі ноти дрібних плодів. Походять від концентрованих антоціанів. Типово для ефіопської кави натуральної обробки та кенійських сортів SL.',
      },
      'wheel_sub_dried_fruit': {
        'en': 'Concentrated, jammy sweetness reminiscent of raisins or dates. Often the result of over-ripening or natural sun-drying. Common in Yemen Moka and processed lots from Brazil.',
        'uk': 'Концентрована, джемова солодкість, що нагадує родзинки або фініки. Часто є результатом перезрівання або натуральної сушки на сонці. Зустрічається в єменській каві Мока та оброблених лотах з Бразилії.',
      },
      'wheel_sub_citrus': {
        'en': 'Zesty and acidic notes providing brightness and "sparkle". Linked to high citric acid content. Signature profile of high-grown Colombian and Honduran coffees.',
        'uk': 'Цедрові та кислі ноти, що забезпечують яскравість та "іскристість". Пов\'язані з високим вмістом лимонної кислоти. Фірмовий профіль високогірної колумбійської та гондураської кави.',
      },
      'wheel_sub_other_fruit': {
        'en': 'Tropical or temperate fruit notes like apple, pear, or mango. Represents intermediate acidity levels. Characteristic of Costa Rican and Salvadoran coffees.',
        'uk': 'Ноти тропічних або фруктів помірного клімату, таких як яблуко, груша або манго. Представляє середні рівні кислотності. Характерно для кави з Коста-Ріки та Сальвадору.',
      },
      'wheel_sub_sour': {
        'en': 'Direct and sharp acidic notes. When balanced, it provides structure; when excessive, it indicates under-extraction or high organic acid concentration.',
        'uk': 'Прямі та гострі кислі ноти. У збалансованому вигляді це забезпечує структуру; при надлишку вказує на недоекстракцію або високу концентрацію органічних кислот.',
      },
      'wheel_sub_alcohol_fermented': {
        'en': 'Heady and winey notes resulting from anaerobic or yeast-assisted fermentation. Reminiscent of spirits or cider. Typical of modern experimental lots from Colombia.',
        'uk': 'П\'янкі та винні ноти, що виникають внаслідок анаеробної або дріжджової ферментації. Нагадує міцні напої або сидр. Типово для сучасних експериментальних лотів з Колумбії.',
      },
      'wheel_sub_cocoa': {
        'en': 'Deep, dark chocolate profiles. Emerges during prolonged development in the roast. Quintessential Brazil and Indian Monsoon Malabar notes.',
        'uk': 'Глибокі профілі темного шоколаду. З\'являються під час тривалого розвитку при обсмажуванні. Квінтесенція нот Бразилії та індійського Monsoon Malabar.',
      },
      'wheel_sub_nutty': {
        'en': 'Earthy and savory notes of roasted nuts. Comes from amino acids reacting with sugars. Found in Classic South American profiles.',
        'uk': 'Землисті та пікантні ноти смажених горіхів. Походять від реакції амінокислот із цукрами. Зустрічаються в класичних південноамериканських профілях.',
      },
      'wheel_sub_sugar_brown': {
        'en': 'Rich caramel and syrup sweetness. The result of complex sugar browning. Universal in well-roasted medium profiles.',
        'uk': 'Багата карамельна та сиропна солодкість. Результат складного карамелізації цукрів. Універсальна нота для добре обсмажених середніх профілів.',
      },
      'wheel_sub_tea': {
        'en': 'Clean, structured mouthfeel with herbal undertones. Relates to specific polyphenols in high-altitude beans. Hallmarks of Yirgacheffe and high-grade Kenyan lots.',
        'uk': 'Чисте, структуроване відчуття в роті з трав\'яними підтонами. Пов\'язано зі специфічними поліфенолами у високогірних зернах. Візитна картка Іргачефу та висококласних кенійських лотів.',
      },
      'wheel_sub_sweet_aromatics': {
        'en': 'Fragrant, comforting scents like vanilla or spice. Derived from late-stage Maillard reactions. Typical of high-quality Arabicas from Central America.',
        'uk': 'Ароматні, затишні запахи, такі як ваніль або спеції. Походять від реакцій Майяра на пізніх стадіях. Типово для високоякісної арабіки з Центральної Америки.',
      },
      'wheel_sub_brown_spice': {
        'en': 'Warm, sweet spice notes that develop as sugars caramelize. Rich in phenolic compounds. Characteristic of Sumatran and Rwandan coffees.',
        'uk': 'Теплі, солодкі пряні ноти, що розвиваються при карамелізації цукрів. Багаті на фенольні сполуки. Характерно для суматранської та руандійської кави.',
      },
      'wheel_sub_cereal': {
        'en': 'Toasted grain and bread-like notes. Indicative of early roast stages or specific bean density. Common in many Brazilian and Indian lots.',
        'uk': 'Ноти підсмаженого зерна та хліба. Вказують на ранні стадії обсмажування або специфічну щільність зерна. Зустрічається в багатьох бразильських та індійських лотах.',
      },
      'wheel_sub_burnt': {
        'en': 'Intense smoky or carbonized notes. Result of high-temperature pyrolysis during roasting. Hallmarks of dark roast profiles.',
        'uk': 'Інтенсивні димні або обвуглені ноти. Результат високотемпературного піролізу під час обсмажування. Візитна картка профілів темного обсмаження.',
      },
      'wheel_sub_green_vegetative': {
        'en': 'Herbal and grassy notes associated with fresh plant matter. Can reflect terroir or light roasting. Typical of under-developed high-density beans.',
        'uk': 'Трав\'янисті та злакові ноти, пов\'язані зі свіжою рослинною матерією. Можуть відображати терруар або світле обсмаження. Типово для недорозвинених щільних зерен.',
      },
      'wheel_sub_chemical': {
        'en': 'Pungent or medicinal notes often resulting from processing defects or improper storage. Rare in specialty lots.',
        'uk': 'Гострі або аптечні ноти, що часто є результатом дефектів обробки або неправильного зберігання. Рідко зустрічаються в спешелті-лотах.',
      },
      'wheel_sub_papery': {
        'en': 'Dry, woody or stale notes reminiscent of cardboard. Often indicates old-crop beans or moisture loss during storage.',
        'uk': 'Сухі, деревні або залежалі ноти, що нагадують картон. Часто вказує на старий врожай або втрату вологи під час зберігання.',
      },

      // --- SPECIFIC NOTES (Expanding to reach 80+) ---
      'wheel_note_blackberry': {
        'en': 'Deep, dark berry sweetness with a slight tannic edge. Reminiscent of wild summer fruit. Characteristic of Kenyan coffees with high phosphorus soil.',
        'uk': 'Глибока солодкість темних ягід з легким таніновим відтінком. Нагадує лісові літні плоди. Характерно для кенійської кави, вирощеної на ґрунтах з високим вмістом фосфору.',
      },
      'wheel_note_blueberry': {
        'en': 'A distinct "jammy" and sweet berry note. Often indicates a clean natural process. The hallmark of Ethiopian Yirgacheffe and Sidamo naturals.',
        'uk': 'Виражена "джемова" і солодка ягідна нота. Часто вказує на чисту натуральну обробку. Візитна картка ефіопських сортів Іргачеф та Сідамо.',
      },
      'wheel_note_raspberry': {
        'en': 'Bright, tart berry note with floral undertones. High malic and citric acidity. Often found in high-altitude Rwandan and Burundian coffees.',
        'uk': 'Яскрава, терпка ягідна нота з квітковими відтінками. Висока яблучна та лимонна кислотність. Часто зустрічається у високогірній каві Руанди та Бурунді.',
      },
      'wheel_note_strawberry': {
        'en': 'Sweet, fragrant red fruit note. Often accompanied by creamy body. Result of slow fermentation in high-sugar cherries like Bourbon or SL28.',
        'uk': 'Солодка, ароматна нота червоних плодів. Часто супроводжується кремовим тілом. Результат повільної ферментації солодких ягід, таких як Бурбон або SL28.',
      },
      'wheel_note_raisin': {
        'en': 'Intense sun-dried sweetness with a slightly fermented edge. Reminiscent of concentrated grape sugars. Common in Yemeni and sun-dried Ethiopian lots.',
        'uk': 'Інтенсивна солодкість сушених на сонці плодів з легким ферментованим відтінком. Нагадує концентрований виноградний цукор. Зустрічається в єменських та ефіопських лотах натуральної сушки.',
      },
      'wheel_note_prune': {
        'en': 'Deep, dark dried fruit sweetness. Often indicates a more complex, heavy-bodied natural process. Typical of Brazilian pulp-naturals.',
        'uk': 'Глибока солодкість темних сухофруктів. Часто вказує на більш складну, солідну натуральну обробку. Типово для бразильських "pulp-natural" лотів.',
      },
      'wheel_note_coconut': {
        'en': 'Creamy, nutty sweetness with a tropical aromatic profile. Often emerges in anaerobic or yeast-processed honey lots. Signature of modern Costa Rican micro-lots.',
        'uk': 'Кремова, горіхова солодкість з тропічним ароматним профілем. Часто проявляється в анаеробних або дріжджових лотах обробки "Honey". Знакова нота для сучасних мікролотів з Коста-Ріки.',
      },
      'wheel_note_cherry': {
        'en': 'Classic stone fruit sweetness with systemic acidity. Relates to the coffee fruit itself. Found in many Central American washed coffees.',
        'uk': 'Класична солодкість кісточкових фруктів з системною кислотністю. Пов\'язана з самим плодом кави. Зустрічається в багатьох центральноамериканських митих лотах.',
      },
      'wheel_note_pomegranate': {
        'en': 'Complex tartness with a dry, slight bitterness. High antioxidant and acid profile. Typical of bright Kenyan and high-end Ethiopian lots.',
        'uk': 'Комплексна терпкість з сухою, легкою гірчинкою. Високий вміст антиоксидантів та кислотний профіль. Типово для яскравих кенійських та дорогих ефіопських лотів.',
      },
      'wheel_note_pineapple': {
        'en': 'Explosive tropical sweetness and high acidity. Result of anaerobic or prolonged lactic fermentation. Common in experimental micro-lots.',
        'uk': 'Вибухова тропічна солодкість і висока кислотність. Результат анаеробної або тривалої молочної ферментації. Зустрічається в експериментальних мікролотах.',
      },
      'wheel_note_grape': {
        'en': 'Juicy sweetness ranging from green to dark purple grapes. Tartaric acid dominance. Characteristic of varieties like Castillo in Colombia.',
        'uk': 'Соковита солодкість, що варіюється від зеленого до темно-фіолетового винограду. Домінування винної кислоти. Характерно для таких сортів, як Кастільйо в Колумбії.',
      },
      'wheel_note_apple': {
        'en': 'Clean, crisp sweetness linked to malic acid. Reminiscent of green or red apples depending on density. Found in many washed Ethiopian and Mexican coffees.',
        'uk': 'Чиста, хрустка солодкість, пов\'язана з яблучною кислотою. Нагадує зелені або червоні яблука залежно від щільності. Зустрічається в багатьох митих ефіопських та мексиканських лотах.',
      },
      'wheel_note_peach': {
        'en': 'Delicate, fuzzy sweetness with a smooth mouthfeel. Intermediate acidity. Hallmark of high-quality Ethiopian washed lots and some Salvadoran Pacamaras.',
        'uk': 'Ніжна солодкість з гладким відчуттям у роті. Середня кислотність. Візитна картка високоякісних ефіопських митих лотів та деяких сальвадорських пакамар.',
      },
      'wheel_note_pear': {
        'en': 'Soft, grainy sweetness with subtle acidity. Often associated with clean, elegant washed profiles. Typical of Mexican and Honduran Arabicas.',
        'uk': 'М\'яка солодкість з тонкими відтінками кислотності. Часто асоціюється з чистими, елегантними митими профілями. Типово для мексиканських та гондураських арабік.',
      },
      'wheel_note_grapefruit': {
        'en': 'Zesty citrus note with a pleasant, tonic-like bitterness. Linked to high phosphorus soils. Common in high-acid Kenyan and Rwandan coffees.',
        'uk': 'Цедрова цитрусова нота з приємною гірчинкою, схожою на тонік. Пов\'язана з ґрунтами з високим вмістом фосфору. Зустрічається у висококислотній кенійській та руандійській каві.',
      },
      'wheel_note_orange': {
        'en': 'Sweet, balanced citrus note with soft acidity. Reminiscent of orange juice or zest. Characteristic of Colombian and Salvadoran Arabicas.',
        'uk': 'Солодка, збалансована цитрусова нота з м\'якою кислотністю. Нагадує апельсиновий сік або цедру. Характерно для колумбійських та сальвадорських арабік.',
      },
      'wheel_note_lemon': {
        'en': 'Sharp, bright, and refreshing citric note. Typical of high-density beans grown in volcanic soil. Frequent in Guatemalan Huehuetenango.',
        'uk': 'Гостра, яскрава та освіжаюча лимонна нота. Типово для щільних зерен, вирощених на вулканічних ґрунтах. Часто зустрічається в гватемальському регоіні Уеуетенанго.',
      },
      'wheel_note_lime': {
        'en': 'The sharpest, most intense citrus acid. Provides a "zingy" finish. Common in extremely high-altitude lots or specific varieties like Geisha.',
        'uk': 'Найгостріша, найбільш інтенсивна цитрусова кислота. Забезпечує "іскристий" посмак. Зустрічається у надзвичайно високогірних лотах або специфічних сортах, таких як Гейша.',
      },
      'wheel_note_black_tea': {
        'en': 'Tannic, structured mouthfeel with a savory-sweet edge. Reminiscent of high-quality Pekoe. Characteristic of Yirgacheffe and many Kenyan lots.',
        'uk': 'Танінне, структуроване відчуття в роті з пікантно-солодким відтінком. Нагадує високоякісний чай Пеко. Характерно для регіону Іргачеф та багатьох кенійських лотів.',
      },
      'wheel_note_green_tea': {
        'en': 'Fresh, herbal and slightly astringent profile. Indicates very light roasting or specific high-altitude varieties. Common in delicate washed Ethiopians.',
        'uk': 'Свіжий, трав\'яний та злегка в\'яжучий профіль. Вказує на дуже світле обсмажування або специфічні високогірні сорти. Зустрічається в делікатних митих ефіопських лотах.',
      },
      'wheel_note_chamomile': {
        'en': 'Gentle, herbal and slightly honey-like sweetness. Indicates complex, low-acidity floral profiles. Often found in processed Nicaraguan coffees.',
        'uk': 'Ніжна, трав\'яна та злегка медова солодкість. Вказує на складні квіткові профілі з низькою кислотністю. Часто зустрічається в обробленій нікарагуанській каві.',
      },
      'wheel_note_rose': {
        'en': 'Soft, elegant floral sweetness. Associated with gentle roast profiles and high elevation. Found in delicate pink-bourbon varieties.',
        'uk': 'М\'яка, елегантна квіткова солодкість. Асоціюється з м\'якими профілями обсмаження та висотою. Зустрічається в делікатних сортах рожевого бурбону.',
      },
      'wheel_note_jasmine': {
        'en': 'Intensely floral and perfume-like aroma. Linked to high concentrations of linalool. The definitive note of Panamanian and Ethiopian Geshas.',
        'uk': 'Інтенсивно квітковий аромат, подібний до парфумів. Пов\'язаний з високою концентрацією ліналоолу. Визначальна нота панамських та ефіопських Гейш.',
      },
      'wheel_note_vanilla': {
        'en': 'Sweet, creamy, and subtle aromatic note. Arises during the middle of the roasting process. Often found in high-grade washed Central American lots.',
        'uk': 'Солодка, кремова та тонка ароматна нота. Виникає в середині процесу обсмажування. Часто зустрічається у висококласних митих центральноамериканських лотах.',
      },
      'wheel_note_vanilla_bean': {
        'en': 'Intense, woodsy and oily sweetness. Represents a more concentrated aromatic profile than simple vanilla. Found in unique Bourbon-variety micro-lots.',
        'uk': 'Інтенсивна, деревна та масляниста солодкість. Представляє більш концентрований ароматний профіль, ніж просто ваніль. Зустрічається в унікальних мікролотах сорту Бурбон.',
      },
      'wheel_note_molasses': {
        'en': 'Thick, dark sugary sweetness with an earthy undertone. Result of high degree of caramelization. Signature of many Brazilian and Sumatran coffees.',
        'uk': 'Густа, темна цукрова солодкість з землистим підтоном. Результат глибокої карамелізації. Характерна нота для багатьох бразильських та суматранських кав.',
      },
      'wheel_note_maple_syrup': {
        'en': 'Clean, woody and persistent sweetness. Represents high-quality, stable carbohydrate breakdown in the roast. Frequent in high-grade Guatemalan lots.',
        'uk': 'Чиста, деревна та стійка солодкість. Представляє високоякісний, стабільний розпад вуглеводів під час обсмаження. Часто зустрічається у висококласних гватемальських лотах.',
      },
      'wheel_note_caramel': {
        'en': 'Rich, sugary browning note. Universal indicator of proper roast development. Present in sweet coffees from Guatemala to Brazil.',
        'uk': 'Багата, цукрова нота карамелізації. Універсальний індикатор правильного розвитку обсмаження. Присутня в солодкій каві від Гватемали до Бразилії.',
      },
      'wheel_note_honey': {
        'en': 'Viscous, floral sweetness. Linked to high mucilage content and specific processing. Hallmarks of Costa Rican "Honey" processed lots.',
        'uk': 'Густа, квіткова солодкість. Пов\'язана з високим вмістом клейковини та специфічною обробкою. Візитна картка кави з Коста-Ріки обробки "Honey".',
      },
      'wheel_note_peanuts': {
        'en': 'Earthy, slightly oily and savory nut sweetness. Characteristic of many South American coffees and specific roast styles. Common in classic Brazilian lots.',
        'uk': 'Землиста, злегка масляниста та пікантна горіхова солодкість. Характерно для багатьох південноамериканських кав та специфічних стилів обсмаження. Зустрічається у класичній Бразилії.',
      },
      'wheel_note_hazelnut': {
        'en': 'Buttery, oily nut sweetness. Typical of medium roasts and stable varieties like Castillo or Caturra. Found throughout Latin America.',
        'uk': 'Масляниста, горіхова солодкість. Типово для середнього обсмаження та стабільних сортів, таких як Кастільйо або Катурра. Зустрічається по всій Латинській Америці.',
      },
      'wheel_note_almond': {
        'en': 'Sweet, slightly bitter nut note with a marzipan-like edge. Linked to specific amino acid profiles. Common in clean, washed Honduran and Salvadoran coffees.',
        'uk': 'Солодка, злегка гіркувата горіхова нота з відтінком марципану. Пов\'язана зі специфічними амінокислотними профілями. Зустрічається у чистих, митих лотах з Гондурасу та Сальвадору.',
      },
      'wheel_note_chocolate': {
        'en': 'Foundational cocoa sweetness. Result of browning reactions. Classic note for Brazilian, Indian, and Vietnamese high-quality robustas and arabicas.',
        'uk': 'Основна какао-солодкість. Результат реакцій карамелізації. Класична нота для бразильської, індійської та в\'єтнамської високоякісної робусти та арабіки.',
      },
      'wheel_note_dark_chocolate': {
        'en': 'Intense, bitter-sweet cocoa richness. Marks high degree of development or specific terroir genetics. Constant in high-altitude Sumatran coffees.',
        'uk': 'Інтенсивна, гірко-солодка насиченість какао. Вказує на високий ступінь розвитку або специфічну генетику терруару. Постійна нота у високогірній суматранській каві.',
      },
      'wheel_note_clove': {
        'en': 'Spicy, pungent note with a warm sensation. Result of specific phenolic compounds. Found in some Rwandan and Burundian coffees.',
        'uk': 'Пряна, гостра нота з відчуттям тепла. Результат дії специфічних фенольних сполук. Зустрічається в деяких лотах з Руанди та Бурунді.',
      },
      'wheel_note_cinnamon': {
        'en': 'Sweet, woody spice note. Common in medium-light roasts of dense coffees. Frequent in Yemeni and some Ethiopian coffees.',
        'uk': 'Солодка, деревна пряна нота. Поширена в середньо-світлому обсмаженні щільної кави. Часто зустрічається в єменській та деякій ефіопській каві.',
      },
      'wheel_note_nutmeg': {
        'en': 'Earthy and warm spice profile. Often complements chocolate and nutty sweetness. Characteristic of high-grade Indonesian Arabicas.',
        'uk': 'Землистий та теплий пряний профіль. Часто доповнює шоколадну та горіхову солодкість. Характерно для висококласних індонезійських арабік.',
      },
      'wheel_note_anise': {
        'en': 'Cool, sweet and slightly medicinal spice note. Reminiscent of licorice. Found in some rare Yemeni and complex African lots.',
        'uk': 'Прохолодна, солодка та злегка аптечна пряна нота. Нагадує лакрицю. Зустрічається у деяких рідкісних єменських та складних африканських лотах.',
      },
      'wheel_note_malt': {
        'en': 'Sweet, grain-like note reminiscent of beer or freshly baked bread. Indicator of specific sugar-amino-acid reactions. Common in traditional Brazilian coffees.',
        'uk': 'Солодка, зернова нота, що нагадує пиво або свіжоспечений хліб. Індикатор специфічних реакцій цукру та амінокислот. Зустрічається в традиційній бразильській каві.',
      },
      'wheel_note_grain': {
        'en': 'Basic, foundational toasted cereal note. Often reflects terroir or specific harvest conditions. Found in many Latin American Arabicas.',
        'uk': 'Базова, основна нота підсмажених злаків. Часто відображає терруар або специфічні умови врожаю. Зустрічається в багатьох латиноамериканських арабіках.',
      },
      'wheel_note_smoky': {
        'en': 'Intense char and wood-smoke notes. Typical of dark-roast profiles where pyrolysis dominates. Quintessential for South Italian espresso styles.',
        'uk': 'Інтенсивні ноти вугілля та деревного диму. Типово для профілів темного обсмаження, де домінує піроліз. Квінтесенція стилів південноіталійського еспресо.',
      },
      'wheel_note_ashy': {
        'en': 'Dry, carbonaceous and mineral-like note. Indicates extreme roast exposure. Found in commercial-grade dark roasts.',
        'uk': 'Суха, вуглецева та мінеральна нота. Вказує на екстремальний вплив тепла під час обсмаження. Зустрічається в комерційних лотах темного обсмаження.',
      },
      'wheel_note_olive_oil': {
        'en': 'Unique, buttery and slightly vegetal mouthfeel. Reflects high concentration of specific lipids. Arises in certain Peruvian and Ecuadorian micro-lots.',
        'uk': 'Унікальне, маслянисте та злегка рослинне відчуття в роті. Відображає високу концентрацію специфічних ліпідів. Проявляється в певних перуанських та еквадорських мікролотах.',
      },
      'wheel_note_raw': {
        'en': 'Undeveloped, grassy note indicating short roast time or low moisture loss. Common in very fast light roasts.',
        'uk': 'Недорозвинена, злакова нота, що вказує на короткий час обсмажування або низьку втрату вологи. Зустрічається у дуже швидких світлих профілях.',
      },
      'wheel_note_under_ripe': {
        'en': 'Sharp, green acidity reminiscent of unripe fruit. Indicates non-uniform cherry harvesting. Present in some commercial-grade mixed lots.',
        'uk': 'Гостра, зелена кислотність, що нагадує недозрілі фрукти. Вказує на неоднорідний збір ягід. Присутня у деяких комерційних змішаних лотах.',
      },
      'wheel_note_peapod': {
        'en': 'Savory, vegetal note reminiscent of fresh peas. Often reflects specific soil minerals or light roasting of high-density beans. Common in Rwandans.',
        'uk': 'Пікантна, рослинна нота, що нагадує свіжий горох. Часто відображає специфічні мінерали ґрунту або світле обсмаження щільних зерен. Зустрічається в Руанді.',
      },
      'wheel_note_fresh': {
        'en': 'Vibrant, green and bright profile. Positive vegetal note indicating fresh-crop beans and light processing. Common in high-grown Peruvians.',
        'uk': 'Яскравий, зелений та чистий профіль. Позитивна рослинна нота, що вказує на свіжий врожай та світлу обробку. Зустрічається у високогірній каві з Перу.',
      },
      'wheel_note_vegetative': {
        'en': 'Broad herbal profile encompassing leaves and stems. Reflects high levels of specific pyrazines. Characteristic of Indonesian Mandheling.',
        'uk': 'Широкий трав\'яний профіль, що охоплює листя та стебла. Відображає високий рівень специфічних піразинів. Характерно для індонезійського сорту Манделінг.',
      },
      'wheel_note_hay_like': {
        'en': 'Dry, sweet grass and straw profile. Often indicates early signs of bean aging or specific terroir dryness. Frequent in processed Brazilian lots.',
        'uk': 'Профіль сухої, солодкої трави та соломи. Часто вказує на перші ознаки старіння зерен або специфічну сухість терруару. Часто зустрічається в обробленій Бразилії.',
      },
      'wheel_note_herb_like': {
        'en': 'Savory herb notes like rosemary or thyme. Correlated with specific volcanic soil profiles. Hallmark of specialty lots from Timor and Bali.',
        'uk': 'Ноти пряних трав, таких як розмарин або чебрець. Корелює зі специфічними вулканічними ґрунтами. Візитна картка спешелті-лотів з Тімору та Балі.',
      },
      'wheel_note_sour_aromatics': {
        'en': 'Tangy and complex acidic scents. Essential for structure in high-grown coffees. Present in almost all high-attribute Central Americans.',
        'uk': 'Гострі та складні кислі запахи. Важливі для структури високогірної кави. Присутні майже у всіх високопродуктивних лотах з Центральної Америки.',
      },
      'wheel_note_acetic_acid': {
        'en': 'Sharp, vinegar-like acidity. Normal at low levels; indicates over-fermentation if aggressive. Found in long-fermented "Funky" Colombian lots.',
        'uk': 'Гостра, схожа на оцет кислотність. Нормальна при низьких рівнях; вказує на надмірну ферментацію, якщо агресивна. Зустрічається у "Funky" колумбійських лотах тривалої ферментації.',
      },
      'wheel_note_butyric_acid': {
        'en': 'Heady and pungent acid profile reminiscent of Greek yogurt or cheese. Result of intensive metabolic processing. Signature of modern experimental ferments.',
        'uk': 'П\'янкий та гострий кислотний профіль, що нагадує грецький йогурт або сир. Результат інтенсивної метаболічної обробки. Знакова нота для сучасних експериментальних ферментацій.',
      },
      'wheel_note_isovaleric_acid': {
        'en': 'Strong, cheese-like or sweaty acid note. Characteristic of extremely long anaerobic fermentations. Often polarizing but sought after in modern competitions.',
        'uk': 'Сильна, схожа на сир або піт кислотна нота. Характерно для надзвичайно тривалих анаеробних ферментацій. Часто викликає суперечки, але цінується на сучасних чемпіонатах.',
      },
      'wheel_note_citric_acid': {
        'en': 'Pure, refreshing and bright acidity. The primary acid in most specialty coffees. Quintessential Kenyan and Colombian profile.',
        'uk': 'Чиста, освіжаюча та яскрава кислотність. Основна кислота в більшості спешелті-кави. Квінтесенція профілю Кенії та Колумбії.',
      },
      'wheel_note_malic_acid': {
        'en': 'Crisp and structural acidity that provides body and sweetness. Common in heavy coffee varieties like Bourbon. Hallmarks of Burundian coffees.',
        'uk': 'Хрустка та структурна кислотність, що забезпечує тіло та солодкість. Поширена у важких сортах кави, таких як Бурбон. Візитна картка кави з Бурунді.',
      },
      'wheel_note_winey': {
        'en': 'Heady, fruity acidity reminiscent of red wine. Result of controlled fruit fermentation. Iconic for natural Ethiopians and Colombian anaerobic lots.',
        'uk': 'П\'янка, фруктова кислотність, що нагадує червоне вино. Результат контрольованої ферментації плодів. Знакова для натуральної Ефіопії та колумбійських анаеробних лотів.',
      },
      'wheel_note_whiskey': {
        'en': 'Complex, alcoholic and woody notes. Indicates intense, prolonged fermentation. Typical of experimental "Spirit-process" lots.',
        'uk': 'Комплексні, алкогольні та деревні ноти. Вказує на інтенсивну, тривалу ферментацію. Типово для експериментальних лотів "Spirit-process".',
      },
      'wheel_note_over_ripe': {
        'en': 'Deep, slightly boozy sweetness of fruit just past its prime. Adds weight to natural processed lots. Common in Brazilian naturals.',
        'uk': 'Глибока, злегка хмільна солодкість фруктів, що щойно минули пік стиглості. Додає ваги лотам натуральної обробки. Поширено в бразильських натуральних лотах.',
      },
      'wheel_note_rubber': {
        'en': 'Dense, pungent note often associated with the genetics of Robusta. Can appear in some intense Brazilian clones. Rare in Arabica.',
        'uk': 'Щільна, гостра нота, що часто асоціюється з генетикою робусти. Може з\'являтися у деяких інтенсивних бразильських клонах. Рідко зустрічається в арабіці.',
      },
      'wheel_note_petroleum': {
        'en': 'Sharp, industrial aromatic note. Usually indicates contamination or major storage faults. Unacceptable in specialty coffee.',
        'uk': 'Гостра, технічна ароматна нота. Зазвичай вказує на забруднення або серйозні помилки зберігання. Неприпустимо для спешелті-кави.',
      },
      'wheel_note_medicinal': {
        'en': 'Iodine or phenol-like scent. Often result of water-borne pathogens during processing. Indicator of poor quality control.',
        'uk': 'Запах йоду або фенолу. Часто є результатом дії патогенів у воді під час обробки. Індикатор низького контролю якості.',
      },
      'wheel_note_stale': {
        'en': 'Flat, dull profile lacking aromatics. Direct indicator of oxidation and lack of freshness. Common in old warehouse stocks.',
        'uk': 'Плоский, тьмяний профіль без ароматики. Прямий індикатор окислення та відсутності свіжості. Часто зустрічається на старих складських залишках.',
      },
      'wheel_note_musty': {
        'en': 'Damp and earthy fault associated with moisture damage. Result of fungal growth during drying. Defect associated with poor processing.',
        'uk': 'Вологий та землистий дефект, пов\'язаний пошкодженням вологою. Результат росту грибків під час сушіння. Дефект, пов\'язаний з поганою обробкою.',
      },
      'wheel_note_dusty': {
        'en': 'Dry, mineral-like flatness. Often indicates improper cleaning of the lot or exposure to fine particulates. Found in lower-grade commercial lots.',
        'uk': 'Суха, мінеральна плоскість. Часто вказує на неналежне очищення лоту або вплив дрібних часток. Зустрічається у комерційних лотах нижчого сорту.',
      },
    };

    return descriptions[key]?[locale] ?? (locale == 'uk' ? 'Опис скоро з\'явиться...' : 'Description coming soon...');
  }
}
