
    -- Article 101
    INSERT INTO specialty_articles (id, image_url, read_time_min) 
    VALUES (101, 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/encyclopedia_module_1.png', 10)
    ON CONFLICT (id) DO UPDATE SET image_url = EXCLUDED.image_url;

    INSERT INTO specialty_article_translations (article_id, language_code, title, subtitle, content_html)
    VALUES (101, 'uk', 'Standards, Institutions, and Ethics', 'Поглиблений модуль знань', '## Розширене визначення Specialty Coffee

**Definition:** Specialty Coffee — це не просто категорія товару, а замкнута екосистема контролю якості, де кожен етап виробництва спрямований на збереження та підкреслення природного генетичного потенціалу зерна.

### Повна простежуваність (Traceability)
Можливість ідентифікувати каву до рівня конкретного лота (Micro-lot) або навіть ділянки ферми (Nano-lot). Це включає GPS-координати плантації, дату збору та точні параметри обробки.

### Сенсорна перевага
Наявність унікальних смакових дескрипторів, зумовлених теруаром, а не процесом обсмажування. Кава повинна демонструвати складну кислотність, виражену солодкість та чистий післясмак.

## Світові інституції: SCA та CQI

### Specialty Coffee Association (SCA)
*Глобальна неприбуткова організація, що встановлює технічні стандарти для всієї індустрії.*

- SCA Water Standard: Специфікація хімічного складу води для заварювання (TDS, кальцієва жорсткість, лужність).
- SCA Cupping Protocol: Суворий регламент проведення професійних дегустацій.
- SCA Green Coffee Grading: Методологія фізичного аналізу зеленого зерна перед обсмажуванням.

### Coffee Quality Institute (CQI)
*Організація, що фокусується на навчанні та сертифікації спеціалістів.*

**Certification: Q-Grader**
Найвищий рівень професійної сертифікації дегустатора кави. Q-грейдери — це ''судді'', які мають право офіційно виставляти бали каві, що впливає на її ринкову вартість.

## Протокол оцінювання та Капінг

## Етична торгівля та Економіка

')
    ON CONFLICT (article_id, language_code) DO UPDATE SET 
        title = EXCLUDED.title,
        content_html = EXCLUDED.content_html;
    

    -- Article 102
    INSERT INTO specialty_articles (id, image_url, read_time_min) 
    VALUES (102, 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/encyclopedia_module_2.png', 10)
    ON CONFLICT (id) DO UPDATE SET image_url = EXCLUDED.image_url;

    INSERT INTO specialty_article_translations (article_id, language_code, title, subtitle, content_html)
    VALUES (102, 'uk', 'Botany, Genetics, and Terroir', 'Поглиблений модуль знань', '## Теруар: Геологія, Клімат та Хімічний метаболізм

### Altitude and Stress
Спешелті кава вимагає висот від 1000 до 2500 і більше метрів над рівнем моря.
На таких висотах виникає сильний добовий перепад температур (спекотні дні та дуже холодні ночі). Цей температурний стрес змушує дерево уповільнювати свій метаболізм. Вночі життєві процеси майже зупиняються, що подовжує період дозрівання ягоди з 6 до 8-10 місяців.
**Result:** Уповільнене дозрівання дозволяє зерну стати значно щільнішим (класифікація SHB - Strictly Hard Bean) та накопичити максимальну кількість сахарози і складних органічних кислот, які є прекурсорами майбутнього смаку.

**Andosols**: Вулканічні ґрунти (поширені в Колумбії, Гватемалі, Коста-Риці). Мають легку пористу структуру, що забезпечує ідеальний дренаж коріння. Насичені попелом, азотом та сіркою, вони сприяють формуванню яскраво вираженої ''іскристої'' кислотності та квіткових нот у каві.

**Alfisols_and_oxisols**: Червоні залізисті та глинисті ґрунти (Африка, зокрема Кенія). Містять аномально високу кількість ортофосфорної кислоти. Коріння кави втягує цей фосфор, що безпосередньо призводить до появи фірмового кенійського профілю: смаку чорної смородини, томатів, ожини та глибокого ''винного'' тіла.

**Soil_microbiome**: Мікориза (симбіоз грибів з корінням) та ґрунтові бактерії розщеплюють недоступні мінерали до форм, які дерево здатне поглинути. Здорова біодинаміка ґрунту є критичною для спешелті ферм.

## Генетика: Базові різновиди Арабіки (Coffea Arabica)

### Typica (Типіка)
Один з найдавніших сортів, від якого пішла більшість інших. Має конічну форму дерева, довгі гілки та вузьке листя з бронзовими кінчиками.
*Agronomy:* Дуже низька врожайність та висока вразливість до кавової іржі (Roya).
*Profile:* Виняткова чистота, ідеальний баланс, солодкість. Класичні дескриптори: молочний шоколад, яблуко, карамель, легкі квіткові ноти. (Відомі підвиди: Blue Mountain, Kona, Pluma Hidalgo).

### Bourbon (Бурбон)
Природна мутація Типіки, виявлена на острові Бурбон (зараз Реюньйон) у 18 столітті. Листя ширше, з зеленими кінчиками.
*Agronomy:* Дає на 20-30% більше врожаю, ніж Типіка, але все ще вразливий до вітрів та хвороб.
*Profile:* Комплексне тіло, інтенсивна сиропна солодкість, яскрава фруктова кислотність. Залежно від кольору ягід (Red Bourbon, Yellow Bourbon, Pink Bourbon) смак варіюється від вишневого до персикового та грейпфрутового.

### Caturra (Катурра)
Одногенна карликова мутація Бурбону, відкрита в Бразилії у 1937 році.
*Agronomy:* Короткі міжвузля дозволяють дереву залишатися низьким, що значно полегшує ручний збір (пікінг) та дозволяє фермерам висаджувати дерева значно щільніше один до одного, збільшуючи врожай з гектара.
*Profile:* Яскрава, пронизлива лимонна або цитрусова кислотність, трохи менше тіла порівняно з Бурбоном.

### Pacamara (Пакамара)
Штучний гібрид, створений в інституті ISIC (Сальвадор) у 1958 році шляхом схрещення Pacas (карликова мутація Бурбону) та Maragogype (мутація Типіки з гігантськими зернами ''elephant beans'').
*Agronomy:* Нестабільна генетика (близько 10-12% дерев повертаються до батьківських форм), потребує ретельного догляду.
*Profile:* Ексцентричний і видатний смак. Унікальне поєднання квіткових і тропічних нот із пікантними (savory) дескрипторами: хміль, базилік, чорний шоколад, червона смородина та іноді розмарин.

## Генетика: Елітні, Аукціонні та Реліктові Різновиди

### Geisha / Gesha (Гейша / Геша)
Зібрана в 1930-х роках у лісі Горі Геша (Ефіопія), привезена в Центральну Америку через Кенію та Танзанію для дослідження стійкості до хвороб.
Безпрецедентно складний, багатошаровий ''парфумований'' аромат. Дескриптори: жасмин, бергамот, чай Ерл Грей, лемонграс, манго, стиглий персик. Рекордно високі ціни (понад $10,000 за кілограм зеленого зерна на преміум-аукціонах).

### SL-28 та SL-34
Виведені у 1930-х роках кенійською лабораторією Scott Agricultural Laboratories (звідси і префікс SL).
Саме ці сорти формують ''впізнаваний смак Кенії''. SL-28 дає вибухову фосфорно-цитрусову кислотність та інтенсивні ноти чорної смородини. SL-34 додає важче, солодке винне тіло та темні ягоди.

### Wush Wush (Вуш Вуш)
Реліктовий сорт (Landrace), знайдений поблизу однойменного міста на південному заході Ефіопії. Набуває шаленої популярності на фермах Колумбії.
На відміну від квіткової Геші, Вуш Вуш забезпечує густе, важке, лікерно-сиропне тіло. Домінуючі ноти: троянда, кавун, зацукровані фрукти, коньяк, полуничне варення.

### Eugenioides (Еуженіоідес)
Вирощується вкрай рідко (зокрема на фермі Inmaculada в Колумбії). Має вдвічі менше кофеїну, ніж арабіка. Практично позбавлений кислотності, але наділений екстремальною, майже штучною солодкістю. Дескриптори: цукрова вата, зефір, стевія, вівсяне молоко, солодкі злаки.

')
    ON CONFLICT (article_id, language_code) DO UPDATE SET 
        title = EXCLUDED.title,
        content_html = EXCLUDED.content_html;
    

    -- Article 103
    INSERT INTO specialty_articles (id, image_url, read_time_min) 
    VALUES (103, 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/encyclopedia_module_3.png', 10)
    ON CONFLICT (id) DO UPDATE SET image_url = EXCLUDED.image_url;

    INSERT INTO specialty_article_translations (article_id, language_code, title, subtitle, content_html)
    VALUES (103, 'uk', 'Agronomy, Harvesting, and Basic Processing', 'Поглиблений модуль знань', '## Агрономія: Управління плантацією

## Збір врожаю: Пікінг та Сортування

## Базові обробки: Натуральна (Natural / Dry Process)

## Базові обробки: Мита (Washed / Wet Process)

## Базові обробки: Хані / Напівмита (Honey / Pulped Natural)

')
    ON CONFLICT (article_id, language_code) DO UPDATE SET 
        title = EXCLUDED.title,
        content_html = EXCLUDED.content_html;
    



    -- Article 104
    INSERT INTO specialty_articles (id, image_url, read_time_min) 
    VALUES (104, 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/encyclopedia_module_4.png', 10)
    ON CONFLICT (id) DO UPDATE SET image_url = EXCLUDED.image_url;

    INSERT INTO specialty_article_translations (article_id, language_code, title, subtitle, content_html)
    VALUES (104, 'uk', 'Roasting Chemistry and Thermodynamics', 'Поглиблений модуль знань', '## Термодинаміка ростера: Види теплопередачі

## Хімічні фази обсмажування

### undefined
undefined
*Chemistry:* undefined

### undefined
undefined
*Chemistry:* undefined

### undefined
undefined
*Chemistry:* undefined

## Профілі обсмажування (Roast Levels)

## Дефекти обсмажування (Roasting Defects)

')
    ON CONFLICT (article_id, language_code) DO UPDATE SET 
        title = EXCLUDED.title,
        content_html = EXCLUDED.content_html;
    

    -- Article 105
    INSERT INTO specialty_articles (id, image_url, read_time_min) 
    VALUES (105, 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/encyclopedia_module_5.png', 10)
    ON CONFLICT (id) DO UPDATE SET image_url = EXCLUDED.image_url;

    INSERT INTO specialty_article_translations (article_id, language_code, title, subtitle, content_html)
    VALUES (105, 'uk', 'Sensory Analysis, Extraction Theory, and Water Chemistry', 'Поглиблений модуль знань', '## Хімія води для заварювання (Water Chemistry)

## Теорія Екстракції (Extraction Theory)

## Фундаментальні змінні заварювання (Brewing Variables)

## Сенсорний аналіз та Колесо смаків (Flavor Wheel)

')
    ON CONFLICT (article_id, language_code) DO UPDATE SET 
        title = EXCLUDED.title,
        content_html = EXCLUDED.content_html;
    

    -- Article 106
    INSERT INTO specialty_articles (id, image_url, read_time_min) 
    VALUES (106, 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/encyclopedia_module_6.png', 10)
    ON CONFLICT (id) DO UPDATE SET image_url = EXCLUDED.image_url;

    INSERT INTO specialty_article_translations (article_id, language_code, title, subtitle, content_html)
    VALUES (106, 'uk', 'Espresso Physics, Milk Chemistry, and Latte Art Dynamics', 'Поглиблений модуль знань', '## Фізика Еспресо та Підготовка ''Таблетки'' (Puck Prep)

## Технологія Помелу: Плоскі vs Конічні Жорна

## Хімія Молока та Мікропіна

## Динаміка та Фізика Латте-Арту

')
    ON CONFLICT (article_id, language_code) DO UPDATE SET 
        title = EXCLUDED.title,
        content_html = EXCLUDED.content_html;
    

    -- Article 107
    INSERT INTO specialty_articles (id, image_url, read_time_min) 
    VALUES (107, 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/encyclopedia_module_7.png', 10)
    ON CONFLICT (id) DO UPDATE SET image_url = EXCLUDED.image_url;

    INSERT INTO specialty_article_translations (article_id, language_code, title, subtitle, content_html)
    VALUES (107, 'uk', 'Digitalization, Smart Tools, and Sustainability', 'Поглиблений модуль знань', '## Інтернет речей (IoT) та Розумне обладнання

## Програмне забезпечення для Обсмажування (Roast Profiling Software)

## Цифрова Простежуваність та Блокчейн (Traceability & Blockchain)

## Мобільні Додатки в Індустрії Specialty Coffee

## Сталий розвиток (Sustainability) та Точне землеробство

')
    ON CONFLICT (article_id, language_code) DO UPDATE SET 
        title = EXCLUDED.title,
        content_html = EXCLUDED.content_html;
    
