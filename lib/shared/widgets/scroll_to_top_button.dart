import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/navigation/navigation_providers.dart';

class ScrollToTopButton extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  final double threshold;

  const ScrollToTopButton({
    super.key,
    required this.scrollController,
    this.threshold = 300.0,
  });

  @override
  ConsumerState<ScrollToTopButton> createState() => _ScrollToTopButtonState();
}

class _ScrollToTopButtonState extends ConsumerState<ScrollToTopButton> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (widget.scrollController.hasClients) {
      final show = widget.scrollController.offset > widget.threshold;
      if (show != _isVisible) {
        setState(() {
          _isVisible = show;
        });
      }
    }
  }

  void _scrollToTop() {
    widget.scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final navHeight = ref.watch(navBarHeightProvider);
    final isNavVisible = ref.watch(navBarVisibleProvider);
    final effectiveNavHeight = isNavVisible ? navHeight : 0.0;

    // Position above the navigation bar or main FAB
    // If main FAB is at effectiveNavHeight + 8, and its height is 56, its top is at effectiveNavHeight + 64.
    // So we put this one at effectiveNavHeight + 72 (or higher).
    final targetBottom = effectiveNavHeight + 84.0;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      bottom: _isVisible ? targetBottom : -80.0,
      right: 24.0,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: _isVisible ? 1.0 : 0.0,
        child: _isVisible
            ? ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: GestureDetector(
                    onTap: _scrollToTop,
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color(0xFFC8A96E).withValues(alpha: 0.4),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.expand_less_rounded,
                        color: Color(0xFFC8A96E),
                        size: 32,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
