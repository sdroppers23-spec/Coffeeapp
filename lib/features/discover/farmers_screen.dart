import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';

final farmersProvider = FutureProvider<List<EncyclopediaEntry>>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getAllOrigins();
});

class FarmersScreen extends ConsumerStatefulWidget {
  const FarmersScreen({super.key});

  @override
  ConsumerState<FarmersScreen> createState() => _FarmersScreenState();
}

class _FarmersScreenState extends ConsumerState<FarmersScreen> {
  String _filterRegion = 'All';
  String _sortMode = 'Score'; // 'Score', 'Name', 'Region'

  @override
  Widget build(BuildContext context) {
    final asyncFarms = ref.watch(farmersProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: asyncFarms.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        data: (entries) {
          // Show all entries, sorted
          var farms = List<EncyclopediaEntry>.from(entries);

          // Apply region filter
          if (_filterRegion != 'All') {
            farms = farms.where((e) => e.region == _filterRegion).toList();
          }

          // Apply sorting
          if (_sortMode == 'Score') {
            farms.sort((a, b) => b.cupsScore.compareTo(a.cupsScore));
          } else if (_sortMode == 'Name') {
            farms.sort((a, b) => a.country.compareTo(b.country));
          } else if (_sortMode == 'Region') {
            farms.sort((a, b) => a.region.compareTo(b.region));
          }

          // Extract unique regions for filter
          final regions = ['All', ...entries.map((e) => e.region).toSet().toList()];

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    children: [
                      // Filter dropdown
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _filterRegion,
                          dropdownColor: const Color(0xFF1E1E1E),
                          decoration: InputDecoration(
                            labelText: 'Регіон',
                            labelStyle: const TextStyle(color: Color(0xFFC8A96E)),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.05),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          items: regions.map((r) => DropdownMenuItem(value: r, child: Text(r, style: const TextStyle(color: Colors.white)))).toList(),
                          onChanged: (val) {
                            if (val != null) setState(() => _filterRegion = val);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Sort dropdown
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _sortMode,
                          dropdownColor: const Color(0xFF1E1E1E),
                          decoration: InputDecoration(
                            labelText: 'Сортування',
                            labelStyle: const TextStyle(color: Color(0xFFC8A96E)),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.05),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          items: ['Score', 'Name', 'Region'].map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(color: Colors.white)))).toList(),
                          onChanged: (val) {
                            if (val != null) setState(() => _sortMode = val);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (farms.isEmpty)
                SliverFillRemaining(
                  child: Center(child: Text('Немає записів', style: TextStyle(color: Colors.white54))),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final farm = farms[index];
                      return _FarmCard(farm: farm);
                    },
                    childCount: farms.length,
                  ),
                ),
            ],
          );
        },
      ),
    ),
    );
  }
}

class _FarmCard extends StatelessWidget {
  final EncyclopediaEntry farm;
  const _FarmCard({required this.farm});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Farm Header Image
          if (farm.farmPhotosUrlCover.isNotEmpty)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                farm.farmPhotosUrlCover,
                height: 160,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 160,
                  color: Colors.black45,
                  child: const Center(child: Icon(Icons.broken_image, color: Colors.white38, size: 40)),
                ),
              ),
            )
          else
            Container(height: 160, decoration: const BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.vertical(top: Radius.circular(16)))),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${farm.countryEmoji} ${farm.country}',
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC8A96E).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFC8A96E)),
                      ),
                      child: Text(
                        '${farm.cupsScore} SCA',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFC8A96E)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 14, color: Colors.white54),
                    const SizedBox(width: 4),
                    Text('${farm.region} • ${farm.altitudeMin}-${farm.altitudeMax}m', style: const TextStyle(color: Colors.white54, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  farm.farmDescription.isNotEmpty
                    ? farm.farmDescription
                    : farm.description,
                  style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
