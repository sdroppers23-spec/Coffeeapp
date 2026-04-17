import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'specialty_encyclopedia_models.dart';

/// Ukrainian section headers for JSON field keys (single-language UI).
const Map<String, String> kSpecialtySectionTitleUk = {
  'altitude_and_stress': 'ВИСОТА ТА СТРЕС',
  'app_categories': 'КАТЕГОРІЇ ЗАСТОСУНКУ',
  'botanical_context': 'БОТАНІЧНИЙ КОНТЕКСТ',
  'burr_types': 'ТИПИ ЖОРНІВ',
  'carbon_footprint': 'ВУГЛЕЦЬОВИЙ СЛІД',
  'categories': 'КАТЕГОРІЇ',
  'climate_resilient_hybrids': 'КЛІМАТОСТІЙКІ ГІБРИДИ',
  'common_defects': 'ПОШИРЕНІ ДЕФЕКТИ',
  'cup_profile': 'СМАКОВИЙ ПРОФІЛЬ',
  'cupping_parameters': 'ПАРАМЕТРИ КАПІНГУ',
  'definition': 'ВИЗНАЧЕННЯ',
  'elite_varieties': 'ЕЛІТНІ РІЗНОВИДИ',
  'extraction_errors': 'ПОМИЛКИ ЕКСТРАКЦІЇ',
  'extraction_stages': 'ЕТАПИ ЕКСТРАКЦІЇ',
  'farm_management': 'УПРАВЛІННЯ ФЕРМОЮ',
  'flavor_categories': 'КАТЕГОРІЇ СМАКУ',
  'foundational_varieties': 'БАЗОВІ РІЗНОВИДИ',
  'fundamental_attributes': 'ФУНДАМЕНТАЛЬНІ АТРИБУТИ',
  'harvesting_protocols': 'ПРОТОКОЛИ ЗБОРУ',
  'heat_transfer_types': 'ТИПИ ПЕРЕДАЧІ ТЕПЛА',
  'honey_categories': 'КАТЕГОРІЇ HONEY',
  'implementation': 'РЕАЛІЗАЦІЯ',
  'industry_controversy': 'ДИСКУСІЇ В ІНДУСТРІЇ',
  'key_metrics': 'КЛЮЧОВІ МЕТРИКИ',
  'mechanics': 'МЕХАНІКА',
  'methods': 'МЕТОДИ',
  'milk_components': 'КОМПОНЕНТИ МОЛОКА',
  'milling_stages': 'ЕТАПИ ОБРОБКИ ЗЕРНА',
  'models': 'МОДЕЛІ',
  'organizations': 'ОРГАНІЗАЦІЇ',
  'packaging_standards': 'СТАНДАРТИ ПАКУВАННЯ',
  'phases': 'ФАЗИ',
  'pouring_mechanics': 'МЕХАНІКА ПОУРУ',
  'precision_agriculture': 'ТОЧНЕ ЗЕМЛЕРОБСТВО',
  'pressure_profiling': 'ПРОФІЛЮВАННЯ ТИСКУ',
  'process_description': 'ОПИС ПРОЦЕСУ',
  'profiles': 'ПРОФІЛІ',
  'puck_preparation_steps': 'ПІДГОТОВКА ПАЙКА',
  'sca_water_standards': 'СТАНДАРТИ ВОДИ SCA',
  'scoring_system': 'СИСТЕМА ОЦІНЮВАННЯ',
  'sensory_profile': 'СЕНСОРНИЙ ПРОФІЛЬ',
  'shade_grown_canopy': 'ТІНЬОВЕ ВИРОЩУВАННЯ',
  'shipping_risks': 'РИЗИКИ ПЕРЕВЕЗЕННЯ',
  'smart_hardware': 'РОЗУМНЕ ЗАЛІЗО',
  'software_ecosystem': 'ПРОГРАМНА ЕКОСИСТЕМА',
  'soil_chemistry': 'ХІМІЯ ҐРУНТУ',
  'specialty_profiles': 'СПЕШЕЛТІ-ПРОФІЛІ',
  'steps_and_chemistry': 'ЕТАПИ ТА ХІМІЯ',
  'sub_method': 'ПІДМЕТОД',
  'sustainability': 'СТАЛІСТЬ',
  'technical_parameters': 'ТЕХНІЧНІ ПАРАМЕТРИ',
  'terms': 'ТЕРМІНИ',
  'variables': 'ЗМІННІ',
  'water_activity': 'АКТИВНІСТЬ ВОДИ',
};

Color get _copper => const Color(0xFFC8A96E);
Color get _subtitleCopper => const Color(0xFFD4A574);

String sectionTitleForKey(String key) =>
    kSpecialtySectionTitleUk[key] ?? key.replaceAll('_', ' ').toUpperCase();

/// Estimated reading time from text volume (~200 words/min, Ukrainian).
int estimateReadMinutes(Map<String, dynamic> item) {
  final buf = StringBuffer();
  void walk(dynamic v) {
    if (v is String) {
      buf.write(v);
      buf.write(' ');
    } else if (v is Map) {
      v.forEach((_, val) => walk(val));
    } else if (v is List) {
      for (final e in v) {
        walk(e);
      }
    }
  }

  walk(item);
  final words = buf
      .toString()
      .split(RegExp(r'\s+'))
      .where((w) => w.isNotEmpty)
      .length;
  return (words / 200).ceil().clamp(1, 120);
}

List<Widget> buildSpecialtyArticleBody(
  Map<String, dynamic> item, {
  required Color onSurface,
}) {
  final children = <Widget>[];
  for (final entry in item.entries) {
    if (entry.key == 'topic') continue;
    children.add(_SectionHeader(title: sectionTitleForKey(entry.key)));
    children.add(const SizedBox(height: 10));
    children.addAll(_buildValue(entry.value, onSurface: onSurface));
    children.add(const SizedBox(height: 20));
  }
  return children;
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
        color: _copper,
        height: 1.3,
      ),
    );
  }
}

List<Widget> _buildValue(
  dynamic value, {
  required Color onSurface,
  double padBottom = 0,
}) {
  if (value == null) return [const SizedBox.shrink()];
  if (value is String) {
    return [
      Padding(
        padding: EdgeInsets.only(bottom: padBottom),
        child: SelectableText(
          value,
          style: GoogleFonts.outfit(
            fontSize: 15,
            height: 1.55,
            color: onSurface.withValues(alpha: 0.92),
          ),
        ),
      ),
    ];
  }
  if (value is num || value is bool) {
    return [
      Text(
        value.toString(),
        style: GoogleFonts.outfit(
          fontSize: 15,
          color: onSurface.withValues(alpha: 0.9),
        ),
      ),
    ];
  }
  if (value is List) {
    return _buildList(value, onSurface: onSurface);
  }
  if (value is Map) {
    return _buildMap(Map<String, dynamic>.from(value), onSurface: onSurface);
  }
  return [
    Text(
      value.toString(),
      style: GoogleFonts.outfit(
        fontSize: 14,
        color: onSurface.withValues(alpha: 0.7),
      ),
    ),
  ];
}

List<Widget> _buildList(List list, {required Color onSurface}) {
  if (list.isEmpty) return [const SizedBox.shrink()];

  final first = list.first;
  if (first is String) {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final e in list)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '•  ',
                    style: TextStyle(color: _copper, fontSize: 16, height: 1.4),
                  ),
                  Expanded(
                    child: SelectableText(
                      e.toString(),
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        height: 1.55,
                        color: onSurface.withValues(alpha: 0.92),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ];
  }

  if (first is Map) {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final raw in list)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildMapCard(
                Map<String, dynamic>.from(raw as Map),
                onSurface: onSurface,
              ),
            ),
        ],
      ),
    ];
  }

  return [
    for (final e in list) ..._buildValue(e, onSurface: onSurface, padBottom: 8),
  ];
}

Widget _buildMapCard(Map<String, dynamic> map, {required Color onSurface}) {
  if (map.containsKey('attribute') && map.containsKey('details')) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.outfit(
          fontSize: 15,
          height: 1.55,
          color: onSurface.withValues(alpha: 0.92),
        ),
        children: [
          TextSpan(
            text: '${map['attribute']}: ',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          TextSpan(text: map['details']?.toString() ?? ''),
        ],
      ),
    );
  }
  if (map.containsKey('term') && map.containsKey('definition')) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          map['term']?.toString() ?? '',
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: onSurface,
          ),
        ),
        const SizedBox(height: 6),
        SelectableText(
          map['definition']?.toString() ?? '',
          style: GoogleFonts.outfit(
            fontSize: 14,
            height: 1.5,
            color: onSurface.withValues(alpha: 0.85),
          ),
        ),
      ],
    );
  }
  if (map.containsKey('name') &&
      (map.containsKey('recipe') ||
          map.containsKey('role') ||
          map.containsKey('description'))) {
    final body = map['recipe'] ?? map['role'] ?? map['description'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          map['name']?.toString() ?? '',
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: _subtitleCopper,
          ),
        ),
        if (body != null) ...[
          const SizedBox(height: 6),
          SelectableText(
            body.toString(),
            style: GoogleFonts.outfit(
              fontSize: 14,
              height: 1.5,
              color: onSurface.withValues(alpha: 0.88),
            ),
          ),
        ],
        ..._buildRemainingMapEntries(
          map,
          skipKeys: {'name', 'recipe', 'role', 'description'},
          onSurface: onSurface,
        ),
      ],
    );
  }
  if (map.containsKey('category') && map.containsKey('drinks')) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          map['category']?.toString() ?? '',
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: onSurface,
          ),
        ),
        const SizedBox(height: 10),
        ..._buildValue(map['drinks'], onSurface: onSurface),
      ],
    );
  }
  if (map.containsKey('type') && map.containsKey('description')) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.outfit(
          fontSize: 15,
          height: 1.55,
          color: onSurface.withValues(alpha: 0.92),
        ),
        children: [
          TextSpan(
            text: '${map['type']}: ',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          TextSpan(text: map['description']?.toString() ?? ''),
        ],
      ),
    );
  }
  if (map.containsKey('step') && map.containsKey('action')) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          map['step']?.toString() ?? '',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: _copper,
          ),
        ),
        const SizedBox(height: 6),
        SelectableText(
          map['action']?.toString() ?? '',
          style: GoogleFonts.outfit(
            fontSize: 14,
            height: 1.5,
            color: onSurface.withValues(alpha: 0.88),
          ),
        ),
      ],
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: _buildMap(map, onSurface: onSurface),
  );
}

List<Widget> _buildRemainingMapEntries(
  Map<String, dynamic> map, {
  required Set<String> skipKeys,
  required Color onSurface,
}) {
  final out = <Widget>[];
  for (final e in map.entries) {
    if (skipKeys.contains(e.key)) continue;
    out.add(const SizedBox(height: 10));
    out.add(
      Text(
        sectionTitleForKey(e.key),
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: onSurface.withValues(alpha: 0.65),
        ),
      ),
    );
    out.add(const SizedBox(height: 4));
    out.addAll(_buildValue(e.value, onSurface: onSurface));
  }
  return out;
}

List<Widget> _buildMap(Map<String, dynamic> map, {required Color onSurface}) {
  final children = <Widget>[];
  final keys = map.keys.toList()..sort();
  for (final k in keys) {
    final v = map[k];
    if (v is Map) {
      children.add(_SectionHeader(title: sectionTitleForKey(k)));
      children.add(const SizedBox(height: 8));
      children.add(
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildMap(
              Map<String, dynamic>.from(v),
              onSurface: onSurface,
            ),
          ),
        ),
      );
      children.add(const SizedBox(height: 14));
    } else {
      children.add(
        Text(
          sectionTitleForKey(k),
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: onSurface.withValues(alpha: 0.7),
          ),
        ),
      );
      children.add(const SizedBox(height: 6));
      children.addAll(_buildValue(v, onSurface: onSurface));
      children.add(const SizedBox(height: 12));
    }
  }
  return children;
}

/// One scroll block: module part + topic index + article card.
class SpecialtyArticleCard extends StatelessWidget {
  final SpecialtyModule module;
  final int topicIndex;
  final Map<String, dynamic> item;

  const SpecialtyArticleCard({
    super.key,
    required this.module,
    required this.topicIndex,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    final topic = item['topic']?.toString() ?? '';
    final part = module.metadata.currentPart;
    final label = '$part.$topicIndex $topic';
    final minutes = estimateReadMinutes(item);
    final subtitle = module.metadata.moduleName;

    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: isDark 
              ? Colors.white.withValues(alpha: 0.06) 
              : Colors.white,
          border: Border.all(
            color: isDark 
                ? Colors.white.withValues(alpha: 0.08)
                : theme.colorScheme.primary.withValues(alpha: 0.1),
          ),
          boxShadow: isDark ? null : [
            BoxShadow(
              color: theme.colorScheme.primary.withValues(alpha: 0.03),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 17,
                    color: onSurface.withValues(alpha: 0.45),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$minutes хв',
                    style: GoogleFonts.outfit(
                      fontSize: 13,
                      color: onSurface.withValues(alpha: 0.55),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  height: 1.25,
                  color: onSurface,
                ),
              ),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: _subtitleCopper,
                    height: 1.35,
                  ),
                ),
              ],
              const SizedBox(height: 22),
              ...buildSpecialtyArticleBody(item, onSurface: onSurface),
            ],
          ),
        ),
      ),
    );
  }
}
