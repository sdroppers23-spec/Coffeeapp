import json
import os
import glob

def generate_localizations():
    arb_dir = 'lib/l10n'
    output_file = 'lib/l10n/app_localizations.dart'
    
    arb_files = glob.glob(os.path.join(arb_dir, 'app_*.arb'))
    if not arb_files:
        print("No ARB files found!")
        return

    # Load all languages
    langs = {}
    for f_path in arb_files:
        lang_code = os.path.basename(f_path).replace('app_', '').replace('.arb', '')
        with open(f_path, 'r', encoding='utf-8') as f:
            langs[lang_code] = json.load(f)

    # Use 'en' as template for keys
    if 'en' not in langs:
        print("English ARB missing!")
        return
    
    template_data = langs['en']
    keys = [k for k in template_data.keys() if not k.startswith('@')]
    
    content = [
        "import 'package:flutter/widgets.dart';",
        "import 'package:flutter_localizations/flutter_localizations.dart';",
        "",
        "abstract class AppLocalizations {",
        "  AppLocalizations(String locale) : localeName = locale;",
        "  final String localeName;",
        "  static AppLocalizations? of(BuildContext context) => Localizations.of<AppLocalizations>(context, AppLocalizations);",
        "",
        "  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();",
        "  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate];",
        f"  static const List<Locale> supportedLocales = { [f'Locale(\"{l}\")' for l in sorted(langs.keys())] };".replace("'", ""),
        ""
    ]
    
    for key in keys:
        content.append(f"  String get {key};")
    
    content.append("}")
    content.append("")
    
    # Generate implementation classes
    for lang, data in langs.items():
        class_name = f"AppLocalizations{lang.capitalize() if len(lang) == 2 else lang.upper()}"
        content.append(f"class {class_name} extends AppLocalizations {{")
        content.append(f"  {class_name}() : super('{lang}');")
        for key in keys:
            val = data.get(key, template_data.get(key, key)).replace("'", "\\'").replace("\n", "\\n").replace("$", "\\$")
            content.append(f"  @override String get {key} => '{val}';")
        content.append("}")
        content.append("")
    
    # Lookup Function
    content.append("AppLocalizations lookupAppLocalizations(Locale locale) {")
    content.append("  switch (locale.languageCode) {")
    for lang in sorted(langs.keys()):
        class_name = f"AppLocalizations{lang.capitalize() if len(lang) == 2 else lang.upper()}"
        content.append(f"    case '{lang}': return {class_name}();")
    content.append("    default: return AppLocalizationsEn();")
    content.append("  }")
    content.append("}")
    content.append("")
    
    # Delegate
    supported_langs_list = str(list(sorted(langs.keys())))
    content.append("class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {")
    content.append("  const _AppLocalizationsDelegate();")
    content.append(f"  @override bool isSupported(Locale locale) => {supported_langs_list}.contains(locale.languageCode);")
    content.append("  @override Future<AppLocalizations> load(Locale locale) async => lookupAppLocalizations(locale);")
    content.append("  @override bool shouldReload(_AppLocalizationsDelegate old) => false;")
    content.append("}")

    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("\n".join(content))
    print(f"Generated {output_file} with {len(langs)} languages")

if __name__ == "__main__":
    generate_localizations()

if __name__ == "__main__":
    generate_localizations()
