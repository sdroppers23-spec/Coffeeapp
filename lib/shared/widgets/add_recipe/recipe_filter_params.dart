part of '../add_recipe_dialog.dart';

extension _RecipeFilterParamsSection on _AddRecipeDialogState {
  Widget _buildFilterParams(WidgetRef ref, UserPreferences pref) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _coffeeController,
                label: ref.t('coffee_g'),
                hint: '15.0',
                keyboardType: TextInputType.number,
                maxLength: 5,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _waterController,
                label: ref.t('water_ml'),
                hint: '250.0',
                keyboardType: TextInputType.number,
                maxLength: 5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _extractionTimeController,
                label: ref.t('extraction_time_hint'),
                hint: '00:30',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  _TimeMaskFormatter(),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _tempController,
                label:
                    '${ref.t('brew_temp')} (${pref.tempUnit == TempUnit.celsius ? '°C' : '°F'})',
                hint: pref.tempUnit == TempUnit.celsius ? '93.0' : '199.4',
                keyboardType: TextInputType.number,
                maxLength: 5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildTextField(
          controller: _ratioController,
          label: ref.t('ratio'),
          hint: '1:16.7',
          readOnly: true,
        ),
      ],
    );
  }
}
