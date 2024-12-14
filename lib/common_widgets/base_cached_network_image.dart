import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
This class is the default cached network image to use as it handles error
@author: Ugochukwu Umeh
*/
class BaseCachedNetworkImage extends StatelessWidget {
  ///The image
  final String? fImage;

  ///The place holder if any
  final Widget Function(BuildContext, String)? fPlaceholderWidget;

  ///The error widget if any
  final Widget Function(BuildContext, String, dynamic)? fErrorWidget;

  ///The image width
  final double? fImageWidth;

  ///The image height
  final double? fImageHeight;

  /// The image builder
  final Widget Function(BuildContext context, ImageProvider image)?
      fImageBuilder;

  const BaseCachedNetworkImage({
    super.key,
    required this.fImage,
    this.fErrorWidget,
    this.fPlaceholderWidget,
    this.fImageHeight,
    this.fImageWidth,
    this.fImageBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final Color fMainColor = context.colors.tertiary.withOpacity(0.3);

    if (fImage == null) {
      return SizedBox(
        width: fImageWidth,
        height: fImageHeight,
        child: ColoredBox(
          color: fMainColor,
        ),
      );
    }
    return CachedNetworkImage(
      imageUrl: fImage!,
      fit: BoxFit.cover,
      width: fImageWidth,
      height: fImageHeight,
      placeholder: fPlaceholderWidget ??
          (_, __) => ColoredBox(
                color: fMainColor,
              ),
      imageBuilder: fImageBuilder,
      errorWidget: fErrorWidget ??
          (_, __, ___) => ColoredBox(
                color: fMainColor,
              ),
    );
  }
}
