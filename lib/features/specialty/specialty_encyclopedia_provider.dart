import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../core/l10n/app_localizations.dart';

import 'specialty_encyclopedia_models.dart';

final currentLanguageProvider = Provider<String>((ref) {
  return ref.watch(localeProvider);
});

final specialtyEncyclopediaProvider = FutureProvider<SpecialtyEncyclopediaRoot>(
  (ref) async {
    try {
      final db = ref.watch(databaseProvider);
      final lang = ref.watch(currentLanguageProvider);

      // Fetch articles and beans for the current language
      final articles = await db.getAllArticles(lang);
      final beans = await db.getAllEncyclopediaEntries(lang);

      // Group into modules for UI compatibility
      final articleModule = SpecialtyModule(
        metadata: SpecialtyModuleMetadata(
          moduleId: 'articles',
          moduleName: ref.t('specialty_articles'),
          totalPartsEstimate: 3,
          currentPart: 1,
        ),
        content: articles
            .map(
              (a) => {
                'id': a.id,
                'image_url': a.imageUrl,
                'read_time': a.readTimeMin,
                'title': a.title,
                'subtitle': '', // Subtitle removed in wide schema migration
                'content_html': a.contentHtml,
              },
            )
            .toList(),
      );

      final beanModule = SpecialtyModule(
        metadata: SpecialtyModuleMetadata(
          moduleId: 'origin_guides',
          moduleName: ref.t('origin_guides'),
          totalPartsEstimate: 2,
          currentPart: 1,
        ),
        content: beans
            .map(
              (b) => {
                'id': b.id,
                'image_url': b.imageUrl,
                'title': b.country,
                'subtitle': b.region,
                'topic': b.country, // Compatibility field
              },
            )
            .toList(),
      );

      return SpecialtyEncyclopediaRoot(modules: [articleModule, beanModule]);
    } catch (e) {
      // Production silent fail
      rethrow;
    }
  },
);

final specialtyArticlesProvider = FutureProvider<List<SpecialtyArticleDto>>((
  ref,
) async {
  final db = ref.watch(databaseProvider);
  final lang = ref.watch(currentLanguageProvider);
  return db.getAllArticles(lang);
});
