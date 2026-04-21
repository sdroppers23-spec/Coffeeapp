import 'dart:ui';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../features/discover/lots/providers/lot_design_debug_provider.dart';

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
  final String? debugKey;

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 15,
    this.opacity = 0.08,
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
    this.enableRepaintBoundary = true,
    this.useOuterClip = true,
    this.debugKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debugConfig = ref.watch(lotDesignDebugProvider);
    final useDebug = debugConfig.isDebugMode;

    double effectiveBlur = useDebug ? debugConfig.blur : blur;
    double effectiveOpacity = useDebug ? debugConfig.tintOpacity : opacity;

    if (useDebug && debugKey != null) {
      if (debugKey == 'navBar') {
        effectiveBlur = debugConfig.navBarBlur;
        effectiveOpacity = debugConfig.navBarOpacity;
      } else if (debugKey == 'flavorCard') {
        effectiveBlur = debugConfig.flavorCardBlur;
        effectiveOpacity = debugConfig.flavorCardOpacity;
      } else if (debugKey == 'profileDialog') {
        effectiveBlur = debugConfig.profileBlur;
        effectiveOpacity = debugConfig.profileOpacity;
      }
    }
    final effectiveBorderRadius = useDebug ? debugConfig.borderRadius : borderRadius;
    final effectiveBorderColor = useDebug
        ? debugConfig.borderColor.withValues(alpha: debugConfig.borderOpacity)
        : (borderColor ?? Colors.white.withValues(alpha: 0.12));
    final effectiveBaseColor = useDebug
        ? debugConfig.baseColor.withValues(alpha: debugConfig.baseOpacity)
        : Colors.black.withValues(alpha: 0.5);
    final effectiveTintColor = useDebug ? debugConfig.tintColor : (color ?? Colors.white);

    // Layer 1 & 2 combined into a clipped stack
    Widget mainContent = ClipRRect(
      borderRadius: BorderRadius.circular(effectiveBorderRadius),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        children: [
          // Layer 1: Glass Blur
          Positioned.fill(
            child: (enableBlur) 
              ? BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: effectiveBlur,
                    sigmaY: effectiveBlur,
                  ),
                  child: Container(color: effectiveBaseColor),
                )
              : Container(color: effectiveBaseColor),
          ),
          // Layer 2: Main decoration and content
          Container(
            padding: padding,
            decoration: BoxDecoration(
              color: (useDebug || backgroundGradient == null)
                  ? effectiveTintColor.withValues(alpha: effectiveOpacity)
                  : null,
              borderRadius: BorderRadius.circular(effectiveBorderRadius),
              border: Border.all(
                color: effectiveBorderColor,
                width: 1.0,
              ),
              image: imageUrl != null
                  ? DecorationImage(
                      image: imageUrl!.startsWith('http')
                          ? CachedNetworkImageProvider(imageUrl!) as ImageProvider
                          : AssetImage(imageUrl!),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withValues(alpha: 1 - imageOpacity),
                        BlendMode.darken,
                      ),
                    )
                  : null,
              gradient: (useDebug || imageUrl != null)
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
    Widget finalCard = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        boxShadow: (enableShadow) 
          ? (shadows ??
            [
              BoxShadow(
                color: (useDebug ? debugConfig.shadowColor : Colors.black)
                    .withValues(alpha: 0.3),
                blurRadius: useDebug ? debugConfig.shadowBlur : 20,
                spreadRadius: useDebug ? debugConfig.shadowSpread : 0,
                offset: Offset(0, useDebug ? debugConfig.shadowOffsetY : 4),
              ),
            ])
          : null,
      ),
      child: useOuterClip 
        ? ClipRRect(
            borderRadius: BorderRadius.circular(effectiveBorderRadius),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: mainContent,
          )
        : mainContent,
    );

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: finalCard,
    );
  }
}
