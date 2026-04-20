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

class AddLotScreen extends ConsumerStatefulWidget {
  final CoffeeLotDto? initialLot;
  final bool openAsAdd;

  const AddLotScreen({
    super.key,
    this.initialLot,
    this.openAsAdd = false,
  });

  @override
  ConsumerState<AddLotScreen> createState() => _AddLotScreenState();
}

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
    'Anaerobic',
    'Carbonic Maceration',
    'Cold Soul',
    'Experimental',
    'Other'
  ];

  final List<String> _decafMethods = [
    'Sugar Cane',
    'Swiss Water',
    'CO2',
    'Mountain Water',
    'Other'
  ];

  final List<String> _roastLevels = [
    'Light',
    'Medium-Light',
    'Medium',
    'Medium-Dark',
    'Dark',
    'Filter',
    'Omni',
    'Espresso'
  ];

  String? _selectedProcess;
  bool _isOtherProcess = false;
  bool _isOtherDecaf = false;

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

    _roasteryController = TextEditingController(text: widget.initialLot?.roasteryName ?? '');
    _roasteryCountryController = TextEditingController(text: widget.initialLot?.roasteryCountry ?? 'Ukraine');
    _originCountryController = TextEditingController(text: widget.initialLot?.originCountry ?? '');
    _regionController = TextEditingController(text: widget.initialLot?.region ?? '');
    _altitudeController = TextEditingController(text: widget.initialLot?.altitude ?? '');
    _varietiesController = TextEditingController(text: widget.initialLot?.varieties ?? '');
    _farmerController = TextEditingController(text: widget.initialLot?.farmer ?? '');
    _washStationController = TextEditingController(text: widget.initialLot?.washStation ?? '');
    _processController = TextEditingController(text: widget.initialLot?.process ?? 'Washed');
    _flavorProfileController = TextEditingController(text: widget.initialLot?.flavorProfile ?? '');
    _scaScoreController = TextEditingController(text: widget.initialLot?.scaScore ?? '85');
    _lotNumberController = TextEditingController(text: widget.initialLot?.lotNumber ?? '');
    _weightController = TextEditingController(text: widget.initialLot?.weight ?? '250g');
    
    // Initial controllers are set based on widget.initialLot in initState
    
    final pricing = widget.initialLot?.pricing ?? {};
    _priceController = TextEditingController(text: pricing['retail_250']?.toString() ?? '');
    _retailPrice1kController = TextEditingController(text: pricing['retail_1k']?.toString() ?? '');
    _wholesalePrice250Controller = TextEditingController(text: pricing['wholesale_250']?.toString() ?? '');
    _wholesalePrice1kController = TextEditingController(text: pricing['wholesale_1k']?.toString() ?? '');

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
        _bitterness = (sensory['bitterness'] ?? sensory['aroma'] ?? 3).toDouble();
        _acidity = (sensory['acidity'] ?? 3).toDouble();
        _sweetness = (sensory['sweetness'] ?? sensory['flavor'] ?? 3).toDouble();
        _body = (sensory['body'] ?? 3).toDouble();
        _intensity = (sensory['intensity'] ?? sensory['balance'] ?? 3).toDouble();
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
              const SnackBar(content: Text('Зображення занадто велике (макс. 5МБ)')),
            );
          }
          return;
        }

        setState(() {
          _imageBytes = bytes;
          _imageExtension = image.name.split('.').last.toLowerCase();
          _currentImageUrl = null; // New image replaces old one
        });
        debugPrint('IMAGE PICKED: extension=$_imageExtension, bytes=${bytes.length}');
      }
    } catch (e) {
      debugPrint('PICK IMAGE ERROR: $e');
    }
  }

  bool get _canSave => 
      _roasteryController.text.trim().isNotEmpty && 
      _originCountryController.text.trim().isNotEmpty;

  Future<void> _saveLot() async {
    if (!_canSave) return;
    
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator(color: Color(0xFFC8A96E))),
    );

    final db = ref.read(databaseProvider);
    final lotId = widget.initialLot?.id ?? const Uuid().v4();

    final messenger = ScaffoldMessenger.of(context);
    final isUk = LocaleService.currentLocale == 'uk';

    String finalImageUrl = _currentImageUrl ?? '';

    try {
      // 1. Handle Image saving to Local Storage if new image selected
      if (_imageBytes != null && _imageExtension != null) {
        try {
          final localPath = await LocalFileManager.saveImageLocal(
            _imageBytes!, 
            extension: '.$_imageExtension'
          );
          finalImageUrl = localPath;
          
          messenger.showSnackBar(
            SnackBar(
              content: Text(isUk ? 'Фото збережено локально' : 'Photo saved locally'),
              backgroundColor: const Color(0xFFC8A96E),
              duration: const Duration(seconds: 1),
            ),
          );
        } catch (e) {
          messenger.showSnackBar(
            SnackBar(
              content: Text(isUk ? 'Помилка збереження фото: $e' : 'Error saving photo: $e'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }

      // 2. Prepare Processing Method
      String processStr = (_selectedProcess == 'Other' || _selectedProcess == null)
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
      await db.insertUserLot(
        CoffeeLotsCompanion(
          id: Value(lotId),
          userId: Value(user.id),
          roasteryName: Value(_roasteryController.text),
          roasteryCountry: Value(_roasteryCountryController.text),
          coffeeName: Value(_originCountryController.text), // Fallback or clear
          originCountry: Value(_originCountryController.text),
          region: Value(_regionController.text),
          altitude: Value(_altitudeController.text),
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
      
      debugPrint('SAVE LOT: Successfully saved $lotId to local database');

      if (mounted) {
        // Pop loading
        Navigator.of(context).pop();
        
        ref.invalidate(userLotsProvider);
        ref.read(syncStatusProvider.notifier).syncEverything();
        ref.read(navBarVisibleProvider.notifier).show();
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        // Pop loading
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Помилка при збереженні: $e')));
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
        backgroundColor: const Color(0xFF0A0908),
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
              child: const Icon(Icons.close_rounded, color: Color(0xFFC8A96E), size: 18),
            ),
          ),
          const Spacer(),
          Text(
            widget.initialLot != null ? 'РЕДАГУВАТИ' : 'НОВИЙ ЛОТ',
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
              _isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
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
          color: const Color(0xFF1A1714),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: const Color(0xFFC8A96E).withValues(alpha: 0.4)),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: const Color(0xFFC8A96E),
        unselectedLabelColor: const Color(0xFFC8A96E).withValues(alpha: 0.38),
        labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 0.5),
        unselectedLabelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w500, fontSize: 11),
        tabs: const [
          Tab(text: 'ОБСМАЖЧИК'),
          Tab(text: 'КАВА'),
          Tab(text: 'СМАК'),
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
            color: _canSave ? const Color(0xFF1A1714) : const Color(0xFF1A1714).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(27),
            border: Border.all(
              color: _canSave 
                ? const Color(0xFFC8A96E).withValues(alpha: 0.4)
                : const Color(0xFFC8A96E).withValues(alpha: 0.1)
            ),
          ),
          child: Center(
            child: Text(
              'ЗБЕРЕГТИ ЛОТ',
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: _canSave ? const Color(0xFFC8A96E) : const Color(0xFFC8A96E).withValues(alpha: 0.3),
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─── Tab 1: Roastery & Pricing ────────────────────────────────────
  Widget _buildRoasteryTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      children: [
        _sectionLabel('Обсмажчик'),
        _darkCard(children: [
          _fieldRow(label: 'NAME *', controller: _roasteryController),
          _divider(),
          _fieldRow(label: 'COUNTRY', controller: _roasteryCountryController),
        ]),
        
        _sectionLabel('Кава та лот'),
        _darkCard(children: [
          _fieldRow(label: 'FARMER', controller: _farmerController),
          _divider(),
          _fieldRow(label: 'WASH STATION', controller: _washStationController),
          _divider(),
          _fieldRow(label: 'LOT NUMBER', controller: _lotNumberController, keyboardType: TextInputType.number),
          _divider(),
          _fieldRow(
            label: 'SCA SCORE', 
            controller: _scaScoreController, 
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            helperText: 'Оцінка SCA від 80 до 100',
          ),
          _divider(),
          _fieldRow(
            label: 'WEIGHT',
            controller: _weightController,
            suffix: 'g',
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              _WeightInputFormatter(),
            ],
          ),
        ]),

        _sectionLabel('Походження'),
        _darkCard(children: [
          _fieldRow(label: 'COUNTRY *', controller: _originCountryController),
          _divider(),
          _fieldRow(label: 'REGION', controller: _regionController),
          _divider(),
          _fieldRow(
            label: 'ALTITUDE',
            controller: _altitudeController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            suffix: 'm',
          ),
          _divider(),
          _fieldRow(label: 'VARIETALS', controller: _varietiesController),
        ]),

        _sectionLabel('Обробка'),
        _buildProcessSection(),

        _sectionLabel('Смакові ноти'),
        _darkCard(children: [
          _fieldRow(label: 'FLAVOR NOTES', controller: _flavorProfileController),
        ]),

        _sectionLabel('Ціноутворення'),
        _darkCard(children: [
          _fieldRow(label: 'РОЗДРІБ 250G', controller: _priceController, keyboardType: TextInputType.number, suffix: '₴'),
          _divider(),
          _fieldRow(label: 'РОЗДРІБ 1KG', controller: _retailPrice1kController, keyboardType: TextInputType.number, suffix: '₴'),
          _divider(),
          _fieldRow(label: 'ОПТ 250G', controller: _wholesalePrice250Controller, keyboardType: TextInputType.number, suffix: '₴'),
          _divider(),
          _fieldRow(label: 'ОПТ 1KG', controller: _wholesalePrice1kController, keyboardType: TextInputType.number, suffix: '₴'),
        ]),
      ],
    );
  }

  // ─── Tab 2: Coffee Info ───────────────────────────────────────────
  Widget _buildCoffeeTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      children: [
        _sectionLabel('Фото лоту'),
        _buildImagePicker(),
        const SizedBox(height: 16),

        _sectionLabel('Дата обсмажування'),
        _darkCard(children: [
          _dateRow(
            label: 'ROAST DATE',
            date: _roastDate,
            onTap: () async {
              final picked = await showDatePicker(
                context: context, 
                initialDate: _roastDate,
                firstDate: DateTime(2020), 
                lastDate: DateTime.now(),
                builder: (ctx, child) => Theme(
                  data: ThemeData.dark().copyWith(
                    colorScheme: const ColorScheme.dark(primary: Color(0xFFC8A96E)),
                  ),
                  child: child!,
                ),
              );
              if (picked != null) setState(() => _roastDate = picked);
            },
          ),
          _divider(),
          _dateRow(
            label: 'OPENED AT',
            date: _openedAt,
            placeholder: 'Не відкрито',
            onTap: () async {
              final picked = await showDatePicker(
                context: context, 
                initialDate: (_openedAt != null && _openedAt!.isAfter(_roastDate)) 
                    ? _openedAt! 
                    : _roastDate,
                firstDate: _roastDate, 
                lastDate: DateTime.now(),
                builder: (ctx, child) => Theme(
                  data: ThemeData.dark().copyWith(
                    colorScheme: const ColorScheme.dark(primary: Color(0xFFC8A96E)),
                  ),
                  child: child!,
                ),
              );
              if (picked != null) setState(() => _openedAt = picked);
            },
          ),
        ]),

        _sectionLabel('Стан пачки'),
        Row(
          children: [
            Expanded(
              child: _toggleButton(
                label: 'ЗАКРИТА', 
                active: !_isOpen, 
                onTap: () => setState(() => _isOpen = false),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _toggleButton(
                label: 'ВІДКРИТА', 
                active: _isOpen, 
                onTap: () {
                  setState(() {
                    _isOpen = true;
                    _openedAt ??= _roastDate;
                  });
                },
              ),
            ),
          ],
        ),

        if (_isOpen) ...[
          _sectionLabel('Тип помелу'),
          _darkCard(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<bool>(
                  value: _isGround,
                  isExpanded: true,
                  dropdownColor: const Color(0xFF1A1714),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFFC8A96E)),
                  style: GoogleFonts.outfit(
                    color: const Color(0xFFC8A96E), 
                    fontSize: 15, 
                    fontWeight: FontWeight.w500,
                  ),
                  items: [
                    DropdownMenuItem(value: false, child: Text('В ЗЕРНАХ', style: GoogleFonts.outfit(color: Colors.white))),
                    DropdownMenuItem(value: true, child: Text('ЗМЕЛЕНА', style: GoogleFonts.outfit(color: Colors.white))),
                  ],
                  onChanged: (v) {
                    setState(() {
                      _isGround = v ?? false;
                      if (_isGround) _openedAt ??= _roastDate;
                    });
                  },
                ),
              ),
            ),
          ]),
        ],

        _sectionLabel('Обсмажка'),
        _darkCard(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ROAST LEVEL',
                  style: GoogleFonts.outfit(
                    fontSize: 10, 
                    color: Colors.white, 
                    fontWeight: FontWeight.bold, 
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _roastLevels.contains(_roastLevel) ? _roastLevel : _roastLevels[2],
                    isExpanded: true,
                    dropdownColor: const Color(0xFF1A1714),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFFC8A96E)),
                    style: GoogleFonts.outfit(color: Colors.white, fontSize: 16),
                    items: _roastLevels.map((String level) {
                      return DropdownMenuItem<String>(
                        value: level,
                        child: Text(level.toUpperCase(), style: GoogleFonts.outfit(color: Colors.white)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _roastLevel = newValue;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ]),
      ],
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1714),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFC8A96E).withValues(alpha: 0.2)),
          image: (_imageBytes != null)
              ? DecorationImage(image: MemoryImage(_imageBytes!), fit: BoxFit.cover)
              : (_currentImageUrl != null && _currentImageUrl!.isNotEmpty)
                  ? (_currentImageUrl!.startsWith('http')
                      ? DecorationImage(image: CachedNetworkImageProvider(_currentImageUrl!), fit: BoxFit.cover)
                      : DecorationImage(image: FileImage(File(_currentImageUrl!)), fit: BoxFit.cover))
                  : null,
        ),
        child: (_imageBytes == null && (_currentImageUrl == null || _currentImageUrl!.isEmpty))
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo_outlined, color: const Color(0xFFC8A96E).withValues(alpha: 0.5), size: 40),
                    const SizedBox(height: 8),
                    Text(
                      'ДОДАТИ ФОТО',
                      style: GoogleFonts.outfit(
                        color: const Color(0xFFC8A96E).withValues(alpha: 0.5),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              )
            : Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit_rounded, color: Colors.white, size: 18),
                ),
              ),
      ),
    );
  }

  Widget _buildProcessSection() {
    return Column(
      children: [
        _darkCard(children: [
          _dropdownRow(
            label: 'METHOD',
            value: _selectedProcess,
            items: _processingMethods,
            onChanged: (val) {
              setState(() {
                _selectedProcess = val;
                _isOtherProcess = val == 'Other';
                if (!_isOtherProcess) _processController.clear();
              });
            },
          ),
          if (_isOtherProcess) ...[
            _divider(),
            _fieldRow(label: 'СВІЙ МЕТОД', controller: _processController, placeholder: 'Введіть назву'),
          ],
          _divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Text(
                  'DECAF',
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFC8A96E).withValues(alpha: 0.6),
                    letterSpacing: 1.0,
                  ),
                ),
                const Spacer(),
                Switch(
                  value: _isDecaf,
                  onChanged: (v) => setState(() => _isDecaf = v),
                  activeThumbColor: const Color(0xFFC8A96E),
                  activeTrackColor: const Color(0xFFC8A96E).withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
          if (_isDecaf) ...[
            _divider(),
            _dropdownRow(
              label: 'DECAF METHOD',
              value: _decafMethods.contains(_decafProcess) ? _decafProcess : 'Other',
              items: _decafMethods,
              onChanged: (val) {
                setState(() {
                  _decafProcess = val!;
                  _isOtherDecaf = val == 'Other';
                });
              },
            ),
            if (_isOtherDecaf) ...[
              _divider(),
              _fieldRow(
                label: 'СВІЙ МЕТОД ДЕКАФУ',
                controller: TextEditingController(text: _decafProcess == 'Other' ? '' : _decafProcess),
                onChanged: (v) => _decafProcess = v,
                placeholder: 'Введіть назву',
              ),
            ],
          ],
        ]),
      ],
    );
  }

  Widget _dropdownRow({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
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
                icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFFC8A96E), size: 18),
                style: GoogleFonts.outfit(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Tab 3: Sensory ───────────────────────────────────────────────
  Widget _buildSensoryTab() {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      children: [
        _sectionLabel('Профіль смаку (1–5)'),
        _darkCard(children: [
          _sensorySlider('BITTERNESS', _bitterness, (v) => setState(() => _bitterness = v), theme: theme),
          _divider(),
          _sensorySlider('ACIDITY', _acidity, (v) => setState(() => _acidity = v), theme: theme),
          _divider(),
          _sensorySlider('SWEETNESS', _sweetness, (v) => setState(() => _sweetness = v), theme: theme),
          _divider(),
          _sensorySlider('BODY', _body, (v) => setState(() => _body = v), theme: theme),
          _divider(),
          _sensorySlider('INTENSITY', _intensity, (v) => setState(() => _intensity = v), theme: theme),
          _divider(),
          _sensorySlider('AFTERTASTE', _aftertaste, (v) => setState(() => _aftertaste = v), theme: theme),
        ]),
      ],
    );
  }

  // ─── Shared Widgets ───────────────────────────────────────────────

  Widget _sectionLabel(String text) => Padding(
        padding: const EdgeInsets.fromLTRB(4, 20, 4, 10),
        child: Text(
          text,
          style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      );

  Widget _darkCard({required List<Widget> children}) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFFC8A96E).withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
      );

  Widget _divider() => Divider(height: 1, color: const Color(0xFFC8A96E).withValues(alpha: 0.06));

  Widget _fieldRow({
    required String label,
    TextEditingController? controller,
    String? value,
    Function(String)? onChanged,
    TextInputType? keyboardType,
    String? suffix,
    String? helperText,
    List<TextInputFormatter>? inputFormatters,
    String? placeholder,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.outfit(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller ?? TextEditingController(text: value ?? ''),
                  style: GoogleFonts.outfit(color: Colors.white, fontSize: 16),
                  keyboardType: keyboardType,
                  enableInteractiveSelection: label != 'SCA SCORE' && label != 'LOT NUMBER',
                  textCapitalization: (label == 'SCA SCORE' || label == 'LOT NUMBER') 
                    ? TextCapitalization.none 
                    : TextCapitalization.sentences,
                  autocorrect: (label == 'SCA SCORE' || label == 'LOT NUMBER') ? false : true,
                  inputFormatters: inputFormatters ?? (label == 'SCA SCORE'
                    ? [ScaScoreInputFormatter()]
                    : label == 'LOT NUMBER'
                      ? [LotNumberInputFormatter()]
                      : label == 'ALTITUDE'
                        ? [AltitudeInputFormatter()]
                      : (keyboardType == TextInputType.number || keyboardType == const TextInputType.numberWithOptions(decimal: true))
                        ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9\.,]'))]
                        : [GlobalCoffeeInputFormatter()]),
                  decoration: InputDecoration(
                    hintText: placeholder ?? (label == 'SCA SCORE' ? '80-100' : null),
                    hintStyle: GoogleFonts.outfit(color: Colors.white.withValues(alpha: 0.2)),
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
                Text(suffix, style: GoogleFonts.outfit(color: const Color(0xFFC8A96E), fontWeight: FontWeight.bold, fontSize: 13)),
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
                Text(label,
                    style: GoogleFonts.outfit(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                const SizedBox(height: 4),
                Text(display,
                    style: GoogleFonts.outfit(color: const Color(0xFFC8A96E), fontSize: 15, fontWeight: FontWeight.w500)),
              ],
            ),
            const Icon(Icons.calendar_today_rounded, color: Color(0xFFC8A96E), size: 16),
          ],
        ),
      ),
    );
  }

  Widget _toggleButton({required String label, required bool active, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFC8A96E).withValues(alpha: 0.06) : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: active ? const Color(0xFFC8A96E) : const Color(0xFFC8A96E).withValues(alpha: 0.1),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.outfit(
            color: active ? const Color(0xFFC8A96E) : const Color(0xFFC8A96E).withValues(alpha: 0.38),
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _sensorySlider(String label, double value, Function(double) onChanged, {required ThemeData theme}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: GoogleFonts.outfit(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
              Text(value.toInt().toString(),
                  style: GoogleFonts.outfit(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
              thumbColor: Colors.white,
              overlayColor: Colors.white.withValues(alpha: 0.2),
              trackHeight: 2,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
            ),
            child: Slider(
              value: value,
              min: 1,
              max: 5,
              divisions: 4,
              onChanged: (v) {
                ref.read(settingsProvider.notifier).triggerSelectionVibrate();
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
                (i) => Text('${i + 1}',
                    style: GoogleFonts.outfit(fontSize: 8, color: Colors.white24, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GlobalCoffeeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;
    if (text.isEmpty) return newValue;

    // 1. Length limit 60
    if (text.length > 60) {
      text = text.substring(0, 60);
    }

    // 2. Double space -> dot
    if (text.contains('  ')) {
      text = text.replaceAll('  ', '.');
    }

    // 3. Allowed characters: Letters, Numbers, Space and .,-()
    final allowedRe = RegExp(r'[^\p{L}\p{N}\s\.,\-\(\)]', unicode: true);
    text = text.replaceAll(allowedRe, '');

    // 4. Max 3 dots in a row
    while (text.contains('....')) {
      text = text.replaceAll('....', '...');
    }

    // 5. Build logic: sign control and capitalization
    final sb = StringBuffer();
    bool capitalizeNext = true; 
    

    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      
      // If we encounter a dot sequence
      if (char == '.') {
        int dotCount = 0;
        while (i < text.length && text[i] == '.' && dotCount < 3) {
          sb.write('.');
          dotCount++;
          i++;
        }
        i--; // Step back for main loop increment
        capitalizeNext = true;
        continue;
      }

      // Check for other signs
      final isSign = RegExp(r'[\,\-\(\)]').hasMatch(char);
      
      // After dot/tridot, no other sign allowed
      if (capitalizeNext && isSign) {
        continue; // Skip sign
      }

      // If it's a letter, handle capitalization
      if (RegExp(r'\p{L}', unicode: true).hasMatch(char)) {
        if (capitalizeNext) {
          sb.write(char.toUpperCase());
          capitalizeNext = false;
        } else {
          sb.write(char);
        }
      } else if (char == ' ') {
        // Space doesn't reset capitalization intent unless after dot
        sb.write(char);
      } else {
        // numbers or allowed signs (if not right after dot)
        sb.write(char);
      }
    }
    
    final finalResult = sb.toString();
    
    // Correct selection offset
    int newOffset = newValue.selection.baseOffset;
    if (finalResult.length != newValue.text.length) {
      newOffset = newOffset.clamp(0, finalResult.length);
    }

    return TextEditingValue(
      text: finalResult,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }
}

class ScaScoreInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(',', '.').replaceAll(' ', '');
    // Strictly allow only digits and dot
    text = text.replaceAll(RegExp(r'[^0-9.]'), '');

    if (text.isEmpty) return newValue.copyWith(text: '');

    // Rule: First digit must be 1, 8, or 9
    final firstChar = text[0];
    if (firstChar != '1' && firstChar != '8' && firstChar != '9') {
      return oldValue;
    }

    // NEW Rule: Prevent dot after the first digit (e.g., prevent "8.")
    if (text.length >= 2 && text[1] == '.') {
      return oldValue;
    }

    // Rule: If starts with 1, second must be 0
    if (text.length >= 2 && text[0] == '1' && text[1] != '0') {
      return const TextEditingValue(
        text: '99.9',
        selection: TextSelection.collapsed(offset: 4),
      );
    }

    // Rule: Auto-dot after 2 digits if not 100
    if (text.length == 3 && !text.contains('.')) {
      if (text == '100') return newValue;
      // If 10x where x != 0, cap at 99.9
      if (text.startsWith('10') && text[2] != '0') {
        return const TextEditingValue(
          text: '99.9',
          selection: TextSelection.collapsed(offset: 4),
        );
      }
      return TextEditingValue(
        text: '${text.substring(0, 2)}.${text.substring(2)}',
        selection: TextSelection.collapsed(offset: 4),
      );
    }

    // Rule: Max 3 digits excluding dot (e.g. 99.9 or 100)
    final digitsOnly = text.replaceAll('.', '');
    if (digitsOnly.length > 3) return oldValue;

    // Rule: Only one dot
    if ('.'.allMatches(text).length > 1) return oldValue;

    return newValue.copyWith(text: text);
  }
}

class AltitudeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;
    if (text.isEmpty) return newValue;

    // 1. Max 8 digits total
    final digitsLength = text.replaceAll(RegExp(r'[^0-9]'), '').length;
    if (digitsLength > 8) return oldValue;

    // 2. Max 1 hyphen
    if ('-'.allMatches(text).length > 1) {
      return oldValue;
    }

    // 3. Prevent consecutive separators or invalid ones
    if (text.contains('--') || text.contains('..') || text.contains('.-') || text.contains('-.')) {
      return oldValue;
    }

    // 4. Prevent starting with separator
    if (text.startsWith('.') || text.startsWith('-')) {
      return oldValue;
    }

    // 5. Allow ONLY digits, dot, and hyphen (as requested: "тільки крапка і дифіс")
    if (!RegExp(r'^[0-9\.\-]*$').hasMatch(text)) {
      return oldValue;
    }

    return newValue;
  }
}

class LotNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;
    if (text.isEmpty) return newValue;

    // 1. Max 6 digits total
    final digitsLength = text.replaceAll(RegExp(r'[^0-9]'), '').length;
    if (digitsLength > 6) return oldValue;

    // 2. Prevent consecutive dots or commas (or mix)
    if (text.contains('..') || text.contains(',,') || text.contains('.,') || text.contains(',.')) {
      return oldValue;
    }
    
    // 3. Prevent starting with dot or comma
    if (text.startsWith('.') || text.startsWith(',')) {
      return oldValue;
    }

    // 4. Allowed symbols: 0-9, ., ,, #, №, (, ), /, -
    final allowedRe = RegExp(r'[^0-9\.,#№\(\)\/\-\s]');
    if (allowedRe.hasMatch(text)) {
      text = text.replaceAll(allowedRe, '');
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class _WeightInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;
    
    // Limit to 4 digits (up to 9999g)
    if (newValue.text.length > 4) return oldValue;
    
    return newValue;
  }
}
