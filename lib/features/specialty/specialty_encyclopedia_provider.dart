import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import 'specialty_encyclopedia_models.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/database/dtos.dart';

final specialtyEncyclopediaProvider =
    FutureProvider<SpecialtyEncyclopediaRoot>((ref) async {
  try {
    final db = ref.watch(databaseProvider);
    final lang = ref.watch(localeProvider);
    final articles = await db.getAllSpecialtyArticles(lang);

    final modules = articles.map((a) {
      return SpecialtyModule(
        metadata: SpecialtyModuleMetadata(
          moduleId: 'ART-${a.id}',
          moduleName: a.title,
          totalPartsEstimate: 1,
          currentPart: 1,
        ),
        content: [
          {
            'id': a.id,
            'title': a.title,
            'subtitle': a.subtitle,
            'content_html': a.contentHtml,
            'image_url': a.imageUrl,
            'read_time': a.readTimeMin,
          }
        ],
      );
    }).toList();

    return SpecialtyEncyclopediaRoot(modules: modules);
  } catch (e, stack) {
    debugPrint('Error in specialtyEncyclopediaProvider: $e\n$stack');
    rethrow;
  }
});

final specialtyArticlesProvider =
    FutureProvider<List<SpecialtyArticleDto>>((ref) async {
  try {
    final db = ref.watch(databaseProvider);
    final lang = ref.watch(localeProvider);
    final articles = await db.getAllSpecialtyArticles(lang);
    debugPrint(
        'SpecialtyArticlesProvider: Fetched ${articles.length} articles from DB');
    return articles;
  } catch (e, stack) {
    debugPrint('Error in specialtyArticlesProvider: $e\n$stack');
    rethrow;
  }
});
