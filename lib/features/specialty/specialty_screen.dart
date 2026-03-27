import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../shared/widgets/glass_container.dart';
import '../../shared/widgets/skeleton_loader.dart';

final specialtyArticlesProvider = FutureProvider<List<SpecialtyArticle>>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getAllSpecialtyArticles();
});

class SpecialtyEducationScreen extends ConsumerWidget {
  const SpecialtyEducationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncArticles = ref.watch(specialtyArticlesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(ref.t('all_specialty')),
      ),
      body: SafeArea(
        child: asyncArticles.when(
          data: (articles) {
            if (articles.isEmpty) {
              return Center(child: Text(ref.t('no_articles')));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final art = articles[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: GlassContainer(
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                          child: Image.network(
                            art.imageUrl,
                            height: 180,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              height: 180,
                              color: Colors.white10,
                              child: const Icon(Icons.broken_image, color: Colors.white54, size: 50),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.timer_outlined, size: 16, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${art.readTimeMin} ${ref.t('read_time')}',
                                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: 13),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                art.title,
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                art.subtitle,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).colorScheme.primary, // Gold accent
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Html(
                                data: art.contentHtml,
                                style: {
                                  "body": Style(
                                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.9),
                                    fontSize: FontSize(15.0),
                                    lineHeight: LineHeight.number(1.5),
                                    margin: Margins.zero,
                                    padding: HtmlPaddings.zero,
                                  ),
                                  "h3": Style(
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontSize: FontSize(18.0),
                                    margin: Margins.only(top: 10, bottom: 8),
                                  ),
                                  "ul": Style(
                                    margin: Margins.only(top: 0, bottom: 10),
                                    padding: HtmlPaddings.only(left: 20),
                                  ),
                                  "li": Style(
                                    margin: Margins.only(bottom: 6),
                                  ),
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          loading: () => ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 3,
            itemBuilder: (_, __) => const Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: SkeletonLoader(width: double.infinity, height: 350, borderRadius: 24),
            ),
          ),
          error: (e, st) => Center(child: Text('${ref.t('error_loading')}: $e')),
        ),
      ),
    );
  }
}
