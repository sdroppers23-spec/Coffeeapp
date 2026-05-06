part of '../../add_lot_screen.dart';

extension _SensoryTabSection on _AddLotScreenState {
  Widget _buildSensoryTab() {
    final theme = Theme.of(context);
    return ListView(
      cacheExtent: 1500,
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
        GlassContainer(
          height: 300,
          borderRadius: 20,
          blur: 0,
          opacity: 0.1,
          enableRepaintBoundary: false,
          borderColor: Colors.white.withValues(alpha: 0.05),
          child: Padding(
            padding: const EdgeInsets.all(16),
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
