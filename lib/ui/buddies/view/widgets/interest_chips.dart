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
  });

  final List<String> fInterests;
  final bool fIsProfile;
  @override
  Widget build(BuildContext context) {
    // Calculate chip height with spacing

    final double maxRows = 2; // Limit to 2 rows

    return SizedBox(
      // height: getRelativeScreenHeight(44, context) * maxRows,
      child: Wrap(
          spacing: 7,
          // runSpacing: 8,
          children: [
            ...fInterests.map((interest) {
              return Chip(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                labelPadding: EdgeInsets.zero,
                backgroundColor: Colors.black,
                label: Text(
                  context.loc.setInterests(interest),
                  style: context.textTheme.bodyMedium!
                      .copyWith(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white24, width: 0.7),
                  borderRadius: BorderRadius.circular(40),
                ),
              );
            }),
            fIsProfile
                ? Chip(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    labelPadding: EdgeInsets.zero,
                    backgroundColor: Colors.black,
                    label: Text(
                      "${context.loc.moreEllipsis}",
                      style: context.textTheme.bodyMedium!
                          .copyWith(color: AppColor.fPrimaryColor),
                    ),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white24, width: 0.7),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  )
                : SizedBox()
          ]),
    );
  }
}
