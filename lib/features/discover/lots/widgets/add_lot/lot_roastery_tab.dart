part of '../../add_lot_screen.dart';

extension _RoasteryTabSection on _AddLotScreenState {
  Widget _buildRoasteryTab() {
    final pref = ref.watch(preferencesProvider);
    final currencySymbol = _getCurrencySymbol(pref.currency);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      children: [
        _sectionLabel(
          (_userRoasterId == null && !_isAddingNewRoaster)
              ? context.t('select_roaster')
              : context.t('section_roaster'),
        ),
        _darkCard(
          children: [
            if (_userRoasterId == null &&
                !_isAddingNewRoaster &&
                !_isSearchingRoaster)
              // 1. Initial State: Placeholder
              InkWell(
                onTap: () => updateState(() => _isSearchingRoaster = true),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      Text(
                        context.t('select_roaster'),
                        style: GoogleFonts.outfit(
                          color: Colors.white.withValues(alpha: 0.38),
                          fontSize: 15,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white38,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              )
            else if (_isSearchingRoaster &&
                _userRoasterId == null &&
                !_isAddingNewRoaster)
              // 2. Search Mode
              Column(
                children: [
                  _fieldRow(
                    label: context.t('search_roaster').toUpperCase(),
                    controller: _roasteryController,
                    focusNode: _roasterNameFocusNode,
                    placeholder: context.t('name_field'),
                    autoFocus: true,
                    onChanged: (val) {
                      _updateRoasterSuggestions(val);
                    },
                    suffix: IconButton(
                      icon: const Icon(Icons.close_rounded,
                          color: Colors.white38, size: 20),
                      onPressed: () {
                        updateState(() {
                          _isSearchingRoaster = false;
                          _roasteryController.clear();
                          _roasterSuggestions = [];
                        });
                      },
                    ),
                  ),
                  // Add New Button
                  InkWell(
                    onTap: () {
                      updateState(() {
                        _isAddingNewRoaster = true;
                        _isSearchingRoaster = false;
                        _roasteryController.clear();
                        _roasterSuggestions = [];
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC8A96E).withValues(alpha: 0.1),
                        border: Border(
                          top: BorderSide(
                            color: const Color(0xFFC8A96E)
                                .withValues(alpha: 0.1),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.add_rounded,
                              color: Color(0xFFC8A96E), size: 20),
                          const SizedBox(width: 8),
                          Text(
                            context.t('add_new_roaster'),
                            style: GoogleFonts.outfit(
                              color: const Color(0xFFC8A96E),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Suggestions List
                  if (_roasterSuggestions.isNotEmpty)
                    Container(
                      constraints: const BoxConstraints(maxHeight: 250),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.white.withValues(alpha: 0.05),
                          ),
                        ),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: _roasterSuggestions.length,
                        separatorBuilder: (context, index) => _divider(),
                        itemBuilder: (context, index) {
                          final roaster = _roasterSuggestions[index];
                          return ListTile(
                            dense: true,
                            title: Text(
                              roaster.name,
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: roaster.location != null
                                ? Text(
                                    roaster.location!,
                                    style: GoogleFonts.outfit(
                                      color: Colors.white38,
                                      fontSize: 12,
                                    ),
                                  )
                                : null,
                            onTap: () {
                              updateState(() {
                                _userRoasterId = roaster.id;
                                _roasteryController.text = roaster.name;
                                _roasteryCountryController.text =
                                    roaster.country ?? '';
                                _roasteryLocationController.text =
                                    roaster.location ?? '';
                                _isSearchingRoaster = false;
                                _roasterSuggestions = [];
                              });
                              _roasterNameFocusNode.unfocus();
                            },
                          );
                        },
                      ),
                    ),
                ],
              )
            else
              // 3. Active Fields (Selected or Adding New)
              Column(
                children: [
                  _fieldRow(
                    label: context.t('roaster_name_field').toUpperCase(),
                    controller: _roasteryController,
                    readOnly: _userRoasterId != null,
                    suffix: IconButton(
                      icon: const Icon(Icons.close_rounded,
                          color: Colors.white38, size: 20),
                      onPressed: () {
                        updateState(() {
                          _userRoasterId = null;
                          _isAddingNewRoaster = false;
                          _isSearchingRoaster = false;
                          _roasteryController.clear();
                          _roasteryCountryController.clear();
                          _roasteryLocationController.clear();
                          _roasterSuggestions = [];
                        });
                      },
                    ),
                  ),
                  _divider(),
                  _fieldRow(
                    label: context.t('location_label').toUpperCase(),
                    controller: _roasteryCountryController,
                    placeholder: context.t('location_label'),
                    readOnly: _userRoasterId != null,
                  ),
                  _divider(),
                  _fieldRow(
                    label: context.t('roaster_city').toUpperCase(),
                    controller: _roasteryLocationController,
                    placeholder: context.t('roaster_city'),
                    readOnly: _userRoasterId != null,
                  ),
                ],
              ),
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
