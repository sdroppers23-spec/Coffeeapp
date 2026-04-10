import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/skeleton_loader.dart';

import 'specialty_encyclopedia_body_v2.dart';
import 'specialty_encyclopedia_provider.dart';

class SpecialtyEducationScreen extends ConsumerWidget {
  const SpecialtyEducationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncArticles = ref.watch(specialtyArticlesProvider);

    return SafeArea(
      child: asyncArticles.when(
        data: (articles) {
          if (articles.isEmpty) {
            return Center(child: Text(ref.t('no_articles')));
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final art = articles[index];
              return SpecialtyArticleCard(
                article: art,
                moduleName: ref.t('education'),
                index: index + 1,
              );
            },
          );
        },
        loading: () => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: 3,
          itemBuilder: (_, __) => const Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: SkeletonLoader(
              width: double.infinity,
              height: 350,
              borderRadius: 24,
            ),
          ),
        ),
        error: (e, st) => Center(child: Text('${ref.t('error_loading')}: $e')),
      ),
    );
  }
}
