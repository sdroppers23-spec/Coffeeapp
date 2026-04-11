import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/providers/settings_provider.dart';
import '../../../shared/widgets/pressable_scale.dart';
import '../../../shared/widgets/sync_indicator.dart';
import '../../../core/database/app_database.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../core/database/dtos.dart';
import '../lots_providers.dart';

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

class _AddLotScreenState extends ConsumerState<AddLotScreen> with TickerProviderStateMixin {
  late TabController _formStepController;

  // Form State
  String _roasteryName = '';
  String _roasteryCountry = 'Ukraine';
  String _coffeeName = '';
  String _originCountry = '';
  String _region = '';
  String _altitude = '';
  String _varieties = '';
  String _process = 'Washed';
  String _otherProcess = '';
  bool _isDecaf = false;
  String _decafProcess = 'Sugar Cane';
  String _flavorProfile = '';
  String _roastLevel = 'Medium';
  DateTime _roastDate = DateTime.now();
  DateTime? _openedAt;
  String _weight = '250g';
  String _scaScore = '85';
  String _lotNumber = '';
  bool _isOpen = false;
  bool _isGround = false;
  bool _isFavorite = false;
  bool _isArchived = false;

  // Sensory State (1-5)
  double _aroma = 3;
  double _sweetness = 3;
  double _acidity = 3;
  double _bitterness = 2;
  double _body = 3;
  double _intensity = 3;

  String _price = '';
  String _retailPrice1k = '';
  String _wholesalePrice250 = '';
  String _wholesalePrice1k = '';

  @override
  void initState() {
    super.initState();
    _formStepController = TabController(length: 3, vsync: this);
    if (widget.initialLot != null) {
      _populateFields(widget.initialLot!);
    }
  }

  void _populateFields(CoffeeLotDto lot) {
    setState(() {
      _roasteryName = lot.roasteryName ?? '';
      _roasteryCountry = lot.roasteryCountry ?? 'Ukraine';
      _coffeeName = lot.coffeeName ?? '';
      _originCountry = lot.originCountry ?? '';
      _region = lot.region ?? '';
      _altitude = lot.altitude ?? '';
      _varieties = lot.varieties ?? '';
      _process = lot.process ?? 'Washed';
      _isDecaf = lot.isDecaf == true;
      if (_isDecaf && _process.contains('(')) {
        final parts = _process.split('(');
        _process = parts[0].trim();
        _decafProcess = parts[1].replaceAll(')', '').trim();
      }
      _flavorProfile = lot.flavorProfile ?? '';
      _roastLevel = lot.roastLevel ?? 'Medium';
      _roastDate = lot.roastDate ?? DateTime.now();
      _openedAt = lot.openedAt;
      _weight = lot.weight ?? '250g';
      _scaScore = lot.scaScore ?? '85';
      _lotNumber = lot.lotNumber ?? '';
      _isOpen = lot.isOpen;
      _isGround = lot.isGround;
      _isFavorite = lot.isFavorite;
      _isArchived = lot.isArchived;

      final sensory = lot.sensoryPoints;
      if (sensory.isNotEmpty) {
        _aroma = (sensory['aroma'] ?? 3).toDouble();
        _sweetness = (sensory['sweetness'] ?? 3).toDouble();
        _acidity = (sensory['acidity'] ?? 3).toDouble();
        _bitterness = (sensory['bitterness'] ?? 2).toDouble();
        _body = (sensory['body'] ?? 3).toDouble();
        _intensity = (sensory['intensity'] ?? 3).toDouble();
      }

      final prices = lot.pricing;
      if (prices.isNotEmpty) {
        _price = prices['retail_250']?.toString() ?? '';
        _retailPrice1k = prices['retail_1k']?.toString() ?? '';
        _wholesalePrice250 = prices['wholesale_250']?.toString() ?? '';
        _wholesalePrice1k = prices['wholesale_1k']?.toString() ?? '';
      }
    });
  }

  Future<void> _saveLot() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final db = ref.read(databaseProvider);
    final lotId = widget.initialLot?.id ?? const Uuid().v4();

    final effectiveProcess = _isDecaf
        ? '$_process ($_decafProcess)'
        : (_process == 'Other' ? _otherProcess : _process);

    final sensoryMap = {
      'aroma': _aroma.toInt(),
      'sweetness': _sweetness.toInt(),
      'acidity': _acidity.toInt(),
      'bitterness': _bitterness.toInt(),
      'body': _body.toInt(),
      'intensity': _intensity.toInt(),
    };

    final priceMap = {
      'retail_250': _price,
      'retail_1k': _retailPrice1k,
      'wholesale_250': _wholesalePrice250,
      'wholesale_1k': _wholesalePrice1k,
    };

    try {
      await db.insertUserLot(
        CoffeeLotsCompanion(
          id: Value(lotId),
          userId: Value(user.id),
          roasteryName: Value(_roasteryName),
          roasteryCountry: Value(_roasteryCountry),
          coffeeName: Value(_coffeeName),
          originCountry: Value(_originCountry),
          region: Value(_region),
          altitude: Value(_altitude),
          process: Value(effectiveProcess),
          roastLevel: Value(_roastLevel),
          roastDate: Value(_roastDate),
          openedAt: Value(_openedAt),
          weight: Value(_weight),
          lotNumber: Value(_lotNumber),
          isDecaf: Value(_isDecaf),
          varieties: Value(_varieties),
          flavorProfile: Value(_flavorProfile),
          scaScore: Value(_scaScore),
          sensoryJson: Value(jsonEncode(sensoryMap)),
          priceJson: Value(jsonEncode(priceMap)),
          isOpen: Value(_isOpen),
          isGround: Value(_isGround),
          isFavorite: Value(_isFavorite),
          isArchived: Value(_isArchived),
          isSynced: const Value(false),
          createdAt: Value(widget.initialLot?.createdAt ?? DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

      if (mounted) {
        ref.invalidate(userLotsProvider);
        ref.read(syncStatusProvider.notifier).syncEverything();
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Помилка: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUk = LocaleService.currentLocale == 'uk';
    
    return Scaffold(
      backgroundColor: const Color(0xFF0A0908),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: TabBarView(
                controller: _formStepController,
                children: [
                   _buildBasicInfoStep(),
                   _buildSensoryStep(),
                   _buildPriceStep(),
                ],
              ),
            ),
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          PressableScale(
            onTap: () => context.pop(),
            child: const Icon(Icons.close_rounded, color: Colors.white70),
          ),
          const SizedBox(width: 16),
          Text(
            widget.initialLot != null ? 'Редагувати лот' : 'Новий лот',
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFC8A96E),
            ),
          ),
          const Spacer(),
          if (_formStepController.index == 2)
            TextButton(
              onPressed: _saveLot,
              child: Text(
                'Готово',
                style: GoogleFonts.outfit(color: const Color(0xFFC8A96E), fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      children: [
        _buildSectionHeader('ОБСМАЖЧИК ТА КАВА'),
        GlassContainer(
          borderRadius: 24,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildModernTextField(
                label: 'Назва обсмажчика',
                initialValue: _roasteryName,
                onChanged: (v) => _roasteryName = v,
                icon: Icons.storefront,
              ),
              const SizedBox(height: 16),
              _buildModernTextField(
                label: 'Назва кави / Лоту',
                initialValue: _coffeeName,
                onChanged: (v) => _coffeeName = v,
                icon: Icons.local_cafe,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildSectionHeader('ПОХОДЖЕННЯ'),
        GlassContainer(
          borderRadius: 24,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildModernTextField(
                label: 'Країна',
                initialValue: _originCountry,
                onChanged: (v) => _originCountry = v,
                icon: Icons.public,
              ),
              const SizedBox(height: 16),
              _buildModernTextField(
                label: 'Регіон',
                initialValue: _region,
                onChanged: (v) => _region = v,
                icon: Icons.map,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildModernTextField(
                      label: 'Висота (м)',
                      initialValue: _altitude,
                      onChanged: (v) => _altitude = v,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildModernTextField(
                      label: 'SCA Бал',
                      initialValue: _scaScore,
                      onChanged: (v) => _scaScore = v,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildSensoryStep() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      children: [
        _buildSectionHeader('ПРОФІЛЬ СМАКУ'),
        GlassContainer(
          borderRadius: 24,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildSensorySlider('АРОМАТ', _aroma, (v) => setState(() => _aroma = v)),
              _buildSensorySlider('КИСЛОТНІСТЬ', _acidity, (v) => setState(() => _acidity = v)),
              _buildSensorySlider('СОЛОДКІСТЬ', _sweetness, (v) => setState(() => _sweetness = v)),
              _buildSensorySlider('ТІЛО', _body, (v) => setState(() => _body = v)),
              _buildSensorySlider('ГІРКОТА', _bitterness, (v) => setState(() => _bitterness = v)),
              _buildSensorySlider('ІНТЕНСИВНІСТЬ', _intensity, (v) => setState(() => _intensity = v)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildModernTextField(
          label: 'Дескриптори (через кому)',
          initialValue: _flavorProfile,
          onChanged: (v) => _flavorProfile = v,
          icon: Icons.auto_awesome,
        ),
      ],
    );
  }

  Widget _buildPriceStep() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      children: [
        _buildSectionHeader('ЦІНОУТВОРЕННЯ'),
        GlassContainer(
          borderRadius: 24,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildModernTextField(
                label: 'Роздріб (250г)',
                initialValue: _price,
                onChanged: (v) => _price = v,
                keyboardType: TextInputType.number,
                suffix: '₴',
              ),
              const SizedBox(height: 16),
              _buildModernTextField(
                label: 'Роздріб (1кг)',
                initialValue: _retailPrice1k,
                onChanged: (v) => _retailPrice1k = v,
                keyboardType: TextInputType.number,
                suffix: '₴',
              ),
              const SizedBox(height: 16),
              _buildModernTextField(
                label: 'Опт (1кг)',
                initialValue: _wholesalePrice1k,
                onChanged: (v) => _wholesalePrice1k = v,
                keyboardType: TextInputType.number,
                suffix: '₴',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white38,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildModernTextField({
    required String label,
    required String initialValue,
    required Function(String) onChanged,
    IconData? icon,
    TextInputType? keyboardType,
    String? suffix,
  }) {
    return TextField(
      controller: TextEditingController(text: initialValue)
        ..selection = TextSelection.fromPosition(TextPosition(offset: initialValue.length)),
      style: GoogleFonts.outfit(color: Colors.white, fontSize: 16),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white24, fontSize: 13),
        prefixIcon: icon != null ? Icon(icon, color: const Color(0xFFC8A96E), size: 20) : null,
        suffixText: suffix,
        suffixStyle: const TextStyle(color: Color(0xFFC8A96E), fontWeight: FontWeight.bold),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFC8A96E))),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildSensorySlider(String label, double value, Function(double) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: GoogleFonts.poppins(fontSize: 10, color: Colors.white54, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: const Color(0xFFC8A96E),
                inactiveTrackColor: Colors.white10,
                thumbColor: Colors.white,
                overlayColor: const Color(0xFFC8A96E).withValues(alpha: 0.2),
                trackHeight: 2,
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
          ),
          Text(
            value.toInt().toString(),
            style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFFC8A96E), fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _formStepController.index > 0
              ? TextButton(
                  onPressed: () {
                    ref.read(settingsProvider.notifier).triggerSelectionVibrate();
                    setState(() => _formStepController.animateTo(_formStepController.index - 1));
                  },
                  child: Text('НАЗАД', style: GoogleFonts.poppins(color: Colors.white38, fontSize: 12, fontWeight: FontWeight.bold)),
                )
              : const SizedBox.shrink(),
          _formStepController.index < 2
              ? PressableScale(
                  onTap: () {
                    ref.read(settingsProvider.notifier).triggerSelectionVibrate();
                    setState(() => _formStepController.animateTo(_formStepController.index + 1));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC8A96E),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'ДАЛІ',
                      style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                )
              : PressableScale(
                  onTap: () {
                    ref.read(settingsProvider.notifier).triggerSelectionVibrate();
                    _saveLot();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC8A96E),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'ЗБЕРЕГТИ',
                      style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
