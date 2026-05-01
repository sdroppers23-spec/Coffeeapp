import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/supabase/supabase_provider.dart';
import 'lots/widgets/lot_card_widgets.dart';
import 'package:go_router/go_router.dart';

final userRoasterLotsProvider = FutureProvider.family<List<CoffeeLotDto>, String>((ref, roasterId) async {
  final db = ref.watch(databaseProvider);
  final userId = ref.watch(currentUserProvider)?.id;
  if (userId == null) return [];
  return db.getLotsByUserRoaster(userId, roasterId);
});

class UserRoasterDetailsScreen extends ConsumerWidget {
  final UserRoasterDto roaster;

  const UserRoasterDetailsScreen({super.key, required this.roaster});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lotsAsync = ref.watch(userRoasterLotsProvider(roaster.id));
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          roaster.name,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1A1A), Color(0xFF0D0D0D)],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 100),
            // Header
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFC8A96E).withAlpha(25),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: const Color(0xFFC8A96E).withAlpha(76),
                  ),
                ),
                child: const Icon(
                  Icons.business_rounded,
                  color: Color(0xFFC8A96E),
                  size: 50,
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (roaster.location != null && roaster.location!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on_rounded, size: 14, color: Colors.white54),
                    const SizedBox(width: 4),
                    Text(
                      roaster.location!,
                      style: GoogleFonts.outfit(color: Colors.white54, fontSize: 14),
                    ),
                  ],
                ),
              ),
            if (roaster.description != null && roaster.description!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                child: Text(
                  roaster.description!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Text(
                    l10n.translate('roaster_lots_title'),
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFC8A96E),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  lotsAsync.when(
                    data: (lots) => Text(
                      lots.length.toString(),
                      style: const TextStyle(color: Colors.white38, fontSize: 14),
                    ),
                    loading: () => const SizedBox(),
                    error: (error, _) => const SizedBox(),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white10, height: 32, indent: 24, endIndent: 24),
            Expanded(
              child: lotsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFC8A96E))),
                error: (error, _) => Center(child: Text(error.toString())),
                data: (lots) {
                  if (lots.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.coffee_rounded, color: Colors.white10, size: 64),
                          const SizedBox(height: 16),
                          Text(
                            l10n.translate('no_lots_linked'),
                            style: GoogleFonts.outfit(color: Colors.white24),
                          ),
                        ],
                      ),
                    );
                  }
                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                      itemCount: lots.length,
                      itemBuilder: (context, i) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: MyLotListCard(
                          lot: lots[i],
                          isSelected: false,
                          isSelectionMode: false,
                          onLongPress: (_) {},
                          onFavoriteToggle: (_) {},
                          onTap: (id) {
                            context.push('/lot_details', extra: {'lot': lots[i]});
                          },
                        ),
                      ),
                    );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
