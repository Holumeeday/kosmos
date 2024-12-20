import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/connection_type_enum.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/buddies/cubit/buddies_cubit.dart';
import 'package:playkosmos_v3/ui/buddies/view/widgets/interest_chips.dart';
import 'package:playkosmos_v3/ui/buddies/view/widgets/next_arrow_button.dart';
import 'package:playkosmos_v3/ui/buddies/view/widgets/overlapping_profiles.dart';
import 'package:playkosmos_v3/ui/buddy_profile/view/buddy_profile_page.dart';

/// Buddies Page
/// A page that displays a user profile with details like distance, interests, and mutual buddies.
/// @author: Chidera Chijama
class BuddiesPage extends StatelessWidget {
  const BuddiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuddiesCubit, BuddiesState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              // Background Image
              Positioned.fill(
                  child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            state.fBuddiesModel.profileImages[0]))),
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
                child: Padding(
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
                                    "${state.fBuddiesModel.distance.toString()} ${context.loc.miles} ${context.loc.away}",
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(
                                            color: context.colors.primary),
                                  )
                                ],
                              ),
                              context),
                          _buildBadge(
                              Text(
                                "${state.fBuddiesModel.similarInterestsCount.toString()} ${context.loc.similarInterests} ",
                                style: context.textTheme.headlineSmall!
                                    .copyWith(
                                        color: context.appColors.textColor),
                              ),
                              context),
                          _buildBadge(
                              Row(
                                children: [
                                  const OverlappingProfiles(),
                                  Text(
                                    " ${state.fBuddiesModel.mutualBuddiesCount.toString()} ${context.loc.mutualBuddies}",
                                    style: context.textTheme.headlineSmall!
                                        .copyWith(
                                            color: context.appColors.textColor),
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
                                fChild: Text(
                                    state.fBuddiesModel.userName.toString(),
                                    style: context.textTheme.displayLarge!
                                        .copyWith(
                                            color: Colors.white, fontSize: 28)),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                state.fBuddiesModel.connectionType
                                    .toConnectionButton(context),
                                const HRelativeSpace(5),
                                NextArrowButton(
                                  fOnTap: () {
                                    context.push(const BuddyProfilePage());
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const VSpace(12),

                      // Interests Chips
                      InterestChips(
                        kInterests: state.fBuddiesModel.interests,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
}
