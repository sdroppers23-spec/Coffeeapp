import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' show Value;
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/dtos.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../shared/widgets/glass_container.dart';
import 'discovery_providers.dart' show brandsProvider;
import '../navigation/navigation_providers.dart';
import 'widgets/conflict_dialog.dart';

class AddRoasterScreen extends ConsumerStatefulWidget {
  const AddRoasterScreen({super.key});

  @override
  ConsumerState<AddRoasterScreen> createState() => _AddRoasterScreenState();
}

class _AddRoasterScreenState extends ConsumerState<AddRoasterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _shortDescController = TextEditingController();
  final _fullDescController = TextEditingController();
  final _logoUrlController = TextEditingController();

  File? _logoFile;
  String? _urlError;
  List<CoffeeLotDto> _allUserLots = [];
  final Set<String> _selectedLotIds = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLots();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _shortDescController.dispose();
    _fullDescController.dispose();
    _logoUrlController.dispose();
    super.dispose();
  }

  Future<void> _loadLots() async {
    final db = ref.read(databaseProvider);
    // Assuming userId is 'me' for now as per current app logic
    final lots = await db.getUserLots('me');
    setState(() {
      _allUserLots = lots.where((l) => l.brandId == null).toList();
      _isLoading = false;
    });
  }

  Future<void> _pickLogo() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png'],
    );

    if (result != null && result.files.single.path != null) {
      final localContext = context;
      final file = File(result.files.single.path!);
      final size = await file.length();

      if (!file.path.toLowerCase().endsWith('.png')) {
        if (localContext.mounted) {
          ScaffoldMessenger.of(localContext).showSnackBar(
            SnackBar(
              content: Text(
                ref.t('invalid_file_format'),
              ),
            ),
          );
        }
        return;
      }

      if (size > 5 * 1024 * 1024) {
        if (localContext.mounted) {
          ScaffoldMessenger.of(localContext).showSnackBar(
            SnackBar(
              content: Text(
                ref.t('file_too_large'),
              ),
            ),
          );
        }
        return;
      }

      setState(() {
        _logoFile = file;
        _logoUrlController.clear();
      });
    }
  }

  Future<void> _handleSave(bool isCopy) async {
    if (!_formKey.currentState!.validate()) return;

    final localContext = context;
    final db = ref.read(databaseProvider);

    // 1. Create Roaster
    final roasterId = await db.insertBrand(
      LocalizedBrandsCompanion.insert(
        name: _nameController.text,
        userId: const Value('me'),
        logoUrl: Value(_logoFile?.path ?? _logoUrlController.text),
      ),
    );

    await db.insertBrandTranslation(
      LocalizedBrandTranslationsCompanion.insert(
        brandId: roasterId,
        languageCode: 'uk',
        shortDesc: Value(_shortDescController.text),
        fullDesc: Value(_fullDescController.text),
      ),
    );

    // 2. Handle Lots
    final selectedLots = _allUserLots
        .where((l) => _selectedLotIds.contains(l.id))
        .toList();
    final List<CoffeeLotDto> affectedLots = [];
    final List<CoffeeLotDto> originalLotsState = [];

    for (var lot in selectedLots) {
      // Check for conflicts
      final conflict = await db.findConflictLot(lot.id);

      CoffeeLotDto lotToProcess = lot;
      bool skip = false;

      if (conflict != null) {
        if (!localContext.mounted) continue;
        final result = await showDialog<ConflictResult>(
          context: localContext,
          barrierDismissible: false,
          builder: (_) => ConflictDialog(lotName: lot.coffeeName ?? ''),
        );
        if (!localContext.mounted) continue;

        switch (result) {
          case ConflictResult.replace:
            // Use conflict ID to overwrite
            lotToProcess = lot.copyWith(
              id: conflict.id,
              brandId: roasterId,
              roasteryName: _nameController.text,
              updatedAt: DateTime.now(),
            );
            originalLotsState.add(conflict); // Keep original to undo replace
            break;

          case ConflictResult.copyRestart:
            // Add suffix and create new
            lotToProcess = lot.copyWith(
              id: const Uuid().v4(),
              coffeeName: ref.t('copy_name_template', args: {'name': lot.coffeeName ?? ''}),
              brandId: roasterId,
              roasteryName: _nameController.text,
              createdAt: DateTime.now(),
            );
            break;

          case ConflictResult.cancel:
          default:
            skip = true;
            break;
        }
      }

      if (skip) continue;

      if (isCopy || (conflict != null && lotToProcess.id != lot.id)) {
        // Copy logic or Replace logic (which is basically an insert/replace with same ID)
        await db.upsertUserLot(
          CoffeeLotsCompanion.insert(
            id: lotToProcess.id,
            userId: lotToProcess.userId ?? 'me',
            roasteryName: Value(lotToProcess.roasteryName),
            coffeeName: Value(lotToProcess.coffeeName),
            originCountry: Value(lotToProcess.originCountry),
            sensoryJson: const Value('{}'),
            priceJson: const Value('{}'),
          ),
        );
        affectedLots.add(lotToProcess);
      } else {
        // Simple Move logic
        originalLotsState.add(lot);
        final updatedLot = lot.copyWith(
          brandId: roasterId,
          roasteryName: _nameController.text,
          updatedAt: DateTime.now(),
        );

        await db.upsertUserLot(
          CoffeeLotsCompanion.insert(
            id: updatedLot.id,
            userId: updatedLot.userId ?? 'me',
            roasteryName: Value(updatedLot.roasteryName),
            coffeeName: Value(updatedLot.coffeeName),
            originCountry: Value(updatedLot.originCountry),
            sensoryJson: const Value('{}'),
            priceJson: const Value('{}'),
          ),
        );
        affectedLots.add(updatedLot);
      }
    }

    if (localContext.mounted) {
      ScaffoldMessenger.of(localContext).showSnackBar(
        SnackBar(
          content: Text(
            isCopy
                ? ref.t('lot_copied')
                : ref.t('lot_moved'),
          ),
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: ref.t('waiter_undo'),
            onPressed: () async {
              // Undo logic
              for (var lot in affectedLots) {
                if (isCopy) {
                  await db.deleteLotPermanently(lot.id);
                } else {
                  final original = originalLotsState.firstWhere(
                    (o) => o.id == lot.id,
                  );
                  await db.upsertUserLot(
                    CoffeeLotsCompanion.insert(
                      id: original.id,
                      userId: original.userId ?? 'me',
                      roasteryName: Value(original.roasteryName),
                      coffeeName: Value(original.coffeeName),
                      originCountry: Value(original.originCountry),
                      sensoryJson: const Value('{}'),
                      priceJson: const Value('{}'),
                    ),
                  );
                }
              }
              ref.invalidate(brandsProvider);
              _loadLots();
            },
          ),
        ),
      );
      Navigator.pop(localContext);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF0F172A),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFC8A96E)),
        ),
      );
    }

    final navHeight = ref.watch(navBarHeightProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            _buildAppBar(),
            SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        _buildGeneralInfoSection(),
                        const SizedBox(height: 32),
                        _buildDescriptionSection(),
                        const SizedBox(height: 32),
                        _buildLogoSection(),
                        const SizedBox(height: 40),
                        _buildLotsSection(),
                        const SizedBox(height: 48),
                        _buildActionButtons(),
                        SizedBox(height: navHeight + 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    String label,
    TextEditingController controller,
    IconData icon, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ),
        GlassContainer(
          opacity: 0.05,
          borderRadius: 16,
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            style: GoogleFonts.outfit(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: const Color(0xFFC8A96E), size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              isDense: true,
            ),
            validator: (v) => v == null || v.isEmpty ? ref.t('required_error') : null,
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      backgroundColor: const Color(0xFF0F172A),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          ref.t('add_roaster'),
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFFC8A96E).withValues(alpha: 0.1),
                const Color(0xFF0F172A),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGeneralInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(ref.t('general_info')),
        const SizedBox(height: 16),
        _buildSection(
          ref.t('roaster_name_label'),
          _nameController,
          Icons.business_rounded,
        ),
        const SizedBox(height: 16),
        _buildSection(
          ref.t('city_label'),
          _locationController,
          Icons.location_on_rounded,
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(ref.t('description')),
        const SizedBox(height: 16),
        _buildSection(
          ref.t('short_desc_label'),
          _shortDescController,
          Icons.short_text_rounded,
        ),
        const SizedBox(height: 16),
        _buildSection(
          ref.t('full_desc_label'),
          _fullDescController,
          Icons.notes_rounded,
          maxLines: 4,
        ),
      ],
    );
  }

  Widget _buildLogoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(ref.t('roastery_logo')),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: GlassContainer(
                opacity: 0.05,
                borderRadius: 16,
                child: StatefulBuilder(
                  builder: (context, setFieldState) {
                    return TextFormField(
                      controller: _logoUrlController,
                      style: GoogleFonts.outfit(color: Colors.white, fontSize: 14),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          String url = value.trim();
                          if (!url.startsWith('http://') && !url.startsWith('https://')) {
                            url = 'https://$url';
                            _logoUrlController.value = TextEditingValue(
                              text: url,
                              selection: TextSelection.collapsed(offset: url.length),
                            );
                          }
                          
                          final urlRegExp = RegExp(
                            r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
                          );
                          
                          if (!urlRegExp.hasMatch(url)) {
                            setFieldState(() {
                              _urlError = ref.t('invalid_url_format');
                            });
                          } else {
                            setFieldState(() {
                              _urlError = null;
                            });
                          }
                        } else {
                          setFieldState(() {
                            _urlError = null;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        hintText: ref.t('roastery_logo_hint'),
                        hintStyle: const TextStyle(color: Colors.white24),
                        errorText: _urlError,
                        errorStyle: GoogleFonts.outfit(color: Colors.redAccent, fontSize: 11),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    );
                  }
                ),
              ),
            ),
            const SizedBox(width: 12),
            _buildLogoPicker(),
          ],
        ),
      ],
    );
  }

  Widget _buildLotsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(ref.t('select_lots')),
        const SizedBox(height: 16),
        ..._allUserLots.map((lot) => _buildLotItem(lot)),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC8A96E),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
            ),
            onPressed: () => _handleSave(false),
            child: Text(
              ref.t('migrate_lots'),
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFC8A96E),
              side: const BorderSide(color: Color(0xFFC8A96E), width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () => _handleSave(true),
            child: Text(
              ref.t('copy_lots'),
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildLogoPicker() {
    return GestureDetector(
      onTap: _pickLogo,
      child: Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
          color: _logoFile != null
              ? const Color(0xFFC8A96E)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _logoFile != null
                ? Colors.transparent
                : Colors.white.withValues(alpha: 0.1),
          ),
        ),
        child: Icon(
          _logoFile != null
              ? Icons.check_rounded
              : Icons.add_photo_alternate_outlined,
          color: _logoFile != null ? Colors.black : const Color(0xFFC8A96E),
        ),
      ),
    );
  }

  Widget _buildLotItem(CoffeeLotDto lot) {
    final isSelected = _selectedLotIds.contains(lot.id);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (isSelected) {
              _selectedLotIds.remove(lot.id);
            } else {
              _selectedLotIds.add(lot.id);
            }
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFC8A96E).withValues(alpha: 0.1)
                : Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFFC8A96E)
                  : Colors.white.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    (lot.originCountry?.isNotEmpty == true)
                        ? lot.originCountry!.substring(0, 1)
                        : '?',
                    style: const TextStyle(
                      color: Color(0xFFC8A96E),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lot.coffeeName ?? ref.t('unknown_lot'),
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      lot.originCountry ?? ref.t('origin_unknown'),
                      style: GoogleFonts.outfit(
                        color: Colors.white38,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Checkbox(
                value: isSelected,
                onChanged: (_) {
                  setState(() {
                    if (isSelected) {
                      _selectedLotIds.remove(lot.id);
                    } else {
                      _selectedLotIds.add(lot.id);
                    }
                  });
                },
                activeColor: const Color(0xFFC8A96E),
                checkColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
