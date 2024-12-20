import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/buddy_profile/cubit/buddy_profile_cubit.dart';
import 'package:playkosmos_v3/utils/theme/app_colors.dart';

class UserStatsSection extends StatelessWidget {
  const UserStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuddyProfileCubit, BuddyProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            // First Row with Followers, Following, Buddies
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 26),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BuildStatItem(
                        value: state.fBuddiesModel.followingCount
                            .formatNumToCompact(),
                        label: context.loc.followingUser),
                    VerticalDivider(
                      color: context.appColors.fDividerColor,
                    ),
                    BuildStatItem(
                      value: state.fBuddiesModel.followersCount
                          .formatNumToCompact(),
                      label: context.loc
                          .setFollowers(state.fBuddiesModel.followersCount),
                    ),
                    VerticalDivider(
                      color: context.appColors.fDividerColor,
                    ),
                    BuildStatItem(
                      value: state.fBuddiesModel.buddiesCount
                          .formatNumToCompact(),
                      label: context.loc
                          .setBuddies(state.fBuddiesModel.followersCount),
                    ),
                    VerticalDivider(
                      color: context.appColors.fDividerColor,
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            // center: Alignment.topCenter,
                            stops: [.5, .8, 1],
                            colors: AppColor.fPrimaryGradient),
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        backgroundColor: context.colors.surface,
                        radius: getRelativeScreenHeight(32, context),
                        child: CircleAvatar(
                          radius: getRelativeScreenHeight(30, context),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              color: context.appColors.fDividerColor,
            ),
            // Second Row with Activity Created, Joined, and Reviews
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 14,
              ),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BuildStatItem(
                        value: state.fBuddiesModel.activityCreatedCount
                            .formatNumToCompact(),
                        label: context.loc.setActivitiesCreated(
                            state.fBuddiesModel.activityCreatedCount)),
                    VerticalDivider(
                      color: context.appColors.fDividerColor,
                    ),
                    BuildStatItem(
                      value: state.fBuddiesModel.activityJoinedCount
                          .formatNumToCompact(),
                      label: context.loc.setActivityJoined(
                          state.fBuddiesModel.activityJoinedCount),
                    ),
                    VerticalDivider(
                      color: context.appColors.fDividerColor,
                    ),
                    BuildStatItem(
                        rating: true,
                        value: state.fBuddiesModel.reviewStars.toString(),
                        label:
                            "${state.fBuddiesModel.reviewCount.formatNumToCompact()} ${context.loc.setReviews(state.fBuddiesModel.reviewCount)}"),
                  ],
                ),
              ),
            ),
            Divider(
              color: context.appColors.fDividerColor,
            ),
          ],
        );
      },
    );
  }
}

class BuildStatItem extends StatelessWidget {
  const BuildStatItem({
    super.key,
    required this.value,
    required this.label,
    this.rating = false,
  });
  final String value;
  final String label;
  final bool rating;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        rating
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const HSpace(4),
                  Text(value,
                      style: context.textTheme.displayLarge!
                          .copyWith(fontSize: 18)),
                ],
              )
            : Text(value,
                style: context.textTheme.displayLarge!.copyWith(fontSize: 18)),
        const VSpace(4),
        Text(label,
            style: context.textTheme.headlineSmall!
                .copyWith(color: context.appColors.darkGreyColor)),
      ],
    );
  }
}
