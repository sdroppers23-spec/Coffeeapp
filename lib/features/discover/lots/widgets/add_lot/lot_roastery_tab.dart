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
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: PressableScale(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => RoasterSelectorSheet(
                      onSelected: (roaster) {
                        updateState(() {
                          _userRoasterId = roaster.id;
                          _roasteryController.text = roaster.name;
                          _roasteryCountryController.text =
                              roaster.country ?? '';
                          _roasteryLocationController.text =
                              roaster.location ?? '';
                        });
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.business_rounded,
                        color: Color(0xFFC8A96E),
                        size: 18,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _roasteryController.text.isEmpty
                              ? context.t('select_roaster')
                              : _roasteryController.text,
                          style: GoogleFonts.outfit(
                            color: _roasteryController.text.isEmpty
                                ? Colors.white38
                                : Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      if (_userRoasterId != null)
                        GestureDetector(
                          onTap: () {
                            updateState(() {
                              _userRoasterId = null;
                              _roasteryController.clear();
                              _roasteryCountryController.clear();
                              _roasteryLocationController.clear();
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(
                              Icons.close_rounded,
                              color: Colors.white38,
                              size: 20,
                            ),
                          ),
                        ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white38,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_userRoasterId != null) ...[
              _divider(),
              _fieldRow(
                label: context.t('name_field').toUpperCase(),
                controller: _roasteryController,
                readOnly: true,
              ),
              _divider(),
              _fieldRow(
                label: context.t('country_field').toUpperCase(),
                controller: _roasteryCountryController,
                readOnly: true,
              ),
              _divider(),
              _fieldRow(
                label: context.t('location_field').toUpperCase(),
                controller: _roasteryLocationController,
                readOnly: true,
              ),
            ],
          ],
        ),

        _sectionLabel(context.t('section_coffee_lot')),
        _darkCard(
          children: [
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
