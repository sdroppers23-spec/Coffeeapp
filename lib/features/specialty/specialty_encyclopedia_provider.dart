import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';

import 'specialty_encyclopedia_models.dart';

final currentLanguageProvider = Provider<String>((ref) {
  // Logic to get the current language code (e.g., 'uk', 'en')
  // For now defaulting to 'uk' as seen in seeding
  return 'uk';
});

final specialtyEncyclopediaProvider = FutureProvider<SpecialtyEncyclopediaRoot>(
  (ref) async {
    try {
      final db = ref.watch(databaseProvider);
      final lang = ref.watch(currentLanguageProvider);

      // Fetch articles and beans for the current language
      final articles = await db.getAllSpecialtyArticles(lang);
      final beans = await db.getAllEncyclopediaEntries(lang);

      // Group into modules for UI compatibility
      final articleModule = SpecialtyModule(
        metadata: const SpecialtyModuleMetadata(
          moduleId: 'articles',
          moduleName: 'Specialty Articles',
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
                'subtitle': a.subtitle,
                'content_html': a.contentHtml,
              },
            )
            .toList(),
      );

      final beanModule = SpecialtyModule(
        metadata: const SpecialtyModuleMetadata(
          moduleId: 'origin_guides',
          moduleName: 'Origin Guides',
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
    } catch (e, stack) {
      debugPrint('Error in specialtyEncyclopediaProvider (DB): $e\n$stack');
      rethrow;
    }
  },
);

final specialtyArticlesProvider = FutureProvider<List<SpecialtyArticleDto>>((
  ref,
) async {
  final db = ref.watch(databaseProvider);
  final lang = ref.watch(currentLanguageProvider);
  return db.getAllSpecialtyArticles(lang);
});
