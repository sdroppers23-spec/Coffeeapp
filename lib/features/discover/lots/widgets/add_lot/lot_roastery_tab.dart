part of '../../add_lot_screen.dart';

extension _RoasteryTabSection on _AddLotScreenState {
  Widget _buildRoasteryTab() {
    final pref = ref.watch(preferencesProvider);
    final currencySymbol = _getCurrencySymbol(pref.currency);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      children: [
        _sectionLabel(context.t('section_roaster')),
        _darkCard(
          children: [
            _selectorRow(
              value: _roasteryController.text,
              placeholder: context.t('select_roaster'),
              onTap: _showRoasterPicker,
              suffix: (_userRoasterId != null ||
                      _roasteryController.text.isNotEmpty)
                  ? GestureDetector(
                      onTap: () {
                        updateState(() {
                          _userRoasterId = null;
                          _roasteryController.clear();
                          _roasteryCountryController.clear();
                          _roasteryLocationController.clear();
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.close_rounded,
                            color: Colors.white38, size: 20),
                      ),
                    )
                  : null,
            ),
            if (_roasteryController.text.isNotEmpty) ...[
              _divider(),
              _fieldRow(
                label: context.t('location_field').toUpperCase(),
                controller: _roasteryLocationController,
                placeholder: context.t('location_field'),
                readOnly: _userRoasterId != null,
              ),
            ],
          ],
        ),

        _sectionLabel(context.t('section_coffee_lot')),
        _darkCard(
          children: [
            _fieldRow(
              label: context.t('coffee_name_field').toUpperCase(),
              controller: _coffeeNameController,
              placeholder: context.t('coffee_name_field'),
            ),
            _divider(),
            _fieldRow(
              label: context.t('farmer_field').toUpperCase(),
              controller: _farmerController,
            ),
            _divider(),
            _fieldRow(
              label: context.t('wash_station_field').toUpperCase(),
              controller: _washStationController,
            ),
            _divider(),
            _fieldRow(
              label: context.t('lot_number_field').toUpperCase(),
              controller: _lotNumberController,
              type: _FieldType.lotNumber,
            ),
            _divider(),
            _fieldRow(
              label: context.t('sca_score_field').toUpperCase(),
              controller: _scaScoreController,
              type: _FieldType.scaScore,
              helperText: context.t('sca_score_helper'),
            ),
            _divider(),
            _fieldRow(
              label: context.t('weight_field').toUpperCase(),
              controller: _weightController,
              suffix: 'g',
              type: _FieldType.weight,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                WeightInputFormatter(),
              ],
            ),
          ],
        ),

        _sectionLabel(context.t('section_origin')),
        _darkCard(
          children: [
            _fieldRow(
              label: context.t('country_field').toUpperCase(),
              controller: _originCountryController,
            ),
            _divider(),
            _fieldRow(
              label: context.t('region_field').toUpperCase(),
              controller: _regionController,
            ),
            _divider(),
            _fieldRow(
              label: context.t('altitude_field').toUpperCase(),
              controller: _altitudeController,
              type: _FieldType.altitude,
              suffix: pref.lengthUnit == LengthUnit.meters ? 'm' : 'ft',
            ),
            _divider(),
            _fieldRow(
              label: context.t('varietals_field').toUpperCase(),
              controller: _varietiesController,
            ),
          ],
        ),

        _sectionLabel(context.t('section_processing')),
        _buildProcessSection(),

        _sectionLabel(context.t('section_flavor_notes')),
        _darkCard(
          children: [
            _fieldRow(
              label: context.t('flavor_notes_field').toUpperCase(),
              controller: _flavorProfileController,
            ),
          ],
        ),

        _sectionLabel(context.t('section_pricing')),
        _darkCard(
          children: [
            _fieldRow(
              label: context.t('retail_250g').toUpperCase(),
              controller: _priceController,
              type: _FieldType.numeric,
              suffix: currencySymbol,
            ),
            _divider(),
            _fieldRow(
              label: context.t('retail_1kg').toUpperCase(),
              controller: _retailPrice1kController,
              type: _FieldType.numeric,
              suffix: currencySymbol,
            ),
            _divider(),
            _fieldRow(
              label: context.t('wholesale_250g').toUpperCase(),
              controller: _wholesalePrice250Controller,
              type: _FieldType.numeric,
              suffix: currencySymbol,
            ),
            _divider(),
            _fieldRow(
              label: context.t('wholesale_1kg').toUpperCase(),
              controller: _wholesalePrice1kController,
              type: _FieldType.numeric,
              suffix: currencySymbol,
            ),
          ],
        ),
      ],
    );
  }
}
