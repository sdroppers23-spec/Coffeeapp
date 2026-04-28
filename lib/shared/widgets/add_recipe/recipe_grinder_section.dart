part of '../add_recipe_dialog.dart';

extension _RecipeGrinderSection on _AddRecipeDialogState {
  Widget _buildGrinderSection(WidgetRef ref, Color gold) {
    if (!_isGrinderExpanded && _grinderNameController.text.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextButton.icon(
            onPressed: () => _updateState(() => _isGrinderExpanded = true),
            icon: Icon(Icons.tune_rounded, color: gold, size: 20),
            label: Text(
              ref.t('choose_grinder'),
              style: GoogleFonts.outfit(
                color: gold,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              backgroundColor: Colors.white.withValues(alpha: 0.05),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: gold.withValues(alpha: 0.3), width: 1),
              ),
            ),
          ),
        ),
      );
    }

    if (!_isGrinderExpanded && _grinderNameController.text.isEmpty) {
      return Center(
        child: TextButton.icon(
          onPressed: () => _updateState(() => _isGrinderExpanded = true),
          icon: Icon(Icons.settings_input_component_rounded, color: gold, size: 20),
          label: Text(
            ref.t('choose_grinder'),
            style: GoogleFonts.outfit(
              color: gold,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            backgroundColor: gold.withValues(alpha: 0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: gold.withValues(alpha: 0.3)),
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ref.t('grinder_model'),
              style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
            ),
            GestureDetector(
              onTap: () => _updateState(() {
                _isGrinderExpanded = false;
                _grinderNameController.clear();
                _customGrinderController.clear();
                _isOtherGrinder = false;
              }),
              child: const Icon(
                Icons.close_rounded,
                color: Colors.white24,
                size: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue:
              _grinderNameController.text.isNotEmpty
                  ? ([
                        'Comandante',
                        'EK43',
                        'Fellow Ode',
                        'Wilfa',
                        'Timemore',
                        'Other',
                      ].contains(_grinderNameController.text)
                      ? _grinderNameController.text
                      : 'Other')
                  : null,
          hint: Text(
            ref.t('select_from_list'),
            style: GoogleFonts.outfit(color: Colors.white24, fontSize: 14),
          ),
          dropdownColor: const Color(0xFF1D1B1A),
          style: GoogleFonts.outfit(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          items:
              ['Comandante', 'EK43', 'Fellow Ode', 'Wilfa', 'Timemore', 'Other']
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e == 'Other' ? ref.t('other') : e),
                    ),
                  )
                  .toList(),
          onChanged:
              (val) => _updateState(() {
                _grinderNameController.text = val!;
                _isOtherGrinder = val == 'Other';
                _isGrinderExpanded = true;
              }),
        ),
        if (_isOtherGrinder) ...[
          const SizedBox(height: 12),
          _buildTextField(
            controller: _customGrinderController,
            label: ref.t('enter_grinder_name'),
            hint: ref.t('grinder_name_label'),
            validator:
                (val) =>
                    val == null || val.isEmpty
                        ? ref.t('required')
                        : null,
          ),
        ],
        const SizedBox(height: 12),
        _buildTextField(
          controller: _grindController,
          label: ref.t('grind'),
          hint: ref.t('grind_setting'),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
          ],
        ),
        const SizedBox(height: 12),
        _buildTextField(
          controller: _micronsController,
          label: ref.t('microns_label'),
          hint: ref.t('microns_label'),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
      ],
    );
  }
}
