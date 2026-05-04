part of '../../add_lot_screen.dart';

extension _SensoryTabSection on _AddLotScreenState {
  Widget _buildSensoryTab() {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
      children: [
        _sectionLabel(ref.t('sensory_profile_1_5')),
        _darkCard(
          children: [
            _sensorySlider(
              ref.t('bitterness'),
              _bitterness,
              (v) => _updateState(() => _bitterness = v),
              theme: theme,
              enabled: !_isSensoryLocked,
            ),
            _divider(),
            _sensorySlider(
              ref.t('acidity'),
              _acidity,
              (v) => _updateState(() => _acidity = v),
              theme: theme,
              enabled: !_isSensoryLocked,
            ),
            _divider(),
            _sensorySlider(
              ref.t('sweetness'),
              _sweetness,
              (v) => _updateState(() => _sweetness = v),
              theme: theme,
              enabled: !_isSensoryLocked,
            ),
            _divider(),
            _sensorySlider(
              ref.t('body'),
              _body,
              (v) => _updateState(() => _body = v),
              theme: theme,
              enabled: !_isSensoryLocked,
            ),
            _divider(),
            _sensorySlider(
              ref.t('intensity'),
              _intensity,
              (v) => _updateState(() => _intensity = v),
              theme: theme,
              enabled: !_isSensoryLocked,
            ),
            _divider(),
            _sensorySlider(
              ref.t('aftertaste'),
              _aftertaste,
              (v) => _updateState(() => _aftertaste = v),
              theme: theme,
              enabled: !_isSensoryLocked,
            ),
          ],
        ),
        const SizedBox(height: 16),
        _sectionLabel(ref.t('visualize_profile')),
        Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFC8A96E).withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(20),
          ),
          child: SensoryRadarChart(
            interactive: false,
            height: 260,
            staticValues: {
              'bitterness': _bitterness,
              'acidity': _acidity,
              'sweetness': _sweetness,
              'body': _body,
              'intensity': _intensity,
              'aftertaste': _aftertaste,
            },
          ),
        ),
        const SizedBox(height: 12),
        _toggleButton(
          label: _isSensoryLocked
              ? ref.t('unlock_sensory')
              : ref.t('lock_sensory'),
          active: !_isSensoryLocked,
          onTap: () => _updateState(() => _isSensoryLocked = !_isSensoryLocked),
        ),
      ],
    );
  }
}
