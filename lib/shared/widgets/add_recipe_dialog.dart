import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' hide Column;
import '../../core/database/app_database.dart';
import '../../core/supabase/supabase_provider.dart';
import '../widgets/glass_container.dart';
import '../../core/database/database_provider.dart';
import '../../core/l10n/app_localizations.dart';

class AddRecipeDialog extends ConsumerStatefulWidget {
  final String lotId;
  const AddRecipeDialog({super.key, required this.lotId});

  @override
  ConsumerState<AddRecipeDialog> createState() => _AddRecipeDialogState();
}

class _AddRecipeDialogState extends ConsumerState<AddRecipeDialog> {
  final _formKey = GlobalKey<FormState>();
  String _method = 'V60';
  final _nameController = TextEditingController();
  final _coffeeController = TextEditingController(text: '15');
  final _waterController = TextEditingController(text: '250');
  final _tempController = TextEditingController(text: '93');
  final _grindController = TextEditingController();
  final _notesController = TextEditingController();
  int _rating = 4;

  @override
  void dispose() {
    _nameController.dispose();
    _coffeeController.dispose();
    _waterController.dispose();
    _tempController.dispose();
    _grindController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final db = ref.read(databaseProvider);
    final user = ref.read(supabaseProvider).auth.currentUser;
    if (user == null) return;

    final recipe = CustomRecipesCompanion.insert(
      id: Value(const Uuid().v4()),
      userId: user.id,
      lotId: Value(widget.lotId),
      methodKey: _method,
      name: _nameController.text.isEmpty ? 'Recipe' : _nameController.text,
      coffeeGrams: double.tryParse(_coffeeController.text) ?? 15.0,
      totalWaterMl: double.tryParse(_waterController.text) ?? 250.0,
      grindNumber: Value(int.tryParse(_grindController.text) ?? 0),
      comandanteClicks: const Value(0),
      ek43Division: const Value(0),
      totalPours: const Value(1),
      pourScheduleJson: const Value('[]'),
      brewTempC: Value(double.tryParse(_tempController.text) ?? 93.0),
      notes: Value(_notesController.text),
      rating: Value(_rating),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    );

    await db.insertCustomRecipe(recipe);
    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: GlassContainer(
        borderRadius: 32,
        opacity: 0.15,
        blur: 30,
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ref.t('add_recipe').toUpperCase(),
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 24),
                _buildFieldLabel('METHOD'),
                DropdownButtonFormField<String>(
                  initialValue: _method,
                  dropdownColor: const Color(0xFF1E1E1E),
                  style: GoogleFonts.outfit(color: Colors.white),
                  decoration: _inputDecoration(),
                  items: ['V60', 'Chemex', 'Aeropress', 'Espresso', 'Batch Brew', 'French Press']
                      .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                      .toList(),
                  onChanged: (val) => setState(() => _method = val!),
                ),
                const SizedBox(height: 16),
                _buildFieldLabel('NAME'),
                TextFormField(
                  controller: _nameController,
                  style: GoogleFonts.outfit(color: Colors.white),
                  decoration: _inputDecoration(hint: 'Flavor Profile or Date'),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel('COFFEE (g)'),
                          TextFormField(
                            controller: _coffeeController,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.outfit(color: Colors.white),
                            decoration: _inputDecoration(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel('WATER (ml)'),
                          TextFormField(
                            controller: _waterController,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.outfit(color: Colors.white),
                            decoration: _inputDecoration(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel('TEMP (°C)'),
                          TextFormField(
                            controller: _tempController,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.outfit(color: Colors.white),
                            decoration: _inputDecoration(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel('GRIND'),
                          TextFormField(
                            controller: _grindController,
                            style: GoogleFonts.outfit(color: Colors.white),
                            decoration: _inputDecoration(hint: 'Ticks/Pos'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildFieldLabel('NOTES'),
                TextFormField(
                  controller: _notesController,
                  maxLines: 3,
                  style: GoogleFonts.outfit(color: Colors.white),
                  decoration: _inputDecoration(hint: 'Aroma, bloom duration, etc.'),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('RATING', style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12)),
                    Row(
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () => setState(() => _rating = index + 1),
                          child: Icon(
                            index < _rating ? Icons.star_rounded : Icons.star_outline_rounded,
                            color: const Color(0xFFC8A96E),
                            size: 28,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC8A96E),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: Text(
                      ref.t('save').toUpperCase(),
                      style: GoogleFonts.outfit(fontWeight: FontWeight.bold, letterSpacing: 2),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Center(
                    child: Text(
                      'CANCEL',
                      style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: const Color(0xFFC8A96E),
          letterSpacing: 1,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
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
