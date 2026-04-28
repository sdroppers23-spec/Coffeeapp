part of '../add_recipe_dialog.dart';

extension _RecipePourScheduleSection on _AddRecipeDialogState {
  Widget _buildPourSchedule(WidgetRef ref, Color gold) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ref.t('pour_schedule_label'),
              style: GoogleFonts.outfit(
                color: gold,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            Row(
              children: [
                Text(
                  ref.t('pours_count', args: {'count': _pourControllers.length.toString()}),
                  style: GoogleFonts.outfit(
                    color: Colors.white38,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(
                    Icons.remove_circle_outline_rounded,
                    color: gold,
                    size: 20,
                  ),
                  onPressed: () {
                    if (_pourControllers.length > 1) {
                      _updateState(
                        () => _pourControllers.removeLast().dispose(),
                      );
                    }
                  },
                ),
                Text(
                  '${_pourControllers.length}',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add_circle_outline_rounded,
                    color: gold,
                    size: 20,
                  ),
                  onPressed: () {
                    if (_pourControllers.length < 10) {
                      _updateState(() => _addPourController());
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...List.generate(_pourControllers.length, (index) {
          return _buildPourItem(index, ref, gold);
        }),
      ],
    );
  }

  Widget _buildPourItem(int index, WidgetRef ref, Color gold) {
    final pc = _pourControllers[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ref.t('pour_num', args: {'num': (index + 1).toString()}),
            style: GoogleFonts.outfit(
              color: gold,
              fontWeight: FontWeight.bold,
              fontSize: 11,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: _buildSmallTextFieldWithLabel(
                  label: ref.t('water_g'),
                  controller: pc.water,
                  hint: '0',
                  maxLength: 5,
                ),
              ),
              const SizedBox(width: 8),
              _buildTimeField(
                label: ref.t('min_label'),
                controller: pc.min,
                focusNode: _minFocusNodes[index],
                onChanged: (val) {
                  if (val.length >= 2) {
                    if (val.length > 2) {
                      final String carry = val.substring(2);
                      final String current = val.substring(0, 2);
                      pc.min.text = current;
                      pc.sec.text = carry;
                      _secFocusNodes[index].requestFocus();
                      pc.sec.selection = TextSelection.collapsed(
                        offset: pc.sec.text.length,
                      );
                    } else {
                      _secFocusNodes[index].requestFocus();
                      pc.sec.selection = TextSelection.collapsed(
                        offset: pc.sec.text.length,
                      );
                    }
                  }
                },
              ),
              const SizedBox(width: 8),
              _buildTimeField(
                label: ref.t('sec_label'),
                controller: pc.sec,
                focusNode: _secFocusNodes[index],
                onChanged: (val) {
                  if (val.length >= 2) {
                    if (val.length > 2) {
                      pc.sec.text = val.substring(0, 2);
                      pc.sec.selection = TextSelection.collapsed(
                        offset: pc.sec.text.length,
                      );
                    }
                    _durFocusNodes[index].requestFocus();
                  }
                },
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 4,
                child: _buildSmallTextFieldWithLabel(
                  label: ref.t('duration_label'),
                  controller: pc.duration,
                  focusNode: _durFocusNodes[index],
                  hint: '00:00:00',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    _TimeMaskFormatter(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildSmallTextFieldWithLabel(
            label: ref.t('notes_label'),
            controller: pc.notes,
            hint: ref.t('notes_optional'),
            isNumber: false,
          ),
        ],
      ),
    );
  }
}
