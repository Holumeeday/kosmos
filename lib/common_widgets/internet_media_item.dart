import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
The widget to display media with string as their type
@author: Ugochukwu
*/
class InternetMediaItem extends StatelessWidget {
  /// The media string
  final String fStringMedia;

  /// To go to the next screen
  final VoidCallback? fToNextScreen;

  /// If its the last media allowed to display
  final bool fLastAllowedToDisplay;

  /// The number of remaining assets
  final int fRemainingAssets;

  /// The width of the media
  final double fWidth;

  /// The height of the media. This should be a non scaled number
  final double fHeight;

  /// The widget to display media with string as their type
  const InternetMediaItem({
    super.key,
    required this.fStringMedia,
    this.fToNextScreen,
    required this.fRemainingAssets,
    required this.fLastAllowedToDisplay,
    required this.fWidth,
    required this.fHeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fToNextScreen,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: fWidth,
          height: fHeight,
          child: Stack(
            children: [
              // If its a video or image
              BaseCachedOnlineMedia(
                fInternetMedia: fStringMedia,
                fUseStaticVideo: true,
                fMediaWidth: double.infinity,
                fMediaHeight: double.infinity,
                fImageErrorWidget: (_, __, ___) {
                  return const _ErrorWidget();
                },
                fVideoErrorWidget: const _ErrorWidget(),
              ),

              // To display the number of assets remaining
              Visibility(
                visible: fLastAllowedToDisplay,
                child: Positioned.fill(
                  child: ColoredBox(
                    color: context.appColors.textBgOnImageCard!,
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          '+ $fRemainingAssets',
                          style: context.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: context.colors.onSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
The error widget
@author: Ugochukwu Umeh
 */
class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.warning,
        size: 30,
        color: context.colors.tertiary,
      ),
    );
  }
}
