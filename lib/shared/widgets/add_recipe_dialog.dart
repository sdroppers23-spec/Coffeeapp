import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' hide Column;
import '../../core/database/app_database.dart';
import '../../core/database/dtos.dart';
import '../../core/supabase/supabase_provider.dart';
import '../../core/database/database_provider.dart';
import '../../core/l10n/app_localizations.dart';
import '../services/toast_service.dart';

// ─── Pour entry (local model) ─────────────────────────────────────────────────
class _PourEntry {
  int? pourNumber;
  double? waterMl;
  double? atMinute;
  int? durationSec;
  String notes;

  _PourEntry({
    this.pourNumber,
    this.waterMl,
    this.atMinute,
    this.durationSec,
    this.notes = '',
  });

  Map<String, dynamic> toJson() => {
        'pourNumber': pourNumber,
        'waterMl': waterMl,
        'atMinute': atMinute,
        'durationSec': durationSec,
        'notes': notes,
      };

  static _PourEntry fromJson(Map<String, dynamic> j) => _PourEntry(
        pourNumber: j['pourNumber'] as int?,
        waterMl: (j['waterMl'] as num?)?.toDouble(),
        atMinute: (j['atMinute'] as num?)?.toDouble(),
        durationSec: j['durationSec'] as int?,
        notes: j['notes'] as String? ?? '',
      );
}

class AddRecipeDialog extends ConsumerStatefulWidget {
  final String lotId;
  final CustomRecipeDto? existingRecipe;
  final String? initialMethod;

  const AddRecipeDialog({
    super.key,
    required this.lotId,
    this.existingRecipe,
    this.initialMethod,
  });

  @override
  ConsumerState<AddRecipeDialog> createState() => _AddRecipeDialogState();
}

class _AddRecipeDialogState extends ConsumerState<AddRecipeDialog> {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;

  // ── Controllers ─────────────────────────────────────────────────────────────
  late TextEditingController _nameCtrl;
  late TextEditingController _coffeeGCtrl;
  late TextEditingController _waterMlCtrl;
  late TextEditingController _grindCtrl;
  late TextEditingController _comandanteCtrl;
  late TextEditingController _ek43Ctrl;
  late TextEditingController _tempCtrl;
  late TextEditingController _notesCtrl;
  late TextEditingController _micronsCtrl;
  late TextEditingController _brewRatioCtrl;
  late TextEditingController _shotTimeCtrl;

  String _selectedGrinder = 'Other';
  late String _method;
  late String _recipeType;

  int _totalPours = 1;
  int _rating = 0;
  List<_PourEntry> _pours = [];

  // Pour controllers (per-row)
  final List<Map<String, TextEditingController>> _pourCtrlsList = [];

  @override
  void initState() {
    super.initState();
    final r = widget.existingRecipe;
    _method = r?.methodKey ?? widget.initialMethod ?? 'V60';
    _recipeType = r?.recipeType ??
        (_method.toLowerCase() == 'espresso' ? 'espresso' : 'filter');

    _nameCtrl = TextEditingController(text: r?.name ?? '');
    _coffeeGCtrl = TextEditingController(
      text: r != null ? r.coffeeGrams.toString() : '15',
    );
    _waterMlCtrl = TextEditingController(
      text: r != null ? r.totalWaterMl.toString() : '250',
    );
    _grindCtrl = TextEditingController(
      text: r != null && r.grindNumber > 0 ? r.grindNumber.toString() : '',
    );
    _comandanteCtrl = TextEditingController(
      text: r != null && r.comandanteClicks > 0
          ? r.comandanteClicks.toString()
          : '',
    );
    _ek43Ctrl = TextEditingController(
      text: r != null && r.ek43Division > 0 ? r.ek43Division.toString() : '',
    );
    _tempCtrl = TextEditingController(
      text: r != null ? r.brewTempC.toString() : '93.0',
    );
    _notesCtrl = TextEditingController(text: r?.notes ?? '');
    _micronsCtrl = TextEditingController(text: r?.microns?.toString() ?? '');
    _brewRatioCtrl = TextEditingController(
      text: r?.brewRatio != null
          ? '1:${r!.brewRatio!.toStringAsFixed(1)}'
          : '1:16.7',
    );
    _selectedGrinder = r?.grinderName ?? 'Other';

    // Load extraction time from pour schedule if espresso
    String initialShotTime = '';
    if (_recipeType == 'espresso' && r != null && r.pours.isNotEmpty) {
      final firstPour = r.pours.first as Map<String, dynamic>;
      initialShotTime = (firstPour['durationSec'] ?? '').toString();
    } else if (_recipeType == 'espresso') {
      initialShotTime = '30';
    }
    _shotTimeCtrl = TextEditingController(text: initialShotTime);

    _rating = r?.rating ?? 4;
    _totalPours = r?.totalPours ?? 1;

    // Listeners for ratio
    _coffeeGCtrl.addListener(_updateRatio);
    _waterMlCtrl.addListener(_updateRatio);

    // Load existing pours or create empty ones
    if (r != null) {
      _pours = r.pours
          .cast<Map<String, dynamic>>()
          .map(_PourEntry.fromJson)
          .toList();
    }

    _syncPourRows();
    _updateRatio();
  }

  void _syncPourRows() {
    // Expand or trim _pours to match _totalPours
    while (_pours.length < _totalPours) {
      _pours.add(_PourEntry(pourNumber: _pours.length + 1));
    }
    while (_pours.length > _totalPours) {
      _pours.removeLast();
    }

    // Dispose old controllers
    for (final m in _pourCtrlsList) {
      for (final c in m.values) {
        c.dispose();
      }
    }
    _pourCtrlsList.clear();

    // Create new controllers
    for (int i = 0; i < _totalPours; i++) {
      final p = _pours[i];
      _pourCtrlsList.add({
        'waterMl': TextEditingController(text: p.waterMl?.toString() ?? ''),
        'atMinute': TextEditingController(text: p.atMinute?.toString() ?? ''),
        'durationSec':
            TextEditingController(text: p.durationSec?.toString() ?? ''),
        'notes': TextEditingController(text: p.notes),
      });
    }
  }

  @override
  void dispose() {
    for (final c in [
      _nameCtrl,
      _coffeeGCtrl,
      _waterMlCtrl,
      _grindCtrl,
      _comandanteCtrl,
      _ek43Ctrl,
      _tempCtrl,
      _notesCtrl,
      _micronsCtrl,
      _brewRatioCtrl,
      _shotTimeCtrl,
    ]) {
      c.dispose();
    }
    for (final m in _pourCtrlsList) {
      for (final c in m.values) {
        c.dispose();
      }
    }
    super.dispose();
  }

  void _updateRatio() {
    final coffee = double.tryParse(_coffeeGCtrl.text.replaceAll(',', '.')) ?? 0;
    final water = double.tryParse(_waterMlCtrl.text.replaceAll(',', '.')) ?? 0;
    if (coffee > 0 && water > 0) {
      final ratio = water / coffee;
      final result = '1:${ratio.toStringAsFixed(1)}';
      if (_brewRatioCtrl.text != result) {
        setState(() {
          _brewRatioCtrl.text = result;
        });
      }
    }
  }

  void _readPourControllers() {
    for (int i = 0; i < _totalPours; i++) {
      final ctrls = _pourCtrlsList[i];
      _pours[i]
        ..pourNumber = i + 1
        ..waterMl = double.tryParse(ctrls['waterMl']!.text)
        ..atMinute = double.tryParse(ctrls['atMinute']!.text)
        ..durationSec = int.tryParse(ctrls['durationSec']!.text)
        ..notes = ctrls['notes']!.text;
    }
  }

  Future<void> _save() async {
    if (_saving) return;
    if (!_formKey.currentState!.validate()) return;
    _readPourControllers();
    setState(() => _saving = true);

    try {
      final db = ref.read(databaseProvider);
      final user = ref.read(supabaseProvider).auth.currentUser;
      if (user == null) return;

      final now = DateTime.now();

      // For Espresso, we simplify the pours to a single "Extraction" event
      if (_recipeType == 'espresso') {
        _totalPours = 1;
        final shotSec = int.tryParse(_shotTimeCtrl.text) ?? 30;
        final yieldWater =
            double.tryParse(_waterMlCtrl.text.replaceAll(',', '.')) ?? 0;
        _pours = [
          _PourEntry(
            pourNumber: 1,
            waterMl: yieldWater,
            atMinute: 0,
            durationSec: shotSec,
            notes: 'Extraction',
          ),
        ];
      }

      final pourJson = jsonEncode(_pours.map((p) => p.toJson()).toList());

      final recipe = CustomRecipesCompanion.insert(
        id: widget.existingRecipe != null
            ? Value(widget.existingRecipe!.id)
            : Value(const Uuid().v4()),
        userId: user.id,
        lotId: Value(widget.lotId),
        methodKey: _method,
        recipeType: Value(_recipeType),
        name: _nameCtrl.text.isEmpty ? 'Recipe' : _nameCtrl.text.trim(),
        coffeeGrams:
            double.tryParse(_coffeeGCtrl.text.replaceAll(',', '.')) ?? 15.0,
        totalWaterMl:
            double.tryParse(_waterMlCtrl.text.replaceAll(',', '.')) ?? 250.0,
        grindNumber: Value(int.tryParse(_grindCtrl.text) ?? 0),
        comandanteClicks: Value(int.tryParse(_comandanteCtrl.text) ?? 0),
        ek43Division: Value(double.tryParse(_ek43Ctrl.text)?.round() ?? 0),
        totalPours: Value(_totalPours),
        pourScheduleJson: Value(pourJson),
        brewTempC:
            Value(double.tryParse(_tempCtrl.text.replaceAll(',', '.')) ?? 93.0),
        notes: Value(_notesCtrl.text),
        rating: Value(_rating),
        createdAt: Value(widget.existingRecipe?.createdAt ?? now),
        updatedAt: Value(now),
        microns: Value(int.tryParse(_micronsCtrl.text)),
        brewRatio:
            Value(double.tryParse(_brewRatioCtrl.text.replaceAll('1:', ''))),
        grinderName: Value(_selectedGrinder),
      );

      if (widget.existingRecipe != null) {
        await db.updateCustomRecipe(recipe);
      } else {
        await db.insertCustomRecipe(recipe);
      }

      if (mounted) {
        ToastService.showSuccess(
            context,
            widget.existingRecipe != null
                ? ref.t('toast_recipe_updated')
                : ref.t('toast_recipe_saved'));
        Navigator.pop(context, true);
      }
    } catch (e) {
      debugPrint('Error saving recipe: $e');
      if (mounted) {
        ToastService.showError(context, 'Failed to save recipe: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (widget.existingRecipe != null
                          ? ref.t('edit_recipe')
                          : ref.t('new_recipe'))
                      .toUpperCase(),
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white54),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Section: General ──────────────────────────────────────────
                      _SectionHeader(ref.t('general')),
                      DropdownButtonFormField<String>(
                        initialValue: _method,
                        dropdownColor: const Color(0xFF1E1E1E),
                        style: GoogleFonts.outfit(color: Colors.white),
                        decoration: _inputDecoration(label: 'METHOD'),
                        items: [
                          'V60',
                          'Chemex',
                          'Aeropress',
                          'Espresso',
                          'Batch Brew',
                          'French Press',
                        ]
                            .map((m) =>
                                DropdownMenuItem(value: m, child: Text(m)))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _method = val;
                              _recipeType =
                                  val.toLowerCase() == 'espresso'
                                      ? 'espresso'
                                      : 'filter';
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      _Field(
                        controller: _nameCtrl,
                        label: ref.t('recipe_name'),
                        hint: 'e.g. Morning V60',
                      ),
                      const SizedBox(height: 12),
                      _RatingRow(
                        rating: _rating,
                        onChanged: (v) => setState(() => _rating = v),
                      ),
                      const SizedBox(height: 24),

                      // ── Section: Coffee & Water ───────────────────────────────────
                      _SectionHeader(_recipeType == 'espresso'
                          ? ref.t('espresso_parameters')
                          : ref.t('coffee_and_water')),
                      Row(
                        children: [
                          Expanded(
                            child: _Field(
                              controller: _coffeeGCtrl,
                              label: '${ref.t('coffee')} (g)',
                              hint: '18',
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _Field(
                              controller: _waterMlCtrl,
                              label: _recipeType == 'espresso'
                                  ? '${ref.t('yield')} (g/ml)'
                                  : '${ref.t('total_water')} (ml)',
                              hint: _recipeType == 'espresso' ? '36' : '300',
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      if (_recipeType == 'espresso') ...[
                        const SizedBox(height: 12),
                        _Field(
                          controller: _shotTimeCtrl,
                          label: '${ref.t('extraction_time')} (s)',
                          hint: '30',
                          keyboardType: TextInputType.number,
                        ),
                      ],
                      const SizedBox(height: 12),
                      _Field(
                        controller: _tempCtrl,
                        label: ref.t('brew_temp'),
                        hint: '93',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 24),

                      // ── Section: Grinder ──────────────────────────────────────────
                      _SectionHeader(ref.t('grinder_settings')),
                      _GrinderDropdown(
                        value: _selectedGrinder,
                        onChanged: (v) {
                          if (v != null) {
                            setState(() {
                              if (_selectedGrinder == 'Comandante Standard' &&
                                  v == 'Comandante Red Clicks') {
                                final clicks =
                                    int.tryParse(_comandanteCtrl.text);
                                if (clicks != null) {
                                  _comandanteCtrl.text = (clicks * 2).toString();
                                }
                              } else if (_selectedGrinder ==
                                      'Comandante Red Clicks' &&
                                  v == 'Comandante Standard') {
                                final clicks =
                                    int.tryParse(_comandanteCtrl.text);
                                if (clicks != null) {
                                  _comandanteCtrl.text = (clicks ~/ 2).toString();
                                }
                              }
                              _selectedGrinder = v;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      if (_selectedGrinder == 'EK43')
                        _Field(
                          controller: _ek43Ctrl,
                          label: ref.t('ek43_division'),
                          hint: '8.5',
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        )
                      else if (_selectedGrinder.contains('Comandante'))
                        _Field(
                          controller: _comandanteCtrl,
                          label: ref.t('comandante_clicks'),
                          hint: '25',
                          keyboardType: TextInputType.number,
                          prefixIcon: Icon(
                            Icons.circle,
                            color: _selectedGrinder == 'Comandante Red Clicks'
                                ? Colors.redAccent
                                : Colors.white24,
                            size: 14,
                          ),
                        )
                      else
                        _Field(
                          controller: _grindCtrl,
                          label: ref.t('grind_settings_label'),
                          hint: '28',
                          keyboardType: TextInputType.number,
                        ),
                      const SizedBox(height: 12),
                      _Field(
                        controller: _micronsCtrl,
                        label: ref.t('microns'),
                        hint: '800',
                        keyboardType: TextInputType.number,
                      ),
                      if (_recipeType == 'espresso') ...[
                        const SizedBox(height: 12),
                        _Field(
                          controller: _brewRatioCtrl,
                          label: ref.t('brew_ratio'),
                          hint: '1:2.0',
                          readOnly: true,
                        ),
                      ],
                      const SizedBox(height: 24),

                      // ── Section: Pour Schedule ────────────────────────────────────
                      if (_recipeType != 'espresso') ...[
                        _SectionHeader(ref.t('pour_schedule')),
                        Row(
                          children: [
                            Text(
                              '${ref.t('number_of_pours')}:',
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 13),
                            ),
                            const SizedBox(width: 16),
                            _CounterWidget(
                              value: _totalPours,
                              min: 1,
                              max: 12,
                              onChanged: (v) => setState(() {
                                _totalPours = v;
                                _syncPourRows();
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ...List.generate(
                          _totalPours,
                          (i) => _PourRow(index: i, ctrls: _pourCtrlsList[i]),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // ── Section: Notes ────────────────────────────────────────────
                      _SectionHeader(ref.t('notes')),
                      _Field(
                        controller: _notesCtrl,
                        label: ref.t('notes_hint'),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _saving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC8A96E),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: _saving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        ref.t('save').toUpperCase(),
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({String? label, String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
      labelStyle: const TextStyle(color: Color(0xFFC8A96E), fontSize: 11),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.05),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFC8A96E), width: 1),
      ),
    );
  }
}

// ─── Section Header ───────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            title.toUpperCase(),
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: const Color(0xFFC8A96E),
              fontSize: 11,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Divider(color: Colors.white10, thickness: 1),
          ),
        ],
      ),
    );
  }
}

// ─── Field Widget ─────────────────────────────────────────────────────────────
class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool dense;
  final bool readOnly;
  final Widget? prefixIcon;

  const _Field({
    required this.controller,
    required this.label,
    this.hint,
    this.keyboardType,
    this.maxLines = 1,
    this.dense = false,
    this.readOnly = false,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      readOnly: readOnly,
      style: GoogleFonts.outfit(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        labelText: label.toUpperCase(),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
        labelStyle: const TextStyle(color: Colors.white38, fontSize: 10),
        prefixIcon: prefixIcon,
        isDense: dense,
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.03),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFC8A96E), width: 1),
        ),
      ),
    );
  }
}

// ─── Pour Row ─────────────────────────────────────────────────────────────────
class _PourRow extends StatelessWidget {
  final int index;
  final Map<String, TextEditingController> ctrls;
  const _PourRow({required this.index, required this.ctrls});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${context.t('pour_index').toUpperCase()} ${index + 1}',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: const Color(0xFFC8A96E),
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _Field(
                  controller: ctrls['waterMl']!,
                  label: context.t('ml'),
                  hint: '50',
                  keyboardType: TextInputType.number,
                  dense: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _Field(
                  controller: ctrls['atMinute']!,
                  label: context.t('min'),
                  hint: '0.5',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  dense: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _Field(
                  controller: ctrls['durationSec']!,
                  label: context.t('sec'),
                  hint: '30',
                  keyboardType: TextInputType.number,
                  dense: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _Field(
            controller: ctrls['notes']!,
            label: context.t('notes').toUpperCase(),
            hint: 'e.g. slow spiral',
            dense: true,
          ),
        ],
      ),
    );
  }
}

// ─── Rating Row ───────────────────────────────────────────────────────────────
class _RatingRow extends StatelessWidget {
  final int rating;
  final void Function(int) onChanged;
  const _RatingRow({required this.rating, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${context.t('rating_label').toUpperCase()}:',
            style: const TextStyle(color: Colors.white38, fontSize: 10)),
        const SizedBox(width: 12),
        ...List.generate(
          5,
          (i) => GestureDetector(
            onTap: () => onChanged(i + 1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Icon(
                i < rating ? Icons.star_rounded : Icons.star_outline_rounded,
                color: const Color(0xFFC8A96E),
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Grinder Dropdown ──────────────────────────────────────────────────────────
class _GrinderDropdown extends StatelessWidget {
  final String value;
  final void Function(String?) onChanged;
  const _GrinderDropdown({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFF1A1714),
          style: GoogleFonts.outfit(color: Colors.white, fontSize: 14),
          items: [
            context.t('other'),
            'EK43',
            'Comandante Standard',
            'Comandante Red Clicks'
          ]
              .map((String val) => DropdownMenuItem<String>(
                    value: val == context.t('other') ? 'Other' : val,
                    child: Text(val),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// ─── Counter Widget ───────────────────────────────────────────────────────────
class _CounterWidget extends StatelessWidget {
  final int value;
  final int min;
  final int max;
  final void Function(int) onChanged;
  const _CounterWidget({
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CircleBtn(
          icon: Icons.remove,
          enabled: value > min,
          onTap: () => onChanged(value - 1),
        ),
        Container(
          width: 40,
          alignment: Alignment.center,
          child: Text(
            '$value',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        _CircleBtn(
          icon: Icons.add,
          enabled: value < max,
          onTap: () => onChanged(value + 1),
        ),
      ],
    );
  }
}

class _CircleBtn extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;
  const _CircleBtn({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: enabled
              ? const Color(0xFFC8A96E).withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.05),
          border: Border.all(
            color: enabled ? const Color(0xFFC8A96E) : Colors.white12,
          ),
        ),
        child: Icon(
          icon,
          size: 18,
          color: enabled ? const Color(0xFFC8A96E) : Colors.white24,
        ),
      ),
    );
  }
}

