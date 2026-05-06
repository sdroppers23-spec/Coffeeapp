import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/l10n/app_localizations.dart';
import '../../shared/models/processing_methods_repository.dart';

extension CoffeeEntityLocalization on String {
  /// Localizes a roast level string (e.g., "Light", "Medium-Light").
  String localizeRoast(WidgetRef ref) {
    final key = 'roast_${toLowerCase().replaceAll('-', '_').replaceAll(' ', '_')}';
    return ref.t(key);
  }

  /// Localizes a roast level string using BuildContext.
  String localizeRoastContext(BuildContext context) {
    final key = 'roast_${toLowerCase().replaceAll('-', '_').replaceAll(' ', '_')}';
    return context.t(key);
  }

  /// Localizes a processing method string (e.g., "Washed", "Natural").
  String localizeProcess(WidgetRef ref) {
    final method = ProcessingMethodsRepository.getByMatchingName(this);
    if (method != null) {
      return ref.t(method.nameKey);
    }
    
    // Fallback to key-based lookup if possible
    final key = 'process_${toLowerCase().replaceAll(' ', '_')}';
    final translated = ref.t(key);
    return translated != key ? translated : this;
  }

  /// Localizes a processing method string using BuildContext.
  String localizeProcessContext(BuildContext context) {
    final method = ProcessingMethodsRepository.getByMatchingName(this);
    if (method != null) {
      return context.t(method.nameKey);
    }
    
    final key = 'process_${toLowerCase().replaceAll(' ', '_')}';
    final translated = context.t(key);
    return translated != key ? translated : this;
  }
  
  /// Localizes a grinder name.
  String localizeGrinder(WidgetRef ref) {
    final key = 'grinder_${toLowerCase().replaceAll(' ', '_')}';
    final translated = ref.t(key);
    return translated != key ? translated : this;
  }
}
