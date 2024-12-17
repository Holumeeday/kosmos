import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/buddies/view/widget/interest_chips.dart';
import 'package:playkosmos_v3/ui/buddies/view/widget/next_arrow_button.dart';
import 'package:playkosmos_v3/ui/buddies/view/widget/overlapping_profiles.dart';

/// Buddies Page
/// A page that displays a user profile with details like distance, interests, and mutual buddies.
/// @author: Chidera Chijama
class BuddiesPage extends StatelessWidget {
  const BuddiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
              child: Container(
            color: Colors.purple,
          )),

          // Gradient Overlay at the bottom
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black87,
                    Colors.black,
                  ],
                  stops: [0.8, 0.85, 0.9],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Bottom Content
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomSection(context),
          ),
        ],
      ),
    );
  }

  /// Bottom section containing the profile name, buttons, and interests
  Widget _buildBottomSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            runSpacing: 9,
            spacing: 8,
            children: [
              _buildBadge(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on_sharp,
                          color: context.colors.primary),
                      Text(
                        "3 ${context.loc.miles} ${context.loc.away}",
                        style: context.textTheme.bodyMedium!
                            .copyWith(color: context.colors.primary),
                      )
                    ],
                  ),
                  context),
              _buildBadge(
                  Text(
                    "15 ${context.loc.similarInterests} ",
                    style: context.textTheme.titleMedium!
                        .copyWith(fontSize: 14)
                        .copyWith(color: context.appColors.textColor),
                  ),
                  context),
              _buildBadge(
                  Row(
                    children: [
                      const OverlappingProfiles(),
                      Text(
                        "+12 ${context.loc.mutualBuddies}",
                        style: context.textTheme.titleMedium!
                            .copyWith(fontSize: 14)
                            .copyWith(color: context.appColors.textColor),
                      )
                    ],
                  ),
                  context),
            ],
          ),

          const VSpace(12),

          // User name and follow button
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextScaleFactorClamp(
                    fChild: Text("Jordyn Vaccaro",
                        style: context.textTheme.displayLarge!
                            .copyWith(color: Colors.white, fontSize: 28)),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PrimaryGradientButton(
                        fOnPressed: () {},
                        fChild: Text(
                          context.loc.followUser,
                          style: context.textTheme.displayLarge!
                              .copyWith(color: Colors.white, fontSize: 16),
                        )),
                    const HSpace(5),
                    const NextArrowButton(),
                  ],
                )
              ],
            ),
          ),
          const VSpace(12),

          // Interests Chips
          const InterestChips(kInterests: kInterests)
        ],
      ),
    );
  }

  /// Builds a badge with an icon and text
  Widget _buildBadge(Widget fChild, BuildContext context) {
    return UnconstrainedBox(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 33,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: fChild),
    );
  }

  static const kInterests = [
    "Art",
    "Hockey",
    "Sport",
    "Baseball",
    "Rugby",
    "Visual Arts",
    "Ice Hockey",
    "Softball",
    "Softball"
  ];
}

