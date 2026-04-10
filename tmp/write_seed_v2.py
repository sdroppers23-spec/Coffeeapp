import os
import sys

content = r"""import 'package:drift/drift.dart';
import 'app_database.dart';

class SeedDataSpecialty {
  static List<Insertable<SpecialtyArticle>> getArticles() {
    return [
      _art(1, 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&q=80', 5),
      _art(2, 'https://images.unsplash.com/photo-1498804103079-a6351b050096?auto=format&fit=crop&q=80', 7),
      _art(3, 'https://images.unsplash.com/photo-1501339819302-ee4467264a2c?auto=format&fit=crop&q=80', 6),
    ];
  }

  static List<Insertable<SpecialtyArticleTranslation>> getArticleTranslations() {
    return [
      _artTrans(1, 'uk', 'Мистецтво обсмажування', 'Від зерна до ідеального профілю', 
        '<h3>Магія піролізу</h3><p>Обсмажування — це не просто нагрівання зерен. Це серія складних хімічних реакцій Маяра, що перетворюють крохмаль на цукор, а органічні кислоти — на складні ефіри з ароматом жасмину, чорниці чи шоколаду.</p><h3>Перший крек</h3><p>У момент, коли волога всередині зерна перетворюється на пару, ви чуєте характерний хрускіт. Це точка неповернення, де починається формування характеру вашої кави.</p>'),
      _artTrans(1, 'en', 'The Art of Roasting', 'From green bean to perfect profile', '<h1>The Roasting Process</h1><p>Roasting coffee involves precise temperature control to unlock complex sugars and volatile oils.</p>'),
      
      _artTrans(2, 'uk', 'Теорія екстракції Espresso', 'Фізика та хімія в одній чашці', 
        '<h3>Баланс TDS та виходу</h3><p>Еспресо — це тонка гра між розчинними речовинами. Ми прагнемо балансу між солодкістю та кислотністю, уникаючи гіркоти надмірної екстракції.</p><h3>Гідродинаміка холдера</h3><p>Тиск у 9 бар змушує воду проходити крізь кавову таблетку, вимиваючи ефірні масла, що формують крема.</p>'),
      _artTrans(2, 'en', 'Espresso Extraction Theory', 'Physics and chemistry in a cup', '<h1>Extraction Basics</h1><p>Learn how grind size and water temperature affect the flavor profile of your espresso shot.</p>'),

      _artTrans(3, 'uk', 'Світ мікро-лотів', 'Чому походження має значення', 
        '<h3>Генетика та терруар</h3><p>Сорт Geisha на висоті 1900м в Ефіопії та в Панамі дасть абсолютно різні результати. Саме терруар створює унікальний відбиток смаку.</p><h3>Ферментаційні експерименти</h3><p>Анаеробна ферментація відкриває двері у світ винних нот та яскравої тропічної кислотності.</p>'),
      _artTrans(3, 'en', 'The World of Micro-lots', 'Why origin matters', '<h1>Terroir and Processing</h1><p>Discover how high-altitude farming and innovative processing create world-class coffee profiles.</p>'),
    ];
  }

  static List<Insertable<LocalizedFarmer>> getFarmers() {
    return [
      _far(1, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&q=80', '🇨🇷', 9.6, -84.0),
      _far(4, 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&q=80', '🇨🇷', 10.0, -84.1),
      _far(5, 'https://images.unsplash.com/photo-1593113598332-cd288d649433?auto=format&fit=crop&q=80', '🇨🇴', 4.5, -75.7),
      _far(6, 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80', '🇪🇹', 7.0, 35.5),
      _far(7, 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&q=80', '🇸🇻', 13.9, -89.5),
      _far(8, 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&q=80', '🇪🇨', 0.3, -78.2),
      _far(9, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&q=80', '🇨🇷', 10.2, -84.3),
      _far(10, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&q=80', '🇧🇷', -19.8, -46.7),
    ];
  }

  static List<Insertable<LocalizedFarmerTranslation>> getFarmerTranslations() {
    return [
      _farTrans(1, 'uk', 'Карлос Монтеро', 'La Pastora / Don Eli', 
        '<h3>Майстер Tarrazu</h3><p>Карлос Монтеро — фермер у третьому поколінні. Родина Монтеро займається кавою понад 100 років, але Карлос став легендою завдяки створенню мікро-станції обробки Don Eli. Його пристрасть до якості та інновацій зробила його ферму взірцем для всього регіону.</p><h3>Філософія мікро-лотів</h3><p>Він був одним з перших, хто зрозумів: майбутнє Коста-Рики — в унікальних мікро-лотів. Він збудував власну станцію, щоб контролювати кожен етап: від збору ягоди до фінальної дегідратації. Це дозволяє йому експериментувати з ферментацією та отримувати профілі, які раніше вважалися неможливими для Tarrazu.</p><h3>Соціальна відповідальність</h3><p>Карлос активно підтримує місцеву спільноту, ділячись знаннями з іншими фермерами. Він вірить, що розвиток усього регіону принесе користь кожному окремому господарству.</p>', 
        'Тарразу', 'Коста-Рика'),
      _farTrans(1, 'en', 'Carlos Montero', 'Don Eli', 'A legend of Tarrazu. His family has been growing coffee for four generations. He built his own micro-mill to control every aspect of production.', 'Tarrazu', 'Costa Rica'),

      _farTrans(4, 'uk', 'Оскар та Франциска Чакон', 'Las Lajas', 
        '<h3>Піонери натуральної обробки</h3><p>Родина Чакон змінила історію Коста-Рики після вимушеного переходу на "сухий" метод у 2008 році. Це зробило їх світовими лідерами Honey-обробки та натурального способу в країні, де традиційно панувала мита кава.</p><h3>Органічне серце</h3><p>Las Lajas — одна з небагатьох ферм з повною органічною сертифікацією. Вони використовують власні добрива, виготовлені з кавової пульпи, та зберігають біорізноманіття тропічного лісу прямо на плантаціях.</p><h3>Майстерність Honey</h3><p>Оскар розробив унікальну класифікацію Honey-обробки: Yellow, Red, Black та Perla Negra, кожна з яких має свій неповторний смаковий профіль.</p>', 
        'Центральна Долина', 'Коста-Рика'),
      
      _farTrans(5, 'uk', 'Карлос та Феліпе Арсіла', 'Cofinet / Jardines del Eden', 
        '<h3>Революція в ферментації</h3><p>Брати Карлос та Феліпе Арсіла — це колумбійські революціонери, які заснували експортну компанію Cofinet і змінили правила гри у "ко-ферментації". Їхній підхід поєднує глибокі знання агрономії з сучасними харчовими технологіями.</p><h3>Інновації в Jardines del Eden</h3><p>Вони спеціалізуються на інфузіях — процесі додавання сторонніх натуральних інгредієнтів (фруктів, трав) під час бродіння кави. Це створює неймовірно яскраві смакові профілі, які нагадують тропічні коктейлі.</p><h3>Родинні традиції</h3><p>Незважаючи на інновації, брати поважають досвід свого батька, який десятиліттями вирощував каву класичними методами. Вони вірять у симбіоз традицій та прогресу.</p>', 
        'Кіндіо', 'Колумбія'),

      _farTrans(6, 'uk', 'Адам Овертон та Рейчел Семюел', 'Gesha Village Coffee Estate', 
        '<h3>Відродження легенди</h3><p>У 2011 році Адам Овертон і Рейчел Семюел розпочали грандіозний проект у віддаленому регіоні Бенч-Мажі в Ефіопії. Їхньою метою було знайти дикі сорти Геші в лісі Горі-Геша та висадити їх на власній фермі.</p><h3>Світове визнання</h3><p>Сьогодні Gesha Village є один з найбільш престижних кавових господарств у світі, пропонуючи каву неймовірної чистоти та ароматичної складності.</p><h3>Експорт якості</h3><p>Вони створили систему лотів, що дозволяє обсмажчикам з усього світу купувати конкретні ділянки врожаю, забезпечуючи повну простежуваність.</p>', 
        'Бенчі-Маджі', 'Ефіопія'),

      _farTrans(7, 'uk', 'Аїда Батлл', 'Finca Kilimanjaro', 
        '<h3>Бунтарка та інноваторка</h3><p>Аїда Батлл — одна з найбільш впізнаваних постатей у світі specialty кави. Вона стала першою жінкою, яка виграла Cup of Excellence в Сальвадорі, і з того часу продовжує ламати стереотипи.</p><h3>Філософія якості</h3><p>Її підхід базується на ретельній селекції та експериментальних методах обробки, багато з яких вона розробляє самостійно на своїх фермах Kilimanjaro та Los Alpes.</p><h3>Аїда Батлл Selection</h3><p>Вона створила бренд "Aida Batlle Selection", який гарантує обсмажчикам найвищий рівень якості та контроль за кожним зерном.</p>', 
        'Санта-Ана', 'Сальвадор'),

      _farTrans(8, 'uk', 'Пепе Хіхон', 'Finca Soledad', 
        '<h3>Від альпінізму до кавової алхімії</h3><p>Пепе Хіхон — колишній професійний альпініст, що підкорив 7 найвищих вершин світу. Його ферма Finca Soledad в Еквадорі — це унікальне місце, де кава росте в гармонії з хмарним лісом.</p><h3>Біодинамічний підхід</h3><p>Пепе практикує біодинаміку: повна відмова від хімії та робота в циклах природи. Його легендарний сорт Sidra стає справжнім витвором мистецтва завдяки особливій ферментації Wave.</p><h3>Чистота смаку</h3><p>Його кава характеризується надзвичайною чистотою та елегантністю, що зробило її улюбленою серед чемпіонів бариста по всьому світу.</p>', 
        'Імбабура', 'Еквадор'),

      _farTrans(9, 'uk', 'Алехо Кастро', 'Volcan Azul', 
        '<h3>Спадкоємець кавової імперії</h3><p>Алехо — представник п’ятого покоління династії Кастро. Його ферма Volcan Azul розташована на схилах вулкану Поас, де багатий на мінерали вулканічний ґрунт створює ідеальні умови для кави.</p><h3>Ботанічний заповідник</h3><p>На фермі висаджено понад 40 рідкісних ботанічних різновидів. Алехо активно інвестує у захист дикої природи, намагаючись зберегти первісний стан тропічних лісів.</p><h3>Сучасна обробка</h3><p>Він поєднує старі сімейні рецепти з сучасними технологіями сортування та сушіння, що дозволяє отримувати стабільну якість з року в рік.</p>', 
        'Західна Долина', 'Коста-Рика'),

      _farTrans(10, 'uk', 'Луїс Паскоаль', 'Daterra Coffee', 
        '<h3>Кремнієва долина кави</h3><p>Daterra — це маєток площею 6000 гектарів, де 50% території відведено під заповідник. Вони першими в Бразилії отримали сертифікат B-Corp, підтверджуючи свою соціальну та екологічну відповідальність.</p><h3>Технологічна досконалість</h3><p>Луїс впровадив у каву передові технології: від аналізу ґрунту дронами до оптичного сортування на молекулярному рівні. Їхня лінійка "Masterpieces" створюється спеціально для світових чемпіонатів.</p><h3>Майстерність блендування</h3><p>Daterra відома своїми складними блендами та лотами, що мають унікальні смакові характеристики, такі як "Sweet Blue" чи "Reserve".</p>', 
        'Серрадо Мінейро', 'Бразилія'),
    ];
  }

  static Insertable<SpecialtyArticle> _art(int id, String url, int time) {
    return SpecialtyArticlesCompanion.insert(
      id: Value(id),
      imageUrl: url,
      readTimeMin: time,
    );
  }

  static Insertable<SpecialtyArticleTranslation> _artTrans(int id, String lang, String title, String sub, String content) {
    return SpecialtyArticleTranslationsCompanion.insert(
      articleId: id,
      languageCode: lang,
      title: title,
      subtitle: sub,
      contentHtml: content,
    );
  }

  static Insertable<LocalizedFarmer> _far(int id, String url, String emoji, double lat, double lon) {
    return LocalizedFarmersCompanion.insert(
      id: Value(id),
      imageUrl: Value(url),
      countryEmoji: Value(emoji),
      latitude: Value(lat),
      longitude: Value(lon),
    );
  }

  static Insertable<LocalizedFarmerTranslation> _farTrans(int id, String lang, String name, String story, String desc, String region, String country) {
    return LocalizedFarmerTranslationsCompanion.insert(
      farmerId: id,
      languageCode: lang,
      name: Value(name),
      story: Value(story),
      description: Value(desc),
      region: Value(region),
      country: Value(country),
    );
  }
}
"""

try:
    path = r'd:/Games/Coffeeapp/lib/core/database/seed_data_specialty.dart'
    dirname = os.path.dirname(path)
    if not os.path.exists(dirname):
        os.makedirs(dirname)
    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)
    print("SUCCESS")
except Exception as e:
    print(f"ERROR: {e}")
    sys.exit(1)
