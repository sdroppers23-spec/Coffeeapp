import re
import os

def update_localization(file_path, key, translations):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Find the block for the key
    pattern = re.compile(f"'{key}': \\{{(.*?)\\}},", re.DOTALL)
    match = pattern.search(content)
    
    if not match:
        print(f"Key {key} not found")
        return

    original_block = match.group(0)
    
    # Construct new block
    new_block = f"'{key}': {{\n"
    for lang, text in translations.items():
        # Escape single quotes
        escaped_text = text.replace("'", "\\'")
        new_block += f"        '{lang}':\n            '{escaped_text}',\n"
    new_block += "      },"

    content = content.replace(original_block, new_block)
    
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(content)

file_path = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

data = {
    'wheel_sub_brown_spice': {
        'en': 'Warm, sweet spice notes that develop as sugars caramelize. Rich in phenolic compounds. Characteristic of Sumatran and Rwandan coffees.',
        'uk': 'Теплі, солодкі пряні ноти, що розвиваються при карамелізації цукрів. Багаті на фенольні сполуки. Характерно для суматранської та руандійської кави.',
        'de': 'Warme, süße Gewürznoten, die bei der Karamellisierung von Zucker entstehen. Reich an phenolischen Verbindungen. Charakteristisch für Sumatra- und Ruanda-Kaffees.',
        'fr': 'Notes d\'épices chaudes et sucrées qui se développent lors de la caramélisation des sucres. Riche en composés phénoliques. Caractéristique des cafés de Sumatra et du Rwanda.',
        'es': 'Notas de especias cálidas y dulces que se desarrollan a medida que los azúcares se caramelizan. Rico en compuestos fenólicos. Característico de los cafés de Sumatra y Ruanda.',
        'it': 'Note di spezie calde e dolci che si sviluppano con la caramellizzazione degli zuccheri. Ricco di composti fenolici. Caratteristico dei caffè di Sumatra e del Ruanda.',
        'pt': 'Notas de especiarias quentes e doces que se desenvolvem à medida que os açúcares caramelizam. Rico em compostos fenólicos. Característico dos cafés de Sumatra e Ruanda.',
        'pl': 'Ciepłe, słodkie nuty przyprawowe, które rozwijają się podczas karmelizacji cukrów. Bogate w związki fenolowe. Charakterystyczne dla kaw z Sumatry i Rwandy.',
        'nl': 'Warme, zoete kruidige tonen die ontstaan bij het karameliseren van suikers. Rijk aan fenolische verbindingen. Kenmerkend voor Sumatraanse en Rwandese koffiesoorten.',
        'sv': 'Varma, söta kryddnoter som utvecklas när socker karamelliseras. Rik på fenoliska föreningar. Karaktäristiskt för kaffe från Sumatra och Rwanda.',
        'tr': 'Şekerler karamelize oldukça gelişen sıcak, tatlı baharat notaları. Fenolik bileşikler açısından zengindir. Sumatra ve Ruanda kahvelerinin özelliğidir.',
        'ja': '糖分がカラメル化する際に生まれる、温かく甘いスパイスのノート。フェノール化合物が豊富です。スマトラ産やルワンダ産コーヒーの特徴です。',
        'ko': '설탕이 카라멜화되면서 발달하는 따뜻하고 달콤한 스파이스 노트입니다. 페놀 화합물이 풍부합니다. 수마트라와 르완다 커피의 특징입니다.',
        'zh': '随着糖分焦糖化而产生的温暖、甜美的香料味。富含酚类化合物。是苏门答腊和卢旺达咖啡的特征。',
        'ar': 'نوتات توابل دافئة وحلوة تتطور مع كراميلة السكريات. غنية بالمركبات الفينولية. مميزة لأنواع القهوة من سومطرة ورواندا.'
    },
    'wheel_sub_cereal': {
        'en': 'Toasted grain and bread-like notes. Indicative of early roast stages or specific bean density. Common in many Brazilian and Indian lots.',
        'uk': 'Ноти підсмаженого зерна та хліба. Вказують на ранні стадії обсмажування або специфічну щільність зерна. Зустрічається в багатьох бразильських та індійських лотах.',
        'de': 'Noten von geröstetem Getreide und Brot. Hinweis auf frühe Röstphasen oder spezifische Bohnendichte. Häufig in vielen brasilianischen und indischen Lots.',
        'fr': 'Notes de céréales grillées et de pain. Indique les premières étapes de la torréfaction ou une densité de grain spécifique. Commun dans de nombreux lots brésiliens et indiens.',
        'es': 'Notas de cereales tostados y pan. Indica etapas tempranas de tostado o una densidad de grano específica. Común en muchos lotes brasileños e indios.',
        'it': 'Note di cereali tostati e pane. Indica le prime fasi di tostatura o una specifica densità del chicco. Comune in molti lotti brasiliani e indiani.',
        'pt': 'Notas de cereais torrados e pão. Indica estágios iniciais de torra ou densidade específica do grão. Comum em muitos lotes brasileiros e indianos.',
        'pl': 'Nuty prażonego ziarna i chleba. Wskazują на wczesne etapy palenia lub specyficzną gęstość ziarna. Występują w wielu brazylijskich i indyjskich partiach kawy.',
        'nl': 'Noten van geroosterd graan en brood. Indicatief voor vroege brandfases of specifieke boon-dichtheid. Veelvoorkomend in veel Braziliaanse en Indiase kavels.',
        'sv': 'Noter av rostat spannmål och bröd. Tyder på tidiga rostningsstadier eller specifik bön-densitet. Vanligt i många brasilianska och indiska partier.',
        'tr': 'Kavrulmuş tahıl ve ekmek benzeri notalar. Erken kavurma aşamalarını veya özel çekirdek yoğunluğunu gösterir. Birçok Brezilya ve Hindistan lotunda yaygındır.',
        'ja': 'トーストした穀物やパンのようなノート。焙煎の初期段階や特定の豆の密度を示します。多くのブラジル産やインド産コーヒーに見られます。',
        'ko': '구운 곡물과 빵 같은 노트입니다. 초기 로스팅 단계나 특정 생두 밀도를 나타냅니다. 많은 브라질과 인도 커피에서 흔히 발견됩니다.',
        'zh': '烘烤谷物和面包般的香气。预示着烘焙早期阶段或特定的咖啡豆密度。在许多巴西和印度批次中很常见。',
        'ar': 'نوتات الحبوب المحمصة والخبز. تشير إلى مراحل التحميص المبكرة أو كثافة معينة للحبوب. شائعة في العديد من المحاصيل البرازيلية والهندية.'
    },
    'wheel_sub_burnt': {
        'en': 'Intense, smoky, and charred aromas. Result of deep roasting or surface bean scorching. Characteristic of Italian and French roast profiles.',
        'uk': 'Інтенсивні, димні та обвуглені аромати. Результат глибокого обсмажування або перегріву поверхні зерна. Характерно для профілів італійського та французького обсмаження.',
        'de': 'Intensive, rauchige und verkohlte Aromen. Ergebnis einer tiefen Röstung oder eines Verbrennens der Bohnenoberfläche. Charakteristisch für italienische und französische Röstprofile.',
        'fr': 'Arômes intenses, fumés et carbonisés. Résultat d\'une torréfaction poussée ou d\'un brûlage de la surface du grain. Caractéristique des profils de torréfaction italienne et française.',
        'es': 'Aromas intensos, ahumados y carbonizados. Resultado de un tostado profundo o quemado superficial del grano. Característico de los perfiles de tostado italiano y francés.',
        'it': 'Aromi intensi, fumosi e bruciati. Risultato di una tostatura profonda o di una bruciatura superficiale del chicco. Caratteristico dei profili di tostatura italiana e francese.',
        'pt': 'Aromas intensos, defumados e carbonizados. Resultado de uma torra profunda ou queima superficial do grão. Característico dos perfis de torra italiana e francesa.',
        'pl': 'Intensywne, dymne i przypalone aromaty. Wynik głębokiego palenia lub przypalenia powierzchni ziarna. Charakterystyczne dla włoskich i francuskich profili palenia.',
        'nl': 'Intense, rokerige en verkoolde aroma\'s. Resultaat van diep branden oder verbranding van het boon-oppervlak. Kenmerkend voor Italiaanse en Franse brandingsprofielen.',
        'sv': 'Intensiva, rökiga och brända aromer. Resultat av djup rostning eller bränning av bönans yta. Karaktäristiskt för italienska och franska rostningsprofiler.',
        'tr': 'Yoğun, isli ve yanık aromalar. Derin kavurmanın veya çekirdek yüzeyinin yanmasının sonucudur. İtalyan ve Fransız kavurma profillerinin özelliğidir.',
        'ja': '強烈で、スモーキー、そして焦げたようなアロマ。深煎りや豆の表面の焦げの結果です。イタリアンローストやフレンチローストの特徴です。',
        'ko': '강렬하고 스모키하며 탄 듯한 아로마입니다. 딥 로스팅이나 원두 표면이 그을린 결과입니다. 이탈리안 및 프렌치 로스팅 프로파일의 특징입니다.',
        'zh': '强烈、烟熏和烧焦的香气。是深度烘焙或豆表焦灼的结果。是意式和法式烘焙风格的特征。',
        'ar': 'روائح مكثفة ومدخنة ومتفحمة. ناتجة عن التحميص العميق أو احتراق سطح الحبوب. مميزة لملفات التحميص الإيطالية والفرنسية.'
    },
    'wheel_sub_green_vegetative': {
        'en': 'Fresh, grassy, and plant-like notes. Often indicative of roast underdevelopment or specific terroir traits. Common in some high-altitude Central American lots.',
        'uk': 'Свіжі, трав\'янисті та рослинні ноти. Часто вказують на недостатній розвиток при обсмажуванні або специфіку терруару. Властиво деяким високогірним сортам з Центральної Америки.',
        'de': 'Frische, grasige und pflanzenartige Noten. Oft ein Hinweis auf eine unzureichende Röstentwicklung oder spezifische Terroir-Merkmale. Häufig in einigen mittelamerikanischen Hochlandkaffees.',
        'fr': 'Notes fraîches, herbacées et végétales. Souvent indicatif d\'un sous-développement de la torréfaction ou de traits de terroir spécifiques. Commun dans certains lots de haute altitude d\'Amérique centrale.',
        'es': 'Notas frescas, herbáceas y vegetales. A menudo indica una falta de desarrollo en el tostado o rasgos específicos del terroir. Común en algunos lotes de gran altura de América Central.',
        'it': 'Note fresche, erbacee e vegetali. Spesso indicano un sottosviluppo della tostatura o tratti specifici del terroir. Comune in alcuni lotti ad alta quota dell\'America Centrale.',
        'pt': 'Notas frescas, herbáceas e vegetais. Frequentemente indica falta de desenvolvimento na torra ou traços específicos do terroir. Comum em alguns lotes de alta altitude da América Central.',
        'pl': 'Świeże, trawiaste i roślinne nuty. Często wskazują на niedostateczne wypalenie lub specyficzne cechy terroir. Charakterystyczne dla niektórych wysokogórskich kaw z Ameryki Środkowej.',
        'nl': 'Verse, grassige en plantachtige noten. Vaak een indicatie van een onderontwikkeling van de branding of specifieke terroir-kenmerken. Veelvoorkomend in sommige Midden-Amerikaanse kavels op grote hoogte.',
        'sv': 'Friska, gräsiga och växtliknande noter. Ofta tyder det på underutveckling vid rostning eller specifika terroir-drag. Vanligt i vissa höghöjdspartier från Centralamerika.',
        'tr': 'Taze, otsu ve bitki benzeri notalar. Genellikle kavurma yetersizliğinin veya özel teruar özelliklerinin göstergesidir. Bazı yüksek rakımlı Orta Amerika lotlarında yaygındır.',
        'ja': '新鮮で、草のような、植物のようなノート。焙煎不足や特定のテロワールの特徴を示すことが多いです。中米の高地産コーヒーによく見られます。',
        'ko': '신선하고 풀 같으며 식물 같은 노트입니다. 종종 로스팅 부족이나 특정 테루아 특성을 나타냅니다. 일부 고지대 중앙아메리카 커피에서 흔히 발견됩니다.',
        'zh': '新鲜、青草和植物般的气息。通常预示着烘焙程度不足或特定的产地特征。在一些高海拔的中美洲批次中很常见。',
        'ar': 'نوتات طازجة وعشبية ونباتية. غالباً ما تشير إلى نقص تطوير التحميص أو سمات تربة معينة. شائعة في بعض المحاصيل المرتفعة من أمريكا الوسطى.'
    },
    'wheel_sub_chemical': {
        'en': 'Sharp, artificial, or medicinal aromas. Can indicate processing defects or external contamination. Usually considered a negative trait in specialty coffee.',
        'uk': 'Різкі, штучні або медичні аромати. Можуть вказувати на дефекти обробки або стороннє забруднення. Зазвичай вважаються негативним фактором у спешелті-каві.',
        'de': 'Scharfe, künstliche oder medizinische Aromen. Können auf Verarbeitungsfehler oder externe Kontamination hinweisen. Gelten im Specialty Coffee meist als negativer Faktor.',
        'fr': 'Arômes vifs, artificiels ou médicinaux. Peut indiquer des défauts de traitement ou une contamination externe. Généralement considéré comme un trait négatif dans le café de spécialité.',
        'es': 'Aromas punzantes, artificiales o medicinales. Pueden indicar defectos de procesamiento o contaminación externa. Generalmente se consideran un rasgo negativo en el café de especialidad.',
        'it': 'Aromi pungenti, artificiali o medicinali. Possono indicare difetti di lavorazione o contaminazione esterna. Solitamente considerati un tratto negativo nel caffè specialty.',
        'pt': 'Aromas nítidos, artificiais ou medicinais. Podem indicar defeitos de processamento ou contaminação externa. Geralmente considerados um traço negativo no café especial.',
        'pl': 'Ostre, sztuczne lub medyczne aromaty. Mogą wskazywać на wady obróbki lub zanieczyszczenie zewnętrzne. Zazwyczaj uważane za negatywną cechę в kawie specialty.',
        'nl': 'Scherpe, kunstmatige of medicinale aroma\'s. Kunnen duiden op verwerkingsfouten of externe besmetting. Wordt meestal als een negatief kenmerk beschouwd in specialty coffee.',
        'sv': 'Skarpa, konstgjorda eller medicinska aromer. Kan tyda på bearbetningsdefekter eller extern förorening. Betraktas vanligtvis som ett negativt drag i specialty coffee.',
        'tr': 'Keskin, yapay veya tıbbi aromalar. İşleme kusurlarını veya dış kirlenmeyi gösterebilir. Nitelikli kahvede genellikle olumsuz bir özellik olarak kabul edilir.',
        'ja': '鋭く、人工的、または薬のようなアロマ。精製過程の欠陥や外部の汚染を示すことがあります。スペシャリティコーヒーでは通常、ネガティブな特徴とされます。',
        'ko': '날카롭고 인공적이거나 약품 같은 아로마입니다. 가공 결함이나 외부 오염을 나타낼 수 있습니다. 스페셜티 커피에서는 보통 결점으로 간주됩니다.',
        'zh': '尖锐、人造或药用气味。可能预示着加工缺陷或外部污染。在精品咖啡中通常被视为负面特征。',
        'ar': 'روائح حادة أو اصطناعية أو طبية. قد تشير إلى عيوب في المعالجة أو تلوث خارجي. تعتبر عادةً سمة سلبية في القهوة المختصة.'
    },
    'wheel_sub_papery': {
        'en': 'Dry notes reminiscent of cardboard or old wood. Often a sign of green bean aging or freshness loss during storage.',
        'uk': 'Сухі ноти, що нагадують картон або стару деревину. Часто є ознакою старіння зеленого зерна або втрати свіжості при зберіганні.',
        'de': 'Trockene Noten, die an Pappe oder altes Holz erinnern. Oft ein Zeichen für die Alterung von Rohkaffee oder Frischeverlust bei der Lagerung.',
        'fr': 'Notes sèches rappelant le carton ou le vieux bois. Souvent un signe de vieillissement du grain vert ou d\'une perte de fraîcheur lors du stockage.',
        'es': 'Notas secas que recuerdan al cartón o a la madera vieja. A menudo es un signo de envejecimiento del grano verde o pérdida de frescura durante el almacenamiento.',
        'it': 'Note secche che ricordano il cartone o il legno vecchio. Spesso segno di invecchiamento del chicco verde o perdita di freschezza durante lo stoccaggio.',
        'pt': 'Notas secas que lembram papelão ou madeira velha. Muitas vezes um sinal de envelhecimento do grão verde ou perda de frescor durante o armazenamento.',
        'pl': 'Suche nuty przypominające karton lub stare drewno. Często są oznaką starzenia się zielonego ziarna lub utraty świeżości podczas przechowywania.',
        'nl': 'Droge tonen die doen denken aan karton of oud hout. Vaak een teken van veroudering van de groene boon of versheidsverlies tijdens opslag.',
        'sv': 'Torra noter som påminner om kartong eller gammalt trä. Ofta ett tecken på att det gröna kaffet har åldrats eller förlorat sin färskhet under lagring.',
        'tr': 'Karton veya eski odunu andıran kuru notalar. Genellikle yeşil çekirdeğin yaşlanmasının veya depolama sırasında tazelik kaybının bir işaretidir.',
        'ja': '段ボールや古い木を思わせるドライなノート。生豆の経年劣化や保管中の鮮度喪失の兆候であることが多いです。',
        'ko': '판지나 오래된 나무를 연상시키는 건조한 노트입니다. 종종 생두의 노화나 보관 중 신선도 상실의 징후입니다.',
        'zh': '让人联想到纸板或老旧木材的干涩气息。通常是生豆老化或储存期间失去新鲜感的迹象。',
        'ar': 'نوتات جافة تشبه الورق المقوى أو الخشب القديم. غالباً ما تكون علامة على تقادم الحبوب الخضراء أو فقدان الطزاجة أثناء التخزين.'
    },
    'wheel_note_clove': {
        'en': 'Spicy, pungent note with a warm sensation. Result of specific phenolic compounds. Found in some Rwandan and Burundian coffees.',
        'uk': 'Пряна, гостра нота з відчуттям тепла. Результат дії специфічних фенольних сполук. Зустрічається в деяких лотах з Руанди та Бурунді.',
        'de': 'Würzige, stechende Note mit einem warmen Gefühl. Ergebnis spezifischer phenolischer Verbindungen. In einigen ruandischen und burundischen Kaffees zu finden.',
        'fr': 'Note épicée et piquante avec une sensation de chaleur. Résultat de composés phénoliques spécifiques. Présente dans certains cafés rwandais et burundais.',
        'es': 'Nota especiada y picante con una sensación cálida. Resultado de compuestos fenólicos específicos. Se encuentra en algunos cafés de Ruanda y Burundi.',
        'it': 'Nota speziata e pungente con una sensazione calda. Risultato di specifici composti fenolici. Presente in alcuni caffè del Ruanda e del Burundi.',
        'pt': 'Nota de especiarias picante com sensação de calor. Resultado de compostos fenólicos específicos. Encontrada em alguns cafés de Ruanda e Burundi.',
        'pl': 'Korzenna, ostra nuta dająca uczucie ciepła. Wynik działania specyficznych związków fenolowych. Występuje w niektórych kawach z Rwandy i Burundi.',
        'nl': 'Kruidige, scherpe noot met een warm gevoel. Resultaat van specifieke fenolische verbindingen. Te vinden in sommige Rwandese en Burundese koffiesoorten.',
        'sv': 'Kryddig, stickande not med en varm känsla. Resultat av specifika fenoliska föreningar. Finns i vissa kaffesorter från Rwanda och Burundi.',
        'tr': 'Sıcaklık hissi veren baharatlı, keskin nota. Özel fenolik bileşiklerin sonucudur. Bazı Ruanda ve Burundi kahvelerinde bulunur.',
        'ja': 'スパイシーで刺激的、かつ温かみのあるノート。特定のフェノール化合物によるものです。ルワンダ産やブルンジ産の一部のコーヒーに見られます。',
        'ko': '따뜻한 느낌을 주는 톡 쏘는 스파이스 노트입니다. 특정 페놀 화합물의 결과입니다. 일부 르완다와 부룬디 커피에서 발견됩니다.',
        'zh': '具有温暖感的辛辣、刺鼻气息。是特定酚类化合物的结果。在一些卢旺达和布隆迪咖啡中可见。',
        'ar': 'نوتة حريفة ولاذعة مع إحساس بالدفء. ناتجة عن مركبات فينولية معينة. توجد في بعض أنواع القهوة الرواندية والبوروندية.'
    },
    'wheel_note_cinnamon': {
        'en': 'Sweet, woody spice note. Common in medium-light roasts of dense coffees. Frequent in Yemeni and some Ethiopian coffees.',
        'uk': 'Солодка, деревна пряна нота. Поширена в середньо-світлому обсмаженні щільної кави. Часто зустрічається в єменській та деякій ефіопській каві.',
        'de': 'Süße, holzige Gewürznote. Häufig bei mittelhellen Röstungen dichter Kaffees. Oft in jemenitischen und einigen äthiopischen Kaffees.',
        'fr': 'Note d\'épice douce et boisée. Commune dans les torréfactions moyennes-claires de cafés denses. Fréquente dans les cafés yéménites et certains cafés éthiopiens.',
        'es': 'Nota de especia dulce y amaderada. Común en tostados medios-claros de cafés densos. Frecuente en cafés yemeníes y algunos etíopes.',
        'it': 'Nota di spezia dolce e legnosa. Comune nelle tostature medio-chiare di caffè densi. Frequente nei caffè yemeniti e in alcuni caffè etiopi.',
        'pt': 'Nota de especiaria doce e amadeirada. Comum em torras médias-claras de cafés densos. Frequente em cafés iemenitas e alguns etíopes.',
        'pl': 'Słodka, drzewna nuta przyprawowa. Często spotykana в średnio-jasnym paleniu gęstych kaw. Częsta в kawach jemeńskich i niektórych etiopskich.',
        'nl': 'Zoete, houtachtige kruidige noot. Veelvoorkomend bij medium-lichte brandingen van koffie met een hoge dichtheid. Vaak in Jemenitische en sommige Ethiopische koffiesoorten.',
        'sv': 'Söt, träig kryddnot. Vanlig i ljus mellanrost av täta kaffesorter. Förekommer ofta i jemenitiskt och visst etiopiskt kaffe.',
        'tr': 'Tatlı, odunsu baharat notası. Yoğun kahvelerin orta-açık kavurmalarında yaygındır. Yemen ve bazı Etiyopya kahvelerinde sıklıkla görülür.',
        'ja': '甘く、ウッディなスパイスのノート。密度の高い豆の中浅煎りでよく見られます。イエメン産や一部のエチオピア産コーヒーに頻繁に現れます。',
        'ko': '달콤하고 우디한 스파이스 노트입니다. 밀도가 높은 생두의 미디엄-라이트 로스팅에서 흔히 발견됩니다. 예멘과 일부 에티오피아 커피에서자주 나타납니다.',
        'zh': '甜美的木质香料味。常见于高密度咖啡的中浅度烘焙。在也门和一些埃塞俄比亚咖啡中经常出现。',
        'ar': 'نوتة توابل حلوة وخشبية. شائعة في التحميص المتوسط الفاتح للقهوة الكثيفة. تتكرر في أنواع القهوة اليمنية وبعض أنواع القهوة الإثيوبية.'
    },
    'wheel_note_nutmeg': {
        'en': 'Earthy and warm spice profile. Often complements chocolate and nutty sweetness. Characteristic of high-grade Indonesian Arabicas.',
        'uk': 'Землистий та теплий пряний профіль. Часто доповнює шоколадну та горіхову солодкість. Характерно для висококласних індонезійських арабік.',
        'de': 'Erdiges und warmes Gewürzprofil. Ergänzt oft Schokolade und nussige Süße. Charakteristisch für hochwertige indonesische Arabicas.',
        'fr': 'Profil d\'épices terreux et chaud. Complète souvent la douceur du chocolat et des noix. Caractéristique des Arabicas indonésiens de haute qualité.',
        'es': 'Perfil de especias terroso y cálido. A menudo complementa el dulzor del chocolate y las nueces. Característico de los arábicas indonesios de alta calidad.',
        'it': 'Profilo di spezie terroso e caldo. Spesso completa la dolcezza del cioccolato e della frutta a guscio. Caratteristico degli Arabica indonesiani di alta qualità.',
        'pt': 'Perfil de especiarias terroso e quente. Frequentemente complementa a doçura do chocolate e das nozes. Característico dos Arábicas indonésios de alta qualidade.',
        'pl': 'Ziemisty i ciepły profil przyprawowy. Często dopełnia czekoladową i orzechową słodycz. Charakterystyczny dla wysokiej klasy indonezyjskich arabik.',
        'nl': 'Aards en warm kruidig profiel. Vult vaak de zoetheid van chocolade en noten aan. Kenmerkend voor hoogwaardige Indonesische Arabica\'s.',
        'sv': 'Jordig och varm kryddprofil. Kompletterar ofta choklad och nötig sötma. Karaktäristiskt för indonesisk arabica av hög kvalitet.',
        'tr': 'Topraksı ve sıcak baharat profili. Genellikle çikolata ve fındıksı tatlılığı tamamlar. Üst düzey Endonezya Arabica\'larının özelliğidir.',
        'ja': '土っぽく温かみのあるスパイスのプロフィール。チョコレートやナッツの甘さを補完することが多いです。高級なインドネシア産アラビカ種の特徴です。',
        'ko': '흙 내음이 나고 따뜻한 스파이스 프로파일입니다. 종종 초콜릿과 견과류의 달콤함을 보완합니다. 고급 인도네시아 아라비카의 특징입니다.',
        'zh': '泥土般温暖的香料风味。经常补充巧克力和坚果的甜味。是高品质印度尼西亚阿拉比卡咖啡的特征。',
        'ar': 'ملف توابل ترابي ودافئ. غالباً ما يكمل حلاوة الشوكولاتة والمكسرات. مميز لأنواع الأرابيكا الإندونيسية عالية الجودة.'
    },
    'wheel_note_anise': {
        'en': 'Cool, sweet and slightly medicinal spice note. Reminiscent of licorice. Found in some rare Yemeni and complex African lots.',
        'uk': 'Прохолодна, солодка та злегка аптечна пряна нота. Нагадує лакрицю. Зустрічається у деяких рідкісних єменських та складних африканських лотах.',
        'de': 'Kühle, süße und leicht medizinische Gewürznote. Erinnert an Lakritz. In einigen seltenen jemenitischen und komplexen afrikanischen Lots zu finden.',
        'fr': 'Note d\'épice fraîche, douce et légèrement médicinale. Rappelle la réglisse. Présente dans certains lots yéménites rares et complexes d\'Afrique.',
        'es': 'Nota de especia fresca, dulce y ligeramente medicinal. Recuerda al regaliz. Se encuentra en algunos lotes yemeníes raros y africanos complejos.',
        'it': 'Nota di spezia fresca, dolce e leggermente medicinale. Ricorda la liquirizia. Presente in alcuni rari lotti yemeniti e complessi africani.',
        'pt': 'Nota de especiaria fresca, doce e ligeiramente medicinal. Lembra alcaçuz. Encontrada em alguns lotes raros iemenitas e complexos africanos.',
        'pl': 'Chłodna, słodka i nieco apteczna nuta przyprawowa. Przypomina lukrecję. Występuje в niektórych rzadkich jemeńskich i złożonych afrykańskich kawach.',
        'nl': 'Frisse, zoete en licht medicinale kruidige noot. Doet denken aan drop. Te vinden in sommige zeldzame Jemenitische en complexe Afrikaanse kavels.',
        'sv': 'Sval, söt och något medicinsk kryddnot. Påminner om lakrits. Finns i vissa sällsynta jemenitiska och komplexa afrikanska partier.',
        'tr': 'Serin, tatlı ve hafif tıbbi baharat notası. Meyan kökünü andırır. Bazı nadir Yemen ve karmaşık Afrika lotlarında bulunur.',
        'ja': '清涼感があり甘く、わずかに薬のようなスパイスのノート。リコリス（甘草）を思わせます。希少なイエメン産や複雑なアフリカ産コーヒーに見られます。',
        'ko': '시원하고 달콤하며 약간의 약품 느낌이 있는 스파이스 노트입니다. 감초를 연상시킵니다. 일부 희귀한 예멘 및 복합적인 아프리카 커피에서 발견됩니다.',
        'zh': '清凉、甜美且略带药味的香料味。让人联想到甘草。在一些稀有的也门和复杂的非洲批次中可见。',
        'ar': 'نوتة توابل باردة وحلوة وطبية قليلاً. تذكرنا بعرق السوس. توجد في بعض المحاصيل اليمنية النادرة والأفريقية المعقدة.'
    },
    'wheel_note_malt': {
        'en': 'Sweet, grain-like note reminiscent of beer or freshly baked bread. Indicator of specific sugar-amino-acid reactions. Common in traditional Brazilian coffees.',
        'uk': 'Солодка, зернова нота, що нагадує пиво або свіжоспечений хліб. Індикатор специфічних реакцій цукру та амінокислот. Зустрічається в традиційній бразильській каві.',
        'de': 'Süße, getreideartige Note, die an Bier oder frisch gebackenes Brot erinnert. Indikator für spezifische Zucker-Aminosäure-Reaktionen. Häufig in traditionellen brasilianischen Kaffees.',
        'fr': 'Note douce et céréalière rappelant la bière ou le pain fraîchement cuit. Indicateur de réactions spécifiques sucre-acides aminés. Commun dans les cafés brésiliens traditionnels.',
        'es': 'Nota dulce y cereal que recuerda a la cerveza o al pan recién horneado. Indicador de reacciones específicas entre azúcares y aminoácidos. Común en los cafés brasileños tradicionales.',
        'it': 'Nota dolce e di cereale che ricorda la birra o il pane appena sfornato. Indicatore di specifiche reazioni zucchero-aminoacidi. Comune nei caffè brasiliani tradizionali.',
        'pt': 'Nota doce e de cereal que lembra cerveja ou pão acabado de cozer. Indicador de reacções específicas açúcar-aminoácidos. Comum nos cafés brasileiros tradicionais.',
        'pl': 'Słodka, zbożowa nuta przypominająca piwo lub świeżo upieczony chleb. Wskaźnik specyficznych reakcji cukrów i aminokwasów. Częsta в tradycyjnych brazylijskich kawach.',
        'nl': 'Zoete, graanachtige noot die doet denken aan bier of vers gebakken brood. Indicator voor specifieke suiker-aminozuurreacties. Veelvoorkomend in traditionele Braziliaanse koffiesoorten.',
        'sv': 'Söt, spannmålsliknande not som påminner om öl eller nybakat bröd. Indikator på specifika socker-aminosyrareaktioner. Vanligt i traditionellt brasilianskt kaffe.',
        'tr': 'Birayı veya taze pişmiş ekmeği andıran tatlı, tahıl benzeri nota. Özel şeker-amino asit reaksiyonlarının göstergesidir. Geleneksel Brezilya kahvelerinde yaygındır.',
        'ja': 'ビールや焼きたてのパンを思わせる、甘く穀物のようなノート。特定の糖とアミノ酸の反応（メイラード反応）の指標です。伝統的なブラジル産コーヒーによく見られます。',
        'ko': '맥주나 갓 구운 빵을 연상시키는 달콤한 곡물 노트입니다. 특정 당-아미노산 반응의 지표입니다. 전통적인 브라질 커피에서 흔히 발견됩니다.',
        'zh': '甜美的谷物气息，让人联想到啤酒或新鲜出炉的面包。是特定糖-氨基酸反应的指标。在传统的巴西咖啡中很常见。',
        'ar': 'نوتة حلوة وحبيبية تشبه البيرة أو الخبز الطازج. مؤشر على تفاعلات معينة بين السكر والأحماض الأمينية. شائعة في أنواع القهوة البرازيلية التقليدية.'
    },
    'wheel_note_grain': {
        'en': 'Toasted, bread-like cereal note. Marks early development stages or high-density beans. Found in many high-quality commercial grade coffees.',
        'uk': 'Ноти підсмажених злаків та хліба. Вказує на ранні стадії розвитку або високу щільність зерна. Зустрічається у багатьох високоякісних комерційних сортах кави.',
        'de': 'Geröstete, brotähnliche Getreidenote. Markiert frühe Entwicklungsstadien oder Bohnen mit hoher Dichte. In vielen hochwertigen kommerziellen Kaffeesorten zu finden.',
        'fr': 'Note de céréales grillées, semblable au pain. Marque les premières étapes du développement ou les grains à haute densité. Présente dans de nombreux cafés de qualité commerciale supérieure.',
        'es': 'Nota de cereal tostado, similar al pan. Marca etapas tempranas de desarrollo o granos de alta densidad. Se encuentra en muchos cafés de grado comercial de alta calidad.',
        'it': 'Nota di cereali tostati, simile al pane. Segna le prime fasi di sviluppo o chicchi ad alta densità. Si trova in molti caffè di qualità commerciale superiore.',
        'pt': 'Nota de cereal torrado, semelhante a pão. Marca estágios iniciais de desenvolvimento ou grãos de alta densidade. Encontrada em muitos cafés de grau comercial de alta qualidade.',
        'pl': 'Prażona, chlebowa nuta zbożowa. Świadczy o wczesnych etapach rozwoju lub ziarnach o wysokiej gęstości. Występuje в wielu wysokiej jakości kawach komercyjnych.',
        'nl': 'Geroosterde, broodachtige graannoot. Markeert vroege ontwikkelingsstadia of bonen met een hoge dichtheid. Te vinden in veel commerciële koffiesoorten van hoge kwaliteit.',
        'sv': 'Rostad, brödliknande spannmålsnot. Tyder på tidiga utvecklingsstadier eller bönor med hög densitet. Finns i många kommersiella kaffesorter av hög kvalitet.',
        'tr': 'Kavrulmuş, ekmek benzeri tahıl notası. Erken gelişim aşamalarını veya yüksek yoğunluklu çekirdekleri işaret eder. Birçok yüksek kaliteli ticari sınıf kahvede bulunur.',
        'ja': 'トーストしたパンのような穀物のノート。初期の焙煎進行や密度の高い豆を示します。多くの高品質なコマーシャルグレードのコーヒーに見られます。',
        'ko': '구운 빵 같은 곡물 노트입니다. 초기 발달 단계나 고밀도 생두를 나타냅니다. 많은 고품질 커머셜 등급 커피에서 발견됩니다.',
        'zh': '烘烤的面包般谷物香气。标志着早期烘焙阶段或高密度咖啡豆。在许多高质量的商业等级咖啡中可见。',
        'ar': 'نوتة حبوب محمصة تشبه الخبز. تشير إلى مراحل التطوير المبكرة أو الحبوب عالية الكثافة. توجد في العديد من أنواع القهوة ذات الدرجة التجارية عالية الجودة.'
    },
}

for key, translations in data.items():
    update_localization(file_path, key, translations)

print("Batch 6 localization update completed successfully.")
