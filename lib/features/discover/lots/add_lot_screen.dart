import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/providers/settings_provider.dart';
import '../../../shared/widgets/sync_indicator.dart';
import '../../../shared/widgets/pressable_scale.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/dtos.dart';
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
  String _roasteryName = '';
  String _roasteryCountry = 'Ukraine';
  String _coffeeName = '';
  String _originCountry = '';
  String _region = '';
  String _altitude = '';
  String _varieties = '';
  String _process = 'Washed';
  final String _otherProcess = '';
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

  // ─── Sensory (1-5) ────────────────────────────────────────────────
  double _aroma = 3;
  double _sweetness = 3;
  double _acidity = 3;
  double _bitterness = 2;
  double _body = 3;
  double _intensity = 3;

  // ─── Prices ───────────────────────────────────────────────────────
  String _price = '';
  String _retailPrice1k = '';
  String _wholesalePrice250 = '';
  String _wholesalePrice1k = '';

  // ─── Lifecycle ────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));
    if (widget.initialLot != null) _populateFields(widget.initialLot!);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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

    final effectiveOpenedAt = (_isOpen || _isGround) 
        ? (_openedAt ?? _roastDate) 
        : null;

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
          openedAt: Value(effectiveOpenedAt),
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
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Помилка: $e')));
      }
    }
  }

  // ─── Build ────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  // ─── Header ───────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
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
          const SizedBox(width: 36),
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
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1714),
            borderRadius: BorderRadius.circular(27),
            border: Border.all(color: const Color(0xFFC8A96E).withValues(alpha: 0.4)),
          ),
          child: Center(
            child: Text(
              'ЗБЕРЕГТИ ЛОТ',
              style: GoogleFonts.outfit(
                color: const Color(0xFFC8A96E),
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 2.0,
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
          _fieldRow(label: 'NAME *', value: _roasteryName, onChanged: (v) => _roasteryName = v),
          _divider(),
          _fieldRow(label: 'COUNTRY', value: _roasteryCountry, onChanged: (v) => _roasteryCountry = v),
        ]),
        _sectionLabel('Дата обсмажування'),
        _darkCard(children: [
          _dateRow(
            label: 'ROAST DATE',
            date: _roastDate,
            onTap: () async {
              final picked = await showDatePicker(
                context: context, initialDate: _roastDate,
                firstDate: DateTime(2020), lastDate: DateTime.now(),
                builder: (ctx, child) => Theme(
                  data: ThemeData.dark().copyWith(colorScheme: const ColorScheme.dark(primary: Color(0xFFC8A96E))),
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
                context: context, initialDate: _openedAt ?? DateTime.now(),
                firstDate: DateTime(2020), lastDate: DateTime.now(),
                builder: (ctx, child) => Theme(
                  data: ThemeData.dark().copyWith(colorScheme: const ColorScheme.dark(primary: Color(0xFFC8A96E))),
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
            Expanded(child: _toggleButton(label: 'ЗАКРИТА', active: !_isOpen, onTap: () => setState(() => _isOpen = false))),
            const SizedBox(width: 8),
            Expanded(child: _toggleButton(label: 'ВІДКРИТА', active: _isOpen, onTap: () {
              setState(() {
                _isOpen = true;
                _openedAt ??= _roastDate;
              });
            })),
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
                  style: GoogleFonts.outfit(color: const Color(0xFFC8A96E), fontSize: 15, fontWeight: FontWeight.w500),
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
        _sectionLabel('Ціноутворення'),
        _darkCard(children: [
          _fieldRow(label: 'РОЗДРІБ 250G', value: _price, onChanged: (v) => _price = v,
              keyboardType: TextInputType.number, suffix: '₴'),
          _divider(),
          _fieldRow(label: 'РОЗДРІБ 1KG', value: _retailPrice1k, onChanged: (v) => _retailPrice1k = v,
              keyboardType: TextInputType.number, suffix: '₴'),
          _divider(),
          _fieldRow(label: 'ОПТ 250G', value: _wholesalePrice250, onChanged: (v) => _wholesalePrice250 = v,
              keyboardType: TextInputType.number, suffix: '₴'),
          _divider(),
          _fieldRow(label: 'ОПТ 1KG', value: _wholesalePrice1k, onChanged: (v) => _wholesalePrice1k = v,
              keyboardType: TextInputType.number, suffix: '₴'),
        ]),
      ],
    );
  }

  // ─── Tab 2: Coffee Info ───────────────────────────────────────────
  Widget _buildCoffeeTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      children: [
        _sectionLabel('Кава та лот'),
        _darkCard(children: [
          _fieldRow(label: 'COFFEE NAME *', value: _coffeeName, onChanged: (v) => _coffeeName = v),
          _divider(),
          _fieldRow(label: 'LOT NUMBER', value: _lotNumber, onChanged: (v) => _lotNumber = v),
          _divider(),
          _fieldRow(label: 'SCA SCORE', value: _scaScore, onChanged: (v) => _scaScore = v,
              keyboardType: TextInputType.number),
        ]),
        _sectionLabel('Походження'),
        _darkCard(children: [
          _fieldRow(label: 'COUNTRY *', value: _originCountry, onChanged: (v) => _originCountry = v),
          _divider(),
          _fieldRow(label: 'REGION', value: _region, onChanged: (v) => _region = v),
          _divider(),
          _fieldRow(label: 'ALTITUDE', value: _altitude, onChanged: (v) => _altitude = v,
              keyboardType: TextInputType.number, suffix: 'm'),
          _divider(),
          _fieldRow(label: 'VARIETALS', value: _varieties, onChanged: (v) => _varieties = v),
        ]),
        _sectionLabel('Обробка та смакові ноти'),
        _darkCard(children: [
          _fieldRow(label: 'PROCESS', value: _process, onChanged: (v) => _process = v),
          _divider(),
          _fieldRow(label: 'FLAVOR NOTES', value: _flavorProfile, onChanged: (v) => _flavorProfile = v),
        ]),
      ],
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
          _sensorySlider('AROMA', _aroma, (v) => setState(() => _aroma = v), theme: theme),
          _divider(),
          _sensorySlider('SWEETNESS', _sweetness, (v) => setState(() => _sweetness = v), theme: theme),
          _divider(),
          _sensorySlider('ACIDITY', _acidity, (v) => setState(() => _acidity = v), theme: theme),
          _divider(),
          _sensorySlider('BITTERNESS', _bitterness, (v) => setState(() => _bitterness = v), theme: theme),
          _divider(),
          _sensorySlider('BODY', _body, (v) => setState(() => _body = v), theme: theme),
          _divider(),
          _sensorySlider('INTENSITY', _intensity, (v) => setState(() => _intensity = v), theme: theme),
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
    required String value,
    required Function(String) onChanged,
    TextInputType? keyboardType,
    String? suffix,
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
                  controller: TextEditingController(text: value)
                    ..selection = TextSelection.fromPosition(TextPosition(offset: value.length)),
                  style: GoogleFonts.outfit(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                  inputFormatters: keyboardType == TextInputType.number 
                    ? [FilteringTextInputFormatter.digitsOnly]
                    : [GlobalCoffeeInputFormatter()],
                  onChanged: onChanged,
                ),
              ),
              if (suffix != null)
                Text(suffix, style: GoogleFonts.outfit(color: const Color(0xFFC8A96E), fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
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
        // Numbers or allowed signs (if not right after dot)
        sb.write(char);
        capitalizeNext = false; 
      }
    }
    
    String finalResult = sb.toString();

    return TextEditingValue(
      text: finalResult,
      selection: TextSelection.collapsed(offset: finalResult.length),
    );
  }
}
