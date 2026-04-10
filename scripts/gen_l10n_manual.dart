// ignore_for_file: avoid_print
import 'dart:io';
import 'dart:convert';

void main() async {
  final arbDir = Directory('lib/l10n');
  final outputFile = File('lib/l10n/app_localizations.dart');

  if (!await arbDir.exists()) {
    print('lib/l10n missing!');
    return;
  }

  final arbFiles = arbDir
      .listSync()
      .where((f) => f.path.endsWith('.arb'))
      .toList();
  if (arbFiles.isEmpty) {
    print('No arb files!');
    return;
  }

  Map<String, Map<String, dynamic>> langs = {};
  for (var f in arbFiles) {
    final name = f.path.split(Platform.pathSeparator).last;
    final lang = name.replaceAll('app_', '').replaceAll('.arb', '');
    final data = json.decode(await (f as File).readAsString());
    langs[lang] = data;
  }

  final keys = langs['en']!.keys.where((k) => !k.startsWith('@')).toList();

  final buffer = StringBuffer();
  buffer.writeln("import 'package:flutter/widgets.dart';");
  buffer.writeln(
    "import 'package:flutter_localizations/flutter_localizations.dart';",
  );
  buffer.writeln("");
  buffer.writeln("abstract class AppLocalizations {");
  buffer.writeln("  AppLocalizations(String locale) : localeName = locale;");
  buffer.writeln("  final String localeName;");
  buffer.writeln("");
  buffer.writeln("  static AppLocalizations of(BuildContext context) {");
  buffer.writeln(
    "    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;",
  );
  buffer.writeln("  }");
  buffer.writeln("");
  buffer.writeln(
    "  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();",
  );
  buffer.writeln(
    "  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate];",
  );
  buffer.writeln(
    "  static const List<Locale> supportedLocales = [${langs.keys.map((l) => "Locale('$l')").join(', ')}];",
  );
  buffer.writeln("");

  for (var k in keys) {
    buffer.writeln("  String get $k;");
  }
  buffer.writeln("}");
  buffer.writeln("");

  for (var entry in langs.entries) {
    final lang = entry.key;
    final className =
        "AppLocalizations${lang[0].toUpperCase()}${lang.substring(1)}";
    buffer.writeln("class $className extends AppLocalizations {");
    buffer.writeln("  $className() : super('$lang');");
    for (var k in keys) {
      final val = (entry.value[k] ?? langs['en']![k] ?? k)
          .toString()
          .replaceAll("'", "\\'")
          .replaceAll("\n", "\\n")
          .replaceAll("\$", "\\\$");
      buffer.writeln("  @override String get $k => '$val';");
    }
    buffer.writeln("}");
    buffer.writeln("");
  }

  buffer.writeln("AppLocalizations lookupAppLocalizations(Locale locale) {");
  buffer.writeln("  switch (locale.languageCode) {");
  for (var l in langs.keys) {
    final className = "AppLocalizations${l[0].toUpperCase()}${l.substring(1)}";
    buffer.writeln("    case '$l': return $className();");
  }
  buffer.writeln("    default: return AppLocalizationsEn();");
  buffer.writeln("  }");
  buffer.writeln("}");
  buffer.writeln("");

  buffer.writeln(
    "class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {",
  );
  buffer.writeln("  const _AppLocalizationsDelegate();");
  buffer.writeln(
    "  @override bool isSupported(Locale locale) => [${langs.keys.map((l) => "'$l'").join(', ')}].contains(locale.languageCode);",
  );
  buffer.writeln(
    "  @override Future<AppLocalizations> load(Locale locale) async => lookupAppLocalizations(locale);",
  );
  buffer.writeln(
    "  @override bool shouldReload(_AppLocalizationsDelegate old) => false;",
  );
  buffer.writeln("}");

  await outputFile.writeAsString(buffer.toString());
  print('Generated ${outputFile.path}');
}
