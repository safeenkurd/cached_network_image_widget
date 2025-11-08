library cached_network_image_widget;

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// A widget for displaying network images with caching, placeholders, and blurhash support.
class CachedNetworkImageWidget extends StatefulWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final BoxFit fit;
  final BoxShape shape;
  final int? cacheWidth;
  final Widget Function(BuildContext, String, Object)? errorBuilder;

  const CachedNetworkImageWidget(
    this.imageUrl, {
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.border,
    this.fit = BoxFit.cover,
    this.shape = BoxShape.rectangle,
    this.cacheWidth,
    this.errorBuilder,
  });

  @override
  State<CachedNetworkImageWidget> createState() =>
      _CachedNetworkImageWidgetState();
}

class _CachedNetworkImageWidgetState extends State<CachedNetworkImageWidget> {
  static final CacheManager _cacheManager = CacheManager(
    Config(
      'cached_network_images',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 100,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.imageUrl;
    if (imageUrl == null || imageUrl.isEmpty) {
      return widget.errorBuilder?.call(context, imageUrl ?? '', Object()) ??
          _MainErrorWidget(
            height: widget.height,
            width: widget.width,
            icon: Icons.image_outlined,
          );
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        border: widget.border,
        shape: widget.shape,
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: widget.height,
        width: widget.width,
        fit: widget.fit,
        memCacheWidth: widget.cacheWidth,
        cacheManager: _cacheManager,
        fadeOutDuration: const Duration(milliseconds: 300),
        fadeInDuration: Duration.zero,
        placeholder: (context, _) => _buildBlurHashPlaceholder(imageUrl),
        errorWidget: (context, url, error) =>
            widget.errorBuilder?.call(context, url, error) ??
            const _MainErrorWidget(),
      ),
    );
  }

  Widget _buildBlurHashPlaceholder(String imageUrl) {
    final blurHash = imageUrl.betweenMarkers('-BH_', '-EBH_')?.expandUrl();
    if (blurHash != null) {
      return Image(
        image: BlurHashImage(blurHash),
        fit: widget.fit,
        errorBuilder: (_, __, ___) => const _PlaceholderWidget(),
      );
    }
    return const _PlaceholderWidget();
  }
}

class _PlaceholderWidget extends StatelessWidget {
  const _PlaceholderWidget();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFFE0E0E0),
    ).animate().shimmer(duration: const Duration(seconds: 1));
  }
}

class _MainErrorWidget extends StatelessWidget {
  final IconData? icon;
  final double? height;
  final double? width;

  const _MainErrorWidget({this.icon, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: Icon(
          icon ?? Icons.error_outline_rounded,
          color: const Color(0xFFBDBDBD),
        ),
      ),
    );
  }
}

/// Extracts a substring between two markers.
extension StringBetweenMarkers on String {
  String? betweenMarkers(String start, String end) {
    final startIndex = indexOf(start);
    if (startIndex == -1) return null;

    final endIndex = indexOf(end, startIndex + start.length);
    if (endIndex == -1) return null;

    return substring(startIndex + start.length, endIndex);
  }
}

/// Decodes a Base64 string from URL-safe format.
extension Base64Extension on String {
  String? expandUrl() {
    try {
      var padded = this + '=' * ((4 - (length % 4)) % 4);
      var decoded = padded.replaceAll('-', '+').replaceAll('_', '/');
      return utf8.decode(base64Url.decode(decoded));
    } catch (_) {
      return null;
    }
  }
}

/// A widget for displaying and caching SVG images from the network.
class CachedNetworkSvgWidget extends StatefulWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final BoxFit fit;
  final BoxShape shape;
  final Duration? fadeDuration;
  final Widget? placeholder;
  final Color? color;
  final Widget Function(BuildContext, String, Object)? errorBuilder;

  const CachedNetworkSvgWidget(
    this.imageUrl, {
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.border,
    this.fit = BoxFit.cover,
    this.shape = BoxShape.rectangle,
    this.fadeDuration = const Duration(milliseconds: 300),
    this.placeholder,
    this.errorBuilder,
    this.color,
  });

  @override
  State<CachedNetworkSvgWidget> createState() => _CachedNetworkSvgWidgetState();
}

class _CachedNetworkSvgWidgetState extends State<CachedNetworkSvgWidget> {
  static final CacheManager _cacheManager = CacheManager(
    Config(
      'cached_svg_images',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 100,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.imageUrl;
    if (imageUrl == null || imageUrl.isEmpty) {
      return widget.errorBuilder?.call(context, imageUrl ?? '', Object()) ??
          _MainErrorWidget(
            height: widget.height,
            width: widget.width,
            icon: Icons.image_outlined,
          );
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        border: widget.border,
        shape: widget.shape,
      ),
      child: CachedNetworkSVGImage(
        imageUrl,
        height: widget.height,
        width: widget.width,
        fit: widget.fit,
        colorFilter: ColorFilter.mode(
          widget.color ?? Colors.black,
          BlendMode.srcIn,
        ),
        cacheManager: _cacheManager,
        fadeDuration: widget.fadeDuration ?? const Duration(milliseconds: 300),
        placeholder:
            widget.placeholder ??
            const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        errorWidget:
            widget.errorBuilder?.call(context, imageUrl, Object()) ??
            const Icon(Icons.error, color: Colors.red),
      ),
    );
  }
}
