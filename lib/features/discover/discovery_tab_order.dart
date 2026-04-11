import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DiscoverTabType { farmers, roasters, history, encyclopedia, myLots }

class DiscoveryTabOrderNotifier extends Notifier<List<DiscoverTabType>> {
  @override
  List<DiscoverTabType> build() {
    return [
      DiscoverTabType.myLots,
      DiscoverTabType.history,
      DiscoverTabType.farmers,
      DiscoverTabType.roasters,
      DiscoverTabType.encyclopedia,
    ];
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final List<DiscoverTabType> next = List.from(state);
    final item = next.removeAt(oldIndex);
    next.insert(newIndex, item);
    state = next;
  }
}

final discoveryTabOrderProvider =
    NotifierProvider<DiscoveryTabOrderNotifier, List<DiscoverTabType>>(() {
      return DiscoveryTabOrderNotifier();
    });
