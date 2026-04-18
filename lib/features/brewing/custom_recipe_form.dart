import 'dart:convert';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../core/database/dtos.dart';

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

// ─── Form Screen ──────────────────────────────────────────────────────────────
class CustomRecipeFormScreen extends ConsumerStatefulWidget {
  final String methodKey;
  final String? lotId;
  final CustomRecipeDto? existingRecipe;

  final String recipeType;

  const CustomRecipeFormScreen({
    super.key,
    required this.methodKey,
    this.lotId,
    this.existingRecipe,
    this.recipeType = 'filter',
  });

  @override
  ConsumerState<CustomRecipeFormScreen> createState() =>
      _CustomRecipeFormScreenState();
}

class _CustomRecipeFormScreenState
    extends ConsumerState<CustomRecipeFormScreen> {
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

  String _selectedGrinder = 'Other';
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
    _nameCtrl = TextEditingController(text: r?.name ?? '');
    _coffeeGCtrl = TextEditingController(
      text: r != null ? r.coffeeGrams.toString() : '',
    );
    _waterMlCtrl = TextEditingController(
      text: r != null ? r.totalWaterMl.toString() : '',
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
      text: r?.brewRatio != null ? '1:${r!.brewRatio!.toStringAsFixed(1)}' : '',
    );
    _selectedGrinder = r?.grinderName ?? 'Other';
    _recipeType = r?.recipeType ?? widget.recipeType;

    _rating = r?.rating ?? 0;
    _totalPours = r?.totalPours ?? 1;

    // Default values for new Espresso
    if (r == null && _recipeType == 'espresso') {
      _coffeeGCtrl.text = '18.0';
      _waterMlCtrl.text = '36.0';
      _updateRatio();
    }

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
  }

  void _syncPourRows() {
    // Expand or trim _pours to match _totalPours
    while (_pours.length < _totalPours) {
      _pours.add(_PourEntry(pourNumber: _pours.length + 1));
    }
    while (_pours.length > _totalPours) {
      _pours.removeLast();
    }

    // Recreate controllers list
    for (final m in _pourCtrlsList) {
      for (final c in m.values) {
        c.dispose();
      }
    }
    _pourCtrlsList
      ..clear()
      ..addAll(
        List.generate(_totalPours, (i) {
          final p = _pours[i];
          return {
            'waterMl': TextEditingController(text: p.waterMl?.toString() ?? ''),
            'atMinute': TextEditingController(
              text: p.atMinute?.toString() ?? '',
            ),
            'durationSec': TextEditingController(
              text: p.durationSec?.toString() ?? '',
            ),
            'notes': TextEditingController(text: p.notes),
          };
        }),
      );
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
    final coffee = double.tryParse(_coffeeGCtrl.text) ?? 0;
    final water = double.tryParse(_waterMlCtrl.text) ?? 0;
    if (coffee > 0 && water > 0) {
      final ratio = water / coffee;
      final result = '1:${ratio.toStringAsFixed(1)}';
      if (_brewRatioCtrl.text != result) {
        _brewRatioCtrl.text = result;
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
    if (!_formKey.currentState!.validate()) return;
    _readPourControllers();
    setState(() => _saving = true);

    final db = ref.read(databaseProvider);
    final now = DateTime.now();
    final pourJson = jsonEncode(_pours.map((p) => p.toJson()).toList());

    if (widget.existingRecipe != null) {
      // Build a full companion with id for update
      final updateCompanion = CustomRecipesCompanion(
        id: Value(widget.existingRecipe!.id),
        methodKey: Value(widget.methodKey),
        name: Value(_nameCtrl.text.trim()),
        createdAt: Value(
          widget.existingRecipe!.updatedAt ?? now,
        ), // Best effort for createdAt
        updatedAt: Value(now),
        coffeeGrams: Value(double.tryParse(_coffeeGCtrl.text) ?? 0),

        totalWaterMl: Value(double.tryParse(_waterMlCtrl.text) ?? 0),
        grindNumber: Value(int.tryParse(_grindCtrl.text) ?? 0),
        comandanteClicks: Value(int.tryParse(_comandanteCtrl.text) ?? 0),
        ek43Division: Value(int.tryParse(_ek43Ctrl.text) ?? 0),
        totalPours: Value(_totalPours),
        pourScheduleJson: Value(pourJson),
        brewTempC: Value(double.tryParse(_tempCtrl.text) ?? 93.0),
        notes: Value(_notesCtrl.text),
        rating: Value(_rating),
        userId: Value(''), // v17 compatibility
        recipeType: Value(_recipeType),
        microns: Value(int.tryParse(_micronsCtrl.text)),
        brewRatio: Value(double.tryParse(_brewRatioCtrl.text.replaceAll('1:', ''))),
        grinderName: Value(_selectedGrinder),
      );
      await db.updateCustomRecipe(updateCompanion);
    } else {
      await db.insertCustomRecipe(
        CustomRecipesCompanion.insert(
          methodKey: widget.methodKey,
          lotId: Value(widget.lotId),
          name: _nameCtrl.text.trim(),
          createdAt: Value(now),
          updatedAt: Value(now),

          coffeeGrams: double.tryParse(_coffeeGCtrl.text) ?? 0,
          totalWaterMl: double.tryParse(_waterMlCtrl.text) ?? 0,
          grindNumber: Value(int.tryParse(_grindCtrl.text) ?? 0),
          comandanteClicks: Value(int.tryParse(_comandanteCtrl.text) ?? 0),
          ek43Division: Value(int.tryParse(_ek43Ctrl.text) ?? 0),
          totalPours: Value(_totalPours),
          pourScheduleJson: Value(pourJson),
          brewTempC: Value(double.tryParse(_tempCtrl.text) ?? 93.0),
          notes: Value(_notesCtrl.text),
          rating: Value(_rating),
          userId: '', // v17 compatibility
          recipeType: Value(_recipeType),
          microns: Value(int.tryParse(_micronsCtrl.text)),
          brewRatio: Value(double.tryParse(_brewRatioCtrl.text.replaceAll('1:', ''))),
          grinderName: Value(_selectedGrinder),
        ),
      );
    }

    if (mounted) {
      setState(() => _saving = false);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existingRecipe != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'Edit Recipe' : 'New Recipe',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        actions: [
          if (_saving)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            TextButton(
              onPressed: _save,
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Color(0xFFC8A96E),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ── Name ──────────────────────────────────────────────────────────
            _SectionHeader('General'),
            _Field(
              controller: _nameCtrl,
              label: 'Recipe Name',
              hint: 'e.g. Morning V60 — Light & Bright',
              validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            // ── Rating ────────────────────────────────────────────────────────
            _RatingRow(
              rating: _rating,
              onChanged: (v) => setState(() => _rating = v),
            ),
            const SizedBox(height: 20),

            // ── Coffee & Water ─────────────────────────────────────────────────
            _SectionHeader('Coffee & Water'),
            Row(
              children: [
                Expanded(
                  child: _Field(
                    controller: _coffeeGCtrl,
                    label: 'Coffee (g)',
                    hint: '18',
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Required' : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _Field(
                    controller: _waterMlCtrl,
                    label: 'Total Water (ml)',
                    hint: '300',
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Required' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _Field(
              controller: _tempCtrl,
              label: 'Brew Temperature (°C)',
              hint: '93',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // ── Grinder ────────────────────────────────────────────────────────
            _SectionHeader('Grinder Settings'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedGrinder,
                  isExpanded: true,
                  dropdownColor: const Color(0xFF1A1714),
                  style: GoogleFonts.outfit(color: Colors.white, fontSize: 14),
                  items: ['Other', 'EK43', 'Comandante Standard', 'Comandante Red Clicks']
                      .map((String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) {
                      setState(() {
                        // Handle Comandante conversion logic
                        if (_selectedGrinder == 'Comandante Standard' && v == 'Comandante Red Clicks') {
                          final clicks = int.tryParse(_comandanteCtrl.text);
                          if (clicks != null) _comandanteCtrl.text = (clicks * 2).toString();
                        } else if (_selectedGrinder == 'Comandante Red Clicks' && v == 'Comandante Standard') {
                          final clicks = int.tryParse(_comandanteCtrl.text);
                          if (clicks != null) _comandanteCtrl.text = (clicks ~/ 2).toString();
                        }
                        _selectedGrinder = v;
                      });
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (_selectedGrinder == 'EK43')
              _Field(
                controller: _ek43Ctrl,
                label: 'Mahlkoenig EK43 Division',
                hint: '8.5',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              )
            else if (_selectedGrinder.contains('Comandante'))
              _Field(
                controller: _comandanteCtrl,
                label: 'Comandante Clicks',
                hint: '25',
                keyboardType: TextInputType.number,
                prefixIcon: Icon(
                  Icons.circle,
                  color: _selectedGrinder == 'Comandante Red Clicks' ? Colors.redAccent : Colors.white24,
                  size: 14,
                ),
              )
            else ...[
              _Field(
                controller: _grindCtrl,
                label: 'Grind Settings',
                hint: '28',
                keyboardType: TextInputType.number,
              ),
            ],
            const SizedBox(height: 12),
            _Field(
              controller: _micronsCtrl,
              label: 'Microns (μm)',
              hint: '800',
              keyboardType: TextInputType.number,
            ),
            if (_recipeType == 'espresso') ...[
              const SizedBox(height: 12),
              _Field(
                controller: _brewRatioCtrl,
                label: 'Brew Ratio',
                hint: '1:2.0',
                readOnly: true,
              ),
            ],
            const SizedBox(height: 20),

            // ── Pour Schedule ──────────────────────────────────────────────────
            _SectionHeader('Pour Schedule'),
            Row(
              children: [
                const Text(
                  'Number of pours:',
                  style: TextStyle(color: Colors.white70),
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
            // Pour rows
            ...List.generate(
              _totalPours,
              (i) => _PourRow(index: i, ctrls: _pourCtrlsList[i]),
            ),
            const SizedBox(height: 20),

            // ── Notes ─────────────────────────────────────────────────────────
            _SectionHeader('Notes'),
            _Field(
              controller: _notesCtrl,
              label: 'Notes (taste, adjustments, etc.)',
              maxLines: 3,
            ),
            const SizedBox(height: 32),

            // ── Save Button ───────────────────────────────────────────────────
            ElevatedButton(
              onPressed: _saving ? null : _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC8A96E),
                foregroundColor: Colors.black,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                isEdit ? 'Save Changes' : 'Save Recipe',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
          ],
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
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pour #${index + 1}',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: const Color(0xFFC8A96E),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _Field(
                  controller: ctrls['waterMl']!,
                  label: 'Water (ml)',
                  hint: '50',
                  keyboardType: TextInputType.number,
                  dense: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _Field(
                  controller: ctrls['atMinute']!,
                  label: 'At minute',
                  hint: '0.5',
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  dense: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _Field(
                  controller: ctrls['durationSec']!,
                  label: 'Duration (s)',
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
            label: 'Notes (optional)',
            hint: 'e.g. slow spiral',
            dense: true,
          ),
        ],
      ),
    );
  }
}

// ─── Helper Widgets ───────────────────────────────────────────────────────────
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
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: const Color(0xFFC8A96E),
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Divider(color: Color(0xFFC8A96E), thickness: 0.5),
          ),
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final bool dense;

  const _Field({
    required this.controller,
    required this.label,
    this.hint,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
    this.prefixIcon,
    this.dense = false,
    this.readOnly = false,
  });

  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      readOnly: readOnly,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white24),
        prefixIcon: prefixIcon,
        isDense: dense,
        contentPadding: dense
            ? const EdgeInsets.symmetric(horizontal: 12, vertical: 10)
            : null,
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.07),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFC8A96E)),
        ),
        labelStyle: const TextStyle(color: Colors.white54, fontSize: 13),
      ),
    );
  }
}

class _RatingRow extends StatelessWidget {
  final int rating;
  final void Function(int) onChanged;
  const _RatingRow({required this.rating, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Rating:', style: TextStyle(color: Colors.white70)),
        const SizedBox(width: 12),
        ...List.generate(
          5,
          (i) => GestureDetector(
            onTap: () => onChanged(i + 1 == rating ? 0 : i + 1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Icon(
                i < rating ? Icons.star_rounded : Icons.star_outline_rounded,
                color: const Color(0xFFC8A96E),
                size: 28,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '$value',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 18,
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
              ? const Color(0xFFC8A96E).withValues(alpha: 0.2)
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
