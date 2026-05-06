
import re
import os

target_file = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

translations = {
    'wheel_sub_brown_spice': {
        'en': "Warm, sweet spice notes that develop as sugars caramelize. Rich in phenolic compounds. Characteristic of Sumatran and Rwandan coffees.",
        'uk': "Теплі, солодкі ноти спецій, що розвиваються під час карамелізації цукрів. Багаті на фенольні сполуки. Характерно для суматранської та руандійської кави.",
        'de': "Warme, süße Gewürznoten, die sich bei der Karamellisierung von Zucker entwickeln. Reich an phenolischen Verbindungen. Charakteristisch für Sumatra- und Ruanda-Kaffees.",
        'fr': "Notes d'épices chaudes et sucrées qui se développent au fur et à mesure que les sucres se caramélisent. Riche en composés phénoliques. Caractéristique des cafés de Sumatra et du Rwanda.",
        'es': "Notas de especias cálidas y dulces que se desarrollan a medida que los azúcares se caramelizan. Rico en compuestos fenólicos. Característico de los cafés de Sumatra y Ruanda.",
        'it': "Note di spezie calde e dolci che si sviluppano man mano che gli zuccheri caramellano. Ricco di composti fenolici. Caratteristico dei caffè di Sumatra e del Ruanda.",
        'pt': "Notas de especiarias quentes e doces que se desenvolvem à medida que os açúcares caramelizam. Rico em compostos fenólicos. Característico de cafés de Samatra e do Ruanda.",
        'pl': "Ciepłe, słodkie nuty korzenne, które rozwijają się podczas karmelizacji cukrów. Bogate w związki fenolowe. Charakterystyczne dla kaw z Sumatry i Rwandy.",
        'nl': "Warme, zoete kruidnoten die ontstaan wanneer suikers karamelliseren. Rijk aan fenolische verbindingen. Kenmerkend voor Sumatraanse en Rwandese koffies.",
        'sv': "Varma, söta kryddnoter som utvecklas när socker karamelliseras. Rik på fenoliska föreningar. Karaktäristiskt för kaffe från Sumatra och Rwanda.",
        'tr': "Şekerler karamelize oldukça gelişen sıcak, tatlı baharat notaları. Fenolik bileşikler açısından zengindir. Sumatra ve Ruanda kahvelerinin özelliğidir.",
        'ja': "糖がカラメル化するにつれて発達する、温かく甘いスパイスのノート。フェノール化合物が豊富。スマトラやルワンダのコーヒーの特徴。",
        'ko': "당분이 캐러멜화되면서 발달하는 따뜻하고 달콤한 향신료 노트입니다. 페놀 화합물이 풍부합니다. 수마트라와 루완다 커피의 특징입니다.",
        'zh': "随着糖分焦糖化而产生的温暖、甜美的香料味。富含酚类化合物。苏门答腊和卢旺达咖啡的特征。",
        'ar': "نكهات توابل دافئة وحلوة تتطور مع كراميل السكريات. غنية بالمركبات الفينولية. من سمات القهوة السومطرية والرواندية.",
    },
    'wheel_note_clove': {
        'en': "Spicy, pungent note with a warm sensation. Result of specific phenolic compounds. Found in some Rwandan and Burundian coffees.",
        'uk': "Пряна, різка нота з відчуттям тепла. Результат дії специфічних фенольних сполук. Зустрічається в деяких руандійських та бурундійських лотах.",
        'de': "Würzige, stechende Note mit einem warmen Gefühl. Ergebnis spezifischer phenolischer Verbindungen. In einigen ruandischen und burundischen Kaffees zu finden.",
        'fr': "Note épicée et piquante avec une sensation de chaleur. Résultat de composés phénoliques spécifiques. Présent dans certains cafés rwandais et burundais.",
        'es': "Nota especiada y punzante con una sensación cálida. Resultado de compuestos fenólicos específicos. Se encuentra en algunos cafés de Ruanda y Burundi.",
        'it': "Nota speziata e pungente con una sensazione di calore. Risultato di specifici composti fenolici. Si trova in alcuni caffè rwandesi e burundesi.",
        'pt': "Nota picante e pungente com uma sensação de calor. Resultado de compostos fenólicos específicos. Encontrada em alguns cafés ruandeses e burundeses.",
        'pl': "Korzenna, ostra nuta z uczuciem ciepła. Wynik specyficznych związków fenolowych. Spotykana w niektórych kawach rwandyjskich i burundyjskich.",
        'nl': "Kruidige, prikkelende noot met een warm gevoel. Resultaat van specifieke fenolische verbindingen. Te vinden in sommige Rwandese en Burundese koffies.",
        'sv': "Kryddig, stickande not med en varm känsla. Resultat av specifika fenoliska föreningar. Finns i vissa kaffesorter från Rwanda och Burundi.",
        'tr': "Sıcak bir his veren baharatlı, keskin nota. Spesifik fenolik bileşiklerin sonucudur. Bazı Ruanda ve Burundi kahvelerinde bulunur.",
        'ja': "温かみのある、スパイシーで刺激的なノート。特定のフェノール化合物の結果。一部のルワンダやブルンジのコーヒーに見られる。",
        'ko': "따뜻한 느낌을 주는 매콤하고 톡 쏘는 노트입니다. 특정 페놀 화합물의 결과입니다. 일부 루완다 및 부룬디 커피에서 발견됩니다.",
        'zh': "辛辣、刺激的味道，带有温暖的感觉。特定酚类化合物的结果。出现在一些卢旺达和布隆迪咖啡中。",
        'ar': "نكهة حادة وحريفة مع إحساس بالدفء. نتيجة لمركبات فينولية معينة. توجد في بعض أنواع القهوة الرواندية والبوروندية.",
    },
    'wheel_note_cinnamon': {
        'en': "Sweet, woody spice note. Common in medium-light roasts of dense coffees. Frequent in Yemeni and some Ethiopian coffees.",
        'uk': "Солодка, деревна нота спецій. Поширена у середньо-світлих обсмажуваннях щільної кави. Часто зустрічається в єменській та деякій ефіопській каві.",
        'de': "Süße, holzige Gewürznote. Häufig bei mittelhellen Röstungen dichter Kaffees. Oft bei jemenitischen und einigen äthiopischen Kaffees.",
        'fr': "Note d'épice sucrée et boisée. Courant dans les torréfactions moyennes-claires de cafés denses. Fréquent dans les cafés yéménites et certains cafés éthiopiens.",
        'es': "Nota de especia dulce y amaderada. Común en tuestes medios-ligeros de cafés densos. Frecuente en cafés yemeníes y algunos etíopes.",
        'it': "Nota speziata dolce e legnosa. Comune nelle tostature medio-chiare di caffè densi. Frequente nei caffè yemeniti e in alcuni etiopi.",
        'pt': "Nota de especiaria doce e amadeirada. Comum em torras médias-claras de cafés densos. Frequente em cafés iemenitas e alguns etíopes.",
        'pl': "Słodka, drzewna nuta korzenna. Powszechna в średnio-jasnych paleniach gęstych kaw. Częsta в kawach jemeńskich i niektórych etiopskich.",
        'nl': "Zoete, houtachtige kruidnoot. Veelvoorkomend bij medium-lichte brandingen van koffie met een hoge dichtheid. Veel te vinden in Jemenitische en sommige Ethiopische koffies.",
        'sv': "Söt, träig kryddnot. Vanligt vid mellanljusa rostningar av täta kaffesorter. Förekommer ofta i jemenitiskt och visst etiopiskt kaffe.",
        'tr': "Tatlı, odunsu baharat notası. Yoğun kahvelerin orta-açık kavurmalarında yaygındır. Yemen ve bazı Etiyopya kahvelerinde sık görülür.",
        'ja': "甘くウッディなスパイスのノート。密度の高い豆の中浅煎りで一般的。イエメン産や一部のエチオピア産コーヒーで頻繁に見られる。",
        'ko': "달콤하고 나무 향이 나는 향신료 노트입니다. 밀도가 높은 원두의 중약배전에서 흔히 볼 수 있습니다. 예멘 및 일부 에티오피아 커피에서 자주 발견됩니다.",
        'zh': "甜美的木质香料味。常见于高密度咖啡的中浅度烘焙。经常出现在也门和一些埃塞俄比亚咖啡中。",
        'ar': "نكهة توابل حلوة وخشبية. شائعة في التحميص المتوسط الخفيف للقهوة الكثيفة. تتكرر في القهوة اليمنية وبعض أنواع القهوة الإثيوبية.",
    },
    'wheel_note_nutmeg': {
        'en': "Earthy and warm spice profile. Often complements chocolate and nutty sweetness. Characteristic of high-grade Indonesian Arabicas.",
        'uk': "Землистий та теплий профіль спецій. Часто доповнює шоколадну та горіхову солодкість. Характерно для високоякісної індонезійської арабіки.",
        'de': "Erdiges und warmes Gewürzprofil. Ergänzt oft schokoladige und nussige Süße. Charakteristisch für hochwertige indonesische Arabicas.",
        'fr': "Profil d'épice terreux et chaud. Complète souvent la douceur du chocolat et des noix. Caractéristique des Arabicas indonésiens de haute qualité.",
        'es': "Perfil de especias terroso y cálido. A menudo complementa la dulzura del chocolate y las nueces. Característico de las arábicas indonesias de alta calidad.",
        'it': "Profilo speziato terroso e caldo. Spesso completa la dolcezza del cioccolato e della frutta a guscio. Caratteristico delle Arabiche indonesiane di alta qualità.",
        'pt': "Perfil de especiaria terroso e quente. Frequentemente complementa a doçura do chocolate e das nozes. Característico de Arábicas indonésias de elevada qualidade.",
        'pl': "Ziemisty i ciepły profil korzenny. Często dopełnia czekoladową i orzechową słodycz. Charakterystyczne dla wysokiej klasy indonezyjskich Arabik.",
        'nl': "Aards en warm kruidprofiel. Vult vaak chocolade- en nootachtige zoetheid aan. Kenmerkend voor hoogwaardige Indonesische Arabica's.",
        'sv': "Jordig och varm kryddprofil. Kompletterar ofta choklad och nötig sötma. Karaktäristiskt för indonesisk Arabica av hög kvalitet.",
        'tr': "Topraksı ve sıcak baharat profili. Genellikle çikolata ve fındıksı tatlılığı tamamlar. Üst düzey Endonezya Arabica'larının özelliğidir.",
        'ja': "土っぽく温かみのあるスパイスのプロファイル。多くの場合、チョコレートやナッツのような甘みを補完する。高級なインドネシア産アラビカ種の特徴。",
        'ko': "흙 내음이 나는 따뜻한 향신료 프로필입니다. 종종 초콜릿과 견과류의 단맛을 보완합니다. 고품질 인도네시아 아라비카의 특징입니다.",
        'zh': "泥土感和温暖的香料剖面。通常与巧克力和坚果的甜味相得益彰。高等级印度尼西亚阿拉比卡咖啡的特征。",
        'ar': "ملف توابل ترابي ودافئ. غالباً ما يكمل حلاوة الشوكولاتة والمكسرات. من سمات أرابيكا الإندونيسية عالية الجودة.",
    },
    'wheel_note_anise': {
        'en': "Cool, sweet and slightly medicinal spice note. Reminiscent of licorice. Found in some rare Yemeni and complex African lots.",
        'uk': "Прохолодна, солодка та злегка аптечна нота спецій. Нагадує лакрицю. Зустрічається в деяких рідкісних єменських та складних африканських лотах.",
        'de': "Kühle, süße und leicht medizinische Gewürznote. Erinnert an Lakritz. In einigen seltenen jemenitischen und komplexen afrikanischen Partien zu finden.",
        'fr': "Note d'épice fraîche, sucrée et légèrement médicinale. Rappelle la réglisse. Présent dans certains lots yéménites rares et des lots africains complexes.",
        'es': "Nota de especia fresca, dulce y ligeramente medicinal. Recuerda al regaliz. Se encuentra en algunos lotes yemeníes raros y africanos complejos.",
        'it': "Nota speziata fresca, dolce e leggermente medicinale. Ricorda la liquirizia. Si trova in alcuni rari lotti yemeniti e complessi lotti africani.",
        'pt': "Nota de especiaria fresca, doce e ligeiramente medicinal. Lembra alcaçuz. Encontrada em alguns lotes iemenitas raros e lotes africanos complexos.",
        'pl': "Chłodna, słodka i lekko medyczna nuta korzenna. Przypomina lukrecję. Spotykana в niektórych rzadkich kawach jemeńskich i złożonych afrykańskich.",
        'nl': "Koele, zoete en licht medicinale kruidnoot. Doet denken aan drop. Te vinden in sommige zeldzame Jemenitische en complexe Afrikaanse partijen.",
        'sv': "Sval, söt och något medicinsk kryddnot. Påminner om lakrits. Finns i vissa sällsynta jemenitiska och komplexa afrikanska partier.",
        'tr': "Serin, tatlı ve hafif tıbbi baharat notası. Meyan kökünü andırır. Bazı nadir Yemen ve karmaşık Afrika lotlarında bulunur.",
        'ja': "冷涼感のある甘くわずかに薬のようなスパイスのノート。リコリス（甘草）を思わせる。一部の希少なイエメン産や複雑なアフリカ産ロットに見られる。",
        'ko': "시원하고 달콤하며 약간 약 같은 느낌의 향신료 노트입니다. 감초를 연상시킵니다. 일부 희귀한 예멘 및 복합적인 아프리카 로트에서 발견됩니다.",
        'zh': "凉爽、甜美且略带药味的香料味。令人联想到甘草。出现在一些稀有的也门批次和复杂的非洲批次中。",
        'ar': "نكهة توابل باردة وحلوة ودوائية قليلاً. تذكرنا بالعرقسوس. توجد في بعض الدفعات اليمنية النادرة والأفريقية المعقدة.",
    },
}

with open(target_file, 'r', encoding='utf-8') as f:
    content = f.read()

for key, langs in translations.items():
    new_block = f"'{key}': {{\n"
    for lang, text in langs.items():
        safe_text = text.replace(chr(39), '\\' + chr(39))
        new_block += f"        '{lang}': '{safe_text}',\n"
    new_block += "      },"
    pattern = rf"'{key}':\s*\{{.*?\}},"
    content = re.sub(pattern, new_block, content, flags=re.DOTALL)

with open(target_file, 'w', encoding='utf-8', newline='\n') as f:
    f.write(content)

print('Spices update complete.')
