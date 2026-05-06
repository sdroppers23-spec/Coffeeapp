import 'dart:async';
import 'dart:ui';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:google_fonts/google_fonts.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/providers/settings_provider.dart';
import '../../../shared/widgets/sync_indicator.dart';
import '../../../shared/widgets/pressable_scale.dart';
import '../../navigation/navigation_providers.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/dtos.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/utils/local_file_manager.dart';
import 'lots_providers.dart';
import 'providers/roaster_providers.dart';
import '../../../shared/models/processing_methods_repository.dart';
import '../../../shared/widgets/sensory_radar_chart.dart';
import '../../../shared/services/toast_service.dart';
import '../../../core/providers/preferences_provider.dart';
import '../../../shared/utils/coffee_input_formatters.dart';
import '../../../shared/widgets/glass_container.dart';

import 'widgets/add_lot/roaster_selector_sheet.dart';

part 'widgets/add_lot/lot_roastery_tab.dart';
part 'widgets/add_lot/lot_coffee_tab.dart';
part 'widgets/add_lot/flavor_notes_selector.dart';
part 'widgets/add_lot/processing_method_selector.dart';

class AddLotScreen extends ConsumerStatefulWidget {
  final CoffeeLotDto? initialLot;
  final bool openAsAdd;

  const AddLotScreen({super.key, this.initialLot, this.openAsAdd = false});

  @override
  ConsumerState<AddLotScreen> createState() => _AddLotScreenState();
}

enum _FieldType { text, numeric, scaScore, weight, altitude, lotNumber }

class _AddLotScreenState extends ConsumerState<AddLotScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  void updateState(VoidCallback fn) {
    setState(() {
      fn();
      _isDirty = true;
    });
  }

  // ─── Form State ───────────────────────────────────────────────────
  bool _isDirty = false;
  void _markDirty() {
    if (!_isDirty) setState(() => _isDirty = true);
  }

  bool _isDecaf = false;
  String _decafProcess = 'Sugar Cane';
  String _roastLevel = 'Medium';
  DateTime? _roastDate;
  DateTime? _openedAt;
  bool _isOpen = false;
  bool _isGround = false;
  bool _isFavorite = false;
  bool _isArchived = false;
  String? _userRoasterId;

  // New State for Images
  Uint8List? _imageBytes;
  String? _imageExtension;
  String? _currentImageUrl;

  final List<String> _processingMethods = [
    'Washed',
    'Natural',
    'Honey',
    'Wet Hulled',
    'Anaerobic',
    'Carbonic Maceration',
    'Lactic',
    'Thermal Shock',
    'Yeast Inoculation',
    'Koji Fermentation',
    'Other',
  ];

  final List<String> _decafMethods = [
    'Sugar Cane',
    'Swiss Water',
    'CO2',
    'Mountain Water',
    'Other',
  ];

  final List<String> _roastLevels = [
    'Light',
    'Medium-Light',
    'Medium',
    'Medium-Dark',
    'Dark',
    'Filter',
    'Omni',
    'Espresso',
  ];

  String? _selectedProcess;
  bool _isOtherProcess = false;
  bool _isOtherDecaf = false;
  bool _isSensoryLocked = true; // Default to locked if using presets

  @override
  void dispose() {
    _tabController.dispose();
    _roasteryController.dispose();
    _roasteryCountryController.dispose();
    _roasteryLocationController.dispose();
    _varietiesController.dispose();
    _farmerController.dispose();
    _washStationController.dispose();
    _processController.dispose();
    _flavorProfileController.dispose();
    _scaScoreController.dispose();
    _lotNumberController.dispose();
    _weightController.dispose();
    _priceController.dispose();
    _retailPrice1kController.dispose();
    _wholesalePrice250Controller.dispose();
    _wholesalePrice1kController.dispose();
    _decafProcessController.dispose();

    // Ensure navbar is visible when leaving this screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(navBarVisibleProvider.notifier).show();
    });
    super.dispose();
  }

  // Controllers to prevent cursor jumps and fix focus
  late final TextEditingController _roasteryController;
  late final TextEditingController _roasteryCountryController;
  late final TextEditingController _roasteryLocationController;
  late final TextEditingController _coffeeNameController;
  late final TextEditingController _originCountryController;
  late final TextEditingController _regionController;
  late final TextEditingController _altitudeController;
  late final TextEditingController _varietiesController;
  late final TextEditingController _farmerController;
  late final TextEditingController _washStationController;
  late final TextEditingController _processController;
  late final TextEditingController _flavorProfileController;
  late final TextEditingController _scaScoreController;
  late final TextEditingController _lotNumberController;
  late final TextEditingController _weightController;
  late final TextEditingController _priceController;
  late final TextEditingController _retailPrice1kController;
  late final TextEditingController _wholesalePrice250Controller;
  late final TextEditingController _wholesalePrice1kController;
  late final TextEditingController _decafProcessController;

  // ─── Sensory (1-5) ────────────────────────────────────────────────
  double _bitterness = 3;
  double _acidity = 3;
  double _sweetness = 3;
  double _body = 3;
  double _intensity = 3;
  double _aftertaste = 3;

  // ─── Lifecycle ────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) ref.read(navBarVisibleProvider.notifier).hide();
    });
    _tabController = TabController(length: 3, vsync: this);

    _userRoasterId = widget.initialLot?.userRoasterId;

    _roasteryController = TextEditingController(
      text: widget.initialLot?.roasteryName ?? '',
    );
    _roasteryCountryController = TextEditingController(
      text: widget.initialLot?.roasteryCountry ?? '',
    );
    _roasteryLocationController = TextEditingController(
      text: widget.initialLot?.roasteryCity ?? '',
    );
    _coffeeNameController = TextEditingController(
      text: widget.initialLot?.coffeeName ?? '',
    );
    _originCountryController = TextEditingController(
      text: widget.initialLot?.originCountry ?? '',
    );
    _regionController = TextEditingController(
      text: widget.initialLot?.region ?? '',
    );

    // Altitude conversion for display
    final pref = ref.read(preferencesProvider);
    String altitudeStr = widget.initialLot?.altitude ?? '';
    if (altitudeStr.isNotEmpty && pref.lengthUnit == LengthUnit.feet) {
      final double? m = double.tryParse(altitudeStr);
      if (m != null) {
        altitudeStr = (m * 3.28084).toStringAsFixed(0);
      }
    }
    _altitudeController = TextEditingController(text: altitudeStr);
    _varietiesController = TextEditingController(
      text: widget.initialLot?.varieties ?? '',
    );
    _farmerController = TextEditingController(
      text: widget.initialLot?.farmer ?? '',
    );
    _washStationController = TextEditingController(
      text: widget.initialLot?.washStation ?? '',
    );
    _processController = TextEditingController(
      text: widget.initialLot?.process ?? '',
    );
    _flavorProfileController = TextEditingController(
      text: widget.initialLot?.flavorProfile ?? '',
    );
    _scaScoreController = TextEditingController(
      text: widget.openAsAdd ? '' : (widget.initialLot?.scaScore ?? ''),
    );
    _lotNumberController = TextEditingController(
      text: widget.initialLot?.lotNumber ?? '',
    );
    _weightController = TextEditingController(
      text: widget.openAsAdd ? '' : (widget.initialLot?.weight ?? ''),
    );

    // Initial controllers are set based on widget.initialLot in initState

    final pricing = widget.initialLot?.pricing ?? {};
    _priceController = TextEditingController(
      text: pricing['retail_250']?.toString() ?? '',
    );
    _retailPrice1kController = TextEditingController(
      text: pricing['retail_1k']?.toString() ?? '',
    );
    _wholesalePrice250Controller = TextEditingController(
      text: pricing['wholesale_250']?.toString() ?? '',
    );
    _wholesalePrice1kController = TextEditingController(
      text: pricing['wholesale_1k']?.toString() ?? '',
    );
    _decafProcessController = TextEditingController();

    if (widget.initialLot != null) {
      _currentImageUrl = widget.initialLot!.imageUrl;
      _populateFields(widget.initialLot!);
    }

    _roasteryController.addListener(_markDirty);
    _roasteryCountryController.addListener(_markDirty);
    _roasteryLocationController.addListener(_markDirty);
    _coffeeNameController.addListener(_markDirty);
    _originCountryController.addListener(_markDirty);
    _regionController.addListener(_markDirty);
    _altitudeController.addListener(_markDirty);
    _varietiesController.addListener(_markDirty);
    _farmerController.addListener(_markDirty);
    _washStationController.addListener(_markDirty);
    _processController.addListener(_markDirty);
    _flavorProfileController.addListener(_markDirty);
    _scaScoreController.addListener(_markDirty);
    _lotNumberController.addListener(_markDirty);
    _weightController.addListener(_markDirty);
    _priceController.addListener(_markDirty);
    _retailPrice1kController.addListener(_markDirty);
    _wholesalePrice250Controller.addListener(_markDirty);
    _wholesalePrice1kController.addListener(_markDirty);
    _decafProcessController.addListener(_markDirty);
  }

  void _populateFields(CoffeeLotDto lot) {
    setState(() {
      _populateProcess(lot);

      _roastLevel = lot.roastLevel ?? 'Medium';
      _roastDate = lot.roastDate;
      _openedAt = lot.openedAt;
      _isOpen = lot.isOpen;
      _isGround = lot.isGround;
      _isFavorite = lot.isFavorite;
      _isArchived = lot.isArchived;

      final sensory = lot.sensoryPoints;
      if (sensory.isNotEmpty) {
        _bitterness = (sensory['bitterness'] ?? sensory['aroma'] ?? 3)
            .toDouble();
        _acidity = (sensory['acidity'] ?? 3).toDouble();
        _sweetness = (sensory['sweetness'] ?? sensory['flavor'] ?? 3)
            .toDouble();
        _body = (sensory['body'] ?? 3).toDouble();
        _intensity = (sensory['intensity'] ?? sensory['balance'] ?? 3)
            .toDouble();
        _aftertaste = (sensory['aftertaste'] ?? 3).toDouble();
      }
    });
  }

  void _populateProcess(CoffeeLotDto lot) {
    String process = lot.process ?? '';
    _isDecaf = lot.isDecaf == true;

    if (_isDecaf && process.contains('(')) {
      final parts = process.split('(');
      process = parts[0].trim();
      _decafProcess = parts[1].replaceAll(')', '').trim();
      _decafProcessController.text = _decafProcess;
    }

    if (_processingMethods.contains(process)) {
      _selectedProcess = process;
      _isOtherProcess = false;
    } else if (process.isNotEmpty) {
      _selectedProcess = 'Other';
      _isOtherProcess = true;
      _processController.text = process;
    } else {
      _selectedProcess = 'Washed';
      _isOtherProcess = false;
    }

    if (_isDecaf) {
      if (!_decafMethods.contains(_decafProcess)) {
        _isOtherDecaf = true;
        _decafProcessController.text = _decafProcess;
      } else {
        _isOtherDecaf = _decafProcess == 'Other';
        if (_isOtherDecaf) _decafProcessController.text = '';
      }
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1600,
        maxHeight: 1600,
        imageQuality: 85,
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        if (bytes.length > 5 * 1024 * 1024) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(ref.t('error_image_too_large'))),
            );
          }
          return;
        }

        updateState(() {
          _imageBytes = bytes;
          _imageExtension = image.name.split('.').last.toLowerCase();
          _currentImageUrl = null; // New image replaces old one
        });
      }
    } catch (e) {
      // Production silent fail
    }
  }

  bool get _canSave =>
      _coffeeNameController.text.trim().isNotEmpty &&
      _originCountryController.text.trim().isNotEmpty;

  void _showRoasterPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RoasterSelectorSheet(
        onSelected: (roaster) {
          if (roaster != null) {
            updateState(() {
              _userRoasterId = roaster.id;
              _roasteryController.text = roaster.name;
              _roasteryCountryController.text = roaster.country ?? '';
              final city = roaster.location ?? '';
              final country = roaster.country ?? '';
              _roasteryLocationController.text = [
                city,
                country,
              ].where((s) => s.isNotEmpty).join(', ');
            });
          } else {
            // "Clear" selection
            updateState(() {
              _userRoasterId = null;
              _roasteryController.clear();
              _roasteryCountryController.clear();
              _roasteryLocationController.clear();
            });
          }
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<void> _saveLot() async {
    if (!_canSave) return;

    _isDirty = false; // Prevents discard dialog on success

    final user = Supabase.instance.client.auth.currentUser;
    final userId = user?.id ?? 'guest';

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: Color(0xFFC8A96E)),
      ),
    );

    final db = ref.read(databaseProvider);
    final lotId = widget.initialLot?.id ?? const Uuid().v4();

    String finalImageUrl = _currentImageUrl ?? '';

    try {
      // 1. Handle Image saving to Local Storage if new image selected
      if (_imageBytes != null && _imageExtension != null) {
        try {
          final localPath = await LocalFileManager.saveImageLocal(
            _imageBytes!,
            extension: '.$_imageExtension',
          );
          finalImageUrl = localPath;

          if (mounted) {
            ToastService.showSuccess(
              context,
              ref.t('toast_photo_saved_locally'),
            );
          }
        } catch (e) {
          if (mounted) {
            ToastService.showError(
              context,
              '${ref.t('error_saving_photo')}: $e',
            );
          }
        }
      }

      // 2. Prepare Processing Method
      final String processStr =
          (_selectedProcess == 'Other' || _selectedProcess == null)
          ? _processController.text
          : _selectedProcess!;

      final effectiveProcess = _isDecaf
          ? '$processStr ($_decafProcess)'
          : processStr;

      final sensoryMap = {
        'bitterness': _bitterness.toInt(),
        'acidity': _acidity.toInt(),
        'sweetness': _sweetness.toInt(),
        'body': _body.toInt(),
        'intensity': _intensity.toInt(),
        'aftertaste': _aftertaste.toInt(),
      };

      final priceMap = {
        'retail_250': _priceController.text,
        'retail_1k': _retailPrice1kController.text,
        'wholesale_250': _wholesalePrice250Controller.text,
        'wholesale_1k': _wholesalePrice1kController.text,
      };

      final effectiveOpenedAt = (_isOpen || _isGround)
          ? (_openedAt ?? _roastDate)
          : null;

      // 2.5 Auto-create roaster if name entered but no ID selected
      String? effectiveRoasterId = _userRoasterId;
      if (effectiveRoasterId == null &&
          _roasteryController.text.trim().isNotEmpty) {
        final roasterName = _roasteryController.text.trim();
        final existing = ref
            .read(userRoastersProvider)
            .firstWhereOrNull(
              (r) => r.name.toLowerCase() == roasterName.toLowerCase(),
            );

        if (existing != null) {
          effectiveRoasterId = existing.id;
        } else {
          // Create new roaster
          final newRoaster = UserRoasterDto(
            id: const Uuid().v4(),
            name: roasterName,
            country: _roasteryCountryController.text.trim(),
            location: _roasteryLocationController.text.trim(),
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
          await ref.read(userRoastersProvider.notifier).saveRoaster(newRoaster);
          effectiveRoasterId = newRoaster.id;
        }
      }

      // 3. Save to Local DB
      await db.upsertUserLot(
        CoffeeLotsCompanion(
          id: Value(lotId),
          userId: Value(userId),
          roasteryName: Value(_roasteryController.text),
          roasteryCountry: Value(_roasteryCountryController.text),
          roasteryCity: Value(_roasteryLocationController.text),
          coffeeName: Value(_coffeeNameController.text),
          originCountry: Value(_originCountryController.text),
          region: Value(_regionController.text),
          altitude: Value(() {
            final raw = _altitudeController.text;
            if (raw.isEmpty) return '';
            final pref = ref.read(preferencesProvider);
            if (pref.lengthUnit == LengthUnit.feet) {
              final ft = double.tryParse(raw);
              if (ft != null) return (ft / 3.28084).toStringAsFixed(0);
            }
            return raw;
          }()),
          process: Value(effectiveProcess),
          roastLevel: Value(_roastLevel),
          roastDate: Value(_roastDate),
          openedAt: Value(effectiveOpenedAt),
          weight: Value(_weightController.text),
          lotNumber: Value(_lotNumberController.text),
          isDecaf: Value(_isDecaf),
          farmer: Value(_farmerController.text),
          washStation: Value(_washStationController.text),
          varieties: Value(_varietiesController.text),
          flavorProfile: Value(_flavorProfileController.text),
          scaScore: Value(_scaScoreController.text),
          sensoryJson: Value(jsonEncode(sensoryMap)),
          priceJson: Value(jsonEncode(priceMap)),
          isOpen: Value(_isOpen),
          isGround: Value(_isGround),
          isFavorite: Value(_isFavorite),
          isArchived: Value(_isArchived),
          imageUrl: Value(finalImageUrl),
          userRoasterId: Value(effectiveRoasterId),
          isSynced: const Value(false),
          createdAt: Value(widget.initialLot?.createdAt ?? DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

      if (mounted) {
        // Pop loading dialog safely
        Navigator.of(context, rootNavigator: true).pop();
        if (!mounted) return;

        ToastService.showSuccess(context, ref.t('toast_changes_saved'));

        ref.invalidate(userLotsStreamProvider);

        // 4. Trigger Sync
        unawaited(ref.read(syncStatusProvider.notifier).syncEverything());

        // 5. Close screen
        ref.read(navBarVisibleProvider.notifier).show();
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        // Pop loading safely
        Navigator.of(context, rootNavigator: true).pop();
        ToastService.showError(context, '${ref.t('error_saving_lot')}: $e');
      }
    }
  }

  Future<bool> _showDiscardChangesDialog() async {
    return await showGeneralDialog<bool>(
          context: context,
          barrierDismissible: true,
          barrierLabel: '',
          barrierColor: Colors.black.withValues(alpha: 0.8),
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, anim1, anim2) => Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 40,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFFC8A96E,
                              ).withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.warning_amber_rounded,
                              color: Color(0xFFC8A96E),
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            ref.t('discard_changes_title'),
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            ref.t('discard_changes_msg'),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              color: Colors.white60,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    ref.t('keep_editing'),
                                    style: GoogleFonts.outfit(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFC8A96E),
                                    foregroundColor: Colors.black,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    ref.t('discard'),
                                    style: GoogleFonts.outfit(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          transitionBuilder: (context, anim1, anim2, child) {
            return FadeTransition(
              opacity: anim1,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                  CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic),
                ),
                child: child,
              ),
            );
          },
        ) ??
        false;
  }

  // ─── Build ────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isDirty,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final confirmed = await _showDiscardChangesDialog();
        if (confirmed && mounted && context.mounted) {
          ref.read(navBarVisibleProvider.notifier).show();
          context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset('Img/images/Whall1.png', fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: Container(color: Colors.black.withValues(alpha: 0.4)),
            ),
            SafeArea(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Column(
                      children: [
                        _buildHeader(),
                        _buildTabBar(),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              _buildRoasteryTab(),
                              _buildCoffeeTab(),
                              _buildSensoryTab(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _buildSaveFab(),
      ),
    );
  }

  // ─── Header ───────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              if (_isDirty) {
                final confirmed = await _showDiscardChangesDialog();
                if (!confirmed) return;
              }
              ref.read(navBarVisibleProvider.notifier).show();
              if (mounted) context.pop();
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFC8A96E).withValues(alpha: 0.1),
              ),
              child: const Icon(
                Icons.close_rounded,
                color: Color(0xFFC8A96E),
                size: 18,
              ),
            ),
          ),
          const Spacer(),
          Text(
            widget.openAsAdd ? ref.t('add_lot') : ref.t('edit_lot'),
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFC8A96E),
              letterSpacing: 2.0,
            ),
          ),
          const Spacer(),
          if (widget.initialLot != null) ...[
            GestureDetector(
              onTap: () {
                updateState(() => _isArchived = !_isArchived);
              },
              child: Icon(
                _isArchived ? Icons.unarchive_rounded : Icons.archive_outlined,
                color: const Color(0xFFC8A96E),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
          ],
          GestureDetector(
            onTap: () {
              updateState(() => _isFavorite = !_isFavorite);
            },
            child: Icon(
              _isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: _isFavorite ? Colors.red : const Color(0xFFC8A96E),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Tab Bar ──────────────────────────────────────────────────────
  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: const Color(0xFFC8A96E).withValues(alpha: 0.4),
          ),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: const Color(0xFFC8A96E),
        unselectedLabelColor: const Color(0xFFC8A96E).withValues(alpha: 0.38),
        labelStyle: GoogleFonts.outfit(
          fontWeight: FontWeight.bold,
          fontSize: 11,
          letterSpacing: 0.5,
        ),
        unselectedLabelStyle: GoogleFonts.outfit(
          fontWeight: FontWeight.w500,
          fontSize: 11,
        ),
        tabs: [
          Tab(text: ref.t('roasters')),
          Tab(text: ref.t('coffee')),
          Tab(text: ref.t('flavor')),
        ],
      ),
    );
  }

  // ─── Save FAB ─────────────────────────────────────────────────────
  Widget _buildSaveFab() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: _canSave ? 1.0 : 0.6,
      child: Container(
        width: 200,
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: GlassContainer(
          borderRadius: 27,
          blur: 15,
          opacity: 0.15,
          color: Colors.white,
          borderColor: _canSave
              ? const Color(0xFFC8A96E).withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.1),
          enableRepaintBoundary: true,
          child: Material(
            color: Colors.transparent,
            child: PressableScale(
              onTap: () async {
                if (!_canSave) return;
                final bool? shouldSave = await showGeneralDialog<bool>(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: '',
                  barrierColor: Colors.black.withValues(alpha: 0.8),
                  transitionDuration: const Duration(milliseconds: 300),
                  pageBuilder: (context, anim1, anim2) => Center(
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.1),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.5),
                              blurRadius: 40,
                              offset: const Offset(0, 20),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFFC8A96E,
                                      ).withValues(alpha: 0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.save_rounded,
                                      color: Color(0xFFC8A96E),
                                      size: 32,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    ref.t('save_lot_confirmation_title'),
                                    style: GoogleFonts.outfit(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    ref.t('save_lot_confirmation_desc'),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.outfit(
                                      color: Colors.white60,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 16,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              side: BorderSide(
                                                color: Colors.white.withValues(
                                                  alpha: 0.1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            ref.t('cancel'),
                                            style: GoogleFonts.outfit(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFFC8A96E,
                                            ),
                                            foregroundColor: Colors.black,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 16,
                                            ),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: Text(
                                            ref.t('save'),
                                            style: GoogleFonts.outfit(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  transitionBuilder: (context, anim1, anim2, child) {
                    return FadeTransition(
                      opacity: anim1,
                      child: ScaleTransition(
                        scale: CurvedAnimation(
                          parent: anim1,
                          curve: Curves.easeOutBack,
                        ).drive(Tween<double>(begin: 0.8, end: 1.0)),
                        child: child,
                      ),
                    );
                  },
                );

                if (shouldSave == true) {
                  _saveLot();
                }
              },
              child: Center(
                child: Text(
                  ref.t('save_lot'),
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _canSave
                        ? const Color(0xFFC8A96E)
                        : const Color(0xFFC8A96E).withValues(alpha: 0.3),
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getCurrencySymbol(Currency c) {
    switch (c) {
      case Currency.uah:
        return '₴';
      case Currency.eur:
        return '€';
      case Currency.usd:
        return r'$';
    }
  }

  // ─── Shared Widgets ───────────────────────────────────────────────

  Widget _sectionLabel(String text) => Padding(
    padding: const EdgeInsets.fromLTRB(4, 20, 4, 10),
    child: Text(
      text,
      style: GoogleFonts.outfit(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: const Color(0xFFC8A96E),
      ),
    ),
  );

  Widget _darkCard({required List<Widget> children}) => GlassContainer(
    margin: const EdgeInsets.only(bottom: 16),
    borderRadius: 27,
    opacity: 0.12,
    blur: 0,
    enableRepaintBoundary: false,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ),
  );

  Widget _divider() => Divider(
    height: 1,
    color: const Color(0xFFC8A96E).withValues(alpha: 0.06),
  );

  Widget _fieldRow({
    required String label,
    _FieldType type = _FieldType.text,
    TextEditingController? controller,
    String? value,
    Function(String)? onChanged,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    dynamic suffix, // String or Widget
    String? helperText,
    String? placeholder,
    bool readOnly = false,
    FocusNode? focusNode,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 6),
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: readOnly,
                    focusNode: focusNode,
                    controller:
                        controller ?? TextEditingController(text: value ?? ''),
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    keyboardType:
                        keyboardType ??
                        (type == _FieldType.numeric ||
                                type == _FieldType.scaScore ||
                                type == _FieldType.weight ||
                                type == _FieldType.altitude
                            ? const TextInputType.numberWithOptions(
                                decimal: true,
                              )
                            : TextInputType.text),
                    enableInteractiveSelection:
                        !readOnly &&
                        type != _FieldType.scaScore &&
                        type != _FieldType.lotNumber,
                    textCapitalization:
                        (type == _FieldType.scaScore ||
                            type == _FieldType.lotNumber)
                        ? TextCapitalization.none
                        : TextCapitalization.sentences,
                    autocorrect:
                        (type == _FieldType.scaScore ||
                            type == _FieldType.lotNumber)
                        ? false
                        : true,
                    inputFormatters:
                        inputFormatters ??
                        (type == _FieldType.scaScore
                            ? [ScaScoreInputFormatter()]
                            : type == _FieldType.lotNumber
                            ? [LotNumberInputFormatter()]
                            : type == _FieldType.altitude
                            ? [AltitudeInputFormatter()]
                            : (type == _FieldType.numeric ||
                                  type == _FieldType.weight)
                            ? [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9\.,]'),
                                ),
                              ]
                            : [GlobalCoffeeInputFormatter()]),
                    decoration: InputDecoration(
                      hintText:
                          placeholder ??
                          (type == _FieldType.scaScore ? '80-100' : null),
                      hintStyle: GoogleFonts.outfit(
                        color: Colors.white.withValues(alpha: 0.35),
                        fontSize: 15,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                    onChanged: (v) {
                      onChanged?.call(v);
                      updateState(() {}); // Trigger _canSave update
                    },
                  ),
                ),
                if (suffix != null) ...[
                  const SizedBox(width: 8),
                  suffix is String
                      ? Text(
                          suffix,
                          style: GoogleFonts.outfit(
                            color: const Color(0xFFC8A96E),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        )
                      : suffix as Widget,
                ],
              ],
            ),
          ),
          if (helperText != null) ...[
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                helperText,
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  color: Colors.white.withValues(alpha: 0.3),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _dateRow({
    required String label,
    DateTime? date,
    String? placeholder,
    required VoidCallback onTap,
  }) {
    final display = date != null
        ? '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}'
        : (placeholder ?? '—');
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 6),
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    display,
                    style: GoogleFonts.outfit(
                      color: const Color(0xFFC8A96E),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Icon(
                    Icons.calendar_today_rounded,
                    color: Color(0xFFC8A96E),
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectorRow({
    String? label,
    required String? value,
    required String placeholder,
    required VoidCallback onTap,
    Widget? suffix,
  }) {
    final hasValue = value != null && value.trim().isNotEmpty;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null && label.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 6),
              child: Text(
                label,
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      hasValue ? value : placeholder,
                      style: GoogleFonts.outfit(
                        color: hasValue
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.2),
                        fontSize: 14,
                        fontWeight: hasValue
                            ? FontWeight.w500
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                  ?suffix,
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Color(0xFFC8A96E),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleButton({
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        borderRadius: 50,
        blur: 0,
        opacity: active ? 0.15 : 0.03,
        borderColor: active
            ? const Color(0xFFC8A96E).withValues(alpha: 0.6)
            : Colors.white.withValues(alpha: 0.05),
        enableRepaintBoundary: false,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          child: Text(
            label,
            style: GoogleFonts.outfit(
              color: active
                  ? const Color(0xFFC8A96E)
                  : Colors.white.withValues(alpha: 0.4),
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _dropdownRow({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    String? localizationPrefix,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.0,
              ),
            ),
          ),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                dropdownColor: Colors.black.withValues(alpha: 0.9),
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFFC8A96E),
                  size: 18,
                ),
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                items: items.map((e) {
                  final text = localizationPrefix != null
                      ? ref.t(
                          '$localizationPrefix${e.toLowerCase().replaceAll(' ', '_')}',
                        )
                      : e;
                  return DropdownMenuItem(value: e, child: Text(text));
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateState(VoidCallback fn) {
    updateState(fn);
  }

  Widget _sensorySlider(
    String label,
    double value,
    Function(double) onChanged, {
    required ThemeData theme,
    bool enabled = true,
  }) {
    return IgnorePointer(
      ignoring: !enabled,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.4,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  Text(
                    value.toInt().toString(),
                    style: GoogleFonts.outfit(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.white,
                  inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
                  thumbColor: Colors.white,
                  overlayColor: Colors.white.withValues(alpha: 0.2),
                  trackHeight: 2,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 7,
                  ),
                ),
                child: Slider(
                  value: value,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  onChanged: (v) {
                    ref
                        .read(settingsProvider.notifier)
                        .triggerSelectionVibrate();
                    onChanged(v);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    5,
                    (i) => Text(
                      '${i + 1}',
                      style: GoogleFonts.outfit(
                        fontSize: 8,
                        color: Colors.white24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
