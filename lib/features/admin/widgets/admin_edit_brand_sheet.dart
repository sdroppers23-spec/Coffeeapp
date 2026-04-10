import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/dtos.dart';

class AdminEditBrandSheet extends ConsumerStatefulWidget {
  final LocalizedBrandDto? existingBrand;
  const AdminEditBrandSheet({super.key, this.existingBrand});

  @override
  ConsumerState<AdminEditBrandSheet> createState() =>
      _AdminEditBrandSheetState();
}

class _AdminEditBrandSheetState extends ConsumerState<AdminEditBrandSheet> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _shortDescUkController;
  late TextEditingController _shortDescEnController;
  late TextEditingController _fullDescUkController;
  late TextEditingController _fullDescEnController;
  late TextEditingController _logoUrlController;
  late TextEditingController _siteUrlController;
  late TextEditingController _locationUkController;
  late TextEditingController _locationEnController;

  bool _isSaving = false;
  bool _isLoadingTr = false;

  @override
  void initState() {
    super.initState();
    final d = widget.existingBrand;

    _nameController = TextEditingController(text: d?.name ?? '');
    _logoUrlController = TextEditingController(text: d?.logoUrl ?? '');
    _siteUrlController = TextEditingController(text: d?.siteUrl ?? '');

    _shortDescUkController = TextEditingController();
    _shortDescEnController = TextEditingController();
    _fullDescUkController = TextEditingController();
    _fullDescEnController = TextEditingController();
    _locationUkController = TextEditingController();
    _locationEnController = TextEditingController();

    if (d != null) {
      _loadTranslations(d.id);
    }
  }

  Future<void> _loadTranslations(int brandId) async {
    setState(() => _isLoadingTr = true);
    final db = ref.read(databaseProvider);
    final en = await db.getBrandTranslation(brandId, 'en');
    final uk = await db.getBrandTranslation(brandId, 'uk');

    if (mounted) {
      setState(() {
        if (en != null) {
          _shortDescEnController.text = en.shortDesc ?? '';
          _fullDescEnController.text = en.fullDesc ?? '';
          _locationEnController.text = en.location ?? '';
        }
        if (uk != null) {
          _shortDescUkController.text = uk.shortDesc ?? '';
          _fullDescUkController.text = uk.fullDesc ?? '';
          _locationUkController.text = uk.location ?? '';
        }
        _isLoadingTr = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _shortDescUkController.dispose();
    _shortDescEnController.dispose();
    _fullDescUkController.dispose();
    _fullDescEnController.dispose();
    _logoUrlController.dispose();
    _siteUrlController.dispose();
    _locationUkController.dispose();
    _locationEnController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    try {
      final db = ref.read(databaseProvider);

      // 1. Base Brand
      final brandId = await db.insertBrand(
        LocalizedBrandsCompanion(
          id: widget.existingBrand == null
              ? const drift.Value.absent()
              : drift.Value(widget.existingBrand!.id),
          name: drift.Value(_nameController.text.trim()),
          logoUrl: drift.Value(_logoUrlController.text.trim()),
          siteUrl: drift.Value(_siteUrlController.text.trim()),
          createdAt: drift.Value(DateTime.now()),
        ),
      );

      // 2. Translations
      await db.insertBrandTranslation(
        LocalizedBrandTranslationsCompanion(
          brandId: drift.Value(brandId),
          languageCode: const drift.Value('en'),
          shortDesc: drift.Value(_shortDescEnController.text.trim()),
          fullDesc: drift.Value(_fullDescEnController.text.trim()),
          location: drift.Value(_locationEnController.text.trim()),
        ),
      );

      await db.insertBrandTranslation(
        LocalizedBrandTranslationsCompanion(
          brandId: drift.Value(brandId),
          languageCode: const drift.Value('uk'),
          shortDesc: drift.Value(_shortDescUkController.text.trim()),
          fullDesc: drift.Value(_fullDescUkController.text.trim()),
          location: drift.Value(_locationUkController.text.trim()),
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
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        maxLines: maxLines,
        validator: required ? (v) => v!.isEmpty ? 'Required' : null : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white54),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.05),
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
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.existingBrand == null ? 'Add New Brand' : 'Edit Brand',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              if (_isLoadingTr)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: CircularProgressIndicator(color: Color(0xFFC8A96E)),
                  ),
                )
              else ...[
                _buildField(
                  label: 'Brand Name',
                  controller: _nameController,
                  required: true,
                ),
                const Text(
                  'English Localization',
                  style: TextStyle(
                    color: Color(0xFFC8A96E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildField(
                  label: 'Short Description (EN)',
                  controller: _shortDescEnController,
                  maxLines: 2,
                ),
                _buildField(
                  label: 'Full Description (EN)',
                  controller: _fullDescEnController,
                  maxLines: 4,
                ),
                _buildField(
                  label: 'Location (EN)',
                  controller: _locationEnController,
                ),
                const Text(
                  'Ukrainian Localization',
                  style: TextStyle(
                    color: Color(0xFFC8A96E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildField(
                  label: 'Short Description (UK)',
                  controller: _shortDescUkController,
                  maxLines: 2,
                ),
                _buildField(
                  label: 'Full Description (UK)',
                  controller: _fullDescUkController,
                  maxLines: 4,
                ),
                _buildField(
                  label: 'Location (UK)',
                  controller: _locationUkController,
                ),
                const Text(
                  'Media & Links',
                  style: TextStyle(
                    color: Color(0xFFC8A96E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildField(label: 'Logo URL', controller: _logoUrlController),
                _buildField(
                  label: 'Website URL',
                  controller: _siteUrlController,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _save,
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
                            'Save Brand',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
