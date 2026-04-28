import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GlassContainer extends ConsumerWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? borderColor;
  final List<BoxShadow>? shadows;
  final String? imageUrl;
  final double imageOpacity;
  final double? width;
  final double? height;
  final Gradient? backgroundGradient;
  final Color? color;
  final bool enableBlur;
  final bool enableShadow;
  final bool enableRepaintBoundary;
  final bool useOuterClip;

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 25.8,
    this.opacity = 0.03,
    this.padding,
    this.margin,
    this.borderRadius = 24,
    this.borderColor,
    this.shadows,
    this.imageUrl,
    this.imageOpacity = 0.4,
    this.width,
    this.height,
    this.backgroundGradient,
    this.color,
    this.enableBlur = true,
    this.enableShadow = true,
    this.enableRepaintBoundary = false,
    this.useOuterClip = true,
    // debugKey removed as it is no longer used
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fixed production configurations
    final double effectiveBlur = blur;
    final double effectiveOpacity = opacity;
    const double effectiveBaseOpacity = 0.4;

    final effectiveBorderRadius = borderRadius;

    final effectiveBorderColor =
        borderColor ?? Colors.white.withValues(alpha: 0.12);

    final effectiveBaseColor = Colors.black.withValues(
      alpha: effectiveBaseOpacity,
    );

    final effectiveTintColor = color ?? Colors.white;

    // Layer 1 & 2 combined into a clipped stack
    Widget mainContent = ClipRRect(
      borderRadius: BorderRadius.circular(effectiveBorderRadius),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Layer 1: Glass Blur (Pure backdrop filter with Windows hack)
          if (enableBlur && effectiveBlur > 0)
            Positioned.fill(
              child: Opacity(
                opacity:
                    0.999, // Hack to force BackdropFilter visibility on Windows
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: effectiveBlur,
                    sigmaY: effectiveBlur,
                  ),
                  child: const SizedBox.shrink(),
                ),
              ),
            ),

          // Layer 2: Base Backdrop Color/Tint
          Positioned.fill(child: Container(color: effectiveBaseColor)),

          // Layer 3: Main decoration and content
          Container(
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundGradient == null
                  ? effectiveTintColor.withValues(alpha: effectiveOpacity)
                  : null,
              borderRadius: BorderRadius.circular(effectiveBorderRadius),
              border: Border.all(color: effectiveBorderColor, width: 1.0),
              image: imageUrl != null
                  ? DecorationImage(
                      image: imageUrl!.startsWith('http')
                          ? CachedNetworkImageProvider(imageUrl!)
                                as ImageProvider
                          : AssetImage(imageUrl!),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withValues(alpha: 1 - imageOpacity),
                        BlendMode.darken,
                      ),
                    )
                  : null,
              gradient: imageUrl != null
                  ? null
                  : (backgroundGradient ??
                        LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withValues(alpha: 0.1),
                            Colors.white.withValues(alpha: 0.02),
                          ],
                        )),
            ),
            child: child,
          ),
        ],
      ),
    );

    if (enableRepaintBoundary) {
      mainContent = RepaintBoundary(child: mainContent);
    }

    // Final structure: Shadow + Optional Outer Clip
    final Widget finalCard = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        boxShadow: (enableShadow)
            ? (shadows ??
                  [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 0,
                      offset: const Offset(0, 4),
                    ),
                  ])
            : null,
      ),
      child: useOuterClip
          ? ClipRRect(
              borderRadius: BorderRadius.circular(effectiveBorderRadius),
              clipBehavior: Clip.antiAlias,
              child: mainContent,
            )
          : mainContent,
    );

    return Padding(padding: margin ?? EdgeInsets.zero, child: finalCard);
  }
}
