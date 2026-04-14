import 'package:flutter/material.dart';

class WheelCategory {
  final String key;
  final String name; 
  final Color color;
  final List<WheelSub> sub;
  WheelCategory({
    required this.key,
    required this.name,
    required this.color,
    required this.sub,
  });
}

class WheelSub {
  final String key;
  final String name; 
  final Color color;
  final List<String> noteKeys;
  WheelSub({
    required this.key,
    required this.name,
    required this.color,
    required this.noteKeys,
  });
}

class ScaFlavorData {
  static List<WheelCategory> get localizedData => [
    WheelCategory(
      key: "Фруктовий",
      name: "Фруктовий",
      color: const Color(0xFFE31B23),
      sub: [
        WheelSub(
          key: "Ягідний",
          name: "Ягідний",
          color: const Color(0xFFA6192E),
          noteKeys: [
            "Ожина",
            "Малина",
            "Чорниця",
            "Полуниця",
          ],
        ),
        WheelSub(
          key: "Сухофрукти",
          name: "Сухофрукти",
          color: const Color(0xFFC76F16),
          noteKeys: ["Родзинки", "Чорносив"],
        ),
        WheelSub(
          key: "Інші фрукти",
          name: "Інші фрукти",
          color: const Color(0xFFDA291C),
          noteKeys: [
            "Кокос",
            "Вишня",
            "Гранат",
            "Ананас",
            "Виноград",
            "Яблуко",
            "Персик",
            "Груша",
          ],
        ),
        WheelSub(
          key: "Цитрусові",
          name: "Цитрусові",
          color: const Color(0xFFFDB913),
          noteKeys: [
            "Грейпфрут",
            "Апельсин",
            "Лимон",
            "Лайм",
          ],
        ),
      ],
    ),
    WheelCategory(
      key: "Квітковий",
      name: "Квітковий",
      color: const Color(0xFFE5007D),
      sub: [
        WheelSub(
          key: "Чай",
          name: "Чай",
          color: const Color(0xFF634D2E),
          noteKeys: ["Чорний чай", "Зелений чай"],
        ),
        WheelSub(
          key: "Квітковий",
          name: "Квітковий",
          color: const Color(0xFFE5007D),
          noteKeys: [
            "Ромашка",
            "Троянда",
            "Жасмин",
          ],
        ),
      ],
    ),
    WheelCategory(
      key: "Солодкий",
      name: "Солодкий",
      color: const Color(0xFFD3A13B),
      sub: [
        WheelSub(
          key: "Солодка ароматика",
          name: "Солодка ароматика",
          color: const Color(0xFFEBD89D),
          noteKeys: ["Ваніль", "Ванілін"],
        ),
        WheelSub(
          key: "Коричневий цукор",
          name: "Коричневий цукор",
          color: const Color(0xFF9E6532),
          noteKeys: [
            "Меляса",
            "Кленовий сироп",
            "Карамель",
            "Мед",
          ],
        ),
      ],
    ),
    WheelCategory(
      key: "Горіх / Какао",
      name: "Горіх / Какао",
      color: const Color(0xFF6B4226),
      sub: [
        WheelSub(
          key: "Горіховий",
          name: "Горіховий",
          color: const Color(0xFF9E6532),
          noteKeys: [
            "Арахіс",
            "Фундук",
            "Мигдаль",
          ],
        ),
        WheelSub(
          key: "Какао",
          name: "Какао",
          color: const Color(0xFF332014),
          noteKeys: ["Шоколад", "Темний шоколад"],
        ),
      ],
    ),
    WheelCategory(
      key: "Спеції",
      name: "Спеції",
      color: const Color(0xFFC44031),
      sub: [
        WheelSub(
          key: "Теплі спеції",
          name: "Теплі спеції",
          color: const Color(0xFF7B3026),
          noteKeys: [
            "Гвоздика",
            "Кориця",
            "Мускатний горіх",
            "Аніс",
          ],
        ),
      ],
    ),
    WheelCategory(
      key: "Смажений",
      name: "Смажений",
      color: const Color(0xFF967D65),
      sub: [
        WheelSub(
          key: "Злаковий",
          name: "Злаковий",
          color: const Color(0xFFD4B08C),
          noteKeys: ["Солод", "Зерно"],
        ),
        WheelSub(
          key: "Горілий",
          name: "Горілий",
          color: const Color(0xFF423C35),
          noteKeys: ["Димний", "Попелястий"],
        ),
      ],
    ),
    WheelCategory(
      key: "Трав'яний",
      name: "Трав'яний",
      color: const Color(0xFF008D4C),
      sub: [
        WheelSub(
          key: "Трав'яний / Овочевий",
          name: "Трав'яний / Овочевий",
          color: const Color(0xFF00563B),
          noteKeys: [
            "Оливкова олія",
            "Сирий",
            "Недозрілий",
            "Стручок гороху",
            "Свіжий",
            "Рослинний",
            "Сіно",
            "Трави",
          ],
        ),
      ],
    ),
    WheelCategory(
      key: "Кислий / Фермент.",
      name: "Кислий / Фермент.",
      color: const Color(0xFFE9A000),
      sub: [
        WheelSub(
          key: "Кислий",
          name: "Кислий",
          color: const Color(0xFFC76F16),
          noteKeys: [
            "Кисла ароматика",
            "Оцтова кислота",
            "Масляна кислота",
            "Ізовалеріанова",
            "Лимонна к-та",
            "Яблучна к-та",
          ],
        ),
        WheelSub(
          key: "Алкогольний",
          name: "Алкогольний",
          color: const Color(0xFF93278F),
          noteKeys: [
            "Винний",
            "Віскі",
            "Перезрілий",
          ],
        ),
      ],
    ),
    WheelCategory(
      key: "Інше",
      name: "Інше",
      color: const Color(0xFF6C6E71),
      sub: [
        WheelSub(
          key: "Хімічний",
          name: "Хімічний",
          color: const Color(0xFF939598),
          noteKeys: [
            "Гума",
            "Нафта/Бензин",
            "Медикаменти",
          ],
        ),
        WheelSub(
          key: "Паперовий",
          name: "Паперовий",
          color: const Color(0xFFBCBEC0),
          noteKeys: [
            "Залежалий",
            "Пліснявий",
            "Запилений",
          ],
        ),
      ],
    ),
  ];
}
