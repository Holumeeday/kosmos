import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/connection_type_enum.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/models/buddies_model.dart';
import 'package:playkosmos_v3/ui/buddies/cubit/buddies_cubit.dart';
import 'package:playkosmos_v3/ui/buddies/view/widgets/interest_chips.dart';
import 'package:playkosmos_v3/ui/buddies/view/widgets/next_arrow_button.dart';
import 'package:playkosmos_v3/ui/buddies/view/widgets/overlapping_profiles.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// Buddies Page
/// A page that displays a user profile with details like distance, interests, and mutual buddies.
/// @author: Chidera Chijama
class BuddiesPage extends StatelessWidget {
  const BuddiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuddiesCubit, BuddiesState>(
      builder: (context, state) {
        return PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: state.fBuddiesModel.length,
          itemBuilder: (context, index) {
            return _BuddyProfile(
              fProfile: state.fBuddiesModel[index],
            );
          },
        );
      },
    );
  }
}

class _BuddyProfile extends StatelessWidget {
  const _BuddyProfile({
    required this.fProfile,
  });

  final BuddyModel fProfile;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        if (fProfile.profileImages.isNotEmpty)
          Positioned.fill(
              child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(fProfile.profileImages.first))),
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
                              "${fProfile.distance} ${context.loc.miles} ${context.loc.away}",
                              style: context.textTheme.bodyMedium!
                                  .copyWith(color: context.colors.primary),
                            )
                          ],
                        ),
                        context),
                    _buildBadge(
                        Text(
                          "${fProfile.similarInterestsCount} ${context.loc.similarInterests} ",
                          style: context.textTheme.headlineSmall!
                              .copyWith(color: context.appColors.textColor),
                        ),
                        context),
                    _buildBadge(
                        Row(
                          children: [
                            const OverlappingProfiles(),
                            Text(
                              " ${fProfile.mutualBuddiesCount > 12 ? '+' : ''}${fProfile.mutualBuddiesCount} ${context.loc.mutualBuddies}",
                              style: context.textTheme.headlineSmall!
                                  .copyWith(color: context.appColors.textColor),
                            )
                          ],
                        ),
                        context),
                  ],
                ),

                const VSpace(12),

                // User name and follow button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextScaleFactorClamp(
                        fChild: Text(fProfile.userName,
                            style: context.textTheme.displayLarge!
                                .copyWith(color: Colors.white, fontSize: 28)),
                      ),
                    ),
                    const HSpace(8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        fProfile.connectionType.toConnectionButton(context),
                        const HSpace(5),
                        NextArrowButton(
                          fOnTap: () {
                            context.push(
                              AppRoute.buddyProfileScreenPath,
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
                const VSpace(12),

                // Interests Chips
                InterestChips(
                  // Should only show few interests here
                  fInterests: fProfile.interests.take(4).toList(),
                )
              ],
            ),
          ),
        ),
      ],
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
        child: fChild,
      ),
    );
  }
}
