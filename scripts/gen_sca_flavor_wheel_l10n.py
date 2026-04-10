# -*- coding: utf-8 -*-
"""Generates lib/core/l10n/sca_flavor_wheel_l10n.dart from the table below."""
from __future__ import annotations

import os

LOCALES = ("en", "uk", "de", "es", "fr", "it", "ja", "pl", "pt", "ro", "ru", "tr", "zh")

# key -> (en, uk, de, es, fr, it, ja, pl, pt, ro, ru, tr, zh)
T: dict[str, tuple[str, ...]] = {
    # Categories
    "wheel_cat_fruity": (
        "Fruity", "Фруктові", "Fruchtig", "Frutal", "Fruitée", "Fruttato", "フルーティー",
        "Owocowy", "Frutado", "Fructat", "Фруктовые", "Meyvemsi", "果香",
    ),
    "wheel_cat_floral": (
        "Floral", "Квіткові", "Blumig", "Floral", "Florale", "Floreale", "フローラル",
        "Kwiatowy", "Floral", "Floral", "Цветочные", "Çiçeksi", "花香",
    ),
    "wheel_cat_sweet": (
        "Sweet", "Солодкі", "Süß", "Dulce", "Sucrée", "Dolce", "甘み",
        "Słodki", "Doce", "Dulce", "Сладкие", "Tatlı", "甜感",
    ),
    "wheel_cat_nutty_cocoa": (
        "Nutty / Cocoa", "Горіх / какао", "Nuss / Kakao", "Nuez / Cacao", "Noisette / Cacao",
        "Nocciola / Cacao", "ナッツ / カカオ", "Orzech / Kakao", "Noz / Cacau", "Nuci / Cacao",
        "Орех / какао", "Fındık / Kakao", "坚果 / 可可",
    ),
    "wheel_cat_spices": (
        "Spices", "Спеції", "Gewürze", "Especias", "Épices", "Spezie", "スパイス",
        "Przyprawy", "Especiarias", "Condimente", "Специи", "Baharat", "香料",
    ),
    "wheel_cat_roasted": (
        "Roasted", "Обсмажені", "Geröstet", "Tostado", "Torréfié", "Tostato", "ロースト",
        "Palone", "Torra", "Prajite", "Обжарка", "Kavrulmuş", "烘焙",
    ),
    "wheel_cat_green_veg": (
        "Green / Vegetal", "Зелені / овочеві", "Grün / Vegetal", "Verde / Vegetal",
        "Vert / Végétal", "Verde / Vegetale", "グリーン / ベジタブル", "Zielony / roślinny",
        "Verde / Vegetal", "Verde / Vegetal", "Зелёные / овощные", "Yeşil / bitkisel", "青香 / 植物",
    ),
    "wheel_cat_sour_fermented": (
        "Sour / Fermented", "Кислі / фермент", "Sauer / Fermentiert", "Ácido / Fermentado",
        "Acide / Fermenté", "Acido / Fermentato", "酸味 / 発酵", "Kwaśny / ferment",
        "Ácido / Fermentado", "Acru / Fermentat", "Кислые / фермент", "Ekşi / fermante", "酸质 / 发酵",
    ),
    "wheel_cat_others": (
        "Others", "Інше", "Sonstiges", "Otros", "Autres", "Altri", "その他",
        "Inne", "Outros", "Altele", "Прочее", "Diğer", "其他",
    ),
    # Subcategories
    "wheel_sub_berry": (
        "Berry", "Ягідні", "Beere", "Baya", "Baie", "Frutti di bosco", "ベリー",
        "Jagodowy", "Frutos vermelhos", "Fructe de pădure", "Ягодные", "Dut meyve", "莓果",
    ),
    "wheel_sub_dried_fruit": (
        "Dried Fruit", "Сухофрукти", "Trockenfrucht", "Fruta seca", "Fruit sec", "Frutta secca", "ドライフルーツ",
        "Suszone owoce", "Fruta seca", "Fructe uscate", "Сухофрукты", "Kuru meyve", "干果",
    ),
    "wheel_sub_other_fruit": (
        "Other Fruit", "Інші фрукти", "Andere Früchte", "Otras frutas", "Autres fruits",
        "Altri frutti", "その他の果物", "Inne owoce", "Outras frutas", "Alte fructe",
        "Другие фрукты", "Diğer meyveler", "其他水果",
    ),
    "wheel_sub_citrus": (
        "Citrus", "Цитрусові", "Zitrus", "Cítrico", "Agrume", "Agrumi", "シトラス",
        "Cytrusy", "Cítrico", "Citrice", "Цитрус", "Narenciye", "柑橘",
    ),
    "wheel_sub_tea": (
        "Tea", "Чай", "Tee", "Té", "Thé", "Tè", "茶系",
        "Herbata", "Chá", "Ceai", "Чай", "Çay", "茶感",
    ),
    "wheel_sub_floral": (
        "Floral", "Квіткові", "Blumig", "Floral", "Florale", "Floreale", "フローラル",
        "Kwiatowy", "Floral", "Floral", "Цветочные", "Çiçeksi", "花香调",
    ),
    "wheel_sub_sweet_aromatics": (
        "Sweet Aromatics", "Солодкі аромати", "Süße Aromen", "Aromas dulces", "Arômes sucrés",
        "Aromaticità dolci", "甘い香り", "Słodkie aromaty", "Aromas doces", "Arome dulci",
        "Сладкие ароматы", "Tatlı aromalar", "甜香",
    ),
    "wheel_sub_sugar_brown": (
        "Brown Sugar", "Коричневий цукор", "Rohrzucker", "Azúcar moreno", "Sucre brun",
        "Zucchero di canna", "ブラウンシュガー", "Cukier trzcinowy", "Açúcar mascavo",
        "Zahăr brun", "Тростниковый сахар", "Esmer şeker", "红糖 / 焦糖感",
    ),
    "wheel_sub_nutty": (
        "Nutty", "Горіхові", "Nussig", "Nuez", "Noisette", "Di nocciola", "ナッツ",
        "Orzechowy", "Amendoado", "Nucă", "Ореховые", "Fındıksı", "坚果",
    ),
    "wheel_sub_cocoa": (
        "Cocoa", "Какао", "Kakao", "Cacao", "Cacao", "Cacao", "カカオ",
        "Kakao", "Cacau", "Cacao", "Какао", "Kakao", "可可",
    ),
    "wheel_sub_brown_spice": (
        "Brown Spice", "Темні спеції", "Braune Gewürze", "Especias oscuras", "Épices brunes",
        "Spezie scure", "ブラウンスパイス", "Ciemne przyprawy", "Especiarias escuras",
        "Condimente închise", "Тёмные специи", "Koyu baharat", "温香料",
    ),
    "wheel_sub_cereal": (
        "Cereal", "Зернові", "Getreide", "Cereal", "Céréale", "Cereale", "穀物",
        "Zbożowy", "Cereal", "Cereale", "Злаковые", "Tahıl", "谷物",
    ),
    "wheel_sub_burnt": (
        "Burnt", "Палені", "Verbrannt", "Quemado", "Brûlé", "Bruciato", "焦げ",
        "Spalony", "Queimado", "Ars", "Подгоревшие", "Yanmış", "焦糊",
    ),
    "wheel_sub_green_vegetative": (
        "Green / Vegetative", "Зелень / вегетативні", "Grün / vegetativ", "Verde / vegetal",
        "Vert / végétal", "Verde / vegetale", "青臭 / 植物", "Zielony / wegetatywny",
        "Verde / vegetativo", "Verde / vegetal", "Зелёный / растительный", "Yeşil / bitkisel", "青蔬",
    ),
    "wheel_sub_sour": (
        "Sour", "Кислі", "Sauer", "Ácido", "Acide", "Acido", "酸味",
        "Kwaśny", "Ácido", "Acru", "Кислые", "Ekşi", "酸",
    ),
    "wheel_sub_alcohol_fermented": (
        "Alcohol / Fermented", "Алкоголь / фермент", "Alkohol / fermentiert", "Alcohol / fermentado",
        "Alcool / fermenté", "Alcol / fermentato", "アルコール / 発酵", "Alkohol / ferment",
        "Álcool / fermentado", "Alcool / fermentat", "Алкоголь / фермент", "Alkol / fermante", "酒酵",
    ),
    "wheel_sub_chemical": (
        "Chemical", "Хімічні", "Chemisch", "Químico", "Chimique", "Chimico", "化学的",
        "Chemiczny", "Químico", "Chimic", "Химические", "Kimyasal", "化学味",
    ),
    "wheel_sub_papery": (
        "Papery", "Паперові", "Pappig", "Papel", "Papier", "Di carta", "紙っぽい",
        "Papierowy", "Papelado", "Ca de hârtie", "Бумажные", "Kağıt", "纸味",
    ),
    # Notes — fruity
    "wheel_note_blackberry": ("Blackberry", "Ожина", "Brombeere", "Mora", "Mûre", "More", "ブラックベリー", "Jeżyna", "Amora", "Mure", "Ежевика", "Böğürtlen", "黑莓",),
    "wheel_note_raspberry": ("Raspberry", "Малина", "Himbeere", "Frambuesa", "Framboise", "Lampone", "ラズベリー", "Malina", "Framboesa", "Zmeură", "Малина", "Ahududu", "覆盆子",),
    "wheel_note_blueberry": ("Blueberry", "Лохина", "Heidelbeere", "Arándano", "Myrtille", "Mirtillo", "ブルーベリー", "Borówka", "Mirtilo", "Afine", "Черника", "Yaban mersini", "蓝莓",),
    "wheel_note_strawberry": ("Strawberry", "Полуниця", "Erdbeere", "Fresa", "Fraise", "Fragola", "ストロベリー", "Truskawka", "Morango", "Căpșună", "Клубника", "Çilek", "草莓",),
    "wheel_note_raisin": ("Raisin", "Родзинка", "Rosine", "Uva pasa", "Raisin sec", "Uvetta", "レーズン", "Rodzynka", "Uva-passa", "Stafide", "Изюм", "Kuru üzüm", "葡萄干",),
    "wheel_note_prune": ("Prune", "Чорнослив", "Pflaume", "Ciruela pasa", "Pruneau", "Prugna secca", "プルーン", "Śliwka suszona", "Ameixa seca", "Prune uscată", "Чернослив", "Kuru erik", "西梅干",),
    "wheel_note_coconut": ("Coconut", "Кокос", "Kokosnuss", "Coco", "Noix de coco", "Cocco", "ココナッツ", "Kokos", "Coco", "Nucă de cocos", "Кокос", "Hindistan cevizi", "椰子",),
    "wheel_note_cherry": ("Cherry", "Вишня", "Kirsche", "Cereza", "Cerise", "Ciliegia", "チェリー", "Wiśnia", "Cereja", "Cireș", "Вишня", "Kiraz", "樱桃",),
    "wheel_note_pomegranate": ("Pomegranate", "Гранат", "Granatapfel", "Granada", "Grenade", "Melograno", "ザクロ", "Granat", "Romã", "Rodie", "Гранат", "Nar", "石榴",),
    "wheel_note_pineapple": ("Pineapple", "Ананас", "Ananas", "Piña", "Ananas", "Ananas", "パイナップル", "Ananas", "Abacaxi", "Ananas", "Ананас", "Ananas", "菠萝",),
    "wheel_note_grape": ("Grape", "Виноград", "Traube", "Uva", "Raisin", "Uva", "グレープ", "Winogrono", "Uva", "Strugure", "Виноград", "Üzüm", "葡萄",),
    "wheel_note_apple": ("Apple", "Яблуко", "Apfel", "Manzana", "Pomme", "Mela", "アップル", "Jabłko", "Maçã", "Măr", "Яблоко", "Elma", "苹果",),
    "wheel_note_peach": ("Peach", "Персик", "Pfirsich", "Melocotón", "Pêche", "Pesca", "ピーチ", "Brzoskwinia", "Pêssego", "Piersică", "Персик", "Şeftali", "桃子",),
    "wheel_note_pear": ("Pear", "Груша", "Birne", "Pera", "Poire", "Pera", "ペア", "Gruszka", "Pera", "Pară", "Груша", "Armut", "梨",),
    "wheel_note_grapefruit": ("Grapefruit", "Грейпфрут", "Grapefruit", "Pomelo", "Pamplemousse", "Pompelmo", "グレープフルーツ", "Grejpfrut", "Toranja", "Grapefruit", "Грейпфрут", "Greyfurt", "西柚",),
    "wheel_note_orange": ("Orange", "Апельсин", "Orange", "Naranja", "Orange", "Arancia", "オレンジ", "Pomarańcza", "Laranja", "Portocală", "Апельсин", "Portakal", "橙子",),
    "wheel_note_lemon": ("Lemon", "Лимон", "Zitrone", "Limón", "Citron", "Limone", "レモン", "Cytryna", "Limão", "Lămâie", "Лимон", "Limon", "柠檬",),
    "wheel_note_lime": ("Lime", "Лайм", "Limette", "Lima", "Citron vert", "Lime", "ライム", "Limonka", "Limão‑verde", "Lime", "Лайм", "Misket limonu", "青柠",),
    # Floral / tea
    "wheel_note_black_tea": ("Black Tea", "Чорний чай", "Schwarzer Tee", "Té negro", "Thé noir", "Tè nero", "紅茶", "Czarna herbata", "Chá preto", "Ceai negru", "Чёрный чай", "Siyah çay", "红茶",),
    "wheel_note_green_tea": ("Green Tea", "Зелений чай", "Grüner Tee", "Té verde", "Thé vert", "Tè verde", "緑茶", "Zielona herbata", "Chá verde", "Ceai verde", "Зелёный чай", "Yeşil çay", "绿茶",),
    "wheel_note_chamomile": ("Chamomile", "Ромашка", "Kamille", "Manzanilla", "Camomille", "Camomilla", "カモミール", "Rumianek", "Camomila", "Mușețel", "Ромашка", "Papatya", "洋甘菊",),
    "wheel_note_rose": ("Rose", "Троянда", "Rose", "Rosa", "Rose", "Rosa", "ローズ", "Róża", "Rosa", "Trandafir", "Роза", "Gül", "玫瑰",),
    "wheel_note_jasmine": ("Jasmine", "Жасмин", "Jasmin", "Jazmín", "Jasmin", "Gelsomino", "ジャスミン", "Jaśmin", "Jasmim", "Iasomie", "Жасмин", "Yasemin", "茉莉",),
    # Sweet
    "wheel_note_vanilla": ("Vanilla", "Ваніль", "Vanille", "Vainilla", "Vanille", "Vaniglia", "バニラ", "Wanilia", "Baunilha", "Vanilie", "Ваниль", "Vanilya", "香草",),
    "wheel_note_vanilla_bean": ("Vanilla Bean", "Стручок ванілі", "Vanilleschote", "Vaina de vainilla", "Gousse de vanille", "Baccello di vaniglia", "バニラビーンズ", "Laska wanilii", "Fava de baunilha", "Păstăi de vanilie", "Стручок ванили", "Vanilya çubuğu", "香草荚",),
    "wheel_note_molasses": ("Molasses", "Меляса", "Melasse", "Melaza", "Mélasse", "Melassa", "モラセス", "Melasa", "Melaço", "Melasă", "Меласса", "Pekmez", "糖蜜",),
    "wheel_note_maple_syrup": ("Maple Syrup", "Кленовий сироп", "Ahornsirup", "Jarabe de arce", "Sirop d'érable", "Sciroppo d'acero", "メープルシロップ", "Syrop klonowy", "Xarope de bordo", "Sirop de arțar", "Клёновый сироп", "Akçaağaç şurubu", "枫糖",),
    "wheel_note_caramel": ("Caramel", "Карамель", "Karamell", "Caramelo", "Caramel", "Caramello", "キャラメル", "Karmel", "Caramelo", "Caramel", "Карамель", "Karamel", "焦糖",),
    "wheel_note_honey": ("Honey", "Мед", "Honig", "Miel", "Miel", "Miele", "ハチミツ", "Miód", "Mel", "Miere", "Мёд", "Bal", "蜂蜜",),
    # Nutty / cocoa
    "wheel_note_peanuts": ("Peanuts", "Арахіс", "Erdnuss", "Cacahuete", "Cacahuète", "Arachide", "ピーナッツ", "Orzeszki ziemne", "Amendoim", "Arahide", "Арахис", "Yer fıstığı", "花生",),
    "wheel_note_hazelnut": ("Hazelnut", "Фундук", "Haselnuss", "Avellana", "Noisette", "Nocciola", "ヘーゼルナッツ", "Orzech laskowy", "Avelã", "Alună", "Фундук", "Fındık", "榛子",),
    "wheel_note_almond": ("Almond", "Мигдаль", "Mandel", "Almendra", "Amande", "Mandorla", "アーモンド", "Migdał", "Amêndoa", "Migdală", "Миндаль", "Badem", "杏仁",),
    "wheel_note_chocolate": ("Chocolate", "Шоколад", "Schokolade", "Chocolate", "Chocolat", "Cioccolato", "チョコレート", "Czekolada", "Chocolate", "Ciocolată", "Шоколад", "Çikolata", "巧克力",),
    "wheel_note_dark_chocolate": ("Dark Chocolate", "Темний шоколад", "Zartbitter", "Chocolate negro", "Chocolat noir", "Cioccolato fondente", "ダークチョコレート", "Ciemna czekolada", "Chocolate amargo", "Ciocolată neagră", "Тёмный шоколад", "Bitter çikolata", "黑巧克力",),
    # Spices
    "wheel_note_clove": ("Clove", "Гвоздика", "Nelke", "Clavo", "Clou de girofle", "Chiodo di garofano", "クローブ", "Goździk", "Cravo", "Cuișoare", "Гвоздика", "Karanfil", "丁香",),
    "wheel_note_cinnamon": ("Cinnamon", "Кориця", "Zimt", "Canela", "Cannelle", "Cannella", "シナモン", "Cynamon", "Canela", "Scorțișoară", "Корица", "Tarçın", "肉桂",),
    "wheel_note_nutmeg": ("Nutmeg", "Мускатний горіх", "Muskatnuss", "Nuez moscada", "Noix de muscade", "Noce moscata", "ナツメグ", "Gałka muszkatołowa", "Noz-moscada", "Nucșoară", "Мускатный орех", "Küçük hindistan cevizi", "肉豆蔻",),
    "wheel_note_anise": ("Anise", "Аніс", "Anis", "Anís", "Anis", "Anice", "アニス", "Anyż", "Anis", "Anason", "Анис", "Anason", "茴香",),
    # Roasted
    "wheel_note_malt": ("Malt", "Солод", "Malz", "Malta", "Malt", "Malto", "モルト", "Słód", "Malte", "Malț", "Солод", "Malt", "麦芽",),
    "wheel_note_grain": ("Grain", "Зерно", "Getreide", "Cereal", "Céréale", "Cereale", "グレイン", "Ziarno", "Grão", "Cereale", "Зерно", "Tahıl", "谷物",),
    "wheel_note_smoky": ("Smoky", "Димний", "Rauchig", "Ahumado", "Fumé", "Affumicato", "スモーキー", "Dymny", "Defumado", "Afumat", "Дымный", "Dumanlı", "烟熏",),
    "wheel_note_ashy": ("Ashy", "Попелястий", "Aschig", "Ceniciento", "Cendré", "Ceneroso", "灰っぽい", "Popielaty", "Cinzento", "Cenușiu", "Золистый", "Küllü", "灰烬感",),
    # Green / vegetal
    "wheel_note_olive_oil": ("Olive Oil", "Оливкова олія", "Olivenöl", "Aceite de oliva", "Huile d'olive", "Olio d'oliva", "オリーブオイル", "Oliwa z oliwek", "Azeite de oliva", "Ulei de măsline", "Оливковое масло", "Zeytinyağı", "橄榄油",),
    "wheel_note_raw": ("Raw", "Сирий", "Roh", "Crudo", "Cru", "Crudo", "生臭", "Surowy", "Cru", "Crud", "Сырой", "Ham", "生青",),
    "wheel_note_under_ripe": ("Under-ripe", "Недозрілий", "Unreif", "Inmaduro", "Pas mûr", "Acerbo", "未熟", "Niedojrzały", "Verde", "Necopt", "Недозрелый", "Ham (olgunlaşmamış)", "未熟",),
    "wheel_note_peapod": ("Peapod", "Стручок гороху", "Schote", "Vaina", "Gousse", "Baccello", "エンドウさや", "Strąk grochu", "Vagem", "Păstaie", "Стручок гороха", "Bezelye kabuğu", "豌豆荚",),
    "wheel_note_fresh": ("Fresh", "Свіжий", "Frisch", "Fresco", "Frais", "Fresco", "フレッシュ", "Świeży", "Fresco", "Proaspăt", "Свежий", "Taze", "新鲜",),
    "wheel_note_vegetative": ("Vegetative", "Вегетативний", "Vegetativ", "Vegetal", "Végétal", "Vegetale", "植物性", "Wegetatywny", "Vegetal", "Vegetal", "Растительный", "Bitkisel", "植物味",),
    "wheel_note_hay_like": ("Hay-like", "Як сіно", "Heuartig", "Henoso", "Foin", "Fieno", "干し草", "Sianisty", "Feno", "Fană", "Сенный", "Saman", "干草",),
    "wheel_note_herb_like": ("Herb-like", "Трав'яний", "Kräuterartig", "Herbáceo", "Herbacé", "Erbaceo", "ハーブ", "Ziołowy", "Herbáceo", "Ierburi", "Травяной", "Otsu", "草本",),
    # Sour / fermented
    "wheel_note_sour_aromatics": ("Sour Aromatics", "Кислі аромати", "Säurearomen", "Aromas ácidos", "Arômes acides", "Aromaticità acida", "酸味の香り", "Kwaśne aromaty", "Aromas ácidos", "Arome acide", "Кислые ароматы", "Ekşi aromalar", "酸香",),
    "wheel_note_acetic_acid": ("Acetic Acid", "Оцтова кислота", "Essigsäure", "Ácido acético", "Acide acétique", "Acido acetico", "酢酸", "Kwas octowy", "Ácido acético", "Acid acetic", "Уксусная кислота", "Asetik asit", "乙酸",),
    "wheel_note_butyric_acid": ("Butyric Acid", "Масляна кислота", "Buttersäure", "Ácido butírico", "Acide butyrique", "Acido butirrico", "酪酸", "Kwas masłowy", "Ácido butírico", "Acid butiric", "Масляная кислота", "Bütirik asit", "丁酸",),
    "wheel_note_isovaleric_acid": ("Isovaleric Acid", "Ізовалеріанова кислота", "Isovaleriansäure", "Ácido isovalérico", "Acide isovalérique", "Acido isovalerico", "イソ吉草酸", "Kwas izowalerianowy", "Ácido isovalérico", "Acid izovaleric", "Изовалериановая кислота", "İzovalerik asit", "异戊酸",),
    "wheel_note_citric_acid": ("Citric Acid", "Лимонна кислота", "Zitronensäure", "Ácido cítrico", "Acide citrique", "Acido citrico", "クエン酸", "Kwas cytrynowy", "Ácido cítrico", "Acid citric", "Лимонная кислота", "Sitrik asit", "柠檬酸",),
    "wheel_note_malic_acid": ("Malic Acid", "Яблучна кислота", "Apfelsäure", "Ácido málico", "Acide malique", "Acido malico", "リンゴ酸", "Kwas jabłkowy", "Ácido málico", "Acid malic", "Яблочная кислота", "Malik asit", "苹果酸",),
    "wheel_note_winey": ("Winey", "Винний", "Weinig", "Vinoso", "Vineux", "Vinoso", "ワイニー", "Winny", "Vinhoso", "Vinuriu", "Винный", "Şarapsı", "酒感",),
    "wheel_note_whiskey": ("Whiskey", "Віскі", "Whisky", "Whisky", "Whisky", "Whisky", "ウイスキー", "Whisky", "Uísque", "Whisky", "Виски", "Viski", "威士忌",),
    "wheel_note_over_ripe": ("Over-ripe", "Перезрілий", "Überreif", "Sobremaduro", "Trop mûr", "Stramaturo", "過熟", "Przerośnięty", "Maduro demais", "Prea copt", "Перезрелый", "Fazla olgun", "过熟",),
    # Others
    "wheel_note_rubber": ("Rubber", "Гума", "Gummi", "Caucho", "Caoutchouc", "Gomma", "ゴム", "Guma", "Borracha", "Cauciuc", "Резина", "Kauçuk", "橡胶",),
    "wheel_note_petroleum": ("Petroleum", "Нафта", "Petroleum", "Petróleo", "Pétrole", "Petrolio", "石油系", "Ropa naftowa", "Petróleo", "Petrol", "Нефть", "Petrol", "石油味",),
    "wheel_note_medicinal": ("Medicinal", "Лікарський", "Medizinisch", "Medicinal", "Médicinal", "Medicinale", "薬品臭", "Medyczny", "Medicinal", "Medicinal", "Лекарственный", "İlaç", "药味",),
    "wheel_note_stale": ("Stale", "Несвіжий", "Fade", "Rancio", "Rassis", "Stantio", "ステール", "Nieświeży", "Empoeirado", "Rahit", "Черствый", "Bayat", "陈味",),
    "wheel_note_musty": ("Musty", "Затхлий", "Modrig", "Mohoso", "Moisi", "Muffa", "カビ臭", "Zatęchły", "Fusty", "Mucegăit", "Затхлый", "Küflü", "霉味",),
    "wheel_note_dusty": ("Dusty", "Пиловий", "Staubig", "Polvoriento", "Poussiéreux", "Polveroso", "ホコリ", "Zapylony", "Empoeirado", "Prafoasă", "Пыльный", "Tozlu", "尘土味",),
}


def dart_escape(s: str) -> str:
    return s.replace("\\", r"\\").replace("'", r"\'").replace("$", r"\$")


def main() -> None:
    for k, tup in T.items():
        if len(tup) != len(LOCALES):
            raise SystemExit(f"wrong arity for {k}: {len(tup)}")

    out: list[str] = [
        "// Generated by scripts/gen_sca_flavor_wheel_l10n.py — do not edit by hand.",
        "",
        "/// SCA-style flavor wheel labels for all app locales.",
        "class ScaFlavorWheelL10n {",
        "  ScaFlavorWheelL10n._();",
        "",
        "  static const supportedLocales = <String>[",
    ]
    for loc in LOCALES:
        out.append(f"    '{loc}',")
    out.append("  ];")
    out.append("")
    out.append("  static const Map<String, Map<String, String>> _byLocale = {")
    for li, loc in enumerate(LOCALES):
        out.append(f"    '{loc}': {{")
        for key in T:
            val = dart_escape(T[key][li])
            out.append(f"      '{key}': '{val}',")
        out.append("    },")
    out.append("  };")
    out.append("")
    out.append("  static String translate(String locale, String key) {")
    out.append("    final lang = supportedLocales.contains(locale) ? locale : 'en';")
    out.append("    final map = _byLocale[lang];")
    out.append("    if (map != null) {")
    out.append("      final v = map[key];")
    out.append("      if (v != null) return v;")
    out.append("    }")
    out.append("    final en = _byLocale['en']![key];")
    out.append("    if (en != null) return en;")
    out.append("    return _humanize(key);")
    out.append("  }")
    out.append("")
    out.append("  static String _humanize(String key) {")
    out.append("    var base = key")
    out.append("        .replaceFirst('wheel_note_', '')")
    out.append("        .replaceFirst('wheel_sub_', '')")
    out.append("        .replaceFirst('wheel_cat_', '')")
    out.append("        .replaceAll('_', ' ');")
    out.append("    if (base.isEmpty) return key;")
    out.append("    return base.split(' ').map((s) {")
    out.append("      if (s.isEmpty) return s;")
    out.append("      return s[0].toUpperCase() + s.substring(1);")
    out.append("    }).join(' ');")
    out.append("  }")
    out.append("}")
    out.append("")

    root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    path = os.path.join(root, "lib", "core", "l10n", "sca_flavor_wheel_l10n.dart")
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8") as f:
        f.write("\n".join(out))
    print(f"Wrote {path} ({len(T)} keys x {len(LOCALES)} locales)")


if __name__ == "__main__":
    main()
