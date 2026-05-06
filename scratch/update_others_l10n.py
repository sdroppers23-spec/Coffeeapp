
import re
import os

target_file = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

translations = {
    'wheel_sub_papery_musty': {
        'en': "Dry, stale or damp basement-like notes. Indicative of improper drying, storage or age. Often referred to as 'past crop' profile.",
        'uk': "Сухі, залежалі або вологі ноти, що нагадують підвал. Вказують на неправильну сушку, зберігання або вік. Часто називають профілем 'старого врожаю'.",
        'de': "Trockene, muffige oder feuchte, kellerähnliche Noten. Deutet auf unsachgemäße Trocknung, Lagerung oder Alter hin. Oft als 'Alt-Ernte'-Profil bezeichnet.",
        'fr': "Notes sèches, rassis ou d'humidité de cave. Indique un séchage, un stockage inadéquat ou l'âge. Souvent appelé profil de 'vieille récolte'.",
        'es': "Notas secas, rancias o de humedad de sótano. Indicativo de secado, almacenamiento inadecuado o edad. A menudo denominado perfil de 'cosecha pasada'.",
        'it': "Note secche, stantie o di umidità da cantina. Indicativo di essiccazione, conservazione inadeguata o età. Spesso definito profilo 'past crop'.",
        'pt': "Notas secas, rançosas ou de humidade de cave. Indicativo de secagem, armazenamento inadequado ou idade. Frequentemente referido como perfil de 'colheita passada'.",
        'pl': "Suche, zwietrzałe lub wilgotne nuty przypominające piwnicę. Wskazują на niewłaściwe suszenie, przechowywanie lub wiek. Często określane jako profil 'starych zbiorów'.",
        'nl': "Droge, muffe of vochtige kelderachtige tonen. Wijst op onjuiste droging, opslag of ouderdom. Vaak aangeduid als 'oude oogst' profiel.",
        'sv': "Torra, unkna eller fuktiga källarliknande noter. Indikerar felaktig torkning, förvaring eller ålder. Kallas ofta för 'gammal skörd'-profil.",
        'tr': "Kuru, bayat veya nemli bodrum benzeri notalar. Yanlış kurutma, depolama veya yaşın göstergesidir. Genellikle 'eski ürün' profili olarak adlandırılır.",
        'ja': "乾燥した、古びた、または湿った地下室のようなノート。不適切な乾燥、保管、または経年劣化を示唆する。多くの場合「旧クロップ」プロファイルと呼ばれる。",
        'ko': "건조하고 퀴퀴하며 습한 지하실 같은 노트입니다. 부적절한 건조, 보관 또는 노후화를 나타냅니다. 종종 '지난 크롭' 프로필로 불립니다.",
        'zh': "干燥、陈旧或潮湿的地下室味。表示干燥不当、储存不当或陈年。通常被称为“旧产季”剖面。",
        'ar': "نكهات جافة أو قديمة أو رطبة تشبه القبو. تشير إلى التجفيف غير السليم أو التخزين أو العمر. غالباً ما يشار إليها باسم ملف 'المحصول القديم'.",
    },
    'wheel_note_papery': {
        'en': "Flat, dry note reminiscent of cardboard or paper. Found in old coffee or when filter paper is not rinsed. Common in stale lots.",
        'uk': "Плоска, суха нота, що нагадує картон або папір. Зустрічається в старій каві або коли паперовий фільтр не пролито. Поширено в залежалих лотах.",
        'de': "Flache, trockene Note, die an Karton oder Papier erinnert. In altem Kaffee zu finden oder wenn Filterpapier nicht gespült wurde. Häufig bei abgestandenen Partien.",
        'fr': "Note plate et sèche rappelant le carton ou le papier. Présent dans le vieux café ou lorsque le papier filtre n'est pas rincé. Courant dans les lots rassis.",
        'es': "Nota plana y seca que recuerda al cartón o al papel. Se encuentra en el café viejo o cuando no se enjuaga el papel de filtro. Común en lotes rancios.",
        'it': "Nota piatta e secca che ricorda il cartone o la carta. Si trova nel caffè vecchio o quando la carta filtro non viene sciacquata. Comune nei lotti stantii.",
        'pt': "Nota plana e seca que lembra cartão ou papel. Encontrada em café velho ou quando o papel de filtro não é enxaguado. Comum em lotes rançosos.",
        'pl': "Płaska, sucha nuta przypominająca tekturę lub papier. Spotykana в starej kawie lub gdy papierowy filtr не został przepłukany. Powszechna в zwietrzałych partiach.",
        'nl': "Vlakke, droge noot die doet denken aan karton of papier. Te vinden in oude koffie of wanneer filterpapier niet is gespoeld. Veelvoorkomend in muffe partijen.",
        'sv': "Platt, torr not som påminner om kartong eller papper. Finns i gammalt kaffe eller när filterpapper inte har sköljts. Vanligt i gamla partier.",
        'tr': "Karton veya kağıdı andıran yassı, kuru nota. Eski kahvelerde veya filtre kağıdı durulanmadığında bulunur. Bayat lotlarda yaygındır.",
        'ja': "平坦で乾燥した、段ボールや紙を思わせるノート。古いコーヒーや、フィルターペーパーをすすいでいない場合に見られる。古くなったロットに一般的。",
        'ko': "판지나 종이를 연상시키는 평범하고 건조한 노트입니다. 오래된 커피나 필터 페이퍼를 헹구지 않았을 때 발견됩니다. 오래된 로트에서 흔히 볼 수 있습니다.",
        'zh': "平淡、干燥的味道，令人联想到硬纸板或纸张。出现在陈旧的咖啡中，或者当滤纸未冲洗时。常见于不新鲜的批次中。",
        'ar': "نكهة مسطحة وجافة تذكرنا بالكرتون أو الورق. توجد في القهوة القديمة أو عندما لا يتم شطف ورق الترشيح. شائعة في الدفعات القديمة.",
    },
    'wheel_note_woody': {
        'en': "Dry, inert note reminiscent of wood or sawdust. Indicator of very old green coffee where organic aromatics have faded. Characteristic of low-grade storage.",
        'uk': "Суха, інертна нота, що нагадує деревину або тирсу. Індикатор дуже старої зеленої кави, де органічні ароматичні речовини вивітрилися. Характерно для неякісного зберігання.",
        'de': "Trockene, inerte Note, die an Holz oder Sägemehl erinnert. Indikator für sehr alten Rohkaffee, bei dem organische Aromen verflogen sind. Charakteristisch für minderwertige Lagerung.",
        'fr': "Note sèche et inerte rappelant le bois ou la sciure. Indicateur de café vert très vieux où les aromates organiques se sont estompés. Caractéristique d'un stockage de mauvaise qualité.",
        'es': "Nota seca e inerte que recuerda a la madera o al serrín. Indicador de café verde muy viejo donde los aromáticos orgánicos se han desvanecido. Característico de un almacenamiento de baja calidad.",
        'it': "Nota secca e inerte che ricorda il legno o la segatura. Indicatore di caffè verde molto vecchio in cui gli aromi organici sono svaniti. Caratteristico di una conservazione di bassa qualità.",
        'pt': "Nota seca e inerte que lembra madeira ou serradura. Indicador de café verde muito velho onde os aromáticos orgânicos desapareceram. Característico de armazenamento de baixa qualidade.",
        'pl': "Sucha, obojętna nuta przypominająca drewno lub trociny. Wskaźnik bardzo starej surowej kawy, в której zmatowiały aromaty organiczne. Charakterystyczne dla złego przechowywania.",
        'nl': "Droge, inerte noot die doet denken aan hout of zaagsel. Indicator van zeer oude groene koffie waarbij de organische aroma's vervaagd zijn. Kenmerkend voor opslag van lage kwaliteit.",
        'sv': "Torr, inert not som påminner om trä eller sågspån. Indikator på mycket gammalt råkaffe där organiska aromer har blenat. Karaktäristiskt för lagring av låg kvalitet.",
        'tr': "Odun veya talaşı andıran kuru, durağan nota. Organik aromaların solduğu çok eski yeşil kahvenin göstergesidir. Düşük kaliteli depolamanın özelliğidir.",
        'ja': "乾燥した、不活性な、木材や切り屑を思わせるノート。有機的な香気が薄れた非常に古い生豆の指標。質の低い保管条件の特徴。",
        'ko': "나무나 톱밥을 연상시키는 건조하고 비활성적인 노트입니다. 유기농 방향족 성분이 퇴색된 매우 오래된 생두의 지표입니다. 저품질 보관의 특징입니다.",
        'zh': "干燥、无活力的味道，令人联想到木头或锯末。非常陈旧的生咖啡豆的指标，其中的有机芳香物质已经褪去。低质量储存的特征。",
        'ar': "نكهة جافة وخاملة تذكرنا بالخشب أو نشارة الخشب. مؤشر على قهوة خضراء قديمة جداً حيث تلاشت الأرومات العضوية. من سمات التخزين الرديء.",
    },
    'wheel_note_moldy_damp': {
        'en': "Musty, wet earth and fungal notes. Result of high-moisture storage or fungal contamination during processing. Major quality defect.",
        'uk': "Плісняві ноти, ноти вологої землі та грибів. Результат зберігання при високій вологості або грибкового зараження під час обробки. Серйозний дефект якості.",
        'de': "Muffige, feuchte Erde und Pilznoten. Ergebnis von Lagerung bei hoher Feuchtigkeit oder Pilzbefall während der Verarbeitung. Gravierender Qualitätsmangel.",
        'fr': "Notes de terre mouillée, de moisi et de champignon. Résultat d'un stockage très humide ou d'une contamination fongique pendant le traitement. Défaut de qualité majeur.",
        'es': "Notas de tierra mojada, humedad y hongos. Resultado de almacenamiento con alta humedad o contaminación fúngica durante el procesamiento. Defecto de calidad importante.",
        'it': "Note di terra bagnata, muffa e funghi. Risultato di stoccaggio ad alta umidità o contaminazione fungina durante la lavorazione. Grave difetto di qualità.",
        'pt': "Notas de terra molhada, mofo e fungos. Resultado de armazenamento com humidade elevada ou contaminação fúngica durante o processamento. Defeito de qualidade grave.",
        'pl': "Stęchłe nuty, nuty wilgotnej ziemi i grzybów. Wynik przechowywania przy wysokiej wilgotności lub skażenia grzybami podczas obróbki. Poważna wada jakości.",
        'nl': "Muffe tonen van natte aarde en schimmels. Resultaat van opslag bij een hoge vochtigheidsgraad of schimmelbesmetting tijdens de verwerking. Groot kwaliteitsdefect.",
        'sv': "Muffiga noter av våt jord och svamp. Resultat av lagring vid hög fukthalt eller svampkontaminering under bearbetningen. Stor kvalitetsdefekt.",
        'tr': "Küflü, ıslak toprak ve mantar notaları. İşleme sırasında yüksek nemli depolama veya mantar kontaminasyonunun sonucudur. Büyük bir kalite kusurudur.",
        'ja': "カビ臭い、湿った土、菌類のようなノート。加工中の高湿度保管や菌類汚染の結果。重大な品質欠陥。",
        'ko': "퀴퀴하고 젖은 흙 및 곰팡이 노트입니다. 가공 중 고습 보관 또는 곰팡이 오염의 결과입니다. 주요 품질 결함입니다.",
        'zh': "霉味、湿土和真菌味。处理过程中高湿度储存或真菌污染的结果。主要的质量缺陷。",
        'ar': "نكهات عفن وتربة مبللة وفطريات. نتيجة للتخزين في رطوبة عالية أو تلوث فطري أثناء المعالجة. عيب جودة كبير.",
    },
    'wheel_note_musty_dusty': {
        'en': "Dry, dusty and old book-like note. Common in coffee stored in dry but very old environments. Indicator of significant aging.",
        'uk': "Суха, пильна нота, що нагадує стару книгу. Поширена в каві, що зберігалася в сухих, але дуже старих приміщеннях. Індикатор значного старіння.",
        'de': "Trockene, staubige Note, die an alte Bücher erinnert. Häufig bei Kaffee, der in trockenen, aber sehr alten Umgebungen gelagert wurde. Indikator für erhebliche Alterung.",
        'fr': "Note sèche, poussiéreuse et rappelant les vieux livres. Courant dans le café stocké dans des environnements secs mais très anciens. Indicateur d'un vieillissement important.",
        'es': "Nota seca, polvorienta y que recuerda a libros viejos. Común en el café almacenado en ambientes secos pero muy antiguos. Indicador de un envejecimiento significativo.",
        'it': "Nota secca, polverosa e che ricorda i vecchi libri. Comune nel caffè conservato in ambienti asciutti ma molto vecchi. Indicatore di un invecchiamento significativo.",
        'pt': "Nota seca, empoeirada e que lembra livros velhos. Comum em café armazenado em ambientes secos mas muito antigos. Indicador de envelhecimento significativo.",
        'pl': "Sucha, zakurzona nuta przypominająca starą książkę. Powszechna в kawie przechowywanej в suchych, ale bardzo starych miejscach. Wskaźnik znacznego starzenia się.",
        'nl': "Droge, stoffige noot die doet denken aan oude boeken. Veelvoorkomend bij koffie die is opgeslagen in droge maar zeer oude omgevingen. Indicator van aanzienlijke veroudering.",
        'sv': "Torr, dammig not som påminner om gamla böcker. Vanligt i kaffe som förvarats i torra men mycket gamla miljöer. Indikator på betydande åldrande.",
        'tr': "Kuru, tozlu ve eski kitap benzeri nota. Kuru ancak çok eski ortamlarda saklanan kahvelerde yaygındır. Önemli bir yaşlanma göstergesidir.",
        'ja': "乾燥した、埃っぽい、古い本のようなノート。乾燥しているが非常に古い環境で保管されたコーヒーに一般的。大幅な劣化の指標。",
        'ko': "건조하고 먼지가 많으며 오래된 책 같은 노트입니다. 건조하지만 매우 오래된 환경에서 보관된 커피에서 흔히 볼 수 있습니다. 상당한 노후화의 지표입니다.",
        'zh': "干燥、满是灰尘且类似旧书的味道。常见于储存在干燥但非常陈旧的环境中的咖啡。明显老化的指标。",
        'ar': "نكهة جافة وغبارية وتشبه الكتب القديمة. شائعة في القهوة المخزنة في بيئات جافة ولكن قديمة جداً. مؤشر على التقادم الكبير.",
    },
    'wheel_note_musty_earthy': {
        'en': "Intense damp earth and soil notes. Can be part of the desired profile in some Sumatran 'Giling Basah' coffees, but usually a defect elsewhere.",
        'uk': "Інтенсивні ноти вологої землі та ґрунту. Може бути частиною бажаного профілю в деяких суматранських сортах 'Giling Basah', але зазвичай вважається дефектом в інших випадках.",
        'de': "Intensive Noten von feuchter Erde und Boden. Kann bei einigen Sumatra-'Giling Basah'-Kaffees Teil des gewünschten Profils sein, ist aber anderswo meist ein Defekt.",
        'fr': "Notes intenses de terre humide et de sol. Peut faire partie du profil recherché dans certains cafés 'Giling Basah' de Sumatra, mais est généralement un défaut ailleurs.",
        'es': "Notas intensas de tierra húmeda y suelo. Puede ser parte del perfil deseado en algunos cafés 'Giling Basah' de Sumatra, pero generalmente es un defecto en otros lugares.",
        'it': "Intense note di terra umida e suolo. Può far parte del profilo desiderato in alcuni caffè 'Giling Basah' di Sumatra, ma di solito è un difetto altrove.",
        'pt': "Notas intensas de terra húmida e solo. Pode fazer parte do perfil desejado em alguns cafés 'Giling Basah' de Samatra, mas é geralmente um defeito noutros locais.",
        'pl': "Intensywne nuty wilgotnej ziemi i gleby. Może być częścią pożądanego profilu w niektórych kawach sumatrzańskich 'Giling Basah', ale zazwyczaj jest wadą w innych.",
        'nl': "Intensieve tonen van vochtige aarde en bodem. Kan deel uitmaken van het gewenste profiel in sommige Sumatraanse 'Giling Basah' koffies, maar is elders meestal een defect.",
        'sv': "Intensiva noter av fuktig jord och mylla. Kan vara en del av den önskade profilen i vissa kaffesorter från Sumatra ('Giling Basah'), men är vanligtvis en defekt på andra håll.",
        'tr': "Yoğun nemli toprak ve toprak notaları. Bazı Sumatra 'Giling Basah' kahvelerinde istenen profilin bir parçası olabilir, ancak genellikle başka yerlerde bir kusurdur.",
        'ja': "強烈な湿った土と土壌のノート。一部のスマトラ産「ギリン・バサ」コーヒーでは望ましいプロファイルの一部となり得るが、通常は他では欠陥とされる。",
        'ko': "강렬한 젖은 흙과 토양의 노트입니다. 일부 수마트라 '길링 바사' 커피에서는 원하는 프로필의 일부일 수 있지만, 일반적으로 다른 곳에서는 결함입니다.",
        'zh': "强烈的湿土和土壤味。在一些苏门答腊“湿剥法”咖啡中可能是理想剖面的一部分，但在其他地方通常是缺陷。",
        'ar': "نكهات تربة رطبة وتراب مكثفة. يمكن أن تكون جزءاً من الملف المطلوب في بعض أنواع القهوة السومطرية 'جيليج باسا'، ولكنها عادة ما تكون عيباً في أماكن أخرى.",
    },
    'wheel_note_animalic': {
        'en': "Notes reminiscent of wet fur, leather or livestock. Often a result of wild-yeast contamination or extreme processing conditions. Rare defect.",
        'uk': "Ноти, що нагадують вологу шерсть, шкіру або худобу. Часто результат зараження дикими дріжджами або екстремальних умов обробки. Рідкісний дефект.",
        'de': "Noten, die an nasses Fell, Leder oder Vieh erinnern. Oft ein Ergebnis von Wildhefe-Kontamination oder extremen Verarbeitungsbedingungen. Seltener Defekt.",
        'fr': "Notes rappelant la fourrure mouillée, le cuir ou le bétail. Souvent le résultat d'une contamination par des levures sauvages ou de conditions de traitement extrêmes. Défaut rare.",
        'es': "Notas que recuerdan a piel mojada, cuero o ganado. A menudo resultado de contaminación por levaduras silvestres o condiciones de procesamiento extremas. Defecto raro.",
        'it': "Note che ricordano la pelliccia bagnata, il cuoio o il bestiame. Spesso risultato di contaminazione da lieviti selvaggi o condizioni di lavorazione estreme. Difetto raro.",
        'pt': "Notas que lembram pelo molhado, couro ou gado. Frequentemente resultado de contaminação por leveduras selvagens ou condições de processamento extremas. Defeito raro.",
        'pl': "Nuty przypominające mokre futro, skórę lub zwierzęta hodowlane. Często wynik skażenia dzikimi drożdżami lub ekstremalnych warunków obróbki. Rzadka wada.",
        'nl': "Tonen die doen denken aan natte vacht, leer of vee. Vaak het resultaat van besmetting met wilde gist of extreme verwerkingsomstandigheden. Zeldzaam defect.",
        'sv': "Noter som påminner om våt päls, läder oder boskap. Ofta ett resultat av vildjästkontaminering eller extrema bearbetningsförhållanden. Sällsynt defekt.",
        'tr': "Islak kürk, deri veya hayvan barınağını andıran notalar. Genellikle yaban mayası kontaminasyonunun veya aşırı işleme koşullarının sonucudur. Nadir bir kusurdur.",
        'ja': "濡れた毛皮、皮革、または家畜を思わせるノート。野生酵母の汚染や極端な加工条件の結果であることが多い。まれな欠陥。",
        'ko': "젖은 털, 가죽 또는 가축을 연상시키는 노트입니다. 종종 야생 효모 오염이나 극단적인 가공 조건의 결과입니다. 드문 결함입니다.",
        'zh': "令人联想到湿皮毛、皮革或家畜的味道。通常是野生酵母污染或极端的处理条件的结果。罕见的缺陷。",
        'ar': "نكهات تذكرنا بالفراء المبلل أو الجلد أو الماشية. غالباً ما تكون نتيجة تلوث بالخميرة البرية أو ظروف معالجة قاسية. عيب نادر.",
    },
    'wheel_note_meaty_brothy': {
        'en': "Savory, protein-like aromatics reminiscent of boiled meat or vegetable broth. Can occur in specific high-nitrogen soils or processing faults.",
        'uk': "Солоні, білкові аромати, що нагадують варене м'ясо або овочевий бульйон. Може виникати в специфічних ґрунтах з високим вмістом азоту або через помилки обробки.",
        'de': "Herzhafte, proteinähnliche Aromen, die an gekochtes Fleisch oder Gemüsebrühe erinnern. Kann bei spezifischen stickstoffreichen Böden oder Verarbeitungsfehlern auftreten.",
        'fr': "Arômes savoureux et protéinés rappelant la viande bouillie ou le bouillon de légumes. Peut se produire dans des sols spécifiques riches en azote ou par des fautes de traitement.",
        'es': "Aromas salados y proteicos que recuerdan a la carne hervida o al caldo de verduras. Puede ocurrir en suelos específicos con alto contenido de nitrógeno o fallas de procesamiento.",
        'it': "Aromi sapidi e proteici che ricordano la carne bollita o il brodo vegetale. Può verificarsi in specifici terreni ad alto contenuto di azoto o per errori di lavorazione.",
        'pt': "Aromas salgados e proteicos que lembram carne cozida ou caldo de legumes. Pode ocorrer em solos específicos com elevado teor de azoto ou falhas de processamento.",
        'pl': "Wytrawne, białkowe aromaty przypominające gotowane mięso lub bulion warzywny. Mogą występować в specyficznych glebach bogatych в azot lub przez błędy obróbki.",
        'nl': "Hartige, eiwitachtige aroma's die doen denken aan gekookt vlees of groentebouillon. Kan voorkomen in specifieke stikstofrijke bodems of door verwerkingsfouten.",
        'sv': "Smakrika, proteinliknande aromer som påminner om kokt kött eller grönsaksbuljong. Kan förekomma i specifika kväverika jordar eller vid bearbetningsfel.",
        'tr': "Haşlanmış et veya sebze suyunu andıran iştah açıcı, protein benzeri aromalar. Belirli yüksek azotlu topraklarda veya işleme hatalarında oluşabilir.",
        'ja': "茹でた肉や野菜のスープを思わせる、風味豊かなタンパク質のような香気。特定の窒素含有量の高い土壌や加工ミスで発生することがある。",
        'ko': "삶은 고기나 야채 국물을 연상시키는 짭짤하고 단백질 같은 방향족 성분입니다. 특정 고질소 토양이나 가공 결함에서 발생할 수 있습니다.",
        'zh': "鲜味的、类似蛋白质的香气，令人联想到煮肉或蔬菜汤。可能发生在特定的高氮土壤中或处理故障中。",
        'ar': "أرومات لذيذة تشبه البروتين تذكرنا باللحم المسلوق أو مرق الخضار. يمكن أن تحدث في تربة معينة غنية بالنيتروجين أو أخطاء في المعالجة.",
    },
    'wheel_note_phenolic': {
        'en': "Medicinal, chemical note reminiscent of antiseptic or TCP. Usually result of microbial contamination during fermentation. Common defect in low-grade coffee.",
        'uk': "Аптечна, хімічна нота, що нагадує антисептик. Зазвичай результат мікробного зараження під час ферментації. Поширений дефект у низькосортній каві.",
        'de': "Medizinische, chemische Note, die an Antiseptika erinnert. Meist Ergebnis mikrobieller Kontamination während der Fermentation. Häufiger Defekt bei minderwertigem Kaffee.",
        'fr': "Note médicinale et chimique rappelant l'antiseptique. Généralement le résultat d'une contamination microbienne pendant la fermentation. Défaut courant dans le café de mauvaise qualité.",
        'es': "Nota medicinal y química que recuerda al antiséptico. Usualmente resultado de contaminación microbiana durante la fermentación. Defecto común en el café de baja calidad.",
        'it': "Nota medicinale e chimica che ricorda l'antisettico. Di solito risultato di contaminazione microbica durante la fermentazione. Difetto comune nel caffè di bassa qualità.",
        'pt': "Nota medicinal e química que lembra antisséptico. Geralmente resultado de contaminação microbiana durante a fermentação. Defeito comum em café de baixa qualidade.",
        'pl': "Medyczna, chemiczna nuta przypominająca antyseptyk. Zazwyczaj wynik skażenia mikrobiologicznego podczas fermentacji. Powszechna wada в kawie niskiej jakości.",
        'nl': "Medicinale, chemische noot die doet denken aan antisepticum. Meestal het resultaat van microbiële besmetting tijdens de fermentatie. Veelvoorkomend defect bij koffie van lage kwaliteit.",
        'sv': "Medicinsk, kemisk not som påminner om antiseptika. Vanligtvis ett resultat av mikrobiell kontaminering under fermenteringen. Vanlig defekt i kaffe av låg kvalitet.",
        'tr': "Antiseptiği andıran tıbbi, kimyasal nota. Genellikle fermantasyon sırasında mikrobiyal kontaminasyonun sonucudur. Düşük kaliteli kahvelerde yaygın bir kusurdur.",
        'ja': "消毒剤を思わせる、薬のような化学的なノート。通常、発酵中の微生物汚染の結果。質の低いコーヒーによく見られる欠陥。",
        'ko': "살균제를 연상시키는 약 같고 화학적인 노트입니다. 보통 발효 중 미생물 오염의 결과입니다. 저품질 커피에서 흔히 볼 수 있는 결함입니다.",
        'zh': "药味、化学味，令人联想到消毒剂。通常是发酵过程中微生物污染的结果。低质量咖啡中的常见缺陷。",
        'ar': "نكهة دوائية وكيميائية تذكرنا بالمطهر. عادة ما تكون نتيجة تلوث ميكروبي أثناء التخمير. عيب شائع في القهوة منخفضة الدرجة.",
    },
    'wheel_note_skunky': {
        'en': "Pungent, sulfur-like note reminiscent of rubber or skunk. Indicator of over-fermentation or exposure to specific pollutants. Major defect.",
        'uk': "Різка, сірчана нота, що нагадує гуму або скунса. Індикатор переферментації або впливу специфічних забруднювачів. Серйозний дефект.",
        'de': "Stechende, schwefelartige Note, die an Gummi oder Stinktier erinnert. Indikator für Überfermentation oder Kontakt mit spezifischen Schadstoffen. Gravierender Defekt.",
        'fr': "Note piquante et soufrée rappelant le caoutchouc ou le putois. Indicateur de sur-fermentation ou d'exposition à des polluants spécifiques. Défaut majeur.",
        'es': "Nota punzante y sulfurosa que recuerda al caucho o a la mofeta. Indicador de sobrefermentación o exposición a contaminantes específicos. Defecto importante.",
        'it': "Nota pungente e sulfurea che ricorda la gomma o la puzzola. Indicatore di sovra-fermentazione o esposizione a specifici inquinanti. Grave difetto.",
        'pt': "Nota pungente e sulfurosa que lembra borracha ou gambá. Indicador de sobre-fermentação ou exposição a poluentes específicos. Defeito grave.",
        'pl': "Ostra, siarkowa nuta przypominająca gumę lub skunksa. Wskaźnik nadmiernej fermentacji lub ekspozycji на specyficzne zanieczyszczenia. Poważna wada.",
        'nl': "Prikkelende, zwavelachtige noot die doet denken aan rubber of stinkdier. Indicator van overfermentatie of blootstelling aan specifieke verontreinigende stoffen. Groot defect.",
        'sv': "Stickande, svavelliknande not som påminner om gummi eller skunk. Indikator på överfermentering eller exponering för specifika föroreningar. Stor defekt.",
        'tr': "Kauçuk veya kokarcayı andıran keskin, kükürt benzeri nota. Aşırı fermantasyonun veya spesifik kirleticilere maruz kalmanın göstergesidir. Büyük bir kusurdur.",
        'ja': "ゴムやスカンクを思わせる、刺激的な硫黄のようなノート。過発酵や特定の汚染物質への曝露の指標。重大な欠陥。",
        'ko': "고무나 스컹크를 연상시키는 톡 쏘는 황 같은 노트입니다. 과발효 또는 특정 오염 물질 노출의 지표입니다. 주요 결함입니다.",
        'zh': "辛辣、硫磺味，令人联想到橡胶或臭鼬。过度发酵或接触特定污染物的指标。主要的缺陷。",
        'ar': "نكهة حادة تشبه الكبريت تذكرنا بالمطاط أو الظربان. مؤشر على الإفراط في التخمير أو التعرض لملوثات معينة. عيب كبير.",
    },
    'wheel_note_salty': {
        'en': "Basic taste sensation often resulting from high mineral content in soil or over-extraction. Rare in well-balanced specialty lots.",
        'uk': "Базове смакове відчуття, що часто є результатом високого вмісту мінералів у ґрунті або переекстракції. Рідко зустрічається в збалансованих спешелті-лотах.",
        'de': "Grundlegende Geschmacksempfindung, die oft durch hohen Mineralgehalt im Boden oder Überextraktion entsteht. Selten bei ausgewogenen Spezialitätenpartien.",
        'fr': "Sensation gustative de base résultant souvent d'une teneur élevée en minéraux dans le sol ou d'une sur-extraction. Rare dans les lots de spécialité bien équilibrés.",
        'es': "Sensación de sabor básica que a menudo resulta de un alto contenido de minerales en el suelo o sobreextracción. Raro en lotes de especialidad bien equilibrados.",
        'it': "Sensazione gustativa di base che spesso deriva da un elevato contenuto di minerali nel terreno o da una sovra-estrazione. Rara nei lotti specialty ben bilanciati.",
        'pt': "Sensação de sabor básica frequentemente resultante de elevado teor mineral no solo ou sobre-extração. Rara em lotes de especialidade bem equilibrados.",
        'pl': "Podstawowe odczucie smakowe, często wynikające z wysokiej zawartości minerałów в glebie lub nadekstrakcji. Rzadkie в zrównoważonych partiach specialty.",
        'nl': "Basale smaaksensatie die vaak het gevolg is van een hoog mineralengehalte in de bodem of overextractie. Zeldzaam in goed uitgebalanceerde specialty partijen.",
        'sv': "Grundläggande smaksensation som ofta beror på hög mineralhalt i jorden eller överextraktion. Sällsynt i välbalanserade specialpartier.",
        'tr': "Genellikle topraktaki yüksek mineral içeriğinden veya aşırı ekstraksiyondan kaynaklanan temel tat duyusu. İyi dengelenmiş nitelikli lotlarda nadirdir.",
        'ja': "土壌の高ミネラル分や過抽出の結果であることが多い、基本的な味覚。バランスの良いスペシャルティロットではまれ。",
        'ko': "종종 토양의 높은 미네랄 함량이나 과다 추출로 인해 발생하는 기본적인 맛의 감각입니다. 잘 균형 잡힌 스페셜티 로트에서는 드뭅니다.",
        'zh': "基础的味觉，通常是由于土壤中矿物质含量高或过度萃取造成的。在平衡良好的精品批次中很少见。",
        'ar': "إحساس أساسي بالتذوق غالباً ما ينتج عن محتوى معدني عالٍ في التربة أو استخلاص مفرط. نادر في الدفعات المتخصصة المتوازنة.",
    },
    'wheel_note_bitter': {
        'en': "Harsh, astringent sensation on the back of the tongue. Usually result of dark roasting or over-extraction of fine particles.",
        'uk': "Різке, в'яжуче відчуття на задній стінці язика. Зазвичай результат темного обсмажування або переекстракції дрібних частинок.",
        'de': "Herbe, adstringierende Empfindung am hinteren Zungenbereich. Meist Ergebnis von dunkler Röstung oder Überextraktion feiner Partikel.",
        'fr': "Sensation rude et astringente à l'arrière de la langue. Généralement le résultat d'une torréfaction foncée ou d'une sur-extraction de particules fines.",
        'es': "Sensación áspera y astringente en la parte posterior de la lengua. Usualmente resultado de un tueste oscuro o sobreextracción de partículas finas.",
        'it': "Sensazione aspra e astringente sul retro della lingua. Di solito risultato della tostatura scura o della sovra-estrazione di particelle fini.",
        'pt': "Sensação áspera e adstringente na parte posterior da língua. Geralmente resultado de torra escura ou sobre-extração de partículas finas.",
        'pl': "Szorstkie, cierpkie odczucie в tylnej części języka. Zazwyczaj wynik ciemnego palenia lub nadekstrakcji drobnych cząstek.",
        'nl': "Scherp, wrang gevoel achter op de tong. Meestal het resultaat van donker branden of overextractie van fijne deeltjes.",
        'sv': "Sträv, sammandragande känsla på tungans bakre del. Vanligtvis ett resultat av mörkrostning eller överextraktion av fina partiklar.",
        'tr': "Dilin arkasında sert, buruk bir his. Genellikle koyu kavurmanın veya ince parçacıkların aşırı ekstraksiyonunun sonucudur.",
        'ja': "舌の後部での不快で収斂性のある感覚。通常、深煎りや微粒子の過抽出の結果。",
        'ko': "혀 뒷부분에서 느껴지는 거칠고 아린 감각입니다. 보통 다크 로스팅이나 미세 입자의 과다 추출 결과입니다.",
        'zh': "舌后部粗糙、涩感。通常是深度烘焙或细微颗粒过度萃取的结果。",
        'ar': "إحساس قاسي وقابض في مؤخرة اللسان. عادة ما يكون نتيجة التحميص الداكن أو الاستخلاص المفرط للجزيئات الناعمة.",
    },
}

with open(target_file, 'r', encoding='utf-8') as f:
    content = f.read()

# Find the end of the map to append new keys if they don't exist
# The map looks like: static const Map<String, Map<String, String>> _descriptions = { ... };

for key, langs in translations.items():
    new_block = f"'{key}': {{\n"
    for lang, text in langs.items():
        safe_text = text.replace(chr(39), '\\' + chr(39))
        new_block += f"        '{lang}': '{safe_text}',\n"
    new_block += "      },"
    
    if f"'{key}':" in content:
        # Update existing
        pattern = rf"'{key}':\s*\{{.*?\}},"
        content = re.sub(pattern, new_block, content, flags=re.DOTALL)
    else:
        # Append before the last };
        # Find the last }; which closes the _descriptions map
        # But wait, there might be other maps. Let's find where _descriptions ends.
        desc_start = content.find('static const Map<String, Map<String, String>> _descriptions = {')
        desc_end = content.find('};', desc_start)
        if desc_end != -1:
            content = content[:desc_end] + f"    {new_block}\n  " + content[desc_end:]

with open(target_file, 'w', encoding='utf-8', newline='\n') as f:
    f.write(content)

print('Others update complete.')
