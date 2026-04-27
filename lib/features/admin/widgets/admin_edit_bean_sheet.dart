import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drift/drift.dart' as drift;
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/dtos.dart';

class AdminEditBeanSheet extends ConsumerStatefulWidget {
  final LocalizedBeanDto? existingBean;
  const AdminEditBeanSheet({super.key, this.existingBean});

  @override
  ConsumerState<AdminEditBeanSheet> createState() => _AdminEditBeanSheetState();
}

class _AdminEditBeanSheetState extends ConsumerState<AdminEditBeanSheet> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late TextEditingController _countryEmojiCtrl;
  late TextEditingController _countryUkCtrl;
  late TextEditingController _countryEnCtrl;
  late TextEditingController _regionUkCtrl;
  late TextEditingController _regionEnCtrl;
  late TextEditingController _altitudeMinCtrl;
  late TextEditingController _altitudeMaxCtrl;
  late TextEditingController _varietiesUkCtrl;
  late TextEditingController _varietiesEnCtrl;
  late TextEditingController _processMethodUkCtrl;
  late TextEditingController _processMethodEnCtrl;
  late TextEditingController _flavorNotesUkCtrl;
  late TextEditingController _flavorNotesEnCtrl;
  late TextEditingController _descUkCtrl;
  late TextEditingController _descEnCtrl;
  late TextEditingController _roastLevelUkCtrl;
  late TextEditingController _roastLevelEnCtrl;
  late TextEditingController _scaScoreCtrl;
  late TextEditingController _priceCtrl;
  late TextEditingController _lotNumberCtrl;
  late TextEditingController _farmCtrl;
  late TextEditingController _washStationCtrl;
  late TextEditingController _retailPriceCtrl;
  late TextEditingController _wholesalePriceCtrl;
  late TextEditingController _detailedProcessCtrl;
  late TextEditingController _urlCtrl;
  late TextEditingController _plantationPhotosCtrl;

  int? _selectedBrandId;
  int? _selectedFarmerId;
  bool _isPremium = false;
  bool _isDecaf = false;
  bool _isSaving = false;
  bool _isLoadingTr = false;

  @override
  void initState() {
    super.initState();
    final d = widget.existingBean;
    _selectedBrandId = d?.brandId;

    _countryEmojiCtrl = TextEditingController(text: d?.countryEmoji ?? '');
    _altitudeMinCtrl = TextEditingController(
      text: d?.altitudeMin?.toString() ?? '',
    );
    _altitudeMaxCtrl = TextEditingController(
      text: d?.altitudeMax?.toString() ?? '',
    );
    _scaScoreCtrl = TextEditingController(text: d?.scaScore ?? '');
    _priceCtrl = TextEditingController(text: d?.pricing.toString() ?? '{}');

    _lotNumberCtrl = TextEditingController(text: d?.lotNumber ?? '');
    _farmCtrl = TextEditingController(text: d?.farm ?? '');
    _washStationCtrl = TextEditingController(text: d?.washStation ?? '');
    _retailPriceCtrl = TextEditingController(text: d?.retailPrice ?? '');
    _wholesalePriceCtrl = TextEditingController(text: d?.wholesalePrice ?? '');
    _detailedProcessCtrl = TextEditingController(
      text: d?.detailedProcess ?? '',
    );
    _urlCtrl = TextEditingController(text: d?.url ?? '');
    _plantationPhotosCtrl = TextEditingController(
      text: d?.plantationPhotos.toString() ?? '[]',
    );

    _selectedFarmerId = d?.farmerId;
    _isPremium = d?.isPremium ?? false;
    _isDecaf = d?.isDecaf ?? false;

    // Localized fields
    _countryUkCtrl = TextEditingController();
    _countryEnCtrl = TextEditingController();
    _regionUkCtrl = TextEditingController();
    _regionEnCtrl = TextEditingController();
    _varietiesUkCtrl = TextEditingController();
    _varietiesEnCtrl = TextEditingController();
    _processMethodUkCtrl = TextEditingController();
    _processMethodEnCtrl = TextEditingController();
    _flavorNotesUkCtrl = TextEditingController(text: '[]');
    _flavorNotesEnCtrl = TextEditingController(text: '[]');
    _descUkCtrl = TextEditingController();
    _descEnCtrl = TextEditingController();
    _roastLevelUkCtrl = TextEditingController();
    _roastLevelEnCtrl = TextEditingController();
    _countryEnCtrl = TextEditingController();
    _regionUkCtrl = TextEditingController();
    _regionEnCtrl = TextEditingController();
    _varietiesUkCtrl = TextEditingController();
    _varietiesEnCtrl = TextEditingController();
    _processMethodUkCtrl = TextEditingController();
    _processMethodEnCtrl = TextEditingController();
    _flavorNotesUkCtrl = TextEditingController(text: '[]');
    _flavorNotesEnCtrl = TextEditingController(text: '[]');
    _descUkCtrl = TextEditingController();
    _descEnCtrl = TextEditingController();
    _roastLevelUkCtrl = TextEditingController();
    _roastLevelEnCtrl = TextEditingController();

    if (d != null) {
      _loadTranslations(d.id);
    }
  }

  Future<void> _loadTranslations(int beanId) async {
    setState(() => _isLoadingTr = true);
    final db = ref.read(databaseProvider);
    final en = await db.getBeanTranslation(beanId, 'en');
    final uk = await db.getBeanTranslation(beanId, 'uk');

    if (mounted) {
      setState(() {
        if (en != null) {
          _countryEnCtrl.text = en.country ?? '';
          _regionEnCtrl.text = en.region ?? '';
          _varietiesEnCtrl.text = en.varieties ?? '';
          _processMethodEnCtrl.text = en.processMethod ?? '';
          _flavorNotesEnCtrl.text = en.flavorNotes;
          _descEnCtrl.text = en.description ?? '';
          _roastLevelEnCtrl.text = en.roastLevel ?? '';
        }
        if (uk != null) {
          _countryUkCtrl.text = uk.country ?? '';
          _regionUkCtrl.text = uk.region ?? '';
          _varietiesUkCtrl.text = uk.varieties ?? '';
          _processMethodUkCtrl.text = uk.processMethod ?? '';
          _flavorNotesUkCtrl.text = uk.flavorNotes;
          _descUkCtrl.text = uk.description ?? '';
          _roastLevelUkCtrl.text = uk.roastLevel ?? '';
        }
        _isLoadingTr = false;
      });
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    try {
      final db = ref.read(databaseProvider);

      // 1. Save Base Bean
      final beanCompanion = LocalizedBeansCompanion(
        id: widget.existingBean == null
            ? const drift.Value.absent()
            : drift.Value(widget.existingBean!.id),
        brandId: drift.Value(_selectedBrandId),
        farmerId: drift.Value(_selectedFarmerId),
        countryEmoji: drift.Value(_countryEmojiCtrl.text),
        altitudeMin: drift.Value(int.tryParse(_altitudeMinCtrl.text)),
        altitudeMax: drift.Value(int.tryParse(_altitudeMaxCtrl.text)),
        lotNumber: drift.Value(_lotNumberCtrl.text),
        scaScore: drift.Value(_scaScoreCtrl.text),
        isPremium: drift.Value(_isPremium),
        isDecaf: drift.Value(_isDecaf),
        farm: drift.Value(_farmCtrl.text),
        washStation: drift.Value(_washStationCtrl.text),
        retailPrice: drift.Value(_retailPriceCtrl.text),
        wholesalePrice: drift.Value(_wholesalePriceCtrl.text),
        detailedProcessMarkdown: drift.Value(_detailedProcessCtrl.text),
        plantationPhotosUrl: drift.Value(_plantationPhotosCtrl.text),
        url: drift.Value(_urlCtrl.text),
        priceJson: drift.Value(_priceCtrl.text),
        createdAt: drift.Value(DateTime.now()),
      );

      final beanId = await db.insertBean(beanCompanion);

      // 2. Save Translations
      await db.insertBeanTranslation(
        LocalizedBeanTranslationsCompanion(
          beanId: drift.Value(beanId),
          languageCode: const drift.Value('en'),
          country: drift.Value(_countryEnCtrl.text.trim()),
          region: drift.Value(_regionEnCtrl.text.trim()),
          varieties: drift.Value(_varietiesEnCtrl.text.trim()),
          processMethod: drift.Value(_processMethodEnCtrl.text.trim()),
          flavorNotes: drift.Value(_flavorNotesEnCtrl.text.trim()),
          description: drift.Value(_descEnCtrl.text.trim()),
          roastLevel: drift.Value(_roastLevelEnCtrl.text.trim()),
        ),
      );

      await db.insertBeanTranslation(
        LocalizedBeanTranslationsCompanion(
          beanId: drift.Value(beanId),
          languageCode: const drift.Value('uk'),
          country: drift.Value(_countryUkCtrl.text.trim()),
          region: drift.Value(_regionUkCtrl.text.trim()),
          varieties: drift.Value(_varietiesUkCtrl.text.trim()),
          processMethod: drift.Value(_processMethodUkCtrl.text.trim()),
          flavorNotes: drift.Value(_flavorNotesUkCtrl.text.trim()),
          description: drift.Value(_descUkCtrl.text.trim()),
          roastLevel: drift.Value(_roastLevelUkCtrl.text.trim()),
        ),
      );

      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType type = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        maxLines: maxLines,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white54, fontSize: 13),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.05),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFC8A96E)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brandsAsync = ref.watch(allBrandsProvider);
    final farmersAsync = ref.watch(allFarmersProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              widget.existingBean == null
                  ? 'Add Coffee Lot'
                  : 'Edit Coffee Lot',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            if (_isLoadingTr)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(color: Color(0xFFC8A96E)),
                ),
              )
            else
              Expanded(
                child: ListView(
                  children: [
                    // Brand Dropdown
                    brandsAsync.when(
                      data: (brands) => DropdownButtonFormField<int>(
                        initialValue: _selectedBrandId,
                        dropdownColor: const Color(0xFF1E1E1E),
                        decoration: InputDecoration(
                          labelText: 'Roaster (Brand)',
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.05),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: brands
                            .map(
                              (b) => DropdownMenuItem(
                                value: b.id,
                                child: Text(
                                  b.name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => _selectedBrandId = v),
                      ),
                      loading: () => const CircularProgressIndicator(),
                      error: (e, _) => Text('Error loading brands: $e'),
                    ),
                    // Farmer Dropdown
                    farmersAsync.when(
                      data: (farmers) => DropdownButtonFormField<int>(
                        initialValue: _selectedFarmerId,
                        dropdownColor: const Color(0xFF1E1E1E),
                        decoration: InputDecoration(
                          labelText: 'Farmer',
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.05),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: farmers
                            .map(
                              (f) => DropdownMenuItem(
                                value: f.id,
                                child: Text(
                                  f.name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => _selectedFarmerId = v),
                      ),
                      loading: () => const CircularProgressIndicator(),
                      error: (e, _) => Text('Error loading farmers: $e'),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: _buildField(
                            label: 'Emoji',
                            controller: _countryEmojiCtrl,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 3,
                          child: _buildField(
                            label: 'Score SCA',
                            controller: _scaScoreCtrl,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 3,
                          child: _buildField(
                            label: 'Lot #',
                            controller: _lotNumberCtrl,
                          ),
                        ),
                      ],
                    ),

                    SwitchListTile(
                      title: const Text(
                        'Premium Lot',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      value: _isPremium,
                      activeThumbColor: const Color(0xFFC8A96E),
                      onChanged: (v) => setState(() => _isPremium = v),
                    ),
                    SwitchListTile(
                      title: const Text(
                        'Decaf',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      value: _isDecaf,
                      activeThumbColor: const Color(0xFFC8A96E),
                      onChanged: (v) => setState(() => _isDecaf = v),
                    ),

                    ExpansionTile(
                      title: const Text(
                        'Origin (EN / UK)',
                        style: TextStyle(color: Color(0xFFC8A96E)),
                      ),
                      initiallyExpanded: true,
                      children: [
                        _buildField(
                          label: 'Country (EN)',
                          controller: _countryEnCtrl,
                        ),
                        _buildField(
                          label: 'Country (UK)',
                          controller: _countryUkCtrl,
                        ),
                        _buildField(
                          label: 'Region (EN)',
                          controller: _regionEnCtrl,
                        ),
                        _buildField(
                          label: 'Region (UK)',
                          controller: _regionUkCtrl,
                        ),
                      ],
                    ),

                    ExpansionTile(
                      title: const Text(
                        'Specs & Process',
                        style: TextStyle(color: Color(0xFFC8A96E)),
                      ),
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildField(
                                label: 'Min Altitude',
                                controller: _altitudeMinCtrl,
                                type: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildField(
                                label: 'Max Altitude',
                                controller: _altitudeMaxCtrl,
                                type: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        _buildField(
                          label: 'Varieties (EN)',
                          controller: _varietiesEnCtrl,
                        ),
                        _buildField(
                          label: 'Varieties (UK)',
                          controller: _varietiesUkCtrl,
                        ),
                        _buildField(
                          label: 'Process (EN)',
                          controller: _processMethodEnCtrl,
                        ),
                        _buildField(
                          label: 'Process (UK)',
                          controller: _processMethodUkCtrl,
                        ),
                        _buildField(label: 'Farm Name', controller: _farmCtrl),
                        _buildField(
                          label: 'Washing Station',
                          controller: _washStationCtrl,
                        ),
                      ],
                    ),

                    ExpansionTile(
                      title: const Text(
                        'Tasting Notes & Profile',
                        style: TextStyle(color: Color(0xFFC8A96E)),
                      ),
                      children: [
                        _buildField(
                          label: 'Notes (EN) - JSON Array',
                          controller: _flavorNotesEnCtrl,
                        ),
                        _buildField(
                          label: 'Notes (UK) - JSON Array',
                          controller: _flavorNotesUkCtrl,
                        ),
                        _buildField(
                          label: 'Roast (EN)',
                          controller: _roastLevelEnCtrl,
                        ),
                        _buildField(
                          label: 'Roast (UK)',
                          controller: _roastLevelUkCtrl,
                        ),
                        _buildField(
                          label: 'Desc (EN)',
                          controller: _descEnCtrl,
                          maxLines: 3,
                        ),
                        _buildField(
                          label: 'Desc (UK)',
                          controller: _descUkCtrl,
                          maxLines: 3,
                        ),
                        _buildField(
                          label: 'Detailed Process (Markdown)',
                          controller: _detailedProcessCtrl,
                          maxLines: 5,
                        ),
                        _buildField(
                          label: 'External URL',
                          controller: _urlCtrl,
                        ),
                        _buildField(
                          label: 'Plantation Photos (JSON Array)',
                          controller: _plantationPhotosCtrl,
                        ),
                      ],
                    ),

                    ExpansionTile(
                      title: const Text(
                        'Retail Info',
                        style: TextStyle(color: Color(0xFFC8A96E)),
                      ),
                      children: [
                        _buildField(
                          label: 'Price JSON (e.g. {"r250": 450})',
                          controller: _priceCtrl,
                        ),
                        _buildField(
                          label: 'Retail Price (Text)',
                          controller: _retailPriceCtrl,
                        ),
                        _buildField(
                          label: 'Wholesale Price (Text)',
                          controller: _wholesalePriceCtrl,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC8A96E),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isSaving
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text(
                        'Save Coffee',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final allBrandsProvider = FutureProvider<List<LocalizedBrandDto>>((ref) async {
  return ref.watch(databaseProvider).getAllBrands('uk');
});

final allFarmersProvider = FutureProvider<List<LocalizedFarmerDto>>((
  ref,
) async {
  return ref.watch(databaseProvider).getAllFarmers('uk');
});
