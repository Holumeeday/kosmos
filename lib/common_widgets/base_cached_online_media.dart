import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
To handle the cases of the media file from the internet
@author: Ugochukwu Umeh
 */
class BaseCachedOnlineMedia extends StatelessWidget {
  /// The string url
  final String? fInternetMedia;

  /// The placeholder widget if [fInternetMedia] is an image
  final Widget Function(BuildContext, String)? fImagePlaceholderWidget;

  /// The error widget if [fInternetMedia] is an image
  final Widget Function(BuildContext, String, dynamic)? fImageErrorWidget;

  /// The error widget if [fInternetMedia] is a video. Defaults to a colored box
  final Widget? fVideoErrorWidget;

  /// The width
  final double? fMediaWidth;

  /// The height
  final double? fMediaHeight;

  /// The image builder if [fInternetMedia] is an image
  final Widget Function(BuildContext context, ImageProvider image)?
      fImageBuilder;

  /// The widget to display if [fInternetMedia] is null. Defaults to a colored
  /// box with the [Theme.of(context).colorScheme.tertiary] color
  final Widget? fNullMedia;

  /// The place holder widget before the thumbnail or when there is an issue in
  /// generating the thumb nail. Defaults to a shimmer
  final Widget? fVideoPlaceholderWidget;

  /// Should show the error media message or the default colored box
  final bool fShowErrorMediaText;

  /// if the video should be a static video or a normal video
  final bool fUseStaticVideo;

  /// The widget to place over the static video to show its a video. Defaults
  /// to a video icon at the bottom right corner
  final Widget? fVideoSignIcon;

  const BaseCachedOnlineMedia({
    super.key,
    required this.fInternetMedia,
    this.fImagePlaceholderWidget,
    this.fImageErrorWidget,
    this.fMediaWidth,
    this.fMediaHeight,
    this.fImageBuilder,
    this.fNullMedia,
    this.fVideoPlaceholderWidget,
    this.fVideoErrorWidget,
    this.fUseStaticVideo = false,
    this.fVideoSignIcon,
    this.fShowErrorMediaText = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color fMainColor = context.colors.tertiary.withOpacity(0.3);

    if (fInternetMedia == null) {
      return SizedBox(
        width: fMediaWidth,
        height: fMediaHeight,
        child: fNullMedia ??
            ColoredBox(
              color: fMainColor,
            ),
      );
    } else if (fInternetMedia!.isVideo) {
      return const SizedBox();
    }
    return BaseCachedNetworkImage(
      fImage: fInternetMedia,
      fImageHeight: fMediaHeight,
      fImageWidth: fMediaWidth,
      fErrorWidget: fImageErrorWidget ??
          (_, __, ___) {
            if (fShowErrorMediaText) {
              return const ErrorMedia();
            }
            return ColoredBox(
              color: fMainColor,
            );
          },
      fImageBuilder: fImageBuilder,
      fPlaceholderWidget: fImagePlaceholderWidget,
    );
  }
}
