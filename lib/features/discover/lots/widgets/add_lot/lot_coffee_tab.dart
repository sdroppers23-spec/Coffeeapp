part of '../../add_lot_screen.dart';

extension _CoffeeTabSection on _AddLotScreenState {
  Widget _buildCoffeeTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      children: [
        _sectionLabel(context.t('section_photo')),
        _buildImagePicker(),
        const SizedBox(height: 16),

        _sectionLabel(context.t('section_roast_date')),
        _darkCard(
          children: [
            _dateRow(
              label: context.t('roast_date_field').toUpperCase(),
              date: _roastDate,
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _roastDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                  builder: (ctx, child) => Theme(
                    data: ThemeData.dark().copyWith(
                      colorScheme: const ColorScheme.dark(
                        primary: Color(0xFFC8A96E),
                      ),
                    ),
                    child: child!,
                  ),
                );
                if (picked != null) _updateState(() => _roastDate = picked);
              },
            ),
            _divider(),
            _dateRow(
              label: context.t('opened_at_field').toUpperCase(),
              date: _openedAt,
              placeholder: context.t('not_opened'),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate:
                      (_openedAt != null && _openedAt!.isAfter(_roastDate))
                      ? _openedAt!
                      : _roastDate,
                  firstDate: _roastDate,
                  lastDate: DateTime.now(),
                  builder: (ctx, child) => Theme(
                    data: ThemeData.dark().copyWith(
                      colorScheme: const ColorScheme.dark(
                        primary: Color(0xFFC8A96E),
                      ),
                    ),
                    child: child!,
                  ),
                );
                if (picked != null) _updateState(() => _openedAt = picked);
              },
            ),
          ],
        ),

        _sectionLabel(context.t('section_bag_state')),
        Row(
          children: [
            Expanded(
              child: _toggleButton(
                label: context.t('bag_closed'),
                active: !_isOpen,
                onTap: () => _updateState(() => _isOpen = false),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _toggleButton(
                label: context.t('bag_opened'),
                active: _isOpen,
                onTap: () {
                  _updateState(() {
                    _isOpen = true;
                    _openedAt ??= _roastDate;
                  });
                },
              ),
            ),
          ],
        ),

        if (_isOpen) ...[
          _sectionLabel(context.t('section_grind_type')),
          _darkCard(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<bool>(
                    value: _isGround,
                    isExpanded: true,
                    dropdownColor: const Color(0xFF1A1714),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFFC8A96E),
                    ),
                    style: GoogleFonts.outfit(
                      color: const Color(0xFFC8A96E),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    items: [
                      DropdownMenuItem(
                        value: false,
                        child: Text(
                          context.t('whole_bean'),
                          style: GoogleFonts.outfit(color: Colors.white),
                        ),
                      ),
                      DropdownMenuItem(
                        value: true,
                        child: Text(
                          context.t('ground_coffee'),
                          style: GoogleFonts.outfit(color: Colors.white),
                        ),
                      ),
                    ],
                    onChanged: (v) {
                      _updateState(() {
                        _isGround = v ?? false;
                        if (_isGround) _openedAt ??= _roastDate;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ],

        _sectionLabel(context.t('section_roast')),
        _darkCard(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.t('roast_level_field').toUpperCase(),
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _roastLevels.contains(_roastLevel)
                          ? _roastLevel
                          : _roastLevels[2],
                      isExpanded: true,
                      dropdownColor: const Color(0xFF1A1714),
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Color(0xFFC8A96E),
                      ),
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      items: _roastLevels.map((String level) {
                        return DropdownMenuItem<String>(
                          value: level,
                          child: Text(
                            context
                                .t(
                                  'roast_${level.toLowerCase().replaceAll('-', '_')}',
                                )
                                .toUpperCase(),
                            style: GoogleFonts.outfit(color: Colors.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          _updateState(() {
                            _roastLevel = newValue;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1714),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFC8A96E).withValues(alpha: 0.2),
          ),
          image: (_imageBytes != null)
              ? DecorationImage(
                  image: MemoryImage(_imageBytes!),
                  fit: BoxFit.cover,
                )
              : (_currentImageUrl != null && _currentImageUrl!.isNotEmpty)
              ? (_currentImageUrl!.startsWith('http')
                    ? DecorationImage(
                        image: CachedNetworkImageProvider(_currentImageUrl!),
                        fit: BoxFit.cover,
                      )
                    : DecorationImage(
                        image: FileImage(File(_currentImageUrl!)),
                        fit: BoxFit.cover,
                      ))
              : null,
        ),
        child:
            (_imageBytes == null &&
                (_currentImageUrl == null || _currentImageUrl!.isEmpty))
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo_outlined,
                      color: const Color(0xFFC8A96E).withValues(alpha: 0.5),
                      size: 40,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.t('add_photo_label'),
                      style: GoogleFonts.outfit(
                        color: const Color(0xFFC8A96E).withValues(alpha: 0.5),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              )
            : Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
      ),
    );
  }
}
