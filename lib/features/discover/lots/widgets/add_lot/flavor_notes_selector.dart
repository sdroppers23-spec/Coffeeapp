part of '../../add_lot_screen.dart';

extension _SensoryTabSection on _AddLotScreenState {
  Widget _buildSensoryTab() {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
      children: [
        _sectionLabel(context.t('sensory_profile_1_5')),
        _darkCard(
          children: [
            _sensorySlider(
              context.t('bitterness'),
              _bitterness,
              (v) => _updateState(() => _bitterness = v),
              theme: theme,
              enabled: !_isSensoryLocked,
            ),
            _divider(),
            _sensorySlider(
              context.t('acidity'),
              _acidity,
              (v) => _updateState(() => _acidity = v),
              theme: theme,
              enabled: !_isSensoryLocked,
            ),
            _divider(),
            _sensorySlider(
              context.t('sweetness'),
              _sweetness,
              (v) => _updateState(() => _sweetness = v),
              theme: theme,
              enabled: !_isSensoryLocked,
            ),
            _divider(),
            _sensorySlider(
              context.t('body'),
              _body,
              (v) => _updateState(() => _body = v),
              theme: theme,
              enabled: !_isSensoryLocked,
            ),
            _divider(),
            _sensorySlider(
              context.t('intensity'),
              _intensity,
              (v) => _updateState(() => _intensity = v),
              theme: theme,
              enabled: !_isSensoryLocked,
            ),
            _divider(),
            _sensorySlider(
              context.t('aftertaste'),
              _aftertaste,
              (v) => _updateState(() => _aftertaste = v),
              theme: theme,
              enabled: !_isSensoryLocked,
            ),
          ],
        ),
        const SizedBox(height: 16),
        _sectionLabel(context.t('visualize_profile')),
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
              ? context.t('unlock_sensory')
              : context.t('lock_sensory'),
          active: !_isSensoryLocked,
          onTap: () => _updateState(() => _isSensoryLocked = !_isSensoryLocked),
        ),
      ],
    );
  }
}
