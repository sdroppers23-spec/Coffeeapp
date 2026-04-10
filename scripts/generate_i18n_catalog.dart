// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';

void main() {
  // 1. Source Data (46 lots)
  final rawLots = [
    // Filter
    {
      "lot": "49",
      "name": "Колумбія 49 Фільтр",
      "cat": "Filter",
      "proc": "Анаеробна мита",
      "var": "Ява",
      "price": 555,
      "notes": ["Жасмин", "Бузина", "Алича"],
      "sca": "87.5",
      "orig": "Колумбія",
      "reg": "Лас Флорес",
      "emoji": "🇨🇴"
    },
    {
      "lot": "50",
      "name": "Колумбія 50 Фільтр",
      "cat": "Filter",
      "proc": "Натуральна",
      "var": "Вуш Вуш",
      "price": 650,
      "notes": ["Вишня", "Сицилійський апельсин", "Ревінь"],
      "sca": "87.25",
      "orig": "Колумбія",
      "reg": "Монтеверде",
      "emoji": "🇨🇴"
    },
    {
      "lot": "48",
      "name": "Колумбія 48 Фільтр",
      "cat": "Filter",
      "proc": "Натуральна",
      "var": "Рожевий Бурбон",
      "price": 555,
      "notes": ["Шовковиця", "Нектарин", "Фруктовий льодяник"],
      "sca": "87.0",
      "orig": "Колумбія",
      "reg": "Ла Рока",
      "emoji": "🇨🇴"
    },
    {
      "lot": "47",
      "name": "Колумбія 47 Фільтр",
      "cat": "Filter",
      "proc": "Мита",
      "var": "Катурра, Катуаі",
      "price": 390,
      "notes": ["Яблуко", "Ківі", "Какао"],
      "sca": "86.5",
      "orig": "Колумбія",
      "reg": "Комбеіма",
      "emoji": "🇨🇴"
    },
    {
      "lot": "46",
      "name": "Колумбія 46 Фільтр",
      "cat": "Filter",
      "proc": "Натуральна",
      "var": "Катурра, Кастільо",
      "price": 405,
      "notes": ["Груша", "Ківі", "Марципан"],
      "sca": "86.0",
      "orig": "Колумбія",
      "reg": "Лас Флорес",
      "emoji": "🇨🇴"
    },
    {
      "lot": "44",
      "name": "Колумбія 44 Фільтр",
      "cat": "Filter",
      "proc": "Термал Шок",
      "var": "Сідра, SL28",
      "price": 705,
      "notes": ["Персик", "Виноград", "Морозиво"],
      "sca": "88.5",
      "orig": "Колумбія",
      "reg": "Вілтон Бенітез",
      "emoji": "🇨🇴"
    },
    {
      "lot": "45",
      "name": "Колумбія 45 Фільтр",
      "cat": "Filter",
      "proc": "Термал Шок",
      "var": "Геша, Червоний Бурбон",
      "price": 420,
      "notes": ["Троянда", "Грейпфрут", "Бісквіт"],
      "sca": "86.75",
      "orig": "Колумбія",
      "reg": "Гранха Параїсо",
      "emoji": "🇨🇴"
    },
    {
      "lot": "31",
      "name": "Колумбія 31 Фільтр",
      "cat": "Filter",
      "proc": "Термал Шок",
      "var": "Чиросо, Катурра",
      "price": 485,
      "notes": ["Жасмин", "Ківі", "Лохина"],
      "sca": "88.0",
      "orig": "Колумбія",
      "reg": "Гранха Параїсо",
      "emoji": "🇨🇴"
    },
    {
      "lot": "20",
      "name": "Кенія 20 Фільтр",
      "cat": "Filter",
      "proc": "Мита",
      "var": "СЛ 28, СЛ 34",
      "price": 340,
      "notes": ["Червоні ягоди", "Мед", "Апельсин"],
      "sca": "85.5",
      "orig": "Кенія",
      "reg": "Кірініяга",
      "emoji": "🇰🇪"
    },
    {
      "lot": "14",
      "name": "Руанда 14 Фільтр",
      "cat": "Filter",
      "proc": "Натуральна",
      "var": "Рожевий Бурбон",
      "price": 370,
      "notes": ["Апельсин", "Бісквіт", "Кісточкові фрукти"],
      "sca": "84.75",
      "orig": "Руанда",
      "reg": "Коакамбу",
      "emoji": "🇷🇼"
    },
    {
      "lot": "4",
      "name": "Індонезія 4 Фільтр",
      "cat": "Filter",
      "proc": "Анаеробна натуральна",
      "var": "С-ліні, Бурбон",
      "price": 465,
      "notes": ["Апельсин", "Лохина", "Ревінь"],
      "sca": "86.0",
      "orig": "Індонезія",
      "reg": "Фрінза",
      "emoji": "🇮🇩"
    },
    {
      "lot": "9",
      "name": "Колумбія 9 Фільтр",
      "cat": "Filter",
      "proc": "Натуральна",
      "var": "Гейша",
      "price": 530,
      "notes": ["Тропіки", "Ожина", "Алкоголь"],
      "sca": "87.5",
      "orig": "Колумбія",
      "reg": "Ель Дівізо",
      "emoji": "🇨🇴"
    },
    {
      "lot": "12",
      "name": "Коста-Ріка 12 Фільтр",
      "cat": "Filter",
      "proc": "Натуральна",
      "var": "Катурра",
      "price": 570,
      "notes": ["Кориця", "Яблуко", "Виноград"],
      "sca": "86.5",
      "orig": "Коста-Ріка",
      "reg": "Лас Лахас",
      "emoji": "🇨🇷"
    },
    {
      "lot": "5",
      "name": "Індонезія 5 Фільтр",
      "cat": "Filter",
      "proc": "Анаеробна натуральна",
      "var": "Ateng",
      "price": 435,
      "notes": ["Червоне вино", "Тропіки"],
      "sca": "85.75",
      "orig": "Індонезія",
      "reg": "Фрінза",
      "emoji": "🇮🇩"
    },
    {
      "lot": "8",
      "name": "Ефіопія 8 Фільтр",
      "cat": "Filter",
      "proc": "Мита",
      "var": "Heirloom",
      "price": 380,
      "notes": ["Жасмин", "Абрикос"],
      "sca": "85.0",
      "orig": "Ефіопія",
      "reg": "Сідамо",
      "emoji": "🇪🇹"
    },
    {
      "lot": "2-D",
      "name": "Колумбія Без Кофеїну 2 Фільтр",
      "cat": "Filter",
      "proc": "Термал Шок",
      "var": "Кастільо",
      "price": 365,
      "notes": ["Мандарин", "Яблуко"],
      "sca": "86.5",
      "orig": "Колумбія",
      "reg": "Без кофеїну",
      "emoji": "🇨🇴"
    },
    {
      "lot": "37",
      "name": "Ефіопія 37 Фільтр",
      "cat": "Filter",
      "proc": "Анаеробна натуральна",
      "var": "Heirloom",
      "price": 420,
      "notes": ["Персик", "Яблучна кислинка"],
      "sca": "86.5",
      "orig": "Ефіопія",
      "reg": "Гуджі",
      "emoji": "🇪🇹"
    },
    {
      "lot": "10",
      "name": "Кенія 10 Фільтр",
      "cat": "Filter",
      "proc": "Мита",
      "var": "SL28, SL34",
      "price": 385,
      "notes": ["Кизил", "Зелене яблуко"],
      "sca": "85.25",
      "orig": "Кенія",
      "reg": "Ньєрі",
      "emoji": "🇰🇪"
    },
    {
      "lot": "BB2",
      "name": "BB2 Brew Blend 2 Фільтр",
      "cat": "Filter",
      "proc": "Анаеробна Х Мита",
      "var": "Mixed",
      "price": 345,
      "notes": ["Смородина", "Тропіки"],
      "sca": "85.0",
      "orig": "Blend",
      "reg": "House",
      "emoji": "🌍"
    },
    {
      "lot": "28",
      "name": "Ефіопія 28 Фільтр",
      "cat": "Filter",
      "proc": "Мита",
      "var": "Heirloom",
      "price": 328,
      "notes": ["Жасмин", "Чорний чай"],
      "sca": "84.0",
      "orig": "Ефіопія",
      "reg": "Іргачеффе",
      "emoji": "🇪🇹"
    },
    {
      "lot": "4-R",
      "name": "Руанда 4 Фільтр",
      "cat": "Filter",
      "proc": "Анаеробна натуральна",
      "var": "Бурбон",
      "price": 390,
      "notes": ["Тропіки", "Полуниця"],
      "sca": "86.0",
      "orig": "Руанда",
      "reg": "Коакамбу",
      "emoji": "🇷🇼"
    },
    {
      "lot": "13",
      "name": "Руанда 13 Фільтр",
      "cat": "Filter",
      "proc": "Мита",
      "var": "Бурбон",
      "price": 340,
      "notes": ["Червоні ягоди", "Мед"],
      "sca": "84.5",
      "orig": "Руанда",
      "reg": "Кібує",
      "emoji": "🇷🇼"
    },
    {
      "lot": "4-C",
      "name": "Колумбія 4 Фільтр",
      "cat": "Filter",
      "proc": "Мита",
      "var": "Катурра",
      "price": 340,
      "notes": ["Яблуко", "Карамель"],
      "sca": "83.0",
      "orig": "Колумбія",
      "reg": "Уїла",
      "emoji": "🇨🇴"
    },
    {
      "lot": "37-C",
      "name": "Колумбія 37 Фільтр",
      "cat": "Filter",
      "proc": "Натуральна",
      "var": "Кастільо",
      "price": 370,
      "notes": ["Червоне яблуко", "Ром"],
      "sca": "85.75",
      "orig": "Колумбія",
      "reg": "Толіма",
      "emoji": "🇨🇴"
    },
    {
      "lot": "1-D",
      "name": "Колумбія Без Кофеїну 1 Фільтр",
      "cat": "Filter",
      "proc": "Мита Шугакейн",
      "var": "Катурра",
      "price": 335,
      "notes": ["Карамель", "Какао"],
      "sca": "82.0",
      "orig": "Колумбія",
      "reg": "Decaf",
      "emoji": "🇨🇴"
    },
    {
      "lot": "UT",
      "name": "Танзанія Утенгуле Фільтр",
      "cat": "Filter",
      "proc": "Хані",
      "var": "Бурбон",
      "price": 450,
      "notes": ["Персик", "Яблуко", "Чай"],
      "sca": "85.5",
      "orig": "Танзанія",
      "reg": "Мбея",
      "emoji": "🇹🇿"
    },
    // Espresso
    {
      "lot": "37-E",
      "name": "Ефіопія 37 Еспресо",
      "cat": "Espresso",
      "proc": "Анаеробна натуральна",
      "var": "Хеірлум",
      "price": 420,
      "notes": ["Персик", "Жасмин", "Яблуко"],
      "sca": "87.0",
      "orig": "Ефіопія",
      "reg": "Гуджі",
      "emoji": "🇪🇹"
    },
    {
      "lot": "46-E",
      "name": "Колумбія 46 Еспресо",
      "cat": "Espresso",
      "proc": "Натуральна",
      "var": "Катурра, Кастільо",
      "price": 405,
      "notes": ["Груша", "Ківі", "Марципан"],
      "sca": "86.0",
      "orig": "Колумбія",
      "reg": "Лас Флорес",
      "emoji": "🇨🇴"
    },
    {
      "lot": "31-E",
      "name": "Колумбія 31 Еспресо",
      "cat": "Espresso",
      "proc": "Термал Шок",
      "var": "Чиросо",
      "price": 485,
      "notes": ["Жасмин", "Ківі", "Лохина"],
      "sca": "88.0",
      "orig": "Колумбія",
      "reg": "Гранха Параїсо",
      "emoji": "🇨🇴"
    },
    {
      "lot": "4-E",
      "name": "Індонезія 4 Еспресо",
      "cat": "Espresso",
      "proc": "Анаеробна натуральна",
      "var": "С-ліні",
      "price": 465,
      "notes": ["Шоколад", "Фрукти", "Вино"],
      "sca": "86.0",
      "orig": "Індонезія",
      "reg": "Фрінза",
      "emoji": "🇮🇩"
    },
    {
      "lot": "12-E",
      "name": "Коста-Ріка 12 Еспресо",
      "cat": "Espresso",
      "proc": "Натуральна",
      "var": "Катурра",
      "price": 570,
      "notes": ["Шоколад", "Карамель", "Яблуко"],
      "sca": "86.5",
      "orig": "Коста-Ріка",
      "reg": "Лас Лахас",
      "emoji": "🇨🇷"
    },
    {
      "lot": "8-E",
      "name": "Ефіопія 8 Еспресо",
      "cat": "Espresso",
      "proc": "Мита",
      "var": "Heirloom",
      "price": 380,
      "notes": ["Жасмин", "Абрикос"],
      "sca": "85.0",
      "orig": "Ефіопія",
      "reg": "Сідамо",
      "emoji": "🇪🇹"
    },
    {
      "lot": "20-E",
      "name": "Кенія 20 Еспресо",
      "cat": "Espresso",
      "proc": "Мита",
      "var": "SL28, SL34",
      "price": 340,
      "notes": ["Ягоди", "Мед", "Апельсин"],
      "sca": "85.5",
      "orig": "Кенія",
      "reg": "Кірініяга",
      "emoji": "🇰🇪"
    },
    {
      "lot": "14-E",
      "name": "Руанда 14 Еспресо",
      "cat": "Espresso",
      "proc": "Натуральна",
      "var": "Бурбон",
      "price": 370,
      "notes": ["Фрукти", "Апельсин"],
      "sca": "84.75",
      "orig": "Руанда",
      "reg": "Коакамбу",
      "emoji": "🇷🇼"
    },
    {
      "lot": "10-E",
      "name": "Кенія 10 Еспресо",
      "cat": "Espresso",
      "proc": "Мита",
      "var": "SL28",
      "price": 385,
      "notes": ["Яблуко", "Ягоди"],
      "sca": "85.25",
      "orig": "Кенія",
      "reg": "Ньєрі",
      "emoji": "🇰🇪"
    },
    {
      "lot": "4-RE",
      "name": "Руанда 4 Еспресо",
      "cat": "Espresso",
      "proc": "Анаеробна натуральна",
      "var": "Бурбон",
      "price": 390,
      "notes": ["Тропіки", "Полуниця"],
      "sca": "86.0",
      "orig": "Руанда",
      "reg": "Коакамбу",
      "emoji": "🇷🇼"
    },
    {
      "lot": "13-E",
      "name": "Руанда 13 Еспресо",
      "cat": "Espresso",
      "proc": "Мита",
      "var": "Бурбон",
      "price": 340,
      "notes": ["Ягоди", "Мед"],
      "sca": "84.5",
      "orig": "Руанда",
      "reg": "Кібує",
      "emoji": "🇷🇼"
    },
    {
      "lot": "47-E",
      "name": "Колумбія 47 Еспресо",
      "cat": "Espresso",
      "proc": "Мита",
      "var": "Caturra",
      "price": 390,
      "notes": ["Яблуко", "Карамель"],
      "sca": "86.5",
      "orig": "Колумбія",
      "reg": "Комбеіма",
      "emoji": "🇨🇴"
    },
    {
      "lot": "28-E",
      "name": "Ефіопія 28 Еспресо",
      "cat": "Espresso",
      "proc": "Мита",
      "var": "Heirloom",
      "price": 328,
      "notes": ["Квіти", "Чай"],
      "sca": "84.0",
      "orig": "Ефіопія",
      "reg": "Іргачеффе",
      "emoji": "🇪🇹"
    },
    {
      "lot": "9-E",
      "name": "Колумбія 9 Еспресо",
      "cat": "Espresso",
      "proc": "Натуральна",
      "var": "Geisha",
      "price": 530,
      "notes": ["Тропіки", "Алкоголь"],
      "sca": "87.5",
      "orig": "Колумбія",
      "reg": "Ель Дівізо",
      "emoji": "🇨🇴"
    },
    {
      "lot": "5-E",
      "name": "Індонезія 5 Еспресо",
      "cat": "Espresso",
      "proc": "Анаеробна натуральна",
      "var": "Ateng",
      "price": 435,
      "notes": ["Вино", "Фрукти"],
      "sca": "85.75",
      "orig": "Індонезія",
      "reg": "Фрінза",
      "emoji": "🇮🇩"
    },
    {
      "lot": "2-DE",
      "name": "Колумбія Без Кофеїну 2 Еспресо",
      "cat": "Espresso",
      "proc": "Термал Шок",
      "var": "Castillo",
      "price": 365,
      "notes": ["Цитрус", "Яблуко"],
      "sca": "86.5",
      "orig": "Колумбія",
      "reg": "Decaf",
      "emoji": "🇨🇴"
    },
    {
      "lot": "100-E",
      "name": "Blend 100 Espresso",
      "cat": "Espresso",
      "proc": "Mixed",
      "var": "Mixed",
      "price": 300,
      "notes": ["Шоколад", "Горіхи"],
      "sca": "83.0",
      "orig": "Blend",
      "reg": "House",
      "emoji": "🌍"
    },
    {
      "lot": "50-E",
      "name": "Blend 50 Espresso",
      "cat": "Espresso",
      "proc": "Mixed",
      "var": "Mixed",
      "price": 280,
      "notes": ["Карамель", "Шоколад"],
      "sca": "82.0",
      "orig": "Blend",
      "reg": "Bistro",
      "emoji": "🌍"
    },
    {
      "lot": "CL-E",
      "name": "Classic Espresso",
      "cat": "Espresso",
      "proc": "Washed",
      "var": "Mixed",
      "price": 250,
      "notes": ["Шоколад", "Прянощі"],
      "sca": "80.0",
      "orig": "Blend",
      "reg": "Classic",
      "emoji": "🌍"
    },
    {
      "lot": "HB-E",
      "name": "House Blend Espresso",
      "cat": "Espresso",
      "proc": "Natural",
      "var": "Mixed",
      "price": 260,
      "notes": ["Горіхи", "Темний цукор"],
      "sca": "81.0",
      "orig": "Blend",
      "reg": "Morning",
      "emoji": "🌍"
    }
  ];

  // 2. Translation Maps (Simplified for hand-crafting descriptions later)
  final origins = {
    'Колумбія': {
      'en': 'Colombia',
      'uk': 'Колумбія',
      'de': 'Kolumbien',
      'es': 'Colombia',
      'fr': 'Colombie',
      'it': 'Colombia',
      'ja': 'コロンビア',
      'pl': 'Kolumbia',
      'pt': 'Colômbia',
      'ro': 'Columbia',
      'ru': 'Колумбия',
      'tr': 'Kolombiya',
      'zh': '哥伦比亚'
    },
    'Ефіопія': {
      'en': 'Ethiopia',
      'uk': 'Ефіопія',
      'de': 'Äthiopien',
      'es': 'Etiopía',
      'fr': 'Éthiopie',
      'it': 'Etiopia',
      'ja': 'エチオピア',
      'pl': 'Etiopia',
      'pt': 'Etiópia',
      'ro': 'Etiopia',
      'ru': 'Эфиопия',
      'tr': 'Etiyopya',
      'zh': '埃塞俄比亚'
    },
    'Кенія': {
      'en': 'Kenya',
      'uk': 'Кенія',
      'de': 'Kenia',
      'es': 'Kenia',
      'fr': 'Kenya',
      'it': 'Kenya',
      'ja': 'ケニア',
      'pl': 'Kenia',
      'pt': 'Quénia',
      'ro': 'Kenya',
      'ru': 'Кения',
      'tr': 'Kenya',
      'zh': '肯尼亚'
    },
    'Руанда': {
      'en': 'Rwanda',
      'uk': 'Руанда',
      'de': 'Ruanda',
      'es': 'Ruanda',
      'fr': 'Rwanda',
      'it': 'Ruanda',
      'ja': 'ルワンダ',
      'pl': 'Rwanda',
      'pt': 'Ruanda',
      'ro': 'Rwanda',
      'ru': 'Руанда',
      'tr': 'Ruanda',
      'zh': '卢旺达'
    },
    'Індонезія': {
      'en': 'Indonesia',
      'uk': 'Індонезія',
      'de': 'Indonesien',
      'es': 'Indonesia',
      'fr': 'Indonésie',
      'it': 'Indonesia',
      'ja': 'インドネシア',
      'pl': 'Indonezja',
      'pt': 'Indonésia',
      'ro': 'Indonezia',
      'ru': 'Индонезия',
      'tr': 'Endonezya',
      'zh': '印度尼西亚'
    },
    'Коста-Ріка': {
      'en': 'Costa Rica',
      'uk': 'Коста-Ріка',
      'de': 'Costa Rica',
      'es': 'Costa Rica',
      'fr': 'Costa Rica',
      'it': 'Costa Rica',
      'ja': 'コスタリカ',
      'pl': 'Kostaryka',
      'pt': 'Costa Rica',
      'ro': 'Costa Rica',
      'ru': 'Коста-Рика',
      'tr': 'Kosta Rika',
      'zh': '哥斯达黎加'
    },
    'Танзанія': {
      'en': 'Tanzania',
      'uk': 'Танзанія',
      'de': 'Tansania',
      'es': 'Tanzania',
      'fr': 'Tanzanie',
      'it': 'Tanzania',
      'ja': 'タンザニア',
      'pl': 'Tanzania',
      'pt': 'Tanzânia',
      'ro': 'Tanzania',
      'ru': 'Танзания',
      'tr': 'Tanzanya',
      'zh': '坦桑尼亚'
    },
    'Blend': {
      'en': 'Blend',
      'uk': 'Бленд',
      'de': 'Mischung',
      'es': 'Mezcla',
      'fr': 'Mélange',
      'it': 'Miscela',
      'ja': 'ブレンド',
      'pl': 'Mieszanka',
      'pt': 'Mistura',
      'ro': 'Amestec',
      'ru': 'Бленд',
      'tr': 'Harman',
      'zh': '混合'
    }
  };

  final processes = {
    'Анаеробна мита': {'en': 'Anaerobic Washed', 'uk': 'Анаеробна мита'},
    'Натуральна': {'en': 'Natural', 'uk': 'Натуральна'},
    'Мита': {'en': 'Washed', 'uk': 'Мита'},
    'Термал Шок': {'en': 'Thermal Shock', 'uk': 'Термал Шок'},
    'Анаеробна натуральна': {
      'en': 'Anaerobic Natural',
      'uk': 'Анаеробна натуральна'
    },
    'Анаеробна Х Мита': {'en': 'Anaerobic x Washed', 'uk': 'Анаеробна х мита'},
    'Мита Шугакейн': {'en': 'Washed Sugarcane', 'uk': 'Мита Шугакейн'},
    'Хані': {'en': 'Honey', 'uk': 'Хані'},
    'Mixed': {'en': 'Mixed', 'uk': 'Змішана'},
    'Washed': {'en': 'Washed', 'uk': 'Мита'}
  };

  List result = [];
  int id = 1;

  for (var r in rawLots) {
    Map bean = {
      "id": id++,
      "brand_id": 1,
      "emoji": r["emoji"],
      "alt_min": 1500,
      "alt_max": 2000,
      "lot": r["lot"],
      "sca": r["sca"],
      "is_premium": 1,
      "prices": {
        "r250": r["price"],
        "w250": (r["price"] as int) * 0.8,
        "r1k": (r["price"] as int) * 4,
        "w1k": (r["price"] as int) * 4 * 0.8
      },
      "sensory": {
        "aroma": (r["notes"] as List)[0],
        "body": "Medium",
        "acidity":
            (r["notes"] as List).length > 1 ? (r["notes"] as List)[1] : "",
        "aftertaste":
            (r["notes"] as List).length > 2 ? (r["notes"] as List)[2] : "",
        "dots": {"acidity": 4, "sweetness": 4, "bitterness": 1, "intensity": 3}
      },
      "translations": {}
    };

    for (var lang in [
      'en',
      'uk',
      'de',
      'es',
      'fr',
      'it',
      'ja',
      'pl',
      'pt',
      'ro',
      'ru',
      'tr',
      'zh'
    ]) {
      final originMap = origins[r['orig']];
      String country = originMap?[lang] ?? r['orig'].toString();

      final processMap = processes[r['proc']];
      String proc = processMap?['en'] ?? r['proc'].toString();
      if (lang == 'uk') proc = processMap?['uk'] ?? r['proc'].toString();

      String roast = r['cat'] == 'Espresso'
          ? (lang == 'uk' ? 'Середня' : 'Medium')
          : (lang == 'uk' ? 'Світла' : 'Light');

      bean["translations"][lang] = {
        "country": country,
        "region": r['reg'],
        "varieties": r['var'],
        "notes": r['notes'],
        "proc": proc,
        "desc": "${r['name']} - Premium coffee from 3 Champs Roastery.",
        "roast": roast
      };
    }
    result.add(bean);
  }

  File('scripts/coffee_full_catalog.json')
      .writeAsStringSync(jsonEncode(result));
  print('Generated ${result.length} lots.');
}
