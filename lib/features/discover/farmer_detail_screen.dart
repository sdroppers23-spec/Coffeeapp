import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/dtos.dart';
import '../../core/config/flag_constants.dart';
import '../navigation/main_scaffold.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FarmerDetailScreen extends ConsumerStatefulWidget {
  final LocalizedFarmerDto farmer;

  const FarmerDetailScreen({super.key, required this.farmer});

  @override
  ConsumerState<FarmerDetailScreen> createState() => _FarmerDetailScreenState();
}

class _FarmerDetailScreenState extends ConsumerState<FarmerDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(navBarVisibleProvider.notifier).hide();
    });
  }

  @override
  void dispose() {
    Future.microtask(() {
      ref.read(navBarVisibleProvider.notifier).show();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const gold = Color(0xFFC8A96E);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0908),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            backgroundColor: Colors.black,
            elevation: 0,
            pinned: true,
            leading: IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.black45,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  if (widget.farmer.imageUrl.isNotEmpty)
                    _LocalOrNetworkImage(
                      url: widget.farmer.imageUrl,
                      fit: BoxFit.cover,
                    )
                  else
                    Container(color: Colors.grey[900]),
                  // Gradient Overlay
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black26,
                          Colors.transparent,
                          Color(0xFF0A0908),
                        ],
                        stops: [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  // Location Chip
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CachedNetworkImage(
                          imageUrl:
                              FlagConstants.getFlag(widget.farmer.country) ??
                              '',
                          width: 32,
                          height: 20,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Container(color: Colors.white10),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.public,
                            size: 20,
                            color: Colors.white24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: gold.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: gold.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          '${widget.farmer.country}, ${widget.farmer.region}'
                              .toUpperCase(),
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: gold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Farmer Name
                  Text(
                    widget.farmer.name,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 42,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Content
                  Html(
                    data:
                        """
                      <div style='color: white; font-family: Inter;'>
                        ${_formatText(widget.farmer.description)}
                        <br/><br/>
                        ${_formatText(widget.farmer.story)}
                      </div>
                    """,
                    style: {
                      "body": Style(
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: FontSize(17),
                        lineHeight: LineHeight.number(1.7),
                      ),
                      "h3": Style(
                        color: gold,
                        fontSize: FontSize(22),
                        fontWeight: FontWeight.w700,
                        margin: Margins.only(top: 32, bottom: 12),
                      ),
                      "p": Style(margin: Margins.only(bottom: 16)),
                      "b": Style(color: gold),
                      "li": Style(
                        margin: Margins.only(bottom: 8),
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    },
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatText(String text) {
    if (text.isEmpty) return '';
    // If it already has HTML tags, return as is
    if (text.contains('<p>') || text.contains('<br') || text.contains('<h')) {
      return text;
    }

    // Convert double newlines to paragraphs
    return text
        .split('\n\n')
        .where((p) => p.trim().isNotEmpty)
        .map((p) => '<p>${p.replaceAll('\n', '<br/>')}</p>')
        .join();
  }
}

class _LocalOrNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit fit;

  const _LocalOrNetworkImage({required this.url, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    final isLocal =
        url.contains(':\\') || url.startsWith('/') || url.startsWith('file://');

    if (isLocal) {
      final path = url.replaceFirst('file://', '');
      return Image.file(
        File(path),
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            Container(color: Colors.grey[900]),
      );
    }

    if (url.startsWith('assets/')) {
      return Image.asset(
        url,
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            Container(color: Colors.grey[900]),
      );
    }

    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      placeholder: (context, url) => Container(
        color: Colors.black,
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      errorWidget: (context, url, error) => Container(color: Colors.grey[900]),
    );
  }
}
