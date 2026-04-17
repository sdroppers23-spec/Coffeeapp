import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GlassContainer extends StatelessWidget {
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
  });

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Stack(
      children: [
        // Layer 1: Base black background for smoothness and to prevent sharp highlights
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: shadows ?? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        ),
        // Layer 2: Blur and Main Glass Decoration
        ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          clipBehavior: Clip.antiAlias,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Container(
              width: width ?? double.infinity,
              height: height,
              padding: padding,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: opacity),
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: borderColor ?? Colors.white.withValues(alpha: 0.15),
                  width: 1.2,
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
                gradient: imageUrl == null
                        ? backgroundGradient ??
                            LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withValues(alpha: 0.12),
                                Colors.white.withValues(alpha: 0.04),
                              ],
                            )
                        : null,
              ),
              child: child,
            ),
          ),
        ),
      ],
    );

    if (margin != null) {
      return Padding(
        padding: margin!,
        child: mainContent,
      );
    }
    return mainContent;
  }
}
