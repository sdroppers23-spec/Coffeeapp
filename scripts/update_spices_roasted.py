import re
import os

# Define the translations for the requested categories and sub-items
translations = {
    'wheel_cat_spices': {
        'en': 'Warm, pungent, or sweet spice notes like pepper, clove, or cinnamon. These often emerge during the middle stages of roasting. Frequently found in Sumatran coffees or spicy varieties from Rwanda.',
        'uk': 'Теплі, гострі або солодкі пряні ноти, такі як перець, гвоздика або кориця. Вони часто проявляються на середніх етапах обсмажування. Часто зустрічаються в суматранській каві або пряних сортах з Руанди.',
        'de': 'Warme, scharfe oder süße Gewürznoten wie Pfeffer, Nelken oder Zimt. Diese entstehen oft in den mittleren Phasen der Röstung. Häufig in Sumatra-Kaffees oder würzigen Sorten aus Ruanda zu finden.',
        'fr': 'Notes d\'épices chaudes, piquantes ou sucrées comme le poivre, le clou de girofle ou la cannelle. Celles-ci émergent souvent pendant les étapes moyennes de la torréfaction. Fréquemment trouvées dans les cafés de Sumatra ou les variétés épicées du Rwanda.',
        'es': 'Notas de especias cálidas, picantes o dulces como pimienta, clavo o canela. Estas suelen surgir durante las etapas medias del tueste. Se encuentran frecuentemente en cafés de Sumatra o variedades especiadas de Ruanda.',
        'it': 'Note di spezie calde, pungenti o dolci come pepe, chiodi di garofano o cannella. Queste emergono spesso durante le fasi intermedie della tostatura. Frequentemente presenti nei caffè di Sumatra o nelle varietà speziate del Ruanda.',
        'pt': 'Notas de especiarias quentes, picantes ou doces, como pimenta, cravo ou canela. Estas surgem frequentemente durante as fases intermédias da torra. Frequentemente encontradas em cafés de Sumatra ou variedades picantes de Ruanda.',
        'pl': 'Ciepłe, ostre lub słodkie nuty przyprawowe, takie jak pieprz, goździki lub cynamon. Często pojawiają się one na środkowych etapach palenia. Często spotykane w kawach z Sumatry lub przyprawowych odmianach z Rwandy.',
        'nl': 'Warme, scherpe of zoete kruidige tonen zoals peper, kruidnagel of kaneel. Deze ontstaan vaak tijdens de middelste fasen van het branden. Veelvoorkomend in Sumatraanse koffiesoorten of kruidige variëteiten uit Rwanda.',
        'sv': 'Varma, skarpa eller söta kryddnoter som peppar, kryddnejlika eller kanel. Dessa uppstår ofta under rostningens mellersta skeden. Vanligt förekommande i kaffe från Sumatra eller kryddiga sorter från Rwanda.',
        'tr': 'Biber, karanfil veya tarçın gibi sıcak, keskin veya tatlı baharat notaları. Bunlar genellikle kavurmanın orta aşamalarında ortaya çıkar. Sıklıkla Sumatra kahvelerinde veya Ruanda\'dan gelen baharatlı çeşitlerde bulunur.',
        'ja': '胡椒、クローブ、シナモンのような、温かみのある、刺激的な、あるいは甘いスパイスのノート。これらは焙煎の中盤に現れることが多いです。スマトラ産のコーヒーや、ルワンダ産の甘辛い品種によく見られます。',
        'ko': '후추, 정향 또는 시나몬과 같은 따뜻하고 톡 쏘는 또는 달콤한 스파이스 노트입니다. 로스팅의 중간 단계에서 주로 나타납니다. 수마트라 커피나 루완다의 스파이시한 품종에서 자주 발견됩니다.',
        'zh': '温暖、辛辣或甜美的香料味，如胡椒、丁香或肉桂。这些味道通常在烘焙的中期阶段出现。常见于苏门答腊咖啡或卢旺达的辛香品种。',
        'ar': 'نكهات توابل دافئة أو لاذعة أو حلوة مثل الفلفل أو القرنفل أو القرفة. تظهر هذه النكهات غالباً خلال المراحل المتوسطة من التحميص. توجد بكثرة في قهوة سومطرة أو الأصناف المتبلة من رواندا.'
    },
    'wheel_cat_roasted': {
        'en': 'Savory and deep notes resulting from the Maillard reaction and caramelization during roasting. These range from toasted bread to smoky accents. Typically associated with medium to dark roast profiles from Brazil or India.',
        'uk': 'Пікантні та глибокі ноти, що виникають внаслідок реакції Майяра та карамелізації під час обсмажування. Вони варіюються від підсмаженого хліба до димних акцентів. Зазвичай асоціюються з профілями середнього та темного обсмаження з Бразилії чи Індії.',
        'de': 'Herzhafte und tiefe Noten, die aus der Maillard-Reaktion und der Karamellisierung während der Röstung resultieren. Diese reichen von getoastetem Brot bis hin zu rauchigen Akzenten. Typischerweise assoziiert mit mittleren bis dunklen Röstprofilen aus Brasilien oder Indien.',
        'fr': 'Notes savoureuses et profondes résultant de la réaction de Maillard et de la caramélisation pendant la torréfaction. Celles-ci vont du pain grillé aux accents fumés. Typiquement associées aux profils de torréfaction moyenne à foncée du Brésil ou de l\'Inde.',
        'es': 'Notas sabrosas y profundas resultantes de la reacción de Maillard y la caramelización durante el tueste. Estas van desde pan tostado hasta acentos ahumados. Típicamente asociadas con perfiles de tueste medio a oscuro de Brasil o India.',
        'it': 'Note sapide e profonde derivanti dalla reazione di Maillard e dalla caramellizzazione durante la tostatura. Queste variano dal pane tostato ad accenti fumosi. Tipicamente associate a profili di tostatura da media a scura del Brasile o dell\'India.',
        'pt': 'Notas salgadas e profundas resultantes da reação de Maillard e caramelização durante a torra. Estas variam de pão torrado a acentos defumados. Tipicamente associadas a perfis de torra média a escura do Brasil ou da Índia.',
        'pl': 'Pikantne i głębokie nuty wynikające z reakcji Maillarda i karmelizacji podczas palenia. Obejmują one zarówno przypieczony chleb, jak i dymne akcenty. Zazwyczaj kojarzone ze średnimi i ciemnymi profilami palenia z Brazylii lub Indii.',
        'nl': 'Hartige en diepe tonen als gevolg van de Maillard-reactie en karamelisatie tijdens het branden. Deze variëren van geroosterd brood tot rokerige accenten. Meestal geassocieerd met medium tot donkere brandingsprofielen uit Brazilië of India.',
        'sv': 'Fylliga och djupa noter som ett resultat av Maillard-reaktionen och karamellisering under rostningen. Dessa sträcker sig från rostat bröd till rökiga accenter. Vanligtvis förknippade med mellan- till mörkrostade profiler från Brasilien eller Indien.',
        'tr': 'Kavurma sırasında Maillard reaksiyonu ve karamelizasyondan kaynaklanan lezzetli ve derin notalar. Bunlar kızarmış ekmekten isli vurgulara kadar uzanır. Tipik olarak Brezilya veya Hindistan\'dan gelen orta ila koyu kavurma profilleriyle ilişkilendirilir.',
        'ja': '焙煎中のメイラード反応とカラメル化によって生まれる、香ばしく深みのあるノート。トーストしたパンからスモーキーなアクセントまで多岐にわたります。通常、ブラジルやインドの中煎りから深煎りのプロフィールに関連しています。',
        'ko': '로스팅 과정 중 마이야르 반응과 카라멜화로 인해 발생하는 풍부하고 깊은 노트입니다. 구운 빵에서 스모키한 악센트까지 다양합니다. 주로 브라질이나 인도의 미디엄에서 다크 로스팅 프로필과 관련이 있습니다.',
        'zh': '烘焙过程中美拉德反应和焦糖化产生的咸鲜而深沉的风味。范围从烤面包到烟熏调。通常与巴西或印度的中度至深度烘焙风格相关。',
        'ar': 'نكهات عميقة ومالحة ناتجة عن تفاعل مايار والكرملة أثناء التحميص. تتراوح هذه النكهات من الخبز المحمص إلى لمحات مدخنة. ترتبط عادةً بملفات التحميص المتوسطة إلى الداكنة من البرازيل أو الهند.'
    },
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
        'pl': 'Nuty prażonego ziarna i chleba. Wskazują na wczesne etapy palenia lub specyficzną gęstość ziarna. Występują w wielu brazylijskich i indyjskich partiach kawy.',
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
        'nl': 'Intense, rokerige en verkoolde aroma\'s. Resultaat van diep branden of verbranding van het boon-oppervlak. Kenmerkend voor Italiaanse en Franse brandingsprofielen.',
        'sv': 'Intensiva, rökiga och brända aromer. Resultat av djup rostning eller bränning av bönans yta. Karaktäristiskt för italienska och franska rostningsprofiler.',
        'tr': 'Yoğun, isli ve yanık aromalar. Derin kavurmanın veya çekirdek yüzeyinin yanmasının sonucudur. İtalyan ve Fransız kavurma profillerinin özelliğidir.',
        'ja': '強烈で、スモーキー、そして焦げたようなアロマ。深煎りや豆の表面の焦げの結果です。イタリアンローストやフレンチローストの特徴です。',
        'ko': '강렬하고 스모키하며 탄 듯한 아로마입니다. 딥 로스팅이나 원두 표면이 그을린 결과입니다. 이탈리안 및 프렌치 로스팅 프로파일의 특징입니다.',
        'zh': '强烈、烟熏和烧焦的香气。是深度烘焙或豆表焦灼的结果。是意式和法式烘焙风格的特征。',
        'ar': 'روائح حادة أو اصطناعية أو طبية. قد تشير إلى عيوب في المعالجة أو تلوث خارجي. تعتبر عادةً سمة سلبية في القهوة المختصة.'
    }
}

file_path = 'lib/core/l10n/flavor_descriptions.dart'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

def replace_entry(key, lang_map):
    pattern = re.compile(rf"('{key}':\s*\{{[^}}]*\}})", re.DOTALL)
    
    new_entry = f"'{key}': {{\n"
    for lang in ['en', 'uk', 'de', 'fr', 'es', 'it', 'pt', 'pl', 'nl', 'sv', 'tr', 'ja', 'ko', 'zh', 'ar']:
        val = lang_map.get(lang, lang_map['en']).replace("'", "\\'")
        new_entry += f"        '{lang}':\n            '{val}',\n"
    new_entry += "      }"
    
    return pattern.sub(new_entry, content)

for key, lang_map in translations.items():
    content = replace_entry(key, lang_map)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print("Successfully updated flavor descriptions for Spices and Roasted.")
