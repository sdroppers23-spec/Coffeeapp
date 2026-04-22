import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drift/drift.dart' as drift;
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/dtos.dart';
import 'package:uuid/uuid.dart';

class AdminEditSphereSheet extends ConsumerStatefulWidget {
  final SphereRegionDto? existingRegion;
  const AdminEditSphereSheet({super.key, this.existingRegion});

  @override
  ConsumerState<AdminEditSphereSheet> createState() =>
      _AdminEditSphereSheetState();
}

class _AdminEditSphereSheetState extends ConsumerState<AdminEditSphereSheet> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _keyCtrl;
  late TextEditingController _nameUkCtrl;
  late TextEditingController _nameEnCtrl;
  late TextEditingController _descUkCtrl;
  late TextEditingController _descEnCtrl;
  late TextEditingController _latCtrl;
  late TextEditingController _lngCtrl;
  late TextEditingController _markerColorCtrl;
  late TextEditingController _flavorsUkCtrl;
  late TextEditingController _flavorsEnCtrl;

  bool _isActive = true;
  bool _isSaving = false;
  bool _isLoadingTr = false;

  @override
  void initState() {
    super.initState();
    final d = widget.existingRegion;

    _keyCtrl = TextEditingController(text: d?.key ?? '');
    _latCtrl = TextEditingController(text: d?.latitude.toString() ?? '');
    _lngCtrl = TextEditingController(text: d?.longitude.toString() ?? '');
    _markerColorCtrl = TextEditingController(text: d?.markerColor ?? '#C8A96E');
    _isActive = d?.isActive ?? true;

    _nameUkCtrl = TextEditingController();
    _nameEnCtrl = TextEditingController();
    _descUkCtrl = TextEditingController();
    _descEnCtrl = TextEditingController();
    _flavorsUkCtrl = TextEditingController(text: '[]');
    _flavorsEnCtrl = TextEditingController(text: '[]');

    if (d != null) {
      _loadTranslations(d.id);
    }
  }

  Future<void> _loadTranslations(String id) async {
    setState(() => _isLoadingTr = true);
    final db = ref.read(databaseProvider);
    final en = await db.getSphereRegionTranslation(id, 'en');
    final uk = await db.getSphereRegionTranslation(id, 'uk');

    if (mounted) {
      setState(() {
        if (en != null) {
          _nameEnCtrl.text = en.name;
          _descEnCtrl.text = en.description ?? '';
          _flavorsEnCtrl.text = en.flavorProfile;
        }
        if (uk != null) {
          _nameUkCtrl.text = uk.name;
          _descUkCtrl.text = uk.description ?? '';
          _flavorsUkCtrl.text = uk.flavorProfile;
        }
        _isLoadingTr = false;
      });
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    try {
      final db = ref.read(databaseProvider);
      final id = widget.existingRegion?.id ?? const Uuid().v4();

      // 1. Base Region
      await db.insertSphereRegion(
        SphereRegionsCompanion(
          id: drift.Value(id),
          key: drift.Value(_keyCtrl.text),
          latitude: drift.Value(double.tryParse(_latCtrl.text) ?? 0.0),
          longitude: drift.Value(double.tryParse(_lngCtrl.text) ?? 0.0),
          markerColor: drift.Value(_markerColorCtrl.text),
          isActive: drift.Value(_isActive),
        ),
      );

      // 2. Translations
      await db.insertSphereRegionTranslation(
        SphereRegionTranslationsCompanion(
          regionId: drift.Value(id),
          languageCode: const drift.Value('en'),
          name: drift.Value(_nameEnCtrl.text),
          description: drift.Value(_descEnCtrl.text),
          flavorProfile: drift.Value(_flavorsEnCtrl.text),
        ),
      );

      await db.insertSphereRegionTranslation(
        SphereRegionTranslationsCompanion(
          regionId: drift.Value(id),
          languageCode: const drift.Value('uk'),
          name: drift.Value(_nameUkCtrl.text),
          description: drift.Value(_descUkCtrl.text),
          flavorProfile: drift.Value(_flavorsUkCtrl.text),
        ),
      );

      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType type = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        maxLines: maxLines,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white54, fontSize: 13),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.05),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFC8A96E)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              widget.existingRegion == null
                  ? 'Add Sphere Region'
                  : 'Edit Region',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            if (_isLoadingTr)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(color: Color(0xFFC8A96E)),
                ),
              )
            else
              Expanded(
                child: ListView(
                  children: [
                    _buildField(
                      label: 'Key Identifier (e.g. columbia_huila)',
                      controller: _keyCtrl,
                    ),
                    ExpansionTile(
                      title: const Text(
                        'Names (EN / UK)',
                        style: TextStyle(color: Color(0xFFC8A96E)),
                      ),
                      initiallyExpanded: true,
                      children: [
                        _buildField(
                          label: 'Name (EN)',
                          controller: _nameEnCtrl,
                        ),
                        _buildField(
                          label: 'Name (UK)',
                          controller: _nameUkCtrl,
                        ),
                        _buildField(
                          label: 'Description (EN)',
                          controller: _descEnCtrl,
                          maxLines: 3,
                        ),
                        _buildField(
                          label: 'Description (UK)',
                          controller: _descUkCtrl,
                          maxLines: 3,
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: const Text(
                        'Map Coordinates',
                        style: TextStyle(color: Color(0xFFC8A96E)),
                      ),
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildField(
                                label: 'Latitude',
                                controller: _latCtrl,
                                type: const TextInputType.numberWithOptions(
                                  signed: true,
                                  decimal: true,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildField(
                                label: 'Longitude',
                                controller: _lngCtrl,
                                type: const TextInputType.numberWithOptions(
                                  signed: true,
                                  decimal: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                        _buildField(
                          label: 'Marker HEX Color',
                          controller: _markerColorCtrl,
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: const Text(
                        'Flavor Profiles',
                        style: TextStyle(color: Color(0xFFC8A96E)),
                      ),
                      children: [
                        _buildField(
                          label: 'Flavors JSON Array (EN)',
                          controller: _flavorsEnCtrl,
                        ),
                        _buildField(
                          label: 'Flavors JSON Array (UK)',
                          controller: _flavorsUkCtrl,
                        ),
                      ],
                    ),
                    SwitchListTile(
                      title: const Text(
                        'Is Active on Map',
                        style: TextStyle(color: Colors.white),
                      ),
                      activeThumbColor: const Color(0xFFC8A96E),
                      value: _isActive,
                      onChanged: (v) => setState(() => _isActive = v),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isSaving || _isLoadingTr ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC8A96E),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isSaving
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text(
                        'Save Region',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
