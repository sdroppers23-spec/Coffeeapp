
import re
import os

target_file = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

translations = {
    'wheel_sub_berry': {
        'en': "Vibrant and sweet-tart notes of small fruits. Derived from concentrated anthocyanins. Typical of Ethiopian natural coffees and Kenyan SL-varieties.",
        'uk': "Яскраві та солодко-кислі ноти дрібних плодів. Походять від концентрованих антоціанів. Типово для ефіопської кави натуральної обробки та кенійських сортів SL.",
        'de': "Lebendige und süß-saure Noten kleiner Früchte. Stammen von konzentrierten Anthocyanen. Typisch für äthiopische Naturkaffees und kenianische SL-Varietäten.",
        'fr': "Notes vibrantes et acidulées de petits fruits. Dérivé d'anthocyanes concentrées. Typique des cafés éthiopiens naturels et des variétés kenyanes SL.",
        'es': "Notas vibrantes y agridulces de frutas pequeñas. Derivado de antocianinas concentradas. Típico de los cafés naturales etíopes y las variedades SL kenianas.",
        'it': "Note vivaci e dolci-aspre di piccoli frutti. Derivano da antociani concentrati. Tipico dei caffè naturali etiopi e delle varietà keniane SL.",
        'pt': "Notas vibrantes e agridoces de pequenos frutos. Derivadas de antocianinas concentradas. Típico de cafés naturais etíopes e variedades quenianas SL.",
        'pl': "Żywe i słodko-cierpkie nuty małych owoców. Pochodzą ze skoncentrowanych antocyjanów. Typowe dla etiopskich kaw naturalnych i kenijskich odmian SL.",
        'nl': "Levendige en zoetzure tonen van kleine vruchten. Afgeleid van geconcentreerde anthocyanen. Typisch voor Ethiopische natural koffies en Keniaanse SL-variëteiten.",
        'sv': "Livliga och söt-syrliga toner av små frukter. Härrör från koncentrerade antocyaniner. Typiskt för etiopiskt naturkaffe och kenyanska SL-varieteter.",
        'tr': "Küçük meyvelerin canlı ve tatlı-ekşi notaları. Konsantre antosiyaninlerden türetilmiştir. Etiyopya doğal kahveleri ve Kenya SL çeşitlerinin özelliğidir.",
        'ja': "小果実の鮮やかで甘酸っぱいノート。濃縮されたアントシアニンに由来する。エチオピアのナチュラルコーヒーやケニアのSL品種に典型的。",
        'ko': "작은 과일의 활기차고 달콤 쌉싸름한 노트입니다. 농축된 안토시아닌에서 비롯됩니다. 에티오피아 내추럴 커피와 케냐 SL 품종의 전형적인 특징입니다.",
        'zh': "小水果的鲜明甜酸味。源自浓缩的安托合苷。埃塞俄比亚日晒咖啡和肯尼亚SL品种的典型特征。",
        'ar': "نكهات حيوية وحلوة وحامضة للفواكه الصغيرة. مشتقة من الأنثوسيانين المركز. نموذجية للقهوة الإثيوبية الطبيعية وأصناف SL الكينية.",
    },
    'wheel_sub_dried_fruit': {
        'en': "Concentrated, jammy sweetness reminiscent of raisins or dates. Often the result of over-ripening or natural sun-drying. Common in Yemen Moka and processed lots from Brazil.",
        'uk': "Концентрована, джемова солодкість, що нагадує родзинки або фініки. Часто результат перезрівання або натурального сушіння на сонці. Зустрічається в єменській Мока та лотах з Бразилії.",
        'de': "Konzentrierte, marmeladige Süße, die an Rosinen oder Datteln erinnert. Oft das Ergebnis von Überreife oder natürlicher Sonnentrocknung. Häufig in Jemen-Moka und brasilianischen Partien.",
        'fr': "Douceur concentrée et confiturée rappelant les raisins secs ou les dattes. Souvent le résultat d'une sur-maturation ou d'un séchage naturel au soleil. Courant dans le Moka du Yémen et les lots brésiliens.",
        'es': "Dulzura concentrada y amermelada que recuerda a las pasas o los dátiles. A menudo resultado de la sobremaduración o el secado natural al sol. Común en el Moka de Yemen y lotes procesados de Brasil.",
        'it': "Dolcezza concentrata e marmellatosa che ricorda l'uva passa o i datteri. Spesso frutto di sovramaturazione o essiccazione naturale al sole. Comune nel Moka dello Yemen e nei lotti brasiliani.",
        'pt': "Doçura concentrada e de compota que lembra passas ou tâmara. Frequentemente o resultado de sobreamaduração ou secagem natural ao sol. Comum no Moka do Iémen e lotes processados do Brasil.",
        'pl': "Skoncentrowana, dżemowa słodycz przypominająca rodzynki lub daktyle. Często wynik przejrzałości lub naturalnego suszenia na słońcu. Powszechna w kawach Yemen Moka i partiach z Brazylii.",
        'nl': "Geconcentreerde, jam-achtige zoetheid die doet denken aan rozijnen of dadels. Vaak het resultaat van overrijping of natuurlijke zonnedroging. Veelvoorkomend in Yemen Moka en verwerkte partijen uit Brazilië.",
        'sv': "Koncentrerad, syltliknande sötma som påminner om russin eller dadlar. Ofta resultatet av övermognad eller naturlig soltorkning. Vanligt i Yemen Moka och bearbetade partier från Brasilien.",
        'tr': "Kuru üzüm veya hurmayı andıran konsantre, reçelsi tatlılık. Genellikle aşırı olgunlaşmanın veya doğal güneşte kurutmanın sonucudur. Yemen Moka ve Brezilya'dan gelen işlenmiş lotlarda yaygındır.",
        'ja': "レーズンやデーツを思わせる、濃縮されたジャムのような甘み。過熟や天日乾燥の結果であることが多い。イエメン・モカやブラジル産の精製ロットに一般的。",
        'ko': "건포도나 대추야자를 연상시키는 농축된 잼 같은 단맛입니다. 종종 과숙되거나 자연 건조된 결과입니다. 예멘 모카와 브라질 가공 로트에서 흔히 볼 수 있습니다.",
        'zh': "浓缩的、果酱般的甜味，令人联想到葡萄干或红枣。通常是过度成熟或天然日晒的结果。常见于也门摩卡和巴西的处理批次中。",
        'ar': "حلاوة مركزة تشبه المربى تذكرنا بالزبيب أو التمر. غالبًا ما تكون نتيجة النضج الزائد أو التجفيف الطبيعي تحت الشمس. شائعة في موكا اليمن والدفعات المعالجة من البرازيل.",
    },
    'wheel_sub_other_fruit': {
        'en': "Tropical or temperate fruit notes like apple, pear, or mango. Represents intermediate acidity levels. Characteristic of Costa Rican and Salvadoran coffees.",
        'uk': "Ноти тропічних або фруктів помірного клімату, таких як яблуко, груша або манго. Представляє середній рівень кислотності. Характерно для коста-риканської та сальвадорської кави.",
        'de': "Noten von tropischen oder heimischen Früchten wie Apfel, Birne oder Mango. Repräsentiert mittlere Säuregrade. Charakteristisch für Kaffees aus Costa Rica und El Salvador.",
        'fr': "Notes de fruits tropicaux ou tempérés comme la pomme, la poire ou la mangue. Représente des niveaux d'acidité intermédiaires. Caractéristique des cafés du Costa Rica et du Salvador.",
        'es': "Notas de frutas tropicales o templadas como manzana, pera o mango. Representa niveles de acidez intermedios. Característico de los cafés de Costa Rica y El Salvador.",
        'it': "Note di frutta tropicale o temperata come mela, pera o mango. Rappresenta livelli di acidità intermedi. Caratteristico dei caffè della Costa Rica e del Salvador.",
        'pt': "Notas de frutas tropicais ou temperadas como maçã, pera ou manga. Representa níveis de acidez intermédios. Característico de cafés da Costa Rica e de El Salvador.",
        'pl': "Nuty owoców tropikalnych lub umiarkowanych, takich jak jabłko, gruszka lub mango. Reprezentuje pośrednie poziomy kwasowości. Charakterystyczne dla kaw z Kostaryki i Salwadoru.",
        'nl': "Tropische of gematigde fruittonen zoals appel, peer of mango. Staat voor gemiddelde zuurgraadniveaus. Kenmerkend voor koffies uit Costa Rica en El Salvador.",
        'sv': "Tropiska eller tempererade fruktnoter som äpple, päron eller mango. Representerar medelhöga syranivåer. Karaktäristiskt för kaffe från Costa Rica och El Salvador.",
        'tr': "Elma, armut veya mango gibi tropikal veya ılıman meyve notaları. Orta düzeyde asidite seviyelerini temsil eder. Kosta Rika ve El Salvador kahvelerinin özelliğidir.",
        'ja': "リンゴ、梨、マンゴーなどの熱帯果実または温帯果実のノート。中程度の酸味レベルを表す。コスタリカやエルサルバドルのコーヒーの特徴。",
        'ko': "사과, 배 또는 망고와 같은 열대 또는 온대 과일 노트입니다. 중간 정도의 산미 수준을 나타냅니다. 코스타리카와 엘살바도르 커피의 특징입니다.",
        'zh': "热带或温带水果气味，如苹果、梨或芒果。代表中等酸度水平。哥斯达黎加和萨尔瓦多咖啡的特征。",
        'ar': "نكهات فواكه استوائية أو معتدلة مثل التفاح أو الكمثرى أو المانجو. تمثل مستويات حموضة متوسطة. من سمات القهوة الكوستاريكية والسلفادورية.",
    },
    'wheel_sub_citrus': {
        'en': "Sharp, bright, and refreshing citric notes. Often associated with high elevation and volcanic soils. Hallmarks of Kenyan, Rwandan, and Guatemalan coffees.",
        'uk': "Гострі, яскраві та освіжаючі цитрусові ноти. Часто асоціюються з великою висотою та вулканічними ґрунтами. Візитна картка кенійської, руандійської та гватемальської кави.",
        'de': "Scharfe, helle und erfrischende Zitrusnoten. Oft mit großen Höhenlagen und vulkanischen Böden verbunden. Kennzeichen von Kaffees aus Kenia, Ruanda und Guatemala.",
        'fr': "Notes citriques vives, nettes et rafraîchissantes. Souvent associées à une altitude élevée et à des sols volcaniques. Marque de fabrique des cafés kenyans, rwandais et guatémaltèques.",
        'es': "Notas cítricas afiladas, brillantes y refrescantes. A menudo asociadas con gran altitud y suelos volcánicos. Sello distintivo de los cafés de Kenia, Ruanda y Guatemala.",
        'it': "Note citriche acute, brillanti e rinfrescanti. Spesso associate ad altitudini elevate e terreni vulcanici. Segno distintivo dei caffè kenioti, ruandesi e guatemaltechi.",
        'pt': "Notas cítricas agudas, brilhantes e refrescantes. Frequentemente associadas a elevadas altitudes e solos vulcânicos. Marcas de cafés quenianos, ruandeses e guatemaltecos.",
        'pl': "Ostre, jasne i odświeżające nuty cytrusowe. Często kojarzone z dużą wysokością upraw i wulkanicznymi glebami. Znaki rozpoznawcze kaw z Kenii, Rwandy i Gwatemali.",
        'nl': "Scherpe, heldere en verfrissende citrustonen. Vaak geassocieerd met grote hoogte en vulkanische bodems. Kenmerken van Keniaanse, Rwandese en Guatemalteekse koffies.",
        'sv': "Skarp, ljusa och uppfriskande citrustoner. Ofta förknippade med hög höjd och vulkaniska jordar. Kännetecken för kaffe från Kenya, Rwanda och Guatemala.",
        'tr': "Keskin, parlak ve ferahlatıcı narenciye notaları. Genellikle yüksek rakım ve volkanik topraklarla ilişkilidir. Kenya, Ruanda ve Guatemala kahvelerinin ayırt edici özellikleridir.",
        'ja': "鋭く明るい、爽やかな柑橘系のノート。多くの場合、高標高や火山性土壌に関連している。ケニア、ルワンダ、グアテマラのコーヒーの特徴。",
        'ko': "날카롭고 밝으며 상쾌한 시트러스 노트입니다. 종종 높은 고도와 화산 토양과 관련이 있습니다. 케냐, 루완다, 과테말라 커피의 특징입니다.",
        'zh': "尖锐、明亮且清新的柑橘味。通常与高海拔和火山土壤有关。肯尼亚、卢旺达和危地马拉咖啡的标志。",
        'ar': "نكهات حمضية حادة ومشرقة ومنعشة. ترتبط غالبًا بالارتفاعات العالية والتربة البركانية. من سمات القهوة الكينية والرواندية والغواتيمالية.",
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

print('Fruity sub-categories update complete.')
