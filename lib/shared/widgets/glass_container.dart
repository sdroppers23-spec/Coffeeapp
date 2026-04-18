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
  final Color? color;

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
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: shadows ?? [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Layer 1: Base matte tint (Smoked Glass)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.5),
                ),
              ),
              // Layer 2: Glass Blur
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                  child: Container(color: Colors.transparent),
                ),
              ),
              // Layer 3: Main decoration and content
              Container(
                padding: padding,
                decoration: BoxDecoration(
                  color: color?.withValues(alpha: opacity) ?? Colors.white.withValues(alpha: opacity),
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(
                    color: borderColor ?? Colors.white.withValues(alpha: 0.12),
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
                  gradient: imageUrl == null
                      ? backgroundGradient ??
                          LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withValues(alpha: 0.1),
                              Colors.white.withValues(alpha: 0.02),
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
