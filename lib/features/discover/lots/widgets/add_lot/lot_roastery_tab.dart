part of '../../add_lot_screen.dart';

extension _RoasteryTabSection on _AddLotScreenState {
  Widget _buildRoasteryTab() {
    final pref = ref.watch(preferencesProvider);
    final currencySymbol = _getCurrencySymbol(pref.currency);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
      children: [
        _sectionLabel(ref.t('section_roaster')),
        _darkCard(
          children: [
            _selectorRow(
              value: _roasteryController.text,
              placeholder: ref.t('select_roaster'),
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
                label: ref.t('location_field'),
                controller: _roasteryLocationController,
                placeholder: ref.t('location_field'),
                readOnly: _userRoasterId != null,
              ),
            ],
          ],
        ),

        _sectionLabel(ref.t('section_coffee_lot')),
        _darkCard(
          children: [
            _fieldRow(
              label: ref.t('coffee_name_field'),
              controller: _coffeeNameController,
              placeholder: ref.t('coffee_name_field'),
            ),
            _divider(),
            _fieldRow(
              label: ref.t('farmer_field'),
              controller: _farmerController,
            ),
            _divider(),
            _fieldRow(
              label: ref.t('wash_station_field'),
              controller: _washStationController,
            ),
            _divider(),
            _fieldRow(
              label: ref.t('lot_number_field'),
              controller: _lotNumberController,
              type: _FieldType.lotNumber,
            ),
            _divider(),
            _fieldRow(
              label: ref.t('sca_score_field'),
              controller: _scaScoreController,
              type: _FieldType.scaScore,
              helperText: ref.t('sca_score_helper'),
            ),
            _divider(),
            _fieldRow(
              label: ref.t('weight_field'),
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

        _sectionLabel(ref.t('section_origin')),
        _darkCard(
          children: [
            _fieldRow(
              label: ref.t('country_field'),
              controller: _originCountryController,
            ),
            _divider(),
            _fieldRow(
              label: ref.t('region_field'),
              controller: _regionController,
            ),
            _divider(),
            _fieldRow(
              label: ref.t('altitude_field'),
              controller: _altitudeController,
              type: _FieldType.altitude,
              suffix: pref.lengthUnit == LengthUnit.meters ? 'm' : 'ft',
            ),
            _divider(),
            _fieldRow(
              label: ref.t('varietals_field'),
              controller: _varietiesController,
            ),
          ],
        ),

        _sectionLabel(ref.t('section_pricing')),
        _darkCard(
          children: [
            _fieldRow(
              label: ref.t('retail_250g'),
              controller: _priceController,
              type: _FieldType.numeric,
              suffix: currencySymbol,
            ),
            _divider(),
            _fieldRow(
              label: ref.t('retail_1kg'),
              controller: _retailPrice1kController,
              type: _FieldType.numeric,
              suffix: currencySymbol,
            ),
            _divider(),
            _fieldRow(
              label: ref.t('wholesale_250g'),
              controller: _wholesalePrice250Controller,
              type: _FieldType.numeric,
              suffix: currencySymbol,
            ),
            _divider(),
            _fieldRow(
              label: ref.t('wholesale_1kg'),
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
