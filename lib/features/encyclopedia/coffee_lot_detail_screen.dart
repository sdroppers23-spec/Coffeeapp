import 'package:flutter/material.dart';
import '../../core/database/dtos.dart';
import '../../shared/widgets/lot_detail_view.dart';

class CoffeeLotDetailScreen extends StatelessWidget {
  final LocalizedBeanDto entry;
  const CoffeeLotDetailScreen({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return LotDetailView(
      entry: entry,
      heroTag: 'lot_image_${entry.id}',
    );
  }
}
