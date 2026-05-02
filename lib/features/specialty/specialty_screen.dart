import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/skeleton_loader.dart';

import 'specialty_encyclopedia_body_v2.dart';
import 'specialty_encyclopedia_provider.dart';

class SpecialtyEducationScreen extends ConsumerStatefulWidget {
  const SpecialtyEducationScreen({super.key});

  @override
  ConsumerState<SpecialtyEducationScreen> createState() =>
      _SpecialtyEducationScreenState();
}

class _SpecialtyEducationScreenState
    extends ConsumerState<SpecialtyEducationScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final asyncArticles = ref.watch(specialtyArticlesProvider);

    return SafeArea(
      child: asyncArticles.when(
        data: (articles) {
          if (articles.isEmpty) {
            return Center(child: Text(ref.t('no_articles')));
          }
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 120),
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
          itemCount: 6,
          itemBuilder: (_, _) => const Padding(
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
