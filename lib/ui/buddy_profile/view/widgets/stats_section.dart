import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/common_widgets/profile_image_with_story_indicator.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/buddy_profile/cubit/buddy_profile_cubit.dart';
import 'package:playkosmos_v3/ui/reviews/view/reviews.dart';
import 'package:playkosmos_v3/utils/utils.dart';

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
                      fValue: state.fBuddiesModel.followingCount
                          .formatNumToCompact(),
                      fLabel: context.loc.followingUser,
                      fOntap: () {
                        context.pushNamed(AppRoute.buddyConnectionsScreenPath,
                            pathParameters: {'initIndex': '0'});
                      },
                    ),
                    VerticalDivider(
                      color: context.appColors.fDividerColor,
                    ),
                    BuildStatItem(
                      fValue: state.fBuddiesModel.followersCount
                          .formatNumToCompact(),
                      fLabel: context.loc
                          .setFollowers(state.fBuddiesModel.followersCount),
                      fOntap: () {
                        context.pushNamed(AppRoute.buddyConnectionsScreenPath,
                            pathParameters: {'initIndex': '1'});
                      },
                    ),
                    VerticalDivider(
                      color: context.appColors.fDividerColor,
                    ),
                    BuildStatItem(
                      fValue:
                          state.fBuddiesModel.buddiesCount.formatNumToCompact(),
                      fLabel: context.loc
                          .setBuddies(state.fBuddiesModel.followersCount),
                      fOntap: () {
                        context.pushNamed(AppRoute.buddyConnectionsScreenPath,
                            pathParameters: {'initIndex': '2'});
                      },
                    ),
                    VerticalDivider(
                      color: context.appColors.fDividerColor,
                    ),
                     ProfileImageWithStoryIndicator(
                      fImage: state.fBuddiesModel.profileImages[0],
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
                        fValue: state.fBuddiesModel.activityCreatedCount
                            .formatNumToCompact(),
                        fLabel: context.loc.setActivitiesCreated(
                            state.fBuddiesModel.activityCreatedCount)),
                    VerticalDivider(
                      color: context.appColors.fDividerColor,
                    ),
                    BuildStatItem(
                      fValue: state.fBuddiesModel.activityJoinedCount
                          .formatNumToCompact(),
                      fLabel: context.loc.setActivityJoined(
                          state.fBuddiesModel.activityJoinedCount),
                    ),
                    VerticalDivider(
                      color: context.appColors.fDividerColor,
                    ),
                    BuildStatItem(
                        fOntap: () {
                          context.push(AppRoute.reviewsScreenPath);
                        },
                        fRating: true,
                        fValue: state.fBuddiesModel.reviews.totalRating.toString(),
                        fLabel:
                            "${state.fBuddiesModel.reviews.count.formatNumToCompact()} ${context.loc.setReviews(state.fBuddiesModel.reviews.count)}"),
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
    required this.fValue,
    required this.fLabel,
    this.fRating = false,
    this.fOntap,
  });
  final String fValue;
  final String fLabel;
  final bool fRating;
  final void Function()? fOntap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fOntap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          fRating
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const HSpace(4),
                    Text(fValue,
                        style: context.textTheme.displayLarge!
                            .copyWith(fontSize: 18)),
                  ],
                )
              : Text(fValue,
                  style:
                      context.textTheme.displayLarge!.copyWith(fontSize: 18)),
          const VSpace(4),
          Text(fLabel,
              style: context.textTheme.headlineSmall!
                  .copyWith(color: context.appColors.darkGreyColor)),
        ],
      ),
    );
  }
}
