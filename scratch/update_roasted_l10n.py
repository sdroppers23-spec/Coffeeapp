
import re
import os

target_file = r'd:\Games\Coffeeapp\lib\core\l10n\flavor_descriptions.dart'

translations = {
    'wheel_sub_cereal': {
        'en': "Toasted grain and bread-like notes. Indicative of early roast stages or specific bean density. Common in many Brazilian and Indian lots.",
        'uk': "Ноти підсмаженого зерна та хліба. Вказують на ранні стадії обсмажування або специфічну щільність зерна. Поширено в багатьох бразильських та індійських лотах.",
        'de': "Noten von geröstetem Getreide und Brot. Deutet auf frühe Röststadien oder eine spezifische Bohnendichte hin. Häufig bei vielen brasilianischen und indischen Partien.",
        'fr': "Notes de céréales grillées et de pain. Indique les premières étapes de la torréfaction ou une densité de grain spécifique. Courant dans de nombreux lots brésiliens et indiens.",
        'es': "Notas de grano tostado y pan. Indicativo de las primeras etapas del tueste o de la densidad específica del grano. Común en muchos lotes brasileños e indios.",
        'it': "Note di cereali tostati e pane. Indicativo delle prime fasi della tostatura o della densità specifica del chicco. Comune in molti lotti brasiliani e indiani.",
        'pt': "Notas de cereais torrados e pão. Indicativo de fases iniciais da torra ou de densidade específica do grão. Comum em muitos lotes brasileiros e indianos.",
        'pl': "Nuty prażonego ziarna i chleba. Wskazują на wczesne etapy palenia lub specyficzną gęstość ziarna. Powszechne в wielu partiach brazylijskich i indyjskich.",
        'nl': "Tonen van geroosterd graan en brood. Indicatief voor vroege brandstadia of specifieke bonendichtheid. Veelvoorkomend in veel Braziliaanse en Indiase partijen.",
        'sv': "Noter av rostat spannmål och bröd. Indikerar tidiga rostningsstadier eller specifik bön-densitet. Vanligt i många brasilianska och indiska partier.",
        'tr': "Kavrulmuş tahıl ve ekmek benzeri notalar. Erken kavurma aşamalarının veya spesifik çekirdek yoğunluğunun göstergesidir. Birçok Brezilya ve Hindistan lotunda yaygındів.",
        'ja': "トーストした穀物やパンのようなノート。焙煎の初期段階や特定の豆の密度を示す。多くのブラジル産やインド産ロットに一般的。",
        'ko': "구운 곡물과 빵 같은 노트입니다. 초기 배전 단계나 특정 원두 밀도를 나타냅니다. 많은 브라질 및 인도 로트에서 흔히 볼 수 있습니다.",
        'zh': "烘烤谷物和面包味。表示早期烘焙阶段或特定的咖啡豆密度。常见于许多巴西和印度批次中。",
        'ar': "نكهات حبوب محمصة وتشبه الخبز. تشير إلى مراحل التحميص المبكرة أو كثافة حبوب معينة. شائعة في العديد من الدفعات البرازيلية والهندية.",
    },
    'wheel_sub_burnt': {
        'en': "Intense smoky or carbonized notes. Result of high-temperature pyrolysis during roasting. Hallmarks of dark roast profiles.",
        'uk': "Інтенсивні димні або обвуглені ноти. Результат високотемпературного піролізу під час обсмажування. Візитна картка темних профілів обсмажування.",
        'de': "Intensive rauchige oder karbonisierte Noten. Ergebnis der Hochtemperaturpyrolyse während des Röstens. Kennzeichen dunkler Röstprofile.",
        'fr': "Notes fumées ou carbonisées intenses. Résultat de la pyrolyse à haute température pendant la torréfaction. Marque de fabrique des profils de torréfaction foncée.",
        'es': "Notas intensas de humo o carbonizadas. Resultado de la pirólisis a alta temperatura durante el tueste. Sello distintivo de los perfiles de tueste oscuro.",
        'it': "Intense note fumose o carbonizzate. Risultato della pirolisi ad alta temperatura durante la tostatura. Segno distintivo dei profili di tostatura scura.",
        'pt': "Notas intensas de fumo ou carbonizadas. Resultado de pirólise a alta temperatura durante a torrefação. Marcas de perfis de torra escura.",
        'pl': "Intensywne nuty dymne lub zwęglone. Wynik pirolizy wysokotemperaturowej podczas palenia. Znaki rozpoznawcze ciemnych profilів palenia.",
        'nl': "Intensieve rokerige of gecarboniseerde tonen. Resultaat van pyrolyse bij hoge temperaturen tijdens het branden. Kenmerken van donkere brandprofielen.",
        'sv': "Intensiva rökiga eller kolsyrade noter. Resultat av högtemperaturpyrolys under rostningen. Kännetecken för mörkrostade profiler.",
        'tr': "Yoğun dumanlı veya karbonize notalar. Kavurma sırasında yüksek sıcaklık pirolizinin sonucudur. Koyu kavurma profillerinin ayırt edici özelliğidir.",
        'ja': "強烈なスモーキーまたは炭化したノート。焙煎中の高温熱分解の結果。深煎りプロファイルの特徴。",
        'ko': "강렬한 스모키 또는 탄 듯한 노트입니다. 배전 중 고온 열분해의 결과입니다. 다크 로스팅 프로필의 특징입니다.",
        'zh': "强烈的烟熏或碳化味。烘焙过程中高温热解的结果。深度烘焙剖面的标志。",
        'ar': "نكهات دخانية أو متفحمة مكثفة. نتيجة التحلل الحراري العالي أثناء التحميص. من سمات ملفات التحميص الداكنة.",
    },
    'wheel_note_malt': {
        'en': "Sweet, grain-like note reminiscent of beer or freshly baked bread. Indicator of specific sugar-amino-acid reactions. Common in traditional Brazilian coffees.",
        'uk': "Солодка, зернова нота, що нагадує пиво або свіжоспечений хліб. Індикатор специфічних реакцій між цукрами та амінокислотами. Поширено в традиційній бразильській каві.",
        'de': "Süße, getreideartige Note, die an Bier oder frisch gebackenes Brot erinnert. Indikator für spezifische Zucker-Aminosäure-Reaktionen. Häufig bei traditionellen brasilianischen Kaffees.",
        'fr': "Note sucrée et céréalière rappelant la bière ou le pain fraîchement cuit. Indicateur de réactions spécifiques entre sucres et acides aminés. Courant dans les cafés brésiliens traditionnels.",
        'es': "Nota dulce y cereal que recuerda a la cerveza o al pan recién horneado. Indicador de reacciones específicas de azúcar y aminoácidos. Común en los cafés brasileños tradicionales.",
        'it': "Nota dolce e cerealicola che ricorda la birra o il pane appena sfornato. Indicatore di specifiche reazioni zucchero-aminoacidi. Comune nei caffè brasiliani tradizionali.",
        'pt': "Nota doce e cereal que lembra cerveja ou pão acabado de cozer. Indicador de reações específicas de açúcar e aminoácidos. Comum em cafés brasileiros tradicionais.",
        'pl': "Słodka, zbożowa nuta przypominająca piwo lub świeżo upieczony chleb. Wskaźnik specyficznych reakcji cukrowo-aminokwasowych. Powszechna в tradycyjnych kawach brazylijskich.",
        'nl': "Zoete, graanachtige noot die doet denken aan bier of vers gebakken brood. Indicator van specifieke suiker-aminozuurreacties. Veelvoorkomend in traditionele Braziliaanse koffies.",
        'sv': "Söt, spannmålsliknande not som påminner om öl eller nybakat bröd. Indikator på specifika socker-aminosyrareaktioner. Vanligt i traditionellt brasilianskt kaffe.",
        'tr': "Bira veya taze pişmiş ekmeği andıran tatlı, tahıl benzeri nota. Spesifik şeker-amino asit reaksiyonlarının göstergesidir. Geleneksel Brezilya kahvelerinde yaygındır.",
        'ja': "ビールや焼き立てのパンを思わせる、甘い穀物のようなノート。特定の糖とアミノ酸の反応の指標。伝統的なブラジル産コーヒーに一般的。",
        'ko': "맥주나 갓 구운 빵을 연상시키는 달콤하고 곡물 같은 노트입니다. 특정 당-아미노산 반응의 지표입니다. 전통적인 브라질 커피에서 흔히 볼 수 있습니다.",
        'zh': "带甜味的谷物味，令人联想到啤酒或刚出炉的面包。特定糖-氨基酸反应的指标。常见于传统的巴西咖啡中。",
        'ar': "نكهة حلوة تشبه الحبوب تذكرنا بالبيرة أو الخبز الطازج. مؤشر على تفاعلات سكر وأحماض أمينية معينة. شائعة في القهوة البرازيلية التقليدية.",
    },
    'wheel_note_grain': {
        'en': "Basic, foundational toasted cereal note. Often reflects terroir or specific harvest conditions. Found in many Latin American Arabicas.",
        'uk': "Базова, фундаментальна нота підсмажених злаків. Часто відображає теруар або специфічні умови збору врожаю. Зустрічається в багатьох латиноамериканських арабіках.",
        'de': "Grundlegende, fundamentale Note von geröstetem Getreide. Spiegelt oft das Terroir oder spezifische Erntebedingungen wider. In vielen lateinamerikanischen Arabicas zu finden.",
        'fr': "Note de céréales grillées de base et fondamentale. Reflète souvent le terroir ou des conditions de récolte spécifiques. Présent dans de nombreuses Arabicas d'Amérique latine.",
        'es': "Nota básica y fundamental de cereal tostado. A menudo refleja el terroir o condiciones de cosecha específicas. Se encuentra en muchas arábicas latinoamericanas.",
        'it': "Nota di cereale tostato base e fondamentale. Spesso riflette il terroir o specifiche condizioni di raccolta. Si trova in molte Arabiche dell'America Latina.",
        'pt': "Nota básica e fundamental de cereal torrado. Frequentemente reflete o terroir ou condições de colheita específicas. Encontrada em muitas Arábicas da América Latina.",
        'pl': "Podstawowa, fundamentalna nuta prażonych zbóż. Często odzwierciedla terroir lub specyficzne warunki zbiorów. Spotykana w wielu latynoamerykańskich Arabikach.",
        'nl': "Basale, fundamentele geroosterde graannoot. Weerspiegelt vaak terroir of specifieke oogstomstandigheden. Te vinden in veel Latijns-Amerikaanse Arabica's.",
        'sv': "Grundläggande rostad spannmålsnot. Speglar ofta terroir eller specifika skördeförhållanden. Finns i många latinamerikanska Arabica-sorter.",
        'tr': "Temel kavrulmuş tahıl notası. Genellikle teruarı veya spesifik hasat koşullarını yansıtır. Birçok Latin Amerika Arabica'sında bulunur.",
        'ja': "基本的で基礎的なトーストしたシリアルのノート。テロワールや特定の収穫条件を反映することが多い。多くの中南米産アラビカ種に見られる。",
        'ko': "기본적이고 근본적인 구운 시리얼 노트입니다. 종종 테루아나 특정 수확 조건을 반영합니다. 많은 라틴 아메리카 아라비카에서 발견됩니다.",
        'zh': "基础的烘烤谷物风味。通常反映风土或特定的收获条件。存在于许多拉丁美洲阿拉比卡咖啡中。",
        'ar': "نكهة حبوب محمصة أساسية وجوهرية. تعكس غالباً البيئة المحلية أو ظروف حصاد معينة. توجد في العديد من أنواع أرابيكا من أمريكا اللاتينية.",
    },
    'wheel_note_smoky': {
        'en': "Intense char and wood-smoke notes. Typical of dark-roast profiles where pyrolysis dominates. Quintessential for South Italian espresso styles.",
        'uk': "Інтенсивні ноти вугілля та деревного диму. Типово для темних профілів обсмажування, де домінує піроліз. Класика для південноіталійського стилю еспресо.",
        'de': "Intensive Holzkohle- und Holzrauchnoten. Typisch für dunkle Röstprofile, bei denen die Pyrolyse dominiert. Inbegriff süditalienischer Espresso-Stile.",
        'fr': "Notes intenses de charbon et de fumée de bois. Typique des profils de torréfaction foncée où la pyrolyse domine. Quintessence des styles d'espresso du sud de l'Italie.",
        'es': "Notas intensas de carbón y humo de madera. Típico de perfiles de tueste oscuro donde domina la pirólisis. Esencial para los estilos de espresso del sur de Italia.",
        'it': "Intense note di carbone e fumo di legna. Tipico dei profili di tostatura scura dove domina la pirolisi. Quintessenza degli stili di espresso del sud Italia.",
        'pt': "Notas intensas de carvão e fumo de madeira. Típico de perfis de torra escura onde a pirólise domina. Quintessencial para estilos de café expresso do sul de Itália.",
        'pl': "Intensywne nuty węgla drzewnego i dymu. Typowe dla profilі ciemnego palenia, w których dominuje piroliza. Kwintesencja stylów espresso z południowych Włoch.",
        'nl': "Intensieve houtskool- en houtrooktonen. Typisch voor donkere brandprofielen waar pyrolyse domineert. Typisch voor Zuid-Italiaanse espressostijlen.",
        'sv': "Intensiva noter av kol och vedrök. Typiskt för mörka rostningsprofiler där pyrolys dominerar. Inbegreppet av syditaliensk espressostil.",
        'tr': "Yoğun kömür ve odun dumanı notaları. Pirolizin baskın olduğu koyu kavurma profillerinin özelliğidir. Güney İtalyan espresso stilleri için vazgeçilmezdir.",
        'ja': "強烈な炭と木煙のノート。熱分解が支配的な深煎りプロファイルに典型的。南イタリアのエスプレッソスタイルの神髄。",
        'ko': "강렬한 숯과 나무 연기 향입니다. 열분해가 지배적인 다크 로스팅 프로필의 전형적인 특징입니다. 남부 이탈리아 에스프레소 스타일의 정수입니다.",
        'zh': "强烈的焦炭和木烟味。典型的深度烘焙剖面，热解作用占主导地位。南意大利意式浓缩风格的精华。",
        'ar': "نكهات فحم ودخان خشب مكثفة. نموذجية لملفات التحميص الداكنة حيث يهيمن التحلل الحراري. جوهر أنماط الإسبريسو في جنوب إيطاليا.",
    },
    'wheel_note_ashy': {
        'en': "Dry, carbonaceous and mineral-like note. Indicates extreme roast exposure. Found in commercial-grade dark roasts.",
        'uk': "Суха, вуглецева та мінеральна нота. Вказує на екстремально тривале обсмажування. Зустрічається в темних обсмажуваннях комерційного класу.",
        'de': "Trockene, kohlenstoffhaltige und mineralähnliche Note. Deutet auf eine extreme Röstung hin. In kommerziellen dunklen Röstungen zu finden.",
        'fr': "Note sèche, carbonée et minérale. Indique une exposition extrême à la torréfaction. Présent dans les torréfactions foncées de qualité commerciale.",
        'es': "Nota seca, carbonosa y mineral. Indica una exposición extrema al tueste. Se encuentra en tuestes oscuros de grado comercial.",
        'it': "Nota secca, carbonosa e minerale. Indica un'esposizione estrema alla tostatura. Si trova nelle tostature scure di grado commerciale.",
        'pt': "Nota seca, carbonosa e mineral. Indica uma exposição extrema à torrefação. Encontrada em torras escuras de grau comercial.",
        'pl': "Wytrawna, węglowa i mineralna nuta. Wskazuje на ekstremalną ekspozycję на palenie. Spotykana в ciemnych paleniach klasy komercyjnej.",
        'nl': "Droge, koolstofhoudende en mineraalachtige noot. Duidt op extreme blootstelling aan hitte tijdens het branden. Te vinden in commerciële donkere brandingen.",
        'sv': "Torr, kolhaltig och mineralliknande not. Indikerar extrem rostningsexponering. Finns i mörkrostningar av kommersiell kvalitet.",
        'tr': "Kuru, karbonlu ve mineral benzeri nota. Aşırı kavurma maruziyetini gösterir. Ticari sınıf koyu kavurmalarda bulunur.",
        'ja': "ドライで炭素質、鉱物のようなノート。極端な焙煎を示唆する。コマーシャルグレードの深煎りに見られる。",
        'ko': "건조하고 탄소 및 미네랄 같은 노트입니다. 극심한 배전 노출을 나타냅니다. 상업용 등급의 다크 로스팅에서 발견됩니다.",
        'zh': "干燥、含碳且类似矿物味。表示极度的烘焙。出现在商业级的深度烘焙咖啡中。",
        'ar': "نكهة جافة وكربونية وشبيهة بالمعادن. تشير إلى تعرض شديد للتحميص. توجد في التحميص الداكن ذو الدرجة التجارية.",
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

print('Roasted update complete.')
