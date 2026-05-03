part of '../../add_lot_screen.dart';

extension _ProcessingMethodSection on _AddLotScreenState {
  Widget _buildProcessSection() {
    return Column(
      children: [
        _darkCard(
          children: [
            _dropdownRow(
              label: context.t('section_processing'),
              value: _selectedProcess,
              items: _processingMethods,
              onChanged: (val) {
                _updateState(() {
                  _selectedProcess = val;
                  _isOtherProcess = val == 'Other';
                  if (!_isOtherProcess) {
                    _processController.clear();
                    // Apply sensory preset
                    final match = ProcessingMethodsRepository.getByMatchingName(
                      val ?? '',
                    );
                    if (match != null) {
                      _bitterness = match.sensoryPreset['bitterness'] ?? 3.0;
                      _acidity = match.sensoryPreset['acidity'] ?? 3.0;
                      _sweetness = match.sensoryPreset['sweetness'] ?? 3.0;
                      _body = match.sensoryPreset['body'] ?? 3.0;
                      _intensity = match.sensoryPreset['intensity'] ?? 3.0;
                      _aftertaste = match.sensoryPreset['aftertaste'] ?? 3.0;
                      _isSensoryLocked = true;
                    }
                  }
                });
              },
              localizationPrefix: 'process_',
            ),
            if (_isOtherProcess) ...[
              _divider(),
              _fieldRow(
                label: context.t('custom_method_label'),
                controller: _processController,
                placeholder: context.t('enter_name_placeholder'),
              ),
            ],
            _divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Text(
                    context.t('decaf'),
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFC8A96E).withValues(alpha: 0.6),
                      letterSpacing: 1.0,
                    ),
                  ),
                  const Spacer(),
                  Switch(
                    value: _isDecaf,
                    onChanged: (v) => _updateState(() => _isDecaf = v),
                    activeThumbColor: const Color(0xFFC8A96E),
                    activeTrackColor: const Color(
                      0xFFC8A96E,
                    ).withValues(alpha: 0.5),
                  ),
                ],
              ),
            ),
            if (_isDecaf) ...[
              _divider(),
              _dropdownRow(
                label:
                    "${context.t('section_processing')} ${context.t('decaf')}",
                value: _decafMethods.contains(_decafProcess)
                    ? _decafProcess
                    : 'Other',
                items: _decafMethods,
                onChanged: (val) {
                  _updateState(() {
                    _decafProcess = val!;
                    _isOtherDecaf = val == 'Other';
                  });
                },
                localizationPrefix: 'decaf_',
              ),
              if (_isOtherDecaf) ...[
                _divider(),
                _fieldRow(
                  label: context.t('custom_decaf_method_label'),
                  controller: TextEditingController(
                    text: _decafProcess == 'Other' ? '' : _decafProcess,
                  ),
                  onChanged: (v) => _decafProcess = v,
                  placeholder: context.t('enter_name_placeholder'),
                ),
              ],
            ],
          ],
        ),
      ],
    );
  }
}
