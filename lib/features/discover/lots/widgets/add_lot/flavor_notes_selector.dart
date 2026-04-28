part of '../../add_lot_screen.dart';

extension SensoryTabSection on _AddLotScreenState {
  Widget _buildSensoryTab() {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      children: [
        _sectionLabel(context.t('sensory_profile_1_5')),
        _darkCard(children: [
          _sensorySlider(context.t('bitterness').toUpperCase(), _bitterness, (v) => setState(() => _bitterness = v), theme: theme, enabled: !_isSensoryLocked),
          _divider(),
          _sensorySlider(context.t('acidity').toUpperCase(), _acidity, (v) => setState(() => _acidity = v), theme: theme, enabled: !_isSensoryLocked),
          _divider(),
          _sensorySlider(context.t('sweetness').toUpperCase(), _sweetness, (v) => setState(() => _sweetness = v), theme: theme, enabled: !_isSensoryLocked),
          _divider(),
          _sensorySlider(context.t('body').toUpperCase(), _body, (v) => setState(() => _body = v), theme: theme, enabled: !_isSensoryLocked),
          _divider(),
          _sensorySlider(context.t('intensity').toUpperCase(), _intensity, (v) => setState(() => _intensity = v), theme: theme, enabled: !_isSensoryLocked),
          _divider(),
          _sensorySlider(context.t('aftertaste').toUpperCase(), _aftertaste, (v) => setState(() => _aftertaste = v), theme: theme, enabled: !_isSensoryLocked),
        ]),
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
          label: _isSensoryLocked ? context.t('unlock_sensory') : context.t('lock_sensory'),
          active: !_isSensoryLocked,
          onTap: () => setState(() => _isSensoryLocked = !_isSensoryLocked),
        ),
      ],
    );
  }
}
