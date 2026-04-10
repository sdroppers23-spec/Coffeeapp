import json
import os

langs = ['en', 'uk', 'de', 'es', 'fr', 'it', 'ja', 'pl', 'pt', 'ro', 'ru', 'tr', 'zh']

translations = {
    "wheel_category_desc": {
        "en": "General flavor category for exploration.",
        "uk": "Загальна категорія смаку для дослідження.",
        "ru": "Общая категория вкуса для исследования."
    },
    # Categories
    "wheel_cat_fruity": {"en": "Fruity", "uk": "Фруктовий", "de": "Fruchtig", "es": "Frutal", "fr": "Fruité", "it": "Fruttato", "ja": "フルーティー", "pl": "Owocowy", "pt": "Frutado", "ro": "Fructat", "ru": "Фруктовый", "tr": "Meyvemsi", "zh": "果味"},
    "wheel_cat_floral": {"en": "Floral", "uk": "Квітковий", "ru": "Цветочный"},
    "wheel_cat_sweet": {"en": "Sweet", "uk": "Солодкий", "ru": "Сладкий"},
    "wheel_cat_nutty_cocoa": {"en": "Nutty/Cocoa", "uk": "Горіх/Какао", "ru": "Орех/Какао"},
    "wheel_cat_spices": {"en": "Spices", "uk": "Спеції", "ru": "Специи"},
    "wheel_cat_roasted": {"en": "Roasted", "uk": "Обсмажений", "ru": "Обжаренный"},
    "wheel_cat_green_veg": {"en": "Green/Veg", "uk": "Зелений/Трав'яний", "ru": "Зеленый/Травяной"},
    "wheel_cat_sour_fermented": {"en": "Sour/Fermented", "uk": "Кислий/Ферментований", "ru": "Кислый/Ферментированный"},
    "wheel_cat_others": {"en": "Others", "uk": "Інше", "ru": "Другое"},

    # Subcategories
    "wheel_sub_berry": {"en": "Berry", "uk": "Ягідний", "ru": "Ягодный"},
    "wheel_sub_dried_fruit": {"en": "Dried Fruit", "uk": "Сухофрукти", "ru": "Сухофрукты"},
    "wheel_sub_other_fruit": {"en": "Other Fruit", "uk": "Інші фрукти", "ru": "Другие фрукты"},
    "wheel_sub_citrus": {"en": "Citrus", "uk": "Цитрусовий", "ru": "Цитрусовый"},
    "wheel_sub_tea": {"en": "Tea", "uk": "Чайний", "ru": "Чайный"},
    "wheel_sub_floral": {"en": "Floral", "uk": "Квітковий", "ru": "Цветочный"},
    "wheel_sub_sweet_aromatics": {"en": "Sweet Aromatics", "uk": "Солодкі аромати", "ru": "Сладкие ароматы"},
    "wheel_sub_sugar_brown": {"en": "Sugar Brown", "uk": "Коричневий цукор", "ru": "Коричневый сахар"},
    "wheel_sub_nutty": {"en": "Nutty", "uk": "Горіховий", "ru": "Ореховый"},
    "wheel_sub_cocoa": {"en": "Cocoa", "uk": "Какао", "ru": "Какао"},
    "wheel_sub_brown_spice": {"en": "Brown Spice", "uk": "Темні спеції", "ru": "Темные специи"},
    "wheel_sub_cereal": {"en": "Cereal", "uk": "Зерновий", "ru": "Зерновой"},
    "wheel_sub_burnt": {"en": "Burnt", "uk": "Горілий", "ru": "Горелый"},
    "wheel_sub_green_vegetative": {"en": "Green/Vegetative", "uk": "Зелений/Трав'яний", "ru": "Зеленый/Травяной"},
    "wheel_sub_sour": {"en": "Sour", "uk": "Кислий", "ru": "Кислый"},
    "wheel_sub_alcohol_fermented": {"en": "Alcohol/Fermented", "uk": "Алкоголь/Ферменти", "ru": "Алкоголь/Ферменты"},
    "wheel_sub_chemical": {"en": "Chemical", "uk": "Хімічний", "ru": "Химический"},
    "wheel_sub_papery": {"en": "Papery", "uk": "Паперовий", "ru": "Бумажный"},

    # Notes (Selected Subset)
    "wheel_note_blackberry": {"en": "Blackberry", "uk": "Ожина", "ru": "Ежевика"},
    "wheel_note_raspberry": {"en": "Raspberry", "uk": "Малина", "ru": "Малина"},
    "wheel_note_blueberry": {"en": "Blueberry", "uk": "Лохина", "ru": "Голубика"},
    "wheel_note_strawberry": {"en": "Strawberry", "uk": "Полуниця", "ru": "Клубника"},
    "wheel_note_raisin": {"en": "Raisin", "uk": "Родзинки", "ru": "Изюм"},
    "wheel_note_prune": {"en": "Prune", "uk": "Чорнослив", "ru": "Чернослив"},
    "wheel_note_coconut": {"en": "Coconut", "uk": "Кокос", "ru": "Кокос"},
    "wheel_note_cherry": {"en": "Cherry", "uk": "Вишня", "ru": "Вишня"},
    "wheel_note_pomegranate": {"en": "Pomegranate", "uk": "Гранат", "ru": "Гранат"},
    "wheel_note_pineapple": {"en": "Pineapple", "uk": "Ананас", "ru": "Ананас"},
    "wheel_note_grape": {"en": "Grape", "uk": "Виноград", "ru": "Виноград"},
    "wheel_note_apple": {"en": "Apple", "uk": "Яблуко", "ru": "Яблоко"},
    "wheel_note_peach": {"en": "Peach", "uk": "Персик", "ru": "Персик"},
    "wheel_note_pear": {"en": "Pear", "uk": "Груша", "ru": "Груша"},
    "wheel_note_grapefruit": {"en": "Grapefruit", "uk": "Грейпфрут", "ru": "Грейпфрут"},
    "wheel_note_orange": {"en": "Orange", "uk": "Апельсин", "ru": "Апельсин"},
    "wheel_note_lemon": {"en": "Lemon", "uk": "Лимон", "ru": "Лимон"},
    "wheel_note_lime": {"en": "Lime", "uk": "Лайм", "ru": "Лайм"},
    "wheel_note_black_tea": {"en": "Black Tea", "uk": "Чорний чай", "ru": "Черный чай"},
    "wheel_note_green_tea": {"en": "Green Tea", "uk": "Зелений чай", "ru": "Зеленый чай"},
    "wheel_note_chamomile": {"en": "Chamomile", "uk": "Ромашка", "ru": "Ромашка"},
    "wheel_note_rose": {"en": "Rose", "uk": "Троянда", "ru": "Роза"},
    "wheel_note_jasmine": {"en": "Jasmine", "uk": "Жасмин", "ru": "Жасмин"},
    "wheel_note_vanilla": {"en": "Vanilla", "uk": "Ваніль", "ru": "Ваниль"},
    "wheel_note_molasses": {"en": "Molasses", "uk": "Меляса", "ru": "Меласса"},
    "wheel_note_caramel": {"en": "Caramel", "uk": "Карамель", "ru": "Карамель"},
    "wheel_note_honey": {"en": "Honey", "uk": "Мед", "ru": "Мед"},
    "wheel_note_hazelnut": {"en": "Hazelnut", "uk": "Фундук", "ru": "Фундук"},
    "wheel_note_almond": {"en": "Almond", "uk": "Мигдаль", "ru": "Миндаль"},
    "wheel_note_chocolate": {"en": "Chocolate", "uk": "Шоколад", "ru": "Шоколад"},
    "wheel_note_dark_chocolate": {"en": "Dark Chocolate", "uk": "Темний шоколад", "ru": "Темный шоколад"},
}

for lang in langs:
    path = f'lib/l10n/app_{lang}.arb'
    if not os.path.exists(path):
        with open(path, 'w', encoding='utf-8') as f:
            json.dump({"@@locale": lang}, f, ensure_ascii=False, indent=2)
    
    with open(path, 'r', encoding='utf-8') as f:
        try:
            data = json.load(f)
        except:
            data = {"@@locale": lang}
    
    for key in translations:
        # Use English for all other languages initially to fill the gaps
        val = translations[key].get(lang, translations[key].get('en', key))
        data[key] = val
    
    with open(path, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)

print("Updated 13 ARB files with expanded SCA keys.")
