import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:go_router/go_router.dart';

import '../../core/l10n/app_localizations.dart';

import '../../shared/widgets/sensory_radar_chart.dart';
import '../../core/database/database_provider.dart';
import '../../core/providers/settings_provider.dart';
import '../../shared/widgets/pressable_scale.dart';
import '../../shared/widgets/sync_indicator.dart';
import '../../core/database/app_database.dart';
import '../../shared/widgets/glass_container.dart';
import '../discover/discovery_filter_provider.dart';
import '../discover/widgets/discovery_action_bar.dart';
import '../navigation/main_scaffold.dart';
import 'comparison_screen.dart';
import 'custom_lot_detail_screen.dart';
import '../../core/database/dtos.dart';

final userLotsProvider = FutureProvider<List<CoffeeLotDto>>((ref) async {
  final db = ref.watch(databaseProvider);
  final userId = Supabase.instance.client.auth.currentUser?.id;
  if (userId == null) return [];
  return db.getUserLots(userId);
});

class AddCustomLotScreen extends ConsumerStatefulWidget {
  final CoffeeLotDto? initialLot;
  final VoidCallback? onBack;
  final bool openAsAdd;

  const AddCustomLotScreen({
    super.key,
    this.initialLot,
    this.onBack,
    this.openAsAdd = false,
  });

  @override
  ConsumerState<AddCustomLotScreen> createState() => _AddCustomLotScreenState();
}

class _AddCustomLotScreenState extends ConsumerState<AddCustomLotScreen>
    with TickerProviderStateMixin, NavBarAwareMixin {
  late TabController _mainTabController;
  late TabController _formStepController;
  late TabController _myLotsSubTabController;

  // Form State
  String _roasteryName = '';
  String _roasteryCountry = 'Ukraine';
  String _flavorProfile = '';
  String _roastLevel = 'Medium';
  DateTime _roastDate = DateTime.now();
  DateTime? _openedAt;
  String _weight = '250g';
  String _retailPrice250 = '';
  String _retailPrice1k = '';
  String _wholesalePrice250 = '';
  String _wholesalePrice1k = '';
  String _scaScore = '85';
  String _lotNumber = '';
  String _coffeeName = '';
  String _originCountry = '';
  String _region = '';
  String _altitude = '';
  String _varieties = '';
  String _process = 'Washed';
  String _otherProcess = '';
  bool _isDecaf = false;
  String _decafProcess = 'Sugar Cane';
  String _farm = '';
  String _washStation = '';
  String _farmer = '';

  // Sensory State (1-5)
  double _aroma = 3;
  double _sweetness = 3;
  double _acidity = 3;
  double _bitterness = 2;
  double _body = 3;
  double _intensity = 3;
  int _formKeyVersion = 0;
  bool _isAdding = false;
  String _currency = '₴ (UAH)';
  String _price = '';
  final Set<String> _selectedLotIds = {};
  DateTime? _lastBackPressTime;

  // Tab change history for PopScope
  final List<int> _tabHistory = [0];

  bool _isOpen = false;
  bool _isGround = false;
  bool _isFavorite = false;
  bool _isArchived = false;
  String? _currentLotId;
  String? _expandedLotId;

  final List<String> _processingMethods = [
    'Washed',
    'Natural',
    'Honey',
    'Anaerobic',
    'Thermal Shock',
    'Carbonic Maceration',
    'Lactic Fermentation',
    'Cold Fermentation',
    'Double Anaerobic',
    'Honey Anaerobic',
    'Other',
  ];

  final List<String> _decafMethods = [
    'Sugar Cane',
    'Swiss Water',
    'CO2 Method',
    'Mountain Water',
    'Ethyl Acetate',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _mainTabController = TabController(length: 2, vsync: this);
    _formStepController = TabController(length: 3, vsync: this);
    _myLotsSubTabController = TabController(length: 3, vsync: this);
    _myLotsSubTabController.addListener(() {
      if (!_myLotsSubTabController.indexIsChanging) {
        if (_tabHistory.isEmpty ||
            _tabHistory.last != _myLotsSubTabController.index) {
          _tabHistory.add(_myLotsSubTabController.index);
          // Limit history size
          if (_tabHistory.length > 10) _tabHistory.removeAt(0);
        }
      }
    });

    _isAdding = widget.initialLot != null || widget.openAsAdd;
    if (widget.initialLot != null) {
      _currentLotId = widget.initialLot!.id;
      _populateFields(widget.initialLot!);
    }

    // Hide nav bar
    Future.microtask(() {
      if (mounted) ref.read(navBarVisibleProvider.notifier).hide();
    });
  }

  void _populateFields(CoffeeLotDto lot) {
    _currentLotId = lot.id; // FIX: Ensure we update existing lot
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
    _farm = lot.farm ?? '';
    _washStation = lot.washStation ?? '';
    _farmer = lot.farmer ?? '';
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
      _retailPrice250 = prices['retail_250']?.toString() ?? '';
      _price = _retailPrice250;
      _retailPrice1k = prices['retail_1k']?.toString() ?? '';
      _wholesalePrice250 = prices['wholesale_250']?.toString() ?? '';
      _wholesalePrice1k = prices['wholesale_1k']?.toString() ?? '';
    }
  }

  void _resetFields() {
    setState(() {
      _currentLotId = null; // IMPORTANT: Reset ID when adding fresh
      _roasteryName = '';
      _roasteryCountry = 'Ukraine';
      _flavorProfile = '';
      _roastLevel = 'Medium';
      _roastDate = DateTime.now();
      _weight = '250g';
      _retailPrice250 = '';
      _price = '';
      _retailPrice1k = '';
      _wholesalePrice250 = '';
      _wholesalePrice1k = '';
      _scaScore = '85';
      _lotNumber = '';
      _coffeeName = '';
      _originCountry = '';
      _region = '';
      _altitude = '';
      _varieties = '';
      _process = 'Washed';
      _otherProcess = '';
      _isDecaf = false;
      _decafProcess = 'Sugar Cane';
      _farm = '';
      _washStation = '';
      _farmer = '';

      _aroma = 3;
      _sweetness = 3;
      _acidity = 3;
      _bitterness = 2;
      _body = 3;
      _intensity = 3;
      _formKeyVersion++;

      _isOpen = false;
      _isGround = false;
      _openedAt = null;
      _isFavorite = false;
      _isArchived = false;
    });
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    _formStepController.dispose();
    _myLotsSubTabController.dispose();
    // Ensure nav bar is shown when leaving
    Future.microtask(() {
      ref.read(navBarVisibleProvider.notifier).show();
    });
    super.dispose();
  }

  Future<void> _saveLot() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in to save lots')),
        );
      }
      return;
    }

    final db = ref.read(databaseProvider);
    final lotId = _currentLotId ?? const Uuid().v4();

    // Validation
    if (_roasteryName.trim().isEmpty ||
        _coffeeName.trim().isEmpty ||
        _originCountry.trim().isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Будь ласка, заповніть обов\'язкові поля: Назва кави, Обсмажчик та Країна походження',
            ),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      return;
    }

    // SCA Score validation
    final score = double.tryParse(_scaScore);
    if (score != null && (score < 80 || score > 100)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Оцінка SCA має бути в діапазоні від 80 до 100'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      return;
    }

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
          farm: Value(_farm),
          washStation: Value(_washStation),
          farmer: Value(_farmer),
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.initialLot != null
                  ? 'Лот оновлено'
                  : ref.t('success_lot_saved'),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            behavior: SnackBarBehavior.floating,
          ),
        );
        ref.invalidate(userLotsProvider);

        // Auto-sync
        ref.read(syncStatusProvider.notifier).syncEverything();

        if (widget.initialLot != null) {
          Navigator.of(context).pop();
        } else {
          setState(() {
            _isAdding = false;
            _resetFields();
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Помилка: $e'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final topPadding = MediaQuery.of(context).padding.top + 10;
    final asyncLots = ref.watch(userLotsProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        // 1. If adding/editing, go back to list
        if (_isAdding && widget.initialLot == null && !widget.openAsAdd) {
          setState(() {
            _isAdding = false;
            _selectedLotIds.clear();
          });
          return;
        }

        // 2. If lots are selected, clear selection
        if (_selectedLotIds.isNotEmpty) {
          setState(() => _selectedLotIds.clear());
          return;
        }

        // 3. Tab history navigation
        if (_tabHistory.length > 1) {
          _tabHistory.removeLast();
          _myLotsSubTabController.animateTo(_tabHistory.last);
          return;
        }

        // 4. Double tap to exit logic
        final now = DateTime.now();
        if (_lastBackPressTime == null ||
            now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
          _lastBackPressTime = now;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text(
                  LocaleService.currentLocale == 'uk'
                      ? 'Натисніть ще раз, щоб вийти'
                      : 'Press back again to exit',
                ),
              ),
              backgroundColor: Colors.black.withValues(alpha: 0.8),
              behavior: SnackBarBehavior.floating,
              width: 200,
              duration: const Duration(seconds: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          );
          return;
        }

        // Final exit
        ref.read(navBarVisibleProvider.notifier).show();
        if (context.canPop()) {
          context.pop();
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0908),
        floatingActionButton: !_isAdding && _selectedLotIds.isEmpty
            ? Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    setState(() {
                      _isAdding = true;
                      _resetFields();
                    });
                  },
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.black,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  icon: const Icon(Icons.add_rounded, size: 24),
                  label: Text(
                    ref.t('add_new_lot').toUpperCase(),
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                      fontSize: 13,
                    ),
                  ),
                ),
              )
            : null,
        body: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;

            final now = DateTime.now();
            final isUk = LocaleService.currentLocale == 'uk';

            if (_selectedLotIds.isNotEmpty) {
              setState(() => _selectedLotIds.clear());
              return;
            }

            if (_isAdding) {
              setState(() => _isAdding = false);
              ref.read(navBarVisibleProvider.notifier).show();
              return;
            }

            // Tab history navigation
            if (_tabHistory.length > 1) {
              _tabHistory.removeLast();
              _myLotsSubTabController.animateTo(_tabHistory.last);
              return;
            }

            // Double tap to exit
            if (_lastBackPressTime == null ||
                now.difference(_lastBackPressTime!) >
                    const Duration(seconds: 2)) {
              _lastBackPressTime = now;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.black.withValues(alpha: 0.8),
                  behavior: SnackBarBehavior.floating,
                  content: Text(
                    isUk
                        ? 'Натисніть ще раз, щоб вийти'
                        : 'Press back again to exit',
                    style: GoogleFonts.outfit(color: Colors.white),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
              return;
            }
            context.pop();
          },
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: topPadding),
                  if (_isAdding)
                    _buildAddingTopBar(theme)
                  else
                    _buildMergedTopBar(theme, asyncLots),
                  if (!_isAdding)
                    asyncLots.when(
                      data: (lots) {
                        if (_selectedLotIds.isNotEmpty) {
                          return const SizedBox.shrink();
                        }

                        final countries =
                            lots
                                .where((l) => l.originCountry != null)
                                .map((l) => l.originCountry!)
                                .toSet()
                                .toList()
                              ..sort();
                        final processes =
                            lots
                                .where((l) => l.process != null)
                                .map((l) => l.process!)
                                .toSet()
                                .toList()
                              ..sort();
                        final flavors =
                            lots
                                .where((l) => l.flavorProfile != null)
                                .expand(
                                  (l) => l.flavorProfile!
                                      .split(',')
                                      .map((s) => s.trim()),
                                )
                                .where((s) => s.isNotEmpty)
                                .toSet()
                                .toList()
                              ..sort();

                        return DiscoveryActionBar(
                          filterProvider: myLotsFilterProvider,
                          availableCountries: countries,
                          availableFlavors: flavors,
                          availableProcesses: processes,
                          onCompareTap: () {
                            if (mounted) {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                      ) => const ComparisonScreen(),
                                  transitionsBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                        child,
                                      ) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                ),
                              ).then((_) {
                                if (mounted) {
                                  ref
                                      .read(navBarVisibleProvider.notifier)
                                      .hide();
                                }
                              });
                            }
                          },
                        );
                      },
                      loading: () => const SizedBox(height: 48),
                      error: (_, _) => const SizedBox(height: 48),
                    ),
                  Expanded(
                    child: _isAdding
                        ? _buildCreateLotTab(theme)
                        : TabBarView(
                            controller: _myLotsSubTabController,
                            children: [
                              _buildMyLotsTab(filterStatus: 'all'),
                              _buildMyLotsTab(filterStatus: 'favorites'),
                              _buildMyLotsTab(filterStatus: 'archive'),
                            ],
                          ),
                  ),
                ],
              ),
              if (!_isAdding && _selectedLotIds.isNotEmpty)
                _buildBulkSelectionBar(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMergedTopBar(
    ThemeData theme,
    AsyncValue<List<CoffeeLotDto>> asyncLots,
  ) {
    final isUk = LocaleService.currentLocale == 'uk';
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Row(
        children: [
          // "Select All" or Back button depending on mode
          _selectedLotIds.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    asyncLots.whenData((lots) {
                      setState(() {
                        if (_selectedLotIds.length == lots.length) {
                          _selectedLotIds.clear();
                        } else {
                          _selectedLotIds.addAll(lots.map((l) => l.id));
                        }
                      });
                    });
                  },
                  icon: Icon(
                    Icons.select_all_rounded,
                    color: theme.colorScheme.primary,
                    size: 22,
                  ),
                  tooltip: isUk ? 'Обрати все' : 'Select All',
                )
              : IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
          const SizedBox(width: 4),
          Expanded(
            child: Container(
              height: 44,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              ),
              child: TabBar(
                controller: _myLotsSubTabController,
                indicator: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(18),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white54,
                labelStyle: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                tabs: [
                  Tab(text: isUk ? 'Усі' : 'All'),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.favorite_rounded, size: 12),
                        const SizedBox(width: 4),
                        Text(isUk ? 'Улюблене' : 'Favs'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.archive_rounded, size: 12),
                        const SizedBox(width: 4),
                        Text(isUk ? 'Архів' : 'Archive'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulkSelectionBar(ThemeData theme) {
    final isUk = LocaleService.currentLocale == 'uk';

    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom + 4,
      left: 16,
      right: 16,
      child: GlassContainer(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        borderRadius: 32,
        opacity: 0.15,
        borderColor: theme.colorScheme.primary.withValues(alpha: 0.3),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Text(
                '${_selectedLotIds.length}',
                style: GoogleFonts.outfit(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                isUk ? 'Обрано' : 'Selected',
                style: GoogleFonts.outfit(color: Colors.white70, fontSize: 14),
              ),
            ),
            _BulkActionButton(
              icon: Icons.favorite_border_rounded,
              onTap: _handleBulkFavorite,
              theme: theme,
            ),
            _BulkActionButton(
              icon: Icons.archive_outlined,
              onTap: _handleBulkArchive,
              theme: theme,
            ),
            _BulkActionButton(
              icon: Icons.delete_outline_rounded,
              color: Colors.redAccent,
              onTap: _handleBulkDelete,
              theme: theme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddingTopBar(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (widget.initialLot != null) {
                Navigator.of(context).pop();
              } else {
                setState(() => _isAdding = false);
              }
            },
            icon: const Icon(Icons.close, color: Colors.white, size: 20),
          ),
          const Spacer(),
          Text(
            (widget.initialLot != null
                    ? ref.t('edit_lot')
                    : ref.t('add_new_lot'))
                .toUpperCase(),
            style: GoogleFonts.outfit(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w900,
              fontSize: 14,
              letterSpacing: 1.2,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 48), // Offset for balance
        ],
      ),
    );
  }

  Widget _buildCreateLotTab(ThemeData theme) {
    return Form(
      key: ValueKey('form_$_formKeyVersion'),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TabBar(
              controller: _formStepController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorColor: theme.colorScheme.primary,
              labelColor: theme.colorScheme.primary,
              unselectedLabelColor: Colors.white24,
              labelStyle: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                Tab(
                  text: LocaleService.currentLocale == 'uk'
                      ? 'ОБСМАЖКА ТА ЦІНИ'
                      : 'ROASTERY & PRICES',
                ),
                Tab(
                  text: LocaleService.currentLocale == 'uk'
                      ? 'КАВА ТА ПОХОДЖЕННЯ'
                      : 'COFFEE & SOURCE',
                ),
                Tab(
                  text: LocaleService.currentLocale == 'uk'
                      ? 'СМАК ТА СЕНСОРИКА'
                      : 'FLAVOR & SENSORY',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              controller: _formStepController,
              children: [
                _buildStepRoastery(theme),
                _buildStepCoffee(theme),
                _buildStepSensory(theme),
              ],
            ),
          ),
          _buildBottomActions(theme),
        ],
      ),
    );
  }

  Widget _buildStepRoastery(ThemeData theme) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        _buildGroupTitle(
          LocaleService.currentLocale == 'uk' ? 'Обсмажчик' : 'Roastery',
        ),
        _buildCard([
          _buildInput(
            'Name',
            (v) => setState(() => _roasteryName = v),
            initialValue: _roasteryName,
            isRequired: true,
            maxLength: 60,
          ),
          _buildInput(
            'Country',
            (v) => setState(() => _roasteryCountry = v),
            initialValue: _roasteryCountry,
            maxLength: 50,
          ),
        ]),
        const SizedBox(height: 20),
        _buildGroupTitle(
          LocaleService.currentLocale == 'uk'
              ? 'Дані обсмажування'
              : 'Roast Data',
        ),
        _buildCard([
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              LocaleService.currentLocale == 'uk'
                  ? 'Дата обсмажування'
                  : 'Roast Date',
              style: GoogleFonts.outfit(color: Colors.white70, fontSize: 13),
            ),
            subtitle: Text(
              '${_roastDate.day}.${_roastDate.month}.${_roastDate.year}',
              style: GoogleFonts.outfit(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(
              Icons.calendar_today,
              color: Colors.white24,
              size: 18,
            ),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _roastDate,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
              );
              if (picked != null) setState(() => _roastDate = picked);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              LocaleService.currentLocale == 'uk'
                  ? 'Дата відкриття (необов\'язково)'
                  : 'Opening Date (optional)',
              style: GoogleFonts.outfit(color: Colors.white70, fontSize: 13),
            ),
            subtitle: Text(
              _openedAt == null
                  ? (LocaleService.currentLocale == 'uk'
                        ? 'Не відкрито'
                        : 'Not opened')
                  : '${_openedAt!.day}.${_openedAt!.month}.${_openedAt!.year}',
              style: GoogleFonts.outfit(
                color: _openedAt == null
                    ? Colors.white24
                    : theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_openedAt != null)
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.redAccent,
                      size: 18,
                    ),
                    onPressed: () => setState(() => _openedAt = null),
                  ),
                const Icon(
                  Icons.calendar_today,
                  color: Colors.white24,
                  size: 18,
                ),
              ],
            ),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _openedAt ?? DateTime.now(),
                firstDate: _roastDate,
                lastDate: DateTime.now(),
              );
              if (picked != null) setState(() => _openedAt = picked);
            },
          ),
          _buildInput(
            LocaleService.currentLocale == 'uk'
                ? 'Вага упаковки (напр. 250г)'
                : 'Package Weight (e.g. 250g)',
            (v) => setState(() => _weight = v),
            initialValue: _weight,
          ),
        ]),
        const SizedBox(height: 20),
        _buildGroupTitle(
          LocaleService.currentLocale == 'uk'
              ? 'Статус упаковки'
              : 'Package Status',
        ),
        _buildCard([
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isOpen = false),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: !_isOpen
                            ? theme.colorScheme.primary.withValues(alpha: 0.1)
                            : Colors.white.withValues(alpha: 0.03),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: !_isOpen
                              ? theme.colorScheme.primary.withValues(alpha: 0.3)
                              : Colors.white.withValues(alpha: 0.05),
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.inventory_2_outlined,
                            color: !_isOpen
                                ? theme.colorScheme.primary
                                : Colors.white24,
                            size: 20,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            LocaleService.currentLocale == 'uk'
                                ? 'Закрита пачка'
                                : 'Closed Pack',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: !_isOpen
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: !_isOpen
                                  ? theme.colorScheme.primary
                                  : Colors.white38,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isOpen = true),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _isOpen
                            ? theme.colorScheme.primary.withValues(alpha: 0.1)
                            : Colors.white.withValues(alpha: 0.03),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _isOpen
                              ? theme.colorScheme.primary.withValues(alpha: 0.3)
                              : Colors.white.withValues(alpha: 0.05),
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.no_drinks_outlined,
                            color: _isOpen
                                ? theme.colorScheme.primary
                                : Colors.white24,
                            size: 20,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            LocaleService.currentLocale == 'uk'
                                ? 'Відкрита'
                                : 'Opened',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: _isOpen
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: _isOpen
                                  ? theme.colorScheme.primary
                                  : Colors.white38,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isOpen) ...[
            const Divider(color: Colors.white10, height: 24),
            _buildDropdown(
              LocaleService.currentLocale == 'uk' ? 'Тип зерна' : 'Bean Type',
              _isGround
                  ? (LocaleService.currentLocale == 'uk' ? 'Змелена' : 'Ground')
                  : (LocaleService.currentLocale == 'uk'
                        ? 'В зернах'
                        : 'Whole Bean'),
              [
                LocaleService.currentLocale == 'uk' ? 'В зернах' : 'Whole Bean',
                LocaleService.currentLocale == 'uk' ? 'Змелена' : 'Ground',
              ],
              (v) {
                setState(() {
                  _isGround =
                      v ==
                      (LocaleService.currentLocale == 'uk'
                          ? 'Змелена'
                          : 'Ground');
                });
              },
            ),
          ],
        ]),
        const SizedBox(height: 20),
        _buildGroupTitle(
          LocaleService.currentLocale == 'uk'
              ? 'Вартість та Валюта'
              : 'Pricing & Currency',
        ),
        _buildCard([
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildDropdown(
                  'Currency',
                  _currency,
                  const ['UAH', 'USD', 'EUR'],
                  (v) => setState(() => _currency = v ?? _currency),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 3,
                child: _buildInput(
                  'Ціна (250г)',
                  (v) => setState(() => _price = v),
                  initialValue: _price,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [CustomPriceFormatter()],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildInput(
                  'Wholesale 250g',
                  (v) => setState(() => _wholesalePrice250 = v),
                  initialValue: _wholesalePrice250,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [CustomPriceFormatter()],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildInput(
                  'Retail 1kg',
                  (v) => setState(() => _retailPrice1k = v),
                  initialValue: _retailPrice1k,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [CustomPriceFormatter()],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInput(
                  'Wholesale 1kg',
                  (v) => setState(() => _wholesalePrice1k = v),
                  initialValue: _wholesalePrice1k,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [CustomPriceFormatter()],
                ),
              ),
            ],
          ),
        ]),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildStepCoffee(ThemeData theme) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        _buildGroupTitle(
          LocaleService.currentLocale == 'uk'
              ? 'Технічні дані'
              : 'Technical Specs',
        ),
        _buildCard([
          _buildInput(
            'Coffee Name',
            (v) => setState(() => _coffeeName = v),
            initialValue: _coffeeName,
            isRequired: true,
            maxLength: 60,
          ),
          _buildInput(
            'Country of origin',
            (v) => setState(() => _originCountry = v),
            initialValue: _originCountry,
            isRequired: true,
            maxLength: 50,
          ),
          _buildInput(
            'Region',
            (v) => setState(() => _region = v),
            initialValue: _region,
            maxLength: 50,
          ),
          _buildInput(
            'Altitude',
            (v) => setState(() => _altitude = v),
            initialValue: _altitude,
            maxLength: 20,
          ),
          _buildInput(
            'Varietals',
            (v) => setState(() => _varieties = v),
            initialValue: _varieties,
            maxLength: 100,
          ),
          _buildInput(
            'Flavor Profile',
            (v) => setState(() => _flavorProfile = v),
            initialValue: _flavorProfile,
            maxLength: 200,
          ),
          _buildDropdown(
            'Processing',
            _process,
            _processingMethods,
            (v) => setState(() => _process = v!),
          ),
          if (_process == 'Other')
            _buildInput(
              'Specify Processing',
              (v) => setState(() => _otherProcess = v),
              isRequired: true,
            ),
          _buildInput(
            'SCA score',
            (v) => setState(() => _scaScore = v),
            initialValue: _scaScore,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              ScaScoreInputFormatter(),
              NumericNoSpaceFormatter(),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) return null;
              final score = double.tryParse(value);
              if (score == null) {
                return LocaleService.currentLocale == 'uk'
                    ? 'Введіть число'
                    : 'Enter a number';
              }
              if (score < 80 || score > 100) {
                return LocaleService.currentLocale == 'uk'
                    ? 'Діапазон 80-100'
                    : 'Range 80-100';
              }
              return null;
            },
          ),
        ]),
        const SizedBox(height: 20),
        _buildGroupTitle(
          LocaleService.currentLocale == 'uk' ? 'Додатково' : 'Additional',
        ),
        _buildCard([
          _buildInput(
            'Farm',
            (v) => setState(() => _farm = v),
            initialValue: _farm,
            maxLength: 60,
          ),
          _buildInput(
            'Wash Station',
            (v) => setState(() => _washStation = v),
            initialValue: _washStation,
            maxLength: 60,
          ),
          _buildInput(
            'Farmer',
            (v) => setState(() => _farmer = v),
            initialValue: _farmer,
            maxLength: 60,
          ),
          _buildInput(
            'Lot #',
            (v) {
              final val = int.tryParse(v);
              if (val != null && val > 100000) {
                // Silently cap or let the user know?
                // For now, let's just update and we'll add a visual warning if needed.
                setState(() => _lotNumber = '100000');
              } else {
                setState(() => _lotNumber = v);
              }
            },
            initialValue: _lotNumber,
            maxLength: 6,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              _LotNumberLimitFormatter(100000),
            ],
          ),
          SwitchListTile(
            title: Text(
              LocaleService.currentLocale == 'uk' ? 'Декаф' : 'Decaf',
              style: GoogleFonts.outfit(color: Colors.white70, fontSize: 13),
            ),
            value: _isDecaf,
            onChanged: (v) => setState(() => _isDecaf = v),
            contentPadding: EdgeInsets.zero,
            activeThumbColor: theme.colorScheme.primary,
          ),
          if (_isDecaf) ...[
            _buildDropdown(
              LocaleService.currentLocale == 'uk'
                  ? 'Метод декафеїнізації'
                  : 'Decaf Process',
              _decafProcess,
              _decafMethods,
              (v) => setState(() => _decafProcess = v!),
            ),
            if (_decafProcess == 'Other')
              _buildInput(
                LocaleService.currentLocale == 'uk'
                    ? 'Вкажіть свій метод'
                    : 'Specify Method',
                (v) => setState(() => _otherProcess = v),
                isRequired: true,
              ),
          ],
        ]),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildStepSensory(ThemeData theme) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        _buildGroupTitle(
          LocaleService.currentLocale == 'uk'
              ? 'Профіль смаку (1-5)'
              : 'Sensory Profile (1-5)',
        ),
        _buildCard([
          _buildSensorySlider(
            'Aroma',
            _aroma,
            (v) => setState(() => _aroma = v),
          ),
          _buildSensorySlider(
            'Sweetness',
            _sweetness,
            (v) => setState(() => _sweetness = v),
          ),
          _buildSensorySlider(
            'Acidity',
            _acidity,
            (v) => setState(() => _acidity = v),
          ),
          _buildSensorySlider(
            'Bitterness',
            _bitterness,
            (v) => setState(() => _bitterness = v),
          ),
          _buildSensorySlider('Body', _body, (v) => setState(() => _body = v)),
          _buildSensorySlider(
            'Intensity',
            _intensity,
            (v) => setState(() => _intensity = v),
          ),
        ]),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildSensorySlider(
    String label,
    double value,
    Function(double) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label.toUpperCase(),
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  color: Colors.white30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value.toInt().toString(),
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  color: const Color(0xFFC8A96E),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 2,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
              tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 1),
            ),
            child: Slider(
              value: value,
              min: 1,
              max: 5,
              divisions: 4,
              activeColor: const Color(0xFFC8A96E),
              inactiveColor: Colors.white10,
              onChanged: onChanged,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                5,
                (i) => Text(
                  '${i + 1}',
                  style: GoogleFonts.outfit(
                    fontSize: 8,
                    color: (i + 1) == value.toInt()
                        ? const Color(0xFFC8A96E)
                        : Colors.white10,
                    fontWeight: (i + 1) == value.toInt()
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyLotsTab({String filterStatus = 'all'}) {
    final lotsAsync = ref.watch(userLotsProvider);
    final filter = ref.watch(myLotsFilterProvider);
    final isUk = LocaleService.currentLocale == 'uk';

    return lotsAsync.when(
      data: (lots) {
        // 1. Initial status filtering (All/Favs/Archive)
        var filteredLots = lots.where((lot) {
          if (lot.isDeletedLocal) return false;
          if (filterStatus == 'favorites') {
            return lot.isFavorite && !lot.isArchived;
          }
          if (filterStatus == 'archive') {
            return lot.isArchived;
          }
          return !lot.isArchived;
        }).toList();

        // 2. Apply discovery filters (Search, Country, Process, etc.)
        filteredLots = _applyMyLotsFilters(filteredLots, filter);

        if (filteredLots.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  filterStatus == 'favorites'
                      ? Icons.favorite_border
                      : (filterStatus == 'archive'
                            ? Icons.archive_outlined
                            : Icons.coffee_outlined),
                  size: 64,
                  color: Colors.white24,
                ),
                const SizedBox(height: 16),
                Text(
                  filterStatus == 'favorites'
                      ? (isUk ? 'Обраних лотів поки немає' : 'No favorites yet')
                      : (filterStatus == 'archive'
                            ? (isUk ? 'Архів порожній' : 'Archive is empty')
                            : (isUk
                                  ? 'Немає активних лотів'
                                  : 'No active lots')),
                  style: GoogleFonts.outfit(color: Colors.white54),
                ),
              ],
            ),
          );
        }

        if (filter.isGrid) {
          return GridView.builder(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 160),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.72,
            ),
            itemCount: filteredLots.length,
            itemBuilder: (context, index) {
              final lot = filteredLots[index];
              return _buildMyLotGridCard(lot);
            },
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 160),
          itemCount: filteredLots.length,
          itemBuilder: (context, index) {
            final lot = filteredLots[index];
            return _buildLotCard(lot);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
    );
  }

  List<CoffeeLotDto> _applyMyLotsFilters(
    List<CoffeeLotDto> lots,
    DiscoveryFilterState filter,
  ) {
    var result = lots.toList();
    // Search filter
    if (filter.search.isNotEmpty) {
      final query = filter.search.toLowerCase();
      result = result.where((lot) {
        return (lot.coffeeName?.toLowerCase().contains(query) ?? false) ||
            (lot.roasteryName?.toLowerCase().contains(query) ?? false) ||
            (lot.region?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    // Origin/Country filter
    if (filter.selectedCountries.isNotEmpty) {
      result = result.where((lot) {
        return filter.selectedCountries.contains(lot.originCountry);
      }).toList();
    }

    // Processing filter
    if (filter.selectedProcesses.isNotEmpty) {
      result = result.where((lot) {
        return filter.selectedProcesses.contains(lot.process);
      }).toList();
    }

    // Flavor filter
    if (filter.selectedFlavorNotes.isNotEmpty) {
      result = result.where((lot) {
        final profile = lot.flavorProfile?.toLowerCase() ?? '';
        return filter.selectedFlavorNotes.any(
          (note) => profile.contains(note.toLowerCase()),
        );
      }).toList();
    }

    // Sort
    switch (filter.sortType) {
      case SortType.alphabetAsc:
        result.sort(
          (a, b) => (a.coffeeName ?? '').compareTo(b.coffeeName ?? ''),
        );
        break;
      case SortType.alphabetDesc:
        result.sort(
          (a, b) => (b.coffeeName ?? '').compareTo(a.coffeeName ?? ''),
        );
        break;
      case SortType.priceAsc:
        result.sort((a, b) => _getLotPrice(a).compareTo(_getLotPrice(b)));
        break;
      case SortType.priceDesc:
        result.sort((a, b) => _getLotPrice(b).compareTo(_getLotPrice(a)));
        break;
      case SortType.dateAsc:
        result.sort(
          (a, b) => (a.createdAt ?? DateTime(0)).compareTo(
            b.createdAt ?? DateTime(0),
          ),
        );
        break;
      case SortType.dateDesc:
        result.sort(
          (a, b) => (b.createdAt ?? DateTime(0)).compareTo(
            a.createdAt ?? DateTime(0),
          ),
        );
        break;
      default:
        break;
    }

    return result;
  }

  Widget _buildMiniInfo(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0.5),
            child: Icon(icon, size: 12, color: const Color(0xFFC8A96E)),
          ),
          const SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.only(bottom: 1.0),
            child: Text(
              text,
              style: GoogleFonts.outfit(
                fontSize: 10,
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSensoryBars(Map<String, dynamic> points) {
    final theme = Theme.of(context);
    final isUk = LocaleService.currentLocale == 'uk';

    final attributes = [
      {'key': 'aroma', 'uk': 'Аромат', 'en': 'Aroma'},
      {'key': 'sweetness', 'uk': 'Солодкість', 'en': 'Sweetness'},
      {'key': 'acidity', 'uk': 'Кислотність', 'en': 'Acidity'},
      {'key': 'bitterness', 'uk': 'Гіркота', 'en': 'Bitterness'},
      {'key': 'body', 'uk': 'Тіло', 'en': 'Body'},
      {'key': 'intensity', 'uk': 'Інтенсивність', 'en': 'Intensity'},
    ];

    return Column(
      children: attributes.map((attr) {
        final value = (points[attr['key']] as num?)?.toDouble() ?? 3.0;
        final label = isUk ? attr['uk']! : attr['en']!;

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label.toUpperCase(),
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      color: Colors.white30,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    value.toStringAsFixed(1),
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: List.generate(5, (i) {
                  final segmentValue = (i + 1).toDouble();
                  final isActive = segmentValue <= value.ceil();
                  // For partial segments (e.g. 3.5), we could do more complex stuff,
                  // but 5 discrete segments is cleaner as per design.

                  return Expanded(
                    child: Container(
                      height: 2.5,
                      margin: EdgeInsets.only(right: i < 4 ? 4 : 0),
                      decoration: BoxDecoration(
                        color: isActive
                            ? theme.colorScheme.primary.withValues(alpha: 0.8)
                            : Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color: theme.colorScheme.primary.withValues(
                                    alpha: 0.2,
                                  ),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  double _getLotPrice(CoffeeLotDto lot) {
    final p = lot.pricing['retail_250'];
    if (p == null) return 0.0;
    if (p is num) return p.toDouble();
    return double.tryParse(p.toString().replaceAll(RegExp(r'[^0-9.]'), '')) ??
        0.0;
  }

  Widget _buildMyLotGridCard(CoffeeLotDto lot) {
    final theme = Theme.of(context);
    final isSelected = _selectedLotIds.contains(lot.id);
    final isSelectionMode = _selectedLotIds.isNotEmpty;

    return PressableScale(
      onLongPress: () {
        if (!isSelectionMode) {
          ref.read(settingsProvider.notifier).triggerHeavyVibrate();
          setState(() => _selectedLotIds.add(lot.id));
        }
      },
      onTap: () {
        if (isSelectionMode) {
          ref.read(settingsProvider.notifier).triggerSelectionVibrate();
          setState(() {
            if (isSelected) {
              _selectedLotIds.remove(lot.id);
            } else {
              _selectedLotIds.add(lot.id);
            }
          });
        } else {
          ref.read(settingsProvider.notifier).triggerSelectionVibrate();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CustomLotDetailScreen(lot: lot)),
          );
        }
      },
      child: GlassContainer(
        padding: const EdgeInsets.all(12),
        opacity: isSelected ? 0.2 : 0.1,
        borderRadius: 24,
        borderColor: isSelected
            ? theme.colorScheme.primary.withValues(alpha: 0.6)
            : Colors.white.withValues(alpha: 0.08),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Score Badge (Top Left)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: theme.colorScheme.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        lot.scaScore ?? '85',
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'SCA',
                        style: GoogleFonts.outfit(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Title
                Text(
                  lot.coffeeName ?? 'Unnamed',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                Text(
                  (lot.roasteryName ?? 'Personal').toUpperCase(),
                  style: GoogleFonts.outfit(
                    fontSize: 9,
                    color: Colors.white24,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 14),
                // 5-Segment Sensory Bars
                _sensoryFiveSegmentBarSmall(
                  label: LocaleService.currentLocale == 'uk'
                      ? 'Гіркота'
                      : 'Bitterness',
                  value: (lot.sensoryPoints['bitterness'] ?? 3).toDouble(),
                  theme: theme,
                ),
                _sensoryFiveSegmentBarSmall(
                  label: LocaleService.currentLocale == 'uk'
                      ? 'Кислотність'
                      : 'Acidity',
                  value: (lot.sensoryPoints['acidity'] ?? 3).toDouble(),
                  theme: theme,
                ),
                _sensoryFiveSegmentBarSmall(
                  label: LocaleService.currentLocale == 'uk'
                      ? 'Солодкість'
                      : 'Sweetness',
                  value: (lot.sensoryPoints['sweetness'] ?? 3).toDouble(),
                  theme: theme,
                ),
                const Spacer(),
                // Bottom Info
                Text(
                  '${lot.originCountry} • ${lot.process}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(fontSize: 9, color: Colors.white38),
                ),
              ],
            ),
            // Heart or Selection Mark (Top Right)
            Positioned(
              top: 0,
              right: 0,
              child: isSelectionMode
                  ? Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : Colors.white24,
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.check,
                        size: 10,
                        color: isSelected ? Colors.black : Colors.transparent,
                      ),
                    )
                  : PressableScale(
                      onTap: () async {
                        ref.read(settingsProvider.notifier).triggerVibrate();
                        // Toggle favorite logic
                        await _toggleFavorite(lot);
                      },
                      child: Icon(
                        lot.isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        size: 14,
                        color: lot.isFavorite
                            ? Colors.redAccent
                            : Colors.white24,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sensoryFiveSegmentBarSmall({
    required String label,
    required double value,
    required ThemeData theme,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 55,
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 8.5,
                color: Colors.white38,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Row(
              children: List.generate(5, (index) {
                final isFilled = index < value.toInt();
                return Expanded(
                  child: Container(
                    height: 3.5,
                    margin: const EdgeInsets.only(right: 2),
                    decoration: BoxDecoration(
                      color: isFilled
                          ? theme.colorScheme.primary
                          : Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value.toInt().toString(),
            style: GoogleFonts.outfit(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLotCard(CoffeeLotDto lot) {
    final theme = Theme.of(context);
    final isUk = LocaleService.currentLocale == 'uk';
    final isSelected = _selectedLotIds.contains(lot.id);
    final isSelectionMode = _selectedLotIds.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Dismissible(
        key: Key(
          'lot_${lot.id}_${isSelectionMode ? "select" : (_expandedLotId == lot.id ? "expanded" : "swipe")}',
        ),
        direction: (isSelectionMode || _expandedLotId == lot.id)
            ? DismissDirection.none
            : DismissDirection.horizontal,
        background: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF3E2723).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(24),
          ),
          margin: const EdgeInsets.only(bottom: 16),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GlassContainer(
                width: 38,
                height: 38,
                padding: EdgeInsets.zero,
                opacity: 0.2,
                borderRadius: 12,
                child: const Center(
                  child: Icon(
                    Icons.edit_rounded,
                    color: Color(0xFF8D6E63),
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        secondaryBackground: Container(
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(24),
          ),
          margin: const EdgeInsets.only(bottom: 16),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GlassContainer(
                width: 38,
                height: 38,
                padding: EdgeInsets.zero,
                opacity: 0.2,
                borderRadius: 12,
                child: const Center(
                  child: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.redAccent,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        onUpdate: (details) {
          if (details.reached && !details.previousReached) {
            ref.read(settingsProvider.notifier).triggerVibrate();
          }
        },
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            final confirmed = await _showDeleteConfirmation(lot);
            if (confirmed) {
              _deleteLotWithUndo(lot);
              return true;
            }
          } else if (direction == DismissDirection.startToEnd) {
            setState(() {
              _isAdding = true;
              _populateFields(lot);
            });
          }
          return false;
        },
        child: PressableScale(
          onTap: () async {
            ref.read(settingsProvider.notifier).triggerVibrate();
            if (!mounted) return;
            if (isSelectionMode) {
              setState(() {
                if (isSelected) {
                  _selectedLotIds.remove(lot.id);
                } else {
                  _selectedLotIds.add(lot.id);
                }
              });
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CustomLotDetailScreen(lot: lot),
                ),
              );
            }
          },
          onLongPress: () {
            if (!isSelectionMode) {
              ref.read(settingsProvider.notifier).triggerSelectionVibrate();
              setState(() => _selectedLotIds.add(lot.id));
            }
          },
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: isSelectionMode ? 32 : 0,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isSelectionMode ? 1 : 0,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.colorScheme.primary
                                : Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : Colors.white24,
                              width: 1.5,
                            ),
                          ),
                          child: Icon(
                            Icons.check,
                            size: 14,
                            color: isSelected
                                ? Colors.black
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GlassContainer(
                  padding: EdgeInsets.zero,
                  opacity: isSelected ? 0.2 : 0.1,
                  borderRadius: 24,
                  borderColor: isSelected
                      ? theme.colorScheme.primary.withValues(alpha: 0.6)
                      : Colors.white.withValues(alpha: 0.08),
                  child: Stack(
                    children: [
                      ExpansionTile(
                        onExpansionChanged: (expanded) {
                          if (!isSelectionMode) {
                            setState(
                              () => _expandedLotId = expanded ? lot.id : null,
                            );
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        collapsedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.1,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              lot.scaScore ?? '85',
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          lot.coffeeName ?? 'Unnamed',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lot.roasteryName ?? 'Personal',
                              style: GoogleFonts.outfit(
                                fontSize: 11,
                                color: Colors.white38,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildSensoryThreeScale(lot.sensoryPoints),
                            if (lot.flavorProfile?.isNotEmpty ?? false) ...[
                              const SizedBox(height: 4),
                              Text(
                                lot.flavorProfile!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.outfit(
                                  fontSize: 10,
                                  color: Colors.white54,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 22,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                child: Row(
                                  children: [
                                    _buildMiniInfo(
                                      Icons.star_outline_rounded,
                                      '${lot.scaScore ?? "85"} SCA',
                                    ),
                                    const SizedBox(width: 12),
                                    _buildMiniInfo(
                                      Icons.location_on_outlined,
                                      lot.region?.split(',').first ?? '-',
                                    ),
                                    const SizedBox(width: 12),
                                    _buildMiniInfo(
                                      Icons.opacity_outlined,
                                      lot.process ?? '-',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (lot.roastDate != null) ...[
                              const SizedBox(height: 12),
                              FreshnessBar(
                                roastDate: lot.roastDate!,
                                openedAt: lot.openedAt,
                                isOpen: lot.isOpen,
                                isGround: lot.isGround,
                              ),
                            ],
                          ],
                        ),
                        trailing: const SizedBox.shrink(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_expandedLotId == lot.id) ...[
                                  const SizedBox(height: 24),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 40,
                                    ),
                                    child: _buildSensoryBars(lot.sensoryPoints),
                                  ),
                                  const SizedBox(height: 32),
                                  const Divider(color: Colors.white10),
                                  const SizedBox(height: 16),
                                  Center(
                                    child: SensoryRadarChart(
                                      interactive: false,
                                      staticValues: lot.sensoryPoints.map(
                                        (k, v) =>
                                            MapEntry(k, (v as num).toDouble()),
                                      ),
                                      height: 300,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                                const SizedBox(height: 20),
                                const Divider(color: Colors.white10),
                                const SizedBox(height: 12),
                                _buildDetailRow(
                                  isUk ? 'Походження' : 'Origin',
                                  '${lot.originCountry ?? "-"}, ${lot.region ?? "-"}',
                                ),
                                _buildDetailRow(
                                  isUk ? 'Фермер' : 'Farmer',
                                  lot.farmer ?? '-',
                                ),
                                if (lot.openedAt != null)
                                  _buildDetailRow(
                                    isUk ? 'Відкрито' : 'Opened',
                                    '${lot.openedAt!.day}.${lot.openedAt!.month}.${lot.openedAt!.year}',
                                  ),
                                if (lot.pricing.isNotEmpty) ...[
                                  const SizedBox(height: 12),
                                  Text(
                                    isUk ? 'ЦІНИ' : 'PRICES',
                                    style: GoogleFonts.outfit(
                                      fontSize: 10,
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  _buildPriceGrid(lot.pricing),
                                ],
                              ],
                            ),
                          ),
                        ], // End ExpansionTile children
                      ), // End ExpansionTile
                      if (!isSelectionMode)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: PressableScale(
                            onTap: () => _toggleFavorite(lot),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                lot.isFavorite
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_outline_rounded,
                                color: lot.isFavorite
                                    ? Colors.redAccent
                                    : Colors.white24,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: GoogleFonts.outfit(fontSize: 11, color: Colors.white24),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.outfit(fontSize: 11, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceGrid(Map<String, dynamic> pricing) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildPriceRow(
            '250g',
            pricing['retail_250'],
            pricing['wholesale_250'],
          ),
          const SizedBox(height: 8),
          _buildPriceRow('1kg', pricing['retail_1k'], pricing['wholesale_1k']),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String size, dynamic retail, dynamic wholesale) {
    return Row(
      children: [
        Text(
          size,
          style: GoogleFonts.outfit(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.white38,
          ),
        ),
        const Spacer(),
        Text(
          'R: ${retail ?? "-"} ₴',
          style: GoogleFonts.outfit(fontSize: 11, color: Colors.white70),
        ),
        const SizedBox(width: 16),
        Text(
          'W: ${wholesale ?? "-"} ₴',
          style: GoogleFonts.outfit(fontSize: 11, color: Colors.white70),
        ),
      ],
    );
  }

  Future<bool> _showDeleteConfirmation(CoffeeLotDto lot) async {
    final isUk = LocaleService.currentLocale == 'uk';
    return await showDialog<bool>(
          context: context,
          barrierColor: Colors.black.withValues(alpha: 0.8),
          builder: (context) => Center(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: GlassContainer(
                borderRadius: 40,
                padding: const EdgeInsets.all(32),
                opacity: 0.12,
                blur: 35,
                borderColor: Colors.white.withValues(alpha: 0.1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.redAccent.withValues(alpha: 0.2),
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.delete_sweep_rounded,
                        size: 40,
                        color: Colors.redAccent,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      isUk ? 'ВИДАЛИТИ ЛОТ?' : 'DELETE LOT?',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      isUk
                          ? 'Ви впевнені, що хочете остаточно видалити ${lot.coffeeName}?'
                          : 'Are you sure you want to permanently delete ${lot.coffeeName}?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        color: Colors.white60,
                        fontSize: 14,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 36),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDialogButton(
                            label: isUk ? 'СКАСУВАТИ' : 'CANCEL',
                            onTap: () => Navigator.pop(context, false),
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildDialogButton(
                            label: isUk ? 'ВИДАЛИТИ' : 'DELETE',
                            onTap: () {
                              ref
                                  .read(settingsProvider.notifier)
                                  .triggerHeavyVibrate();
                              Navigator.pop(context, true);
                            },
                            color: Colors.redAccent,
                            isPrimary: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ) ??
        false;
  }

  Future<void> _deleteLotWithUndo(CoffeeLotDto lot) async {
    final database = ref.read(databaseProvider);
    final isUk = LocaleService.currentLocale == 'uk';
    bool undone = false;

    // Show Modern Glassy Undo Timer
    ModernUndoTimer.show(
      context,
      message: isUk ? 'Видалено 1 ${_getPluralElement(1)}' : '1 item deleted',
      onUndo: () async {
        undone = true;
        await (database.update(
          database.coffeeLots,
        )..where((t) => t.id.equals(lot.id))).write(
          const CoffeeLotsCompanion(
            isDeletedLocal: Value(false),
            isSynced: Value(false),
          ),
        );
        ref.invalidate(userLotsProvider);
      },
      onDismiss: () {
        if (!undone) {
          // Sync to cloud after timeout
          ref.read(syncServiceProvider).syncLots().catchError((e) {
            debugPrint('Sync after delete failed: $e');
          });
        }
      },
    );

    // Mark as deleted locally using write() to preserve other fields
    await (database.update(
      database.coffeeLots,
    )..where((t) => t.id.equals(lot.id))).write(
      const CoffeeLotsCompanion(
        isDeletedLocal: Value(true),
        isSynced: Value(false),
      ),
    );

    // Update UI
    ref.invalidate(userLotsProvider);
  }

  Future<void> _toggleFavorite(CoffeeLotDto lot) async {
    ref.read(settingsProvider.notifier).triggerVibrate();
    final database = ref.read(databaseProvider);
    await (database.update(
      database.coffeeLots,
    )..where((t) => t.id.equals(lot.id))).write(
      CoffeeLotsCompanion(
        isFavorite: Value(!lot.isFavorite),
        isSynced: const Value(false),
      ),
    );
    ref.invalidate(userLotsProvider);
    // Explicit sync trigger
    ref.read(syncServiceProvider).syncLots();
  }

  Future<void> _handleBulkFavorite() async {
    if (_selectedLotIds.isEmpty) return;
    final database = ref.read(databaseProvider);

    // Check if any in selection are NOT favorite
    final lots = await ref.read(userLotsProvider.future);
    final selectedLots = lots
        .where((l) => _selectedLotIds.contains(l.id))
        .toList();
    final allFavorite = selectedLots.every((l) => l.isFavorite);

    for (final id in _selectedLotIds) {
      await (database.update(
        database.coffeeLots,
      )..where((t) => t.id.equals(id))).write(
        CoffeeLotsCompanion(
          isFavorite: Value(!allFavorite),
          isSynced: const Value(false),
        ),
      );
    }

    setState(() => _selectedLotIds.clear());
    ref.invalidate(userLotsProvider);
    ref.read(syncServiceProvider).syncLots();
    ref.read(settingsProvider.notifier).triggerVibrate();
  }

  Future<void> _handleBulkArchive() async {
    if (_selectedLotIds.isEmpty) return;
    final database = ref.read(databaseProvider);

    // Check if any in selection are NOT archived
    final lots = await ref.read(userLotsProvider.future);
    final selectedLots = lots
        .where((l) => _selectedLotIds.contains(l.id))
        .toList();
    final allArchived = selectedLots.every((l) => l.isArchived);

    for (final id in _selectedLotIds) {
      await (database.update(
        database.coffeeLots,
      )..where((t) => t.id.equals(id))).write(
        CoffeeLotsCompanion(
          isArchived: Value(!allArchived),
          isSynced: const Value(false),
        ),
      );
    }

    setState(() => _selectedLotIds.clear());
    ref.invalidate(userLotsProvider);
    ref.read(syncServiceProvider).syncLots();
    ref.read(settingsProvider.notifier).triggerVibrate();
  }

  Future<void> _handleBulkDelete() async {
    if (_selectedLotIds.isEmpty) return;
    final database = ref.read(databaseProvider);
    final isUk = LocaleService.currentLocale == 'uk';

    final List<String> idsToDelete = List.from(_selectedLotIds);
    bool undone = false;

    // Show Modern Glassy Undo Timer
    ModernUndoTimer.show(
      context,
      message: isUk
          ? 'Видалено ${idsToDelete.length} ${_getPluralElement(idsToDelete.length)}'
          : 'Deleted ${idsToDelete.length} ${idsToDelete.length == 1 ? 'item' : 'items'}',
      onUndo: () async {
        undone = true;
        for (final id in idsToDelete) {
          await (database.update(
            database.coffeeLots,
          )..where((t) => t.id.equals(id))).write(
            const CoffeeLotsCompanion(
              isDeletedLocal: Value(false),
              isSynced: Value(false),
            ),
          );
        }
        ref.invalidate(userLotsProvider);
      },
      onDismiss: () {
        if (!undone) {
          ref.read(syncServiceProvider).syncLots();
        }
      },
    );

    // Initial local delete
    for (final id in idsToDelete) {
      await (database.update(
        database.coffeeLots,
      )..where((t) => t.id.equals(id))).write(
        const CoffeeLotsCompanion(
          isDeletedLocal: Value(true),
          isSynced: Value(false),
        ),
      );
    }

    setState(() => _selectedLotIds.clear());
    ref.invalidate(userLotsProvider);
    ref.read(settingsProvider.notifier).triggerHeavyVibrate();
  }

  String _getPluralElement(int n) {
    final count = n % 100;
    if (count >= 11 && count <= 19) return 'елементів';
    final lastDigit = n % 10;
    if (lastDigit == 1) return 'елемент';
    if (lastDigit >= 2 && lastDigit <= 4) return 'елементи';
    return 'елементів';
  }

  Widget _buildBottomActions(ThemeData theme) {
    final isNavBarVisible = ref.watch(navBarVisibleProvider);
    final navBarHeight = ref.watch(navBarHeightProvider);

    final double adaptiveBottom = isNavBarVisible ? (navBarHeight + 8.0) : 56.0;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, 0, 24, adaptiveBottom),
        child: GlassContainer(
          padding: EdgeInsets.zero,
          opacity: 0.15,
          borderRadius: 24,
          borderColor: theme.colorScheme.primary.withValues(alpha: 0.3),
          child: TextButton(
            onPressed: _saveLot,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Center(
              child: Text(
                widget.initialLot != null
                    ? (LocaleService.currentLocale == 'uk'
                          ? 'ОНОВИТИ ЛОТ'
                          : 'UPDATE LOT')
                    : (LocaleService.currentLocale == 'uk'
                          ? 'ЗБЕРЕГТИ ЛОТ'
                          : 'SAVE LOT'),
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) => GlassContainer(
    padding: const EdgeInsets.all(20),
    opacity: 0.05,
    borderRadius: 24,
    borderColor: Colors.white.withValues(alpha: 0.1),
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(children: children),
  );

  Widget _buildDialogButton({
    required String label,
    required VoidCallback onTap,
    required Color color,
    bool isPrimary = false,
  }) {
    return PressableScale(
      onTap: () {
        ref.read(settingsProvider.notifier).triggerSelectionVibrate();
        onTap();
      },
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          border: Border.all(
            color: isPrimary
                ? color.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.15),
            width: 1.5,
          ),
          boxShadow: [
            if (isPrimary)
              BoxShadow(
                color: color.withValues(alpha: 0.15),
                blurRadius: 20,
                spreadRadius: 2,
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(27),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: isPrimary
                  ? color.withValues(alpha: 0.25)
                  : Colors.white.withValues(alpha: 0.08),
              child: Text(
                label,
                style: GoogleFonts.outfit(
                  color: isPrimary ? Colors.white : Colors.white70,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  letterSpacing: 1.8,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGroupTitle(String title) => Padding(
    padding: const EdgeInsets.only(left: 4, bottom: 12),
    child: Text(
      title,
      style: GoogleFonts.outfit(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 0.5,
      ),
    ),
  );

  Widget _buildInput(
    String label,
    Function(String) onChanged, {
    String? initialValue,
    bool isRequired = false,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () =>
              ref.read(settingsProvider.notifier).triggerSelectionVibrate(),
          borderRadius: BorderRadius.circular(16),
          highlightColor: Colors.white.withValues(alpha: 0.05),
          splashColor: Colors.white.withValues(alpha: 0.05),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      label.toUpperCase(),
                      style: GoogleFonts.outfit(
                        fontSize: 10,
                        color: Colors.white38,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    if (isRequired) ...[
                      const SizedBox(width: 4),
                      Text(
                        '*',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: const Color(0xFFC8A96E),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
                TextFormField(
                  initialValue: initialValue,
                  onChanged: onChanged,
                  validator: validator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: keyboardType,
                  maxLength: maxLength,
                  style: GoogleFonts.outfit(color: Colors.white, fontSize: 15),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    counterText: '',
                  ),
                  inputFormatters: [
                    if (keyboardType == TextInputType.number ||
                        keyboardType ==
                            const TextInputType.numberWithOptions(
                              decimal: true,
                            )) ...[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                      if (label.toLowerCase().contains('ціна') ||
                          label.toLowerCase().contains('price'))
                        CustomPriceFormatter()
                      else
                        NumericNoSpaceFormatter(),
                    ] else ...[
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Zа-яА-ЯіІїЇєЄґҐ0-9\s.,()\-№#]'),
                      ),
                      DoubleSpaceToDotFormatter(),
                      StrictPunctuationFormatter(),
                    ],
                    if (maxLength != null)
                      LengthLimitingTextInputFormatter(maxLength),
                    ...?inputFormatters,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: GoogleFonts.outfit(
              fontSize: 10,
              color: Colors.white38,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          DropdownButton<String>(
            value: value,
            isExpanded: true,
            dropdownColor: const Color(0xFF1A1614),
            underline: Container(height: 1, color: Colors.white10),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white24,
              size: 18,
            ),
            items: items
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildSensoryThreeScale(Map<String, dynamic> sensory) {
    final theme = Theme.of(context);
    final isUk = LocaleService.currentLocale == 'uk';

    final attributes = [
      {'key': 'bitterness', 'label': isUk ? 'Гіркота' : 'Bitterness'},
      {'key': 'acidity', 'label': isUk ? 'Кислотність' : 'Acidity'},
      {'key': 'sweetness', 'label': isUk ? 'Солодкість' : 'Sweetness'},
    ];

    return Row(
      children: attributes.map((attr) {
        final value = (sensory[attr['key']] ?? 3).toDouble();
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: attr['key'] == 'sweetness' ? 0 : 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attr['label']!.toUpperCase(),
                  style: GoogleFonts.outfit(
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    color: Colors.white24,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: List.generate(5, (i) {
                    final isActive = i < value.toInt();
                    return Expanded(
                      child: Container(
                        height: 2.5,
                        margin: EdgeInsets.only(right: i < 4 ? 2 : 0),
                        decoration: BoxDecoration(
                          color: isActive
                              ? theme.colorScheme.primary
                              : Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class FreshnessBar extends ConsumerWidget {
  final DateTime roastDate;
  final DateTime? openedAt;
  final bool isOpen;
  final bool isGround;

  const FreshnessBar({
    super.key,
    required this.roastDate,
    this.openedAt,
    this.isOpen = false,
    this.isGround = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // If openedAt is set, we calculate freshness strictly from that date.
    // Otherwise, we use roastDate.
    final referenceDate = openedAt ?? roastDate;
    final daysPassed = DateTime.now().difference(referenceDate).inDays;

    int totalDaysAllowed;
    if (isGround) {
      totalDaysAllowed = 7;
    } else if (openedAt != null || isOpen) {
      totalDaysAllowed = 9;
    } else {
      totalDaysAllowed = 90;
    }

    final daysRemaining = math.max(0, totalDaysAllowed - daysPassed);
    final progress = (daysRemaining / totalDaysAllowed).clamp(0.0, 1.0);

    Color color;
    if (progress > 0.5) {
      // Green to Yellow
      color = Color.lerp(
        Colors.yellowAccent,
        Colors.greenAccent,
        (progress - 0.5) / 0.5,
      )!;
    } else {
      // Yellow to Red
      color = Color.lerp(
        Colors.redAccent,
        Colors.yellowAccent,
        progress / 0.5,
      )!;
    }

    final isUk = LocaleService.currentLocale == 'uk';
    String daysText;
    if (daysRemaining == 0) {
      daysText = isUk ? 'Термін вийшов' : 'Expired';
    } else {
      daysText = isUk ? '$daysRemaining дн.' : '$daysRemaining days';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ref.t('freshness'),
              style: GoogleFonts.outfit(
                fontSize: 9,
                color: Colors.white24,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              daysText,
              style: GoogleFonts.outfit(
                fontSize: 9,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          height: 3,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Stack(
            children: [
              FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color.withValues(alpha: 0.3), color],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomPriceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;
    String text = newValue.text.replaceAll(' ', '').replaceAll(',', '');
    final parts = text.split('.');
    String whole = parts[0];
    String? decimal = parts.length > 1 ? parts[1] : null;

    if (whole.length > 5) whole = whole.substring(0, 5);

    if (whole.length > 3) {
      whole =
          '${whole.substring(0, whole.length - 3)},${whole.substring(whole.length - 3)}';
    }

    String result = whole;
    if (parts.length > 1) {
      result += '.${decimal?.substring(0, math.min(decimal.length, 2)) ?? ''}';
    }

    return TextEditingValue(
      text: result,
      selection: TextSelection.collapsed(offset: result.length),
    );
  }
}

class NumericNoSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.contains(' ') || newValue.text.contains(',')) {
      return oldValue;
    }
    return newValue;
  }
}

class ScaScoreInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;
    String text = newValue.text;

    if (text.contains(',')) return oldValue;

    if (text.startsWith('1')) {
      if (text.length > 1 && text[1] != '0') {
        return const TextEditingValue(
          text: '99.9',
          selection: TextSelection.collapsed(offset: 4),
        );
      }
      if (text.length > 3) return oldValue;
      return newValue;
    }

    final first = text[0];
    if (first != '8' && first != '9') return oldValue;
    if (text.length > 1 && text[1] == '.') return oldValue;

    if (text.length == 3 && !text.contains('.')) {
      String newText = '${text.substring(0, 2)}.${text.substring(2)}';
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
    if (text.contains('.') && text.length > 4) return oldValue;
    if (RegExp(r'\.').allMatches(text).length > 1) return oldValue;
    if (!RegExp(r'^\d{0,2}(\.\d{0,1})?$').hasMatch(text) && text != '100') {
      return oldValue;
    }
    return newValue;
  }
}

class DoubleSpaceToDotFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length < 2) return newValue;
    String text = newValue.text;
    if (text.startsWith(' ')) text = text.trimLeft();

    if (text.contains('  ')) {
      text = text.replaceAll('  ', '. ');
    }

    if ('.'.allMatches(text).length > 3) return oldValue;

    text = text.replaceAll(RegExp(r'\s{2,}'), ' ');

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class StrictPunctuationFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (RegExp(r'\.').allMatches(text).length > 3) return oldValue;

    final symbols = [',', '-', '#', '№', '(', ')'];
    for (final sym in symbols) {
      if (RegExp(RegExp.escape(sym) + r'{2,}').hasMatch(text)) {
        return oldValue;
      }
    }

    return newValue;
  }
}

class _BulkActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final ThemeData theme;
  final Color? color;

  const _BulkActionButton({
    required this.icon,
    required this.onTap,
    required this.theme,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(
            icon,
            color: color ?? theme.colorScheme.primary,
            size: 24,
          ),
        ),
      ),
    );
  }
}

class ModernUndoTimer {
  static void show(
    BuildContext context, {
    required String message,
    required VoidCallback onUndo,
    required VoidCallback onDismiss,
    int durationSeconds = 5,
  }) {
    final entry = OverlayEntry(
      builder: (context) => _ModernUndoWidget(
        message: message,
        onUndo: onUndo,
        onDismiss: onDismiss,
        durationSeconds: durationSeconds,
      ),
    );
    Overlay.of(context).insert(entry);
  }
}

class _ModernUndoWidget extends StatefulWidget {
  final String message;
  final VoidCallback onUndo;
  final VoidCallback onDismiss;
  final int durationSeconds;

  const _ModernUndoWidget({
    required this.message,
    required this.onUndo,
    required this.onDismiss,
    required this.durationSeconds,
  });

  @override
  State<_ModernUndoWidget> createState() => _ModernUndoWidgetState();
}

class _ModernUndoWidgetState extends State<_ModernUndoWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.durationSeconds),
    );
    _controller.forward().then((_) {
      if (mounted && _isVisible) {
        _hide();
      }
    });
  }

  void _hide() {
    if (!mounted) return;
    setState(() => _isVisible = false);
    Future.delayed(const Duration(milliseconds: 300), () {
      widget.onDismiss();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutBack,
      bottom: _isVisible ? 80 : -100,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: GlassContainer(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          opacity: 0.2, // More premium deeper glass
          borderRadius: 24,
          borderColor: Colors.white.withValues(alpha: 0.15),
          child: Row(
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) => Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        value: 1.0 - _controller.value,
                        strokeWidth: 3,
                        color: const Color(0xFFC8A96E),
                        backgroundColor: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                    const Icon(
                      Icons.timer_outlined,
                      size: 14,
                      color: Colors.white60,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.message,
                  style: GoogleFonts.outfit(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              PressableScale(
                onTap: () {
                  widget.onUndo();
                  _hide();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFC8A96E),
                        const Color(0xFFC8A96E).withValues(alpha: 0.7),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFC8A96E).withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    LocaleService.currentLocale == 'uk' ? 'ВІДМІНИТИ' : 'UNDO',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                      letterSpacing: 1.1,
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

class _LotNumberLimitFormatter extends TextInputFormatter {
  final int max;
  _LotNumberLimitFormatter(this.max);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;
    final n = int.tryParse(newValue.text);
    if (n != null && n <= max) return newValue;
    return oldValue;
  }
}
