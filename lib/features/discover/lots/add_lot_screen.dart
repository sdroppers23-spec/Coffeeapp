import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:google_fonts/google_fonts.dart';
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
import '../../../shared/models/processing_methods_repository.dart';
import '../../../shared/widgets/sensory_radar_chart.dart';
import '../../../shared/services/toast_service.dart';
import '../../../core/providers/preferences_provider.dart';
import '../../../shared/utils/coffee_input_formatters.dart';

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

  // ─── Form State ───────────────────────────────────────────────────
  bool _isDecaf = false;
  String _decafProcess = 'Sugar Cane';
  String _roastLevel = 'Medium';
  DateTime _roastDate = DateTime.now();
  DateTime? _openedAt;
  bool _isOpen = false;
  bool _isGround = false;
  bool _isFavorite = false;
  bool _isArchived = false;

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

    // Ensure navbar is visible when leaving this screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(navBarVisibleProvider.notifier).show();
    });
    super.dispose();
  }

  // Controllers to prevent cursor jumps and fix focus
  late final TextEditingController _roasteryController;
  late final TextEditingController _roasteryCountryController;
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
    _tabController.addListener(() => setState(() {}));

    _roasteryController = TextEditingController(
      text: widget.initialLot?.roasteryName ?? '',
    );
    _roasteryCountryController = TextEditingController(
      text: widget.initialLot?.roasteryCountry ?? 'Ukraine',
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
      text: widget.initialLot?.process ?? 'Washed',
    );
    _flavorProfileController = TextEditingController(
      text: widget.initialLot?.flavorProfile ?? '',
    );
    _scaScoreController = TextEditingController(
      text: widget.initialLot?.scaScore ?? '85',
    );
    _lotNumberController = TextEditingController(
      text: widget.initialLot?.lotNumber ?? '',
    );
    _weightController = TextEditingController(
      text: widget.initialLot?.weight ?? '250g',
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

    if (widget.initialLot != null) {
      _currentImageUrl = widget.initialLot!.imageUrl;
      _populateFields(widget.initialLot!);
    }
  }

  void _populateFields(CoffeeLotDto lot) {
    setState(() {
      _populateProcess(lot);

      _roastLevel = lot.roastLevel ?? 'Medium';
      _roastDate = lot.roastDate ?? DateTime.now();
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

    if (!_decafMethods.contains(_decafProcess) && _isDecaf) {
      _isOtherDecaf = true;
      // We can use a separate controller if needed, but for now we use _decafProcess as is
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
              SnackBar(content: Text(context.t('error_image_too_large'))),
            );
          }
          return;
        }

        setState(() {
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
      _roasteryController.text.trim().isNotEmpty &&
      _originCountryController.text.trim().isNotEmpty;

  Future<void> _saveLot() async {
    if (!_canSave) return;

    final user = Supabase.instance.client.auth.currentUser;
    final userId = user?.id ?? 'guest';

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
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
              context.t('toast_photo_saved_locally'),
            );
          }
        } catch (e) {
          if (mounted) {
            ToastService.showError(
              context,
              '${context.t('error_saving_photo')}: $e',
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

      // 3. Save to Local DB
      await db.upsertUserLot(
        CoffeeLotsCompanion(
          id: Value(lotId),
          userId: Value(userId),
          roasteryName: Value(_roasteryController.text),
          roasteryCountry: Value(_roasteryCountryController.text),
          coffeeName: Value(_originCountryController.text), // Fallback or clear
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
          isSynced: const Value(false),
          createdAt: Value(widget.initialLot?.createdAt ?? DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

      if (mounted) {
        // Pop loading
        if (mounted) {
          ToastService.showSuccess(context, context.t('toast_changes_saved'));
        }

        ref.invalidate(userLotsProvider);
        ref.read(syncStatusProvider.notifier).syncEverything();
        ref.read(navBarVisibleProvider.notifier).show();
        if (mounted) context.pop();
      }
    } catch (e) {
      if (mounted) {
        // Pop loading
        Navigator.of(context).pop();
        ToastService.showError(context, '${context.t('error_saving_lot')}: $e');
      }
    }
  }

  // ─── Build ────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          ref.read(navBarVisibleProvider.notifier).show();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
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
            onTap: () {
              ref.read(navBarVisibleProvider.notifier).show();
              context.pop();
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
            widget.initialLot != null
                ? context.t('edit_lot').toUpperCase()
                : context.t('add_lot').toUpperCase(),
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
                setState(() => _isArchived = !_isArchived);
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
              setState(() => _isFavorite = !_isFavorite);
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
        color: const Color(0xFFC8A96E).withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(50),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF121212),
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
          Tab(text: context.t('roasters').toUpperCase()),
          Tab(text: context.t('coffee').toUpperCase()),
          Tab(text: context.t('flavor').toUpperCase()),
        ],
      ),
    );
  }

  // ─── Save FAB ─────────────────────────────────────────────────────
  Widget _buildSaveFab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: PressableScale(
        onTap: _saveLot,
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            color: _canSave
                ? const Color(0xFF121212)
                : const Color(0xFF121212).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(27),
            border: Border.all(
              color: _canSave
                  ? const Color(0xFFC8A96E).withValues(alpha: 0.4)
                  : const Color(0xFFC8A96E).withValues(alpha: 0.1),
            ),
          ),
          child: Center(
            child: Text(
              context.t('save_lot').toUpperCase(),
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
        color: Colors.white,
      ),
    ),
  );

  Widget _darkCard({required List<Widget> children}) => Container(
    decoration: BoxDecoration(
      color: const Color(0xFFC8A96E).withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(20),
    ),
    clipBehavior: Clip.hardEdge,
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
    String? suffix,
    String? helperText,
    String? placeholder,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller:
                      controller ?? TextEditingController(text: value ?? ''),
                  style: GoogleFonts.outfit(color: Colors.white, fontSize: 16),
                  keyboardType:
                      keyboardType ??
                      (type == _FieldType.numeric ||
                              type == _FieldType.scaScore ||
                              type == _FieldType.weight ||
                              type == _FieldType.altitude
                          ? const TextInputType.numberWithOptions(decimal: true)
                          : TextInputType.text),
                  enableInteractiveSelection:
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
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  onChanged: (v) {
                    onChanged?.call(v);
                    setState(() {}); // Trigger _canSave update
                  },
                ),
              ),
              if (suffix != null)
                Text(
                  suffix,
                  style: GoogleFonts.outfit(
                    color: const Color(0xFFC8A96E),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
            ],
          ),
          if (helperText != null) ...[
            const SizedBox(height: 4),
            Text(
              helperText,
              style: GoogleFonts.outfit(
                fontSize: 10,
                color: Colors.white.withValues(alpha: 0.38),
                fontWeight: FontWeight.w400,
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
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.outfit(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  display,
                  style: GoogleFonts.outfit(
                    color: const Color(0xFFC8A96E),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.calendar_today_rounded,
              color: Color(0xFFC8A96E),
              size: 16,
            ),
          ],
        ),
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: active
              ? const Color(0xFFC8A96E).withValues(alpha: 0.06)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: active
                ? const Color(0xFFC8A96E)
                : const Color(0xFFC8A96E).withValues(alpha: 0.1),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.outfit(
            color: active
                ? const Color(0xFFC8A96E)
                : const Color(0xFFC8A96E).withValues(alpha: 0.38),
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
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
                color: const Color(0xFFC8A96E).withValues(alpha: 0.6),
                letterSpacing: 1.0,
              ),
            ),
          ),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                dropdownColor: const Color(0xFF1A1714),
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
                      ? context.t(
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
    setState(fn);
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
