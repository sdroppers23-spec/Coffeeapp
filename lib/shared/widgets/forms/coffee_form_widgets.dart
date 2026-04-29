import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class CoffeeSectionLabel extends StatelessWidget {
  final String text;

  const CoffeeSectionLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 20, 4, 10),
      child: Text(
        text,
        style: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class CoffeeDarkCard extends StatelessWidget {
  final List<Widget> children;

  const CoffeeDarkCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFC8A96E).withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class CoffeeDivider extends StatelessWidget {
  const CoffeeDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: const Color(0xFFC8A96E).withValues(alpha: 0.06),
    );
  }
}

class CoffeeFieldRow extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? suffix;
  final String? helperText;
  final String? placeholder;
  final TextCapitalization textCapitalization;
  final bool autocorrect;
  final bool enableInteractiveSelection;

  const CoffeeFieldRow({
    super.key,
    required this.label,
    this.controller,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.suffix,
    this.helperText,
    this.placeholder,
    this.textCapitalization = TextCapitalization.sentences,
    this.autocorrect = true,
    this.enableInteractiveSelection = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  style: GoogleFonts.outfit(color: Colors.white, fontSize: 16),
                  keyboardType: keyboardType,
                  enableInteractiveSelection: enableInteractiveSelection,
                  textCapitalization: textCapitalization,
                  autocorrect: autocorrect,
                  inputFormatters: inputFormatters,
                  decoration: InputDecoration(
                    hintText: placeholder,
                    hintStyle: GoogleFonts.outfit(
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  onChanged: onChanged,
                ),
              ),
              if (suffix != null)
                Text(
                  suffix!,
                  style: GoogleFonts.outfit(
                    color: const Color(0xFFC8A96E),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
            ],
          ),
          if (helperText != null) ...[
            const SizedBox(height: 4),
            Text(
              helperText!,
              style: GoogleFonts.outfit(
                fontSize: 10,
                color: Colors.white.withValues(alpha: 0.38),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class CoffeeDateRow extends StatelessWidget {
  final String label;
  final DateTime? date;
  final String? placeholder;
  final VoidCallback onTap;

  const CoffeeDateRow({
    super.key,
    required this.label,
    this.date,
    this.placeholder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final display = date != null
        ? '${date!.day.toString().padLeft(2, '0')}.${date!.month.toString().padLeft(2, '0')}.${date!.year}'
        : (placeholder ?? '—');

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.outfit(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  display,
                  style: GoogleFonts.outfit(
                    color: const Color(0xFFC8A96E),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.calendar_today_rounded,
              color: Color(0xFFC8A96E),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class CoffeeToggleButton extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const CoffeeToggleButton({
    super.key,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: active
              ? const Color(0xFFC8A96E).withValues(alpha: 0.06)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: active
                ? const Color(0xFFC8A96E)
                : const Color(0xFFC8A96E).withValues(alpha: 0.1),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.outfit(
            color: active
                ? const Color(0xFFC8A96E)
                : const Color(0xFFC8A96E).withValues(alpha: 0.38),
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }
}

class CoffeeDropdownRow<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabelBuilder;
  final ValueChanged<T?> onChanged;

  const CoffeeDropdownRow({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.itemLabelBuilder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFC8A96E).withValues(alpha: 0.6),
                letterSpacing: 1.0,
              ),
            ),
          ),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: value,
                isExpanded: true,
                dropdownColor: const Color(0xFF121212),
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFFC8A96E),
                  size: 18,
                ),
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                items: items
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(itemLabelBuilder(e)),
                      ),
                    )
                    .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
