import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/settings_provider.dart';

enum DiscoverTabType { farmers, roasters, history, encyclopedia, myLots, debug }

class DiscoveryTabOrderNotifier extends Notifier<List<DiscoverTabType>> {
  static const String _storageKey = 'discovery_tab_order_v1';

  @override
  List<DiscoverTabType> build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final savedOrder = prefs.getStringList(_storageKey);
    
    if (savedOrder != null) {
      try {
        return savedOrder
            .map((e) => DiscoverTabType.values.firstWhere((v) => v.name == e))
            .toList();
      } catch (_) {
        // Fallback to default if enum names changed
      }
    }
    
    return [
      DiscoverTabType.history,
      DiscoverTabType.encyclopedia,
      DiscoverTabType.myLots,
      DiscoverTabType.farmers,
      DiscoverTabType.roasters,
      DiscoverTabType.debug,
    ];
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final List<DiscoverTabType> next = List.from(state);
    final item = next.removeAt(oldIndex);
    next.insert(newIndex, item);
    state = next;
    
    // Persist
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setStringList(_storageKey, state.map((e) => e.name).toList());
  }
}

final discoveryTabOrderProvider =
    NotifierProvider<DiscoveryTabOrderNotifier, List<DiscoverTabType>>(() {
      return DiscoveryTabOrderNotifier();
    });
