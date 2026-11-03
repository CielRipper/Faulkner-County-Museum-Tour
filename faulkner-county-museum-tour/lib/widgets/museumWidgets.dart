import 'package:flutter/material.dart';
import 'package:faulkner_county_museum_tour/theme.dart';

/// Shows an asset image, or a linen-colored placeholder if there's
/// no image yet (or the file can't be found).
class MuseumImage extends StatelessWidget {
  const MuseumImage({
    super.key,
    this.path,
    this.height,
    this.width,
    this.iconSize = 40,
    this.borderRadius = BorderRadius.zero,
  });

  final String? path;
  final double? height;
  final double? width;
  final double iconSize;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      height: height,
      width: width,
      color: MuseumColors.placeholder,
      alignment: Alignment.center,
      child: Icon(Icons.image_outlined,
          size: iconSize, color: MuseumColors.muted),
    );

    return ClipRRect(
      borderRadius: borderRadius,
      child: path == null
          ? placeholder
          : Image.asset(
              path!,
              height: height,
              width: width,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => placeholder,
            ),
    );
  }
}