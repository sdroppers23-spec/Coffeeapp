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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: shadows ?? [
            BoxShadow(
              color: isDark 
                  ? Colors.black.withValues(alpha: 0.3)
                  : theme.primaryColor.withValues(alpha: 0.05),
              blurRadius: isDark ? 20 : 15,
              spreadRadius: isDark ? 0 : -2,
              offset: isDark ? const Offset(0, 4) : const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Layer 1: Base matte tint
              Positioned.fill(
                child: Container(
                  color: isDark 
                      ? Colors.black.withValues(alpha: 0.5)
                      : theme.colorScheme.surface.withValues(alpha: 0.8),
                ),
              ),
              // Layer 2: Glass Blur
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                  child: Container(color: Colors.transparent),
                ),
              ),
              // Layer 3: Specular Highlight (Light Mode only)
              if (!isDark)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withValues(alpha: 0.5),
                          Colors.white.withValues(alpha: 0.0),
                        ],
                        stops: const [0.0, 0.3],
                      ),
                    ),
                  ),
                ),
              // Layer 4: Main decoration and content
              Container(
                padding: padding,
                decoration: BoxDecoration(
                  color: isDark 
                      ? Colors.white.withValues(alpha: opacity)
                      : Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(
                    color: borderColor ?? (isDark 
                        ? Colors.white.withValues(alpha: 0.12)
                        : theme.colorScheme.primary.withValues(alpha: 0.08)),
                    width: isDark ? 1.0 : 1.5,
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
                            colors: isDark ? [
                              Colors.white.withValues(alpha: 0.1),
                              Colors.white.withValues(alpha: 0.02),
                            ] : [
                              Colors.white.withValues(alpha: 0.5),
                              Colors.white.withValues(alpha: 0.1),
                            ],
                          )
                      : null,
                ),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
