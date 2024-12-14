import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
The added media to the activity
@author: Ugochukwu Umeh
*/
class ActivityAddedMedia extends StatelessWidget {
  /// A list of the added media
  final List<String> fAddedMedia;

  /// To move to activity added media screen
  final VoidCallback? fToMediaScreen;

  const ActivityAddedMedia({
    super.key,
    required this.fAddedMedia,
    this.fToMediaScreen,
  });

  @override
  Widget build(BuildContext context) {
    if (fAddedMedia.isEmpty) {
      return const SizedBox.shrink();
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        // The width of each media item
        const double fMediaWidth = 105;

        // The maximum number of media to display
        final int fMaxMediaNumber = (constraints.maxWidth ~/ fMediaWidth);

        // Padding to use
        final double fPaddingToUse =
            (constraints.maxWidth % fMediaWidth) / (fMaxMediaNumber - 1);

        //The number of remaining assets
        final int fRemainingAssets = fAddedMedia.length - fMaxMediaNumber;

        //Takes not more than the maximum number specified
        final List<String> fMediaToDisplay =
            fAddedMedia.take(fMaxMediaNumber).toList();

        // The final length of the list
        final int fListLength = fMediaToDisplay.length;

        return SizedBox(
          height: 110,
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              fListLength,
              (index) {
                final String media = fMediaToDisplay[index];
                final bool lastItem = index == fListLength - 1;
                final bool fLastAllowedToDisplay =
                    (fRemainingAssets > 0 && lastItem);
                return Semantics(
                  label: media.isVideo ? context.loc.video : context.loc.image,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: lastItem ? 0 : fPaddingToUse,
                    ),
                    child: InternetMediaItem(
                      fHeight: 100,
                      fStringMedia: media,
                      fWidth: fMediaWidth,
                      fToNextScreen: fToMediaScreen,
                      fRemainingAssets: fRemainingAssets,
                      fLastAllowedToDisplay: fLastAllowedToDisplay,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
