import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('pl'),
    Locale('pt'),
    Locale('ro'),
    Locale('ru'),
    Locale('tr'),
    Locale('uk'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Specialty Tracker'**
  String get appTitle;

  /// No description provided for @discoverTitle.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get discoverTitle;

  /// No description provided for @timerTitle.
  ///
  /// In en, this message translates to:
  /// **'Timer'**
  String get timerTitle;

  /// No description provided for @scannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Scanner'**
  String get scannerTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get profileTitle;

  /// No description provided for @discover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get discover;

  /// No description provided for @timer.
  ///
  /// In en, this message translates to:
  /// **'Timer'**
  String get timer;

  /// No description provided for @scanner.
  ///
  /// In en, this message translates to:
  /// **'Scanner'**
  String get scanner;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get profile;

  /// No description provided for @encyclopedia.
  ///
  /// In en, this message translates to:
  /// **'Encyclopedia'**
  String get encyclopedia;

  /// No description provided for @farmers.
  ///
  /// In en, this message translates to:
  /// **'Farmers'**
  String get farmers;

  /// No description provided for @roasters.
  ///
  /// In en, this message translates to:
  /// **'Roasters'**
  String get roasters;

  /// No description provided for @specialty.
  ///
  /// In en, this message translates to:
  /// **'Specialty'**
  String get specialty;

  /// No description provided for @all_specialty.
  ///
  /// In en, this message translates to:
  /// **'Specialty Education'**
  String get all_specialty;

  /// No description provided for @no_articles.
  ///
  /// In en, this message translates to:
  /// **'No articles yet'**
  String get no_articles;

  /// No description provided for @read_time.
  ///
  /// In en, this message translates to:
  /// **'min read'**
  String get read_time;

  /// No description provided for @error_loading.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error_loading;

  /// No description provided for @recipes.
  ///
  /// In en, this message translates to:
  /// **'Recipes'**
  String get recipes;

  /// No description provided for @scans.
  ///
  /// In en, this message translates to:
  /// **'Scans'**
  String get scans;

  /// No description provided for @badges.
  ///
  /// In en, this message translates to:
  /// **'Badges'**
  String get badges;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'EDIT PROFILE'**
  String get edit_profile;

  /// No description provided for @sign_out.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get sign_out;

  /// No description provided for @compare.
  ///
  /// In en, this message translates to:
  /// **'Compare'**
  String get compare;

  /// No description provided for @log_in.
  ///
  /// In en, this message translates to:
  /// **'LOG IN'**
  String get log_in;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'SIGN UP'**
  String get sign_up;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @google_sign_in.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get google_sign_in;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @bloom.
  ///
  /// In en, this message translates to:
  /// **'Bloom'**
  String get bloom;

  /// No description provided for @pour.
  ///
  /// In en, this message translates to:
  /// **'Pour'**
  String get pour;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @prev.
  ///
  /// In en, this message translates to:
  /// **'Prev'**
  String get prev;

  /// No description provided for @running.
  ///
  /// In en, this message translates to:
  /// **'RUNNING'**
  String get running;

  /// No description provided for @paused.
  ///
  /// In en, this message translates to:
  /// **'PAUSED'**
  String get paused;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @source.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get source;

  /// No description provided for @purchase_details.
  ///
  /// In en, this message translates to:
  /// **'PURCHASE DETAILS'**
  String get purchase_details;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @roast_date.
  ///
  /// In en, this message translates to:
  /// **'Roast Date'**
  String get roast_date;

  /// No description provided for @lot_number.
  ///
  /// In en, this message translates to:
  /// **'Lot #'**
  String get lot_number;

  /// No description provided for @roast_level.
  ///
  /// In en, this message translates to:
  /// **'ROAST LEVEL'**
  String get roast_level;

  /// No description provided for @sync_options.
  ///
  /// In en, this message translates to:
  /// **'Data Sync'**
  String get sync_options;

  /// No description provided for @sync_choice_desc.
  ///
  /// In en, this message translates to:
  /// **'Choose synchronization mode:'**
  String get sync_choice_desc;

  /// No description provided for @cloud_sync.
  ///
  /// In en, this message translates to:
  /// **'Cloud Sync'**
  String get cloud_sync;

  /// No description provided for @push_local.
  ///
  /// In en, this message translates to:
  /// **'Push to Cloud'**
  String get push_local;

  /// No description provided for @process_natural.
  ///
  /// In en, this message translates to:
  /// **'Natural'**
  String get process_natural;

  /// No description provided for @process_washed.
  ///
  /// In en, this message translates to:
  /// **'Washed'**
  String get process_washed;

  /// No description provided for @process_honey.
  ///
  /// In en, this message translates to:
  /// **'Honey'**
  String get process_honey;

  /// No description provided for @process_wet_hulled.
  ///
  /// In en, this message translates to:
  /// **'Wet Hulled'**
  String get process_wet_hulled;

  /// No description provided for @process_anaerobic.
  ///
  /// In en, this message translates to:
  /// **'Anaerobic'**
  String get process_anaerobic;

  /// No description provided for @process_carbonic.
  ///
  /// In en, this message translates to:
  /// **'Carbonic Maceration'**
  String get process_carbonic;

  /// No description provided for @process_lactic.
  ///
  /// In en, this message translates to:
  /// **'Lactic Fermentation'**
  String get process_lactic;

  /// No description provided for @process_thermal.
  ///
  /// In en, this message translates to:
  /// **'Thermal Shock'**
  String get process_thermal;

  /// No description provided for @process_yeast.
  ///
  /// In en, this message translates to:
  /// **'Yeast Inoculation'**
  String get process_yeast;

  /// No description provided for @process_koji.
  ///
  /// In en, this message translates to:
  /// **'Koji Fermentation'**
  String get process_koji;

  /// No description provided for @process_natural_desc.
  ///
  /// In en, this message translates to:
  /// **'### Stage 1: Sorting\nOnly ripe cherries are selected and spread out on African beds or patios.\n### Stage 2: Drying\nThe whole fruit dries for 2-4 weeks, allowing sugars to concentrate inside the bean.\n### Stage 3: Hulling\nThe dried husk is removed only after reaching 11-12% moisture. Produces sweet cups with low acidity.'**
  String get process_natural_desc;

  /// No description provided for @process_washed_desc.
  ///
  /// In en, this message translates to:
  /// **'### Stage 1: Depulping\nThe skin and pulp are removed mechanically. The sticky mucilage stays on the parchment.\n### Stage 2: Fermentation\nBeans soak in water tanks for 12-48 hours where bacteria break down the mucilage.\n### Stage 3: Washing & Drying\nBeans are washed with clean water and dried on patios. Produces a very clean flavor with bright acidity.'**
  String get process_washed_desc;

  /// No description provided for @process_honey_desc.
  ///
  /// In en, this message translates to:
  /// **'### Hybrid Method\nThe skin is removed, but part of the sticky mucilage stays on the bean during drying.\n### Categories\nDepending on how much mucilage remains, it ranges from White to Black Honey. Produces very sweet, syrupy and buttery cups.'**
  String get process_honey_desc;

  /// No description provided for @process_wet_hulled_desc.
  ///
  /// In en, this message translates to:
  /// **'### Traditional Indonesian Method (Giling Basah)\nThe skin is removed at very high moisture content (30-40%).\n### Result\nThe bean dries without its protective parchment. This creates a unique profile: low acidity, heavy earthy body, and notes of spice or chocolate.'**
  String get process_wet_hulled_desc;

  /// No description provided for @process_anaerobic_desc.
  ///
  /// In en, this message translates to:
  /// **'### Stage 1: Sealing\nCherries or depulped beans are placed in airtight tanks where oxygen is replaced with CO2 or simply removed.\n### Stage 2: Fermentation\nLasts 48-120 hours. This stimulates specific microbes that create complex \"funky\" tropical flavor profiles.'**
  String get process_anaerobic_desc;

  /// No description provided for @process_carbonic_desc.
  ///
  /// In en, this message translates to:
  /// **'### Wine-making Technique\nWhole cherries are loaded into sealed containers which are then filled with CO2 gas.\n### Result\nCarbon dioxide slows down sugar breakdown. The resulting flavor is very clean, structured, and often has distinct winey notes.'**
  String get process_carbonic_desc;

  /// No description provided for @process_lactic_desc.
  ///
  /// In en, this message translates to:
  /// **'### Lactic Fermentation\nA focus on the development of lactic acid bacteria (Lactobacillus).\n### Result\nCreates high concentrations of lactic acid. In the cup, this results in an incredibly silky, creamy body with notes of yogurt or dairy.'**
  String get process_lactic_desc;

  /// No description provided for @process_thermal_desc.
  ///
  /// In en, this message translates to:
  /// **'### Stage 1: Hot Shock\nBeans are rinsed with 40°C water to expand pores and absorb fermentation compounds.\n### Stage 2: Cold Shock\nImmediate rinse with 12°C water to \"lock\" intense flavors inside. Extremely vibrant and intense profile.'**
  String get process_thermal_desc;

  /// No description provided for @process_yeast_desc.
  ///
  /// In en, this message translates to:
  /// **'### Controlled Fermentation\nSpecific yeast strains (wine or specially developed coffee yeast) are added to the fermentation tank.\n### Result\nFull control over the process. Yeast highlights precise floral or berry aromas, leading to a much cleaner and more predictable flavor.'**
  String get process_yeast_desc;

  /// No description provided for @process_koji_desc.
  ///
  /// In en, this message translates to:
  /// **'### Japanese Technology\nUses Aspergillus oryzae (Koji) mold, commonly used in sake and soy sauce production.\n### Result\nKoji breaks down complex carbohydrates and proteins that normal yeast cannot. Results in extreme sweetness, depth, and a subtle umami finish.'**
  String get process_koji_desc;

  /// No description provided for @shop_coffee.
  ///
  /// In en, this message translates to:
  /// **'SHOP THIS COFFEE'**
  String get shop_coffee;

  /// No description provided for @terroir_farm.
  ///
  /// In en, this message translates to:
  /// **'TERROIR & FARM'**
  String get terroir_farm;

  /// No description provided for @sensory_grid.
  ///
  /// In en, this message translates to:
  /// **'SENSORY PROFILE'**
  String get sensory_grid;

  /// No description provided for @cupping_score.
  ///
  /// In en, this message translates to:
  /// **'Cupping Score'**
  String get cupping_score;

  /// No description provided for @body.
  ///
  /// In en, this message translates to:
  /// **'Body'**
  String get body;

  /// No description provided for @aftertaste.
  ///
  /// In en, this message translates to:
  /// **'Aftertaste'**
  String get aftertaste;

  /// No description provided for @acidity_type.
  ///
  /// In en, this message translates to:
  /// **'Acidity Type'**
  String get acidity_type;

  /// No description provided for @indicators.
  ///
  /// In en, this message translates to:
  /// **'Indicators'**
  String get indicators;

  /// No description provided for @acidity.
  ///
  /// In en, this message translates to:
  /// **'Acidity'**
  String get acidity;

  /// No description provided for @sweetness.
  ///
  /// In en, this message translates to:
  /// **'Sweetness'**
  String get sweetness;

  /// No description provided for @bitterness.
  ///
  /// In en, this message translates to:
  /// **'Bitterness'**
  String get bitterness;

  /// No description provided for @intensity.
  ///
  /// In en, this message translates to:
  /// **'Intensity'**
  String get intensity;

  /// No description provided for @tab_product.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get tab_product;

  /// No description provided for @tab_source.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get tab_source;

  /// No description provided for @tab_recipes.
  ///
  /// In en, this message translates to:
  /// **'Recipes'**
  String get tab_recipes;

  /// No description provided for @roast_light.
  ///
  /// In en, this message translates to:
  /// **'LIGHT'**
  String get roast_light;

  /// No description provided for @roast_medium.
  ///
  /// In en, this message translates to:
  /// **'MEDIUM'**
  String get roast_medium;

  /// No description provided for @roast_dark.
  ///
  /// In en, this message translates to:
  /// **'DARK'**
  String get roast_dark;

  /// No description provided for @no_recipes_for_lot.
  ///
  /// In en, this message translates to:
  /// **'No recommended recipes for this lot yet.'**
  String get no_recipes_for_lot;

  /// No description provided for @process_detail.
  ///
  /// In en, this message translates to:
  /// **'PROCESSING DETAILS'**
  String get process_detail;

  /// No description provided for @story_terroir.
  ///
  /// In en, this message translates to:
  /// **'STORY & TERROIR'**
  String get story_terroir;

  /// No description provided for @coffee_origins.
  ///
  /// In en, this message translates to:
  /// **'Coffee Origins'**
  String get coffee_origins;

  /// No description provided for @premium_roasters.
  ///
  /// In en, this message translates to:
  /// **'Premium Roasters'**
  String get premium_roasters;

  /// No description provided for @auth_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome! Please log in or sign up'**
  String get auth_subtitle;

  /// No description provided for @search_origins.
  ///
  /// In en, this message translates to:
  /// **'Search origins...'**
  String get search_origins;

  /// No description provided for @no_results.
  ///
  /// In en, this message translates to:
  /// **'No results for'**
  String get no_results;

  /// No description provided for @altitude.
  ///
  /// In en, this message translates to:
  /// **'Altitude'**
  String get altitude;

  /// No description provided for @varieties.
  ///
  /// In en, this message translates to:
  /// **'Varieties'**
  String get varieties;

  /// No description provided for @region.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get region;

  /// No description provided for @process.
  ///
  /// In en, this message translates to:
  /// **'Process'**
  String get process;

  /// No description provided for @lot_desc_col_46_filter.
  ///
  /// In en, this message translates to:
  /// **'Complex acidity, long blackberry aftertaste. Light roast for filter brewing.'**
  String get lot_desc_col_46_filter;

  /// No description provided for @lot_desc_col_31_filter.
  ///
  /// In en, this message translates to:
  /// **'Long apple acidity. Thermal shock processed Chiroso variety.'**
  String get lot_desc_col_31_filter;

  /// No description provided for @lot_desc_kenya_20_filter.
  ///
  /// In en, this message translates to:
  /// **'Bright berry classic. Notes of red berries and honey.'**
  String get lot_desc_kenya_20_filter;

  /// No description provided for @lot_desc_eth_37_filter.
  ///
  /// In en, this message translates to:
  /// **'Clean and elegant tea profile. Jasmine and lemon notes.'**
  String get lot_desc_eth_37_filter;

  /// No description provided for @lot_desc_col_46_espresso.
  ///
  /// In en, this message translates to:
  /// **'Full body, perfect for milk-based drinks. Notes of pear and marzipan.'**
  String get lot_desc_col_46_espresso;

  /// No description provided for @lot_desc_tanzania_utengule.
  ///
  /// In en, this message translates to:
  /// **'Sweet and balanced lot from Tanzania. Honey process adds honey sweetness and fruit clarity.'**
  String get lot_desc_tanzania_utengule;

  /// No description provided for @lot_desc_col_alto_osos.
  ///
  /// In en, this message translates to:
  /// **'Aged natural processing with anaerobic-like sweetness. High complexity with tropical fruit and rum notes.'**
  String get lot_desc_col_alto_osos;

  /// No description provided for @lot_desc_indonesia_manis.
  ///
  /// In en, this message translates to:
  /// **'Indonesia without earthiness. Only fruit, rum, and chocolate delight.'**
  String get lot_desc_indonesia_manis;

  /// No description provided for @lot_desc_kenya_gichathaini.
  ///
  /// In en, this message translates to:
  /// **'Bright and juicy Kenya with characteristic currant acidity and long aftertaste.'**
  String get lot_desc_kenya_gichathaini;

  /// No description provided for @region_central_america.
  ///
  /// In en, this message translates to:
  /// **'Central America'**
  String get region_central_america;

  /// No description provided for @region_south_america.
  ///
  /// In en, this message translates to:
  /// **'South America'**
  String get region_south_america;

  /// No description provided for @region_asia_pacific.
  ///
  /// In en, this message translates to:
  /// **'Asia Pacific'**
  String get region_asia_pacific;

  /// No description provided for @flavor_map_title.
  ///
  /// In en, this message translates to:
  /// **'Flavor Map'**
  String get flavor_map_title;

  /// No description provided for @tab_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get tab_profile;

  /// No description provided for @tab_sphere.
  ///
  /// In en, this message translates to:
  /// **'Sphere'**
  String get tab_sphere;

  /// No description provided for @tab_wheel.
  ///
  /// In en, this message translates to:
  /// **'Flavor Wheel'**
  String get tab_wheel;

  /// No description provided for @tab_steps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get tab_steps;

  /// No description provided for @tab_custom.
  ///
  /// In en, this message translates to:
  /// **'My Versions'**
  String get tab_custom;

  /// No description provided for @tab_recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get tab_recommended;

  /// No description provided for @tap_wheel_to_explore.
  ///
  /// In en, this message translates to:
  /// **'Tap segments to explore flavors'**
  String get tap_wheel_to_explore;

  /// No description provided for @process_details.
  ///
  /// In en, this message translates to:
  /// **'Process Details'**
  String get process_details;

  /// No description provided for @view_details.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get view_details;

  /// No description provided for @region_east_africa.
  ///
  /// In en, this message translates to:
  /// **'East Africa (Ethiopia/Kenya)'**
  String get region_east_africa;

  /// No description provided for @region_west_africa.
  ///
  /// In en, this message translates to:
  /// **'West Africa'**
  String get region_west_africa;

  /// No description provided for @region_se_asia.
  ///
  /// In en, this message translates to:
  /// **'Southeast Asia & Indonesia'**
  String get region_se_asia;

  /// No description provided for @region_india.
  ///
  /// In en, this message translates to:
  /// **'India & South Asia'**
  String get region_india;

  /// No description provided for @region_brazil.
  ///
  /// In en, this message translates to:
  /// **'Brazil (Terra Roxa)'**
  String get region_brazil;

  /// No description provided for @flavor_floral.
  ///
  /// In en, this message translates to:
  /// **'Floral'**
  String get flavor_floral;

  /// No description provided for @flavor_fruity.
  ///
  /// In en, this message translates to:
  /// **'Fruity'**
  String get flavor_fruity;

  /// No description provided for @flavor_sweet.
  ///
  /// In en, this message translates to:
  /// **'Sweet / Caramel'**
  String get flavor_sweet;

  /// No description provided for @flavor_nutty.
  ///
  /// In en, this message translates to:
  /// **'Nutty / Cocoa'**
  String get flavor_nutty;

  /// No description provided for @flavor_spicy.
  ///
  /// In en, this message translates to:
  /// **'Spicy'**
  String get flavor_spicy;

  /// No description provided for @flavor_earthy.
  ///
  /// In en, this message translates to:
  /// **'Earthy / Herbal'**
  String get flavor_earthy;

  /// No description provided for @note_jasmine.
  ///
  /// In en, this message translates to:
  /// **'Jasmine'**
  String get note_jasmine;

  /// No description provided for @note_tea.
  ///
  /// In en, this message translates to:
  /// **'Black Tea'**
  String get note_tea;

  /// No description provided for @note_blueberry.
  ///
  /// In en, this message translates to:
  /// **'Blueberry'**
  String get note_blueberry;

  /// No description provided for @note_citrus.
  ///
  /// In en, this message translates to:
  /// **'Citrus'**
  String get note_citrus;

  /// No description provided for @note_caramel.
  ///
  /// In en, this message translates to:
  /// **'Caramel'**
  String get note_caramel;

  /// No description provided for @note_chocolate.
  ///
  /// In en, this message translates to:
  /// **'Dark Chocolate'**
  String get note_chocolate;

  /// No description provided for @note_hazelnut.
  ///
  /// In en, this message translates to:
  /// **'Hazelnut'**
  String get note_hazelnut;

  /// No description provided for @note_cinnamon.
  ///
  /// In en, this message translates to:
  /// **'Cinnamon'**
  String get note_cinnamon;

  /// No description provided for @note_forest.
  ///
  /// In en, this message translates to:
  /// **'Forest Floor'**
  String get note_forest;

  /// No description provided for @note_tobacco.
  ///
  /// In en, this message translates to:
  /// **'Tobacco'**
  String get note_tobacco;

  /// No description provided for @note_winey.
  ///
  /// In en, this message translates to:
  /// **'Winey'**
  String get note_winey;

  /// No description provided for @desc_east_africa.
  ///
  /// In en, this message translates to:
  /// **'The birthplace of coffee. Characterized by bright acidity, floral tea-like notes, and intense berry sweetness.'**
  String get desc_east_africa;

  /// No description provided for @desc_central_america.
  ///
  /// In en, this message translates to:
  /// **'Clean, bright, and often nutty. Known for balanced profiles and chocolatey undertones from high altitudes.'**
  String get desc_central_america;

  /// No description provided for @desc_se_asia.
  ///
  /// In en, this message translates to:
  /// **'Deep, heavy-bodied, and earthy. Unique processing often results in notes of spice, tobacco, and dark chocolate.'**
  String get desc_se_asia;

  /// No description provided for @desc_south_america.
  ///
  /// In en, this message translates to:
  /// **'Reliable sweetness and medium body. Classic profiles of caramel, cocoa, and nutty balance.'**
  String get desc_south_america;

  /// No description provided for @desc_india.
  ///
  /// In en, this message translates to:
  /// **'Unique \"Monsooned\" processing creates low acidity, heavy body, and intense spicy or woody character.'**
  String get desc_india;

  /// No description provided for @desc_sensory_terroir_title.
  ///
  /// In en, this message translates to:
  /// **'SENSORY TERROIR PROFILE:'**
  String get desc_sensory_terroir_title;

  /// No description provided for @characteristics_header.
  ///
  /// In en, this message translates to:
  /// **'CHARACTERISTICS'**
  String get characteristics_header;

  /// No description provided for @prices_header.
  ///
  /// In en, this message translates to:
  /// **'PRICES (250g / 1kg)'**
  String get prices_header;

  /// No description provided for @sensory_profile_header.
  ///
  /// In en, this message translates to:
  /// **'SENSORY PROFILE'**
  String get sensory_profile_header;

  /// No description provided for @lot_metrics_header.
  ///
  /// In en, this message translates to:
  /// **'LOT METRICS'**
  String get lot_metrics_header;

  /// No description provided for @retail.
  ///
  /// In en, this message translates to:
  /// **'RETAIL'**
  String get retail;

  /// No description provided for @wholesale.
  ///
  /// In en, this message translates to:
  /// **'WHOLESALE'**
  String get wholesale;

  /// No description provided for @note_strawberry.
  ///
  /// In en, this message translates to:
  /// **'Strawberry'**
  String get note_strawberry;

  /// No description provided for @note_raspberry.
  ///
  /// In en, this message translates to:
  /// **'Raspberry'**
  String get note_raspberry;

  /// No description provided for @note_orange.
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get note_orange;

  /// No description provided for @note_lime.
  ///
  /// In en, this message translates to:
  /// **'Lime'**
  String get note_lime;

  /// No description provided for @note_lemon.
  ///
  /// In en, this message translates to:
  /// **'Lemon'**
  String get note_lemon;

  /// No description provided for @note_tropical.
  ///
  /// In en, this message translates to:
  /// **'Tropical'**
  String get note_tropical;

  /// No description provided for @note_mango.
  ///
  /// In en, this message translates to:
  /// **'Mango'**
  String get note_mango;

  /// No description provided for @note_pineapple.
  ///
  /// In en, this message translates to:
  /// **'Pineapple'**
  String get note_pineapple;

  /// No description provided for @note_cocoa.
  ///
  /// In en, this message translates to:
  /// **'Cocoa'**
  String get note_cocoa;

  /// No description provided for @note_berry.
  ///
  /// In en, this message translates to:
  /// **'Berry'**
  String get note_berry;

  /// No description provided for @sync_pushing.
  ///
  /// In en, this message translates to:
  /// **'Pushing to Cloud...'**
  String get sync_pushing;

  /// No description provided for @sync_connecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting to Cloud Sync...'**
  String get sync_connecting;

  /// No description provided for @sync_failed.
  ///
  /// In en, this message translates to:
  /// **'Action failed'**
  String get sync_failed;

  /// No description provided for @sensory_profile.
  ///
  /// In en, this message translates to:
  /// **'Sensory Profile'**
  String get sensory_profile;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @coffee_origins_cap.
  ///
  /// In en, this message translates to:
  /// **'COFFEE ORIGINS'**
  String get coffee_origins_cap;

  /// No description provided for @explore_terroirs.
  ///
  /// In en, this message translates to:
  /// **'Explore terroirs and unique flavors'**
  String get explore_terroirs;

  /// No description provided for @nav_latte_art.
  ///
  /// In en, this message translates to:
  /// **'Latte Art'**
  String get nav_latte_art;

  /// No description provided for @process_washed_label.
  ///
  /// In en, this message translates to:
  /// **'Washed'**
  String get process_washed_label;

  /// No description provided for @process_natural_label.
  ///
  /// In en, this message translates to:
  /// **'Natural'**
  String get process_natural_label;

  /// No description provided for @process_honey_label.
  ///
  /// In en, this message translates to:
  /// **'Honey'**
  String get process_honey_label;

  /// No description provided for @ethiopia.
  ///
  /// In en, this message translates to:
  /// **'Ethiopia'**
  String get ethiopia;

  /// No description provided for @brazil.
  ///
  /// In en, this message translates to:
  /// **'Brazil'**
  String get brazil;

  /// No description provided for @anaerobic_template.
  ///
  /// In en, this message translates to:
  /// **'Anaerobic'**
  String get anaerobic_template;

  /// No description provided for @no_regions.
  ///
  /// In en, this message translates to:
  /// **'No regions available.'**
  String get no_regions;

  /// No description provided for @browse_lots.
  ///
  /// In en, this message translates to:
  /// **'Browse Lots'**
  String get browse_lots;

  /// No description provided for @tilt.
  ///
  /// In en, this message translates to:
  /// **'Tilt'**
  String get tilt;

  /// No description provided for @rotation.
  ///
  /// In en, this message translates to:
  /// **'Rotation'**
  String get rotation;

  /// No description provided for @auto_rotation.
  ///
  /// In en, this message translates to:
  /// **'Auto-Rotation'**
  String get auto_rotation;

  /// No description provided for @on.
  ///
  /// In en, this message translates to:
  /// **'ON'**
  String get on;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'OFF'**
  String get off;

  /// No description provided for @calibrate.
  ///
  /// In en, this message translates to:
  /// **'Reset Position'**
  String get calibrate;

  /// No description provided for @search_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Search varieties and regions...'**
  String get search_placeholder;

  /// No description provided for @wheel_category_desc.
  ///
  /// In en, this message translates to:
  /// **'A main flavor family on the wheel. Tap the middle ring for subgroups or the outer ring for specific notes.'**
  String get wheel_category_desc;

  /// No description provided for @encyclopedia_title.
  ///
  /// In en, this message translates to:
  /// **'Coffee Encyclopedia'**
  String get encyclopedia_title;

  /// No description provided for @legal.
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get legal;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @terms_of_use.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get terms_of_use;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @contact_us.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contact_us;

  /// No description provided for @rate_app.
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get rate_app;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// No description provided for @vibration.
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get vibration;

  /// No description provided for @enable_vibration.
  ///
  /// In en, this message translates to:
  /// **'Haptic Feedback'**
  String get enable_vibration;

  /// No description provided for @haptic_desc.
  ///
  /// In en, this message translates to:
  /// **'Gentle vibration on tap and long press'**
  String get haptic_desc;

  /// No description provided for @my_lots.
  ///
  /// In en, this message translates to:
  /// **'My Lots'**
  String get my_lots;

  /// No description provided for @add_recipe.
  ///
  /// In en, this message translates to:
  /// **'Add Recipe'**
  String get add_recipe;

  /// No description provided for @recipe_limit_reached.
  ///
  /// In en, this message translates to:
  /// **'Maximum 10 recipes per lot reached'**
  String get recipe_limit_reached;

  /// No description provided for @selection_mode.
  ///
  /// In en, this message translates to:
  /// **'Selection Mode'**
  String get selection_mode;

  /// No description provided for @delete_selected.
  ///
  /// In en, this message translates to:
  /// **'Delete Selected'**
  String get delete_selected;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @discard_changes_title.
  ///
  /// In en, this message translates to:
  /// **'Discard Changes?'**
  String get discard_changes_title;

  /// No description provided for @discard_changes_msg.
  ///
  /// In en, this message translates to:
  /// **'You have unsaved changes. Are you sure you want to discard them?'**
  String get discard_changes_msg;

  /// No description provided for @discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @edit_lot.
  ///
  /// In en, this message translates to:
  /// **'Edit Lot'**
  String get edit_lot;

  /// No description provided for @add_lot.
  ///
  /// In en, this message translates to:
  /// **'Add Lot'**
  String get add_lot;

  /// No description provided for @select_roaster.
  ///
  /// In en, this message translates to:
  /// **'Select Roaster'**
  String get select_roaster;

  /// No description provided for @section_roaster.
  ///
  /// In en, this message translates to:
  /// **'Roaster'**
  String get section_roaster;

  /// No description provided for @name_field.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name_field;

  /// No description provided for @coffee_name_field.
  ///
  /// In en, this message translates to:
  /// **'Coffee Name'**
  String get coffee_name_field;

  /// No description provided for @roaster_name_field.
  ///
  /// In en, this message translates to:
  /// **'Roaster Name'**
  String get roaster_name_field;

  /// No description provided for @country_label.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country_label;

  /// No description provided for @city_label.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city_label;

  /// No description provided for @section_coffee_lot.
  ///
  /// In en, this message translates to:
  /// **'Coffee Lot'**
  String get section_coffee_lot;

  /// No description provided for @farmer_field.
  ///
  /// In en, this message translates to:
  /// **'Farmer'**
  String get farmer_field;

  /// No description provided for @wash_station_field.
  ///
  /// In en, this message translates to:
  /// **'Wash Station'**
  String get wash_station_field;

  /// No description provided for @lot_number_field.
  ///
  /// In en, this message translates to:
  /// **'Lot Number'**
  String get lot_number_field;

  /// No description provided for @sca_score_field.
  ///
  /// In en, this message translates to:
  /// **'SCA Score'**
  String get sca_score_field;

  /// No description provided for @sca_score_helper.
  ///
  /// In en, this message translates to:
  /// **'Score between 80 and 100'**
  String get sca_score_helper;

  /// No description provided for @weight_field.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight_field;

  /// No description provided for @section_origin.
  ///
  /// In en, this message translates to:
  /// **'Origin'**
  String get section_origin;

  /// No description provided for @country_field.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country_field;

  /// No description provided for @region_field.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get region_field;

  /// No description provided for @altitude_field.
  ///
  /// In en, this message translates to:
  /// **'Altitude'**
  String get altitude_field;

  /// No description provided for @varietals_field.
  ///
  /// In en, this message translates to:
  /// **'Varietals'**
  String get varietals_field;

  /// No description provided for @section_processing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get section_processing;

  /// No description provided for @section_flavor_notes.
  ///
  /// In en, this message translates to:
  /// **'Flavor Notes'**
  String get section_flavor_notes;

  /// No description provided for @flavor_notes_field.
  ///
  /// In en, this message translates to:
  /// **'Flavor Profile'**
  String get flavor_notes_field;

  /// No description provided for @section_pricing.
  ///
  /// In en, this message translates to:
  /// **'Pricing'**
  String get section_pricing;

  /// No description provided for @retail_250g.
  ///
  /// In en, this message translates to:
  /// **'Retail 250g'**
  String get retail_250g;

  /// No description provided for @retail_1kg.
  ///
  /// In en, this message translates to:
  /// **'Retail 1kg'**
  String get retail_1kg;

  /// No description provided for @wholesale_250g.
  ///
  /// In en, this message translates to:
  /// **'Wholesale 250g'**
  String get wholesale_250g;

  /// No description provided for @wholesale_1kg.
  ///
  /// In en, this message translates to:
  /// **'Wholesale 1kg'**
  String get wholesale_1kg;

  /// No description provided for @save_lot.
  ///
  /// In en, this message translates to:
  /// **'Save Lot'**
  String get save_lot;

  /// No description provided for @save_lot_confirmation_title.
  ///
  /// In en, this message translates to:
  /// **'Save Lot?'**
  String get save_lot_confirmation_title;

  /// No description provided for @save_lot_confirmation_desc.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to save this coffee lot?'**
  String get save_lot_confirmation_desc;

  /// No description provided for @keep_editing.
  ///
  /// In en, this message translates to:
  /// **'Keep Editing'**
  String get keep_editing;

  /// No description provided for @roaster_city.
  ///
  /// In en, this message translates to:
  /// **'Roaster City'**
  String get roaster_city;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'ja',
    'pl',
    'pt',
    'ro',
    'ru',
    'tr',
    'uk',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
