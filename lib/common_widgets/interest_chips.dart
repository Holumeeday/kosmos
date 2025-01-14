import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/theme/app_colors.dart';

/* InterestChips
 Displays a list of user interests as chips.
 Limits the display to a maximum of 2 rows.
 @author: Chidera Chijama 
 */
class InterestChips extends StatelessWidget {
  const InterestChips({
    super.key,
    required this.fInterests,
    this.fIsProfile = false,
    this.fOnTap,
  });

  final List<String> fInterests;
  final bool fIsProfile;
  final void Function()? fOnTap;
  // Maximum collective length of rendered strings

  @override
  Widget build(BuildContext context) {
    // Determine the list of interests to display
    List<String> displayedInterests = [];
    int currentLength = 0;
    double maxLength = 20.0;

    for (String interest in fInterests) {
      if ((currentLength + interest.length) <=
          getRelativeScreenWidth(maxLength, context).floor()) {
        displayedInterests.add(interest);
        currentLength += interest.length;
      } else {
        break;
      }
    }

    return SizedBox(
      child: Wrap(
        spacing: 7,
        children: [
          // Render chips for the calculated interests
          ...displayedInterests.map((interest) {
            return Chip(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              labelPadding: EdgeInsets.zero,
              backgroundColor: Colors.black,
              label: Text(
                context.loc.setInterests(interest.toLowerCase()),
                style:
                    context.textTheme.bodyMedium!.copyWith(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white24, width: 0.7),
                borderRadius: BorderRadius.circular(40),
              ),
            );
          }),

          // Add "More..." chip if `fIsProfile` is true
          if (fIsProfile)
            GestureDetector(
              onTap: fOnTap,
              child: Chip(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                labelPadding: EdgeInsets.zero,
                backgroundColor: Colors.black,
                label: Text(
                  context.loc.moreEllipsis,
                  style: context.textTheme.bodyMedium!
                      .copyWith(color: AppColor.fPrimaryColor),
                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white24, width: 0.7),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
