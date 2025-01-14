import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/common_widgets/profile_image_with_story_indicator.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/buddy_profile/cubit/buddy_profile_cubit.dart';
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
                      fValue:
                          state.fBuddyModel.followingCount.formatNumToCompact(),
                      fLabel: context.loc.followingUser,
                      fOntap: () {
                        context.pushNamed(AppRoute.buddyConnectionsScreen,
                            extra: 0);
                      },
                    ),
                    VerticalDivider(
                      color: context.appColors.fDividerColor,
                    ),
                    BuildStatItem(
                      fValue:
                          state.fBuddyModel.followersCount.formatNumToCompact(),
                      fLabel: context.loc
                          .setFollowers(state.fBuddyModel.followersCount),
                      fOntap: () {
                        context.pushNamed(AppRoute.buddyConnectionsScreen,
                            extra: 1);
                      },
                    ),
                    VerticalDivider(
                      color: context.appColors.fDividerColor,
                    ),
                    BuildStatItem(
                      fValue:
                          state.fBuddyModel.buddiesCount.formatNumToCompact(),
                      fLabel: context.loc
                          .setBuddies(state.fBuddyModel.followersCount),
                      fOntap: () {
                        context.pushNamed(AppRoute.buddyConnectionsScreen,
                            extra: 2);
                      },
                    ),
                    VerticalDivider(
                      color: context.appColors.fDividerColor,
                    ),
                    ProfileImageWithStoryIndicator(
                      fImage: state.fBuddyModel.profileImages[0],
                    )
                  ],
                ),
              ),
            ),
            Divider(
              color: context.appColors.fDividerColor,
            ),
            TextWithBackground(
                fText:
                    "${context.loc.setActivitiesCreated(2)}, ${context.loc.reviews}, & ${context.loc.ratings}"),
            Divider(
              color: context.appColors.fDividerColor,
            ),
            // Second Row with Activity Created, Joined, and Reviews
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(context.loc.activitiesHosted.toUpperCase(),
                            style: context.textTheme.headlineSmall!
                                .copyWith(color: context.colors.tertiary)),
                        const VSpace(4),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 10),
                          child: IntrinsicHeight(
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BuildStatItem(
                                  fOntap: () {
                                    context.pushNamed(
                                        AppRoute.buddyActivitiesScreen,
                                        extra: true);
                                  },
                                  fValue: state.fBuddyModel.activityCreatedCount
                                      .formatNumToCompact(),
                                ),
                                VerticalDivider(
                                  color: context.appColors.fDividerColor,
                                  width: 20,
                                ),
                                state.fBuddyModel.reviews.count < 1
                                    ? Text(context.loc.noReview,
                                        style: context.textTheme.headlineSmall!
                                            .copyWith(
                                                color: context
                                                    .appColors.darkGreyColor))
                                    : BuildStatItem(
                                        fOntap: () {
                                          context
                                              .push(AppRoute.reviewsScreenPath);
                                        },
                                        fRating: true,
                                        fValue: state
                                            .fBuddyModel.reviews.averageRating
                                            .toString(),
                                        fLabel:
                                            "${state.fBuddyModel.reviews.count.formatNumToCompact()} ${context.loc.setReviews(state.fBuddyModel.reviews.count)}"),
                              ],
                            ),
                          ),
                        ),
                        const VSpace(10)
                      ],
                    ),
                    VerticalDivider(
                      color: context.appColors.fDividerColor,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(context.loc.activitiesJoined.toUpperCase(),
                            style: context.textTheme.headlineSmall!
                                .copyWith(color: context.colors.tertiary)),
                        const VSpace(4),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 10),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BuildStatItem(
                                  fOntap: () {
                                    context.pushNamed(
                                        AppRoute.buddyActivitiesScreen,
                                        extra: false);
                                  },
                                  fValue: state.fBuddyModel.activityJoinedCount
                                      .formatNumToCompact(),
                                ),
                                VerticalDivider(
                                  color: context.appColors.fDividerColor,
                                  width: 20,
                                ),
                                state.fBuddyModel.reviews.count < 1
                                    ? Text(context.loc.noReview,
                                        style: context.textTheme.headlineSmall!
                                            .copyWith(
                                                color: context
                                                    .appColors.darkGreyColor))
                                    : BuildStatItem(
                                        fOntap: () {
                                          context
                                              .push(AppRoute.reviewsScreenPath);
                                        },
                                        fRating: true,
                                        fValue: state
                                            .fBuddyModel.reviews.averageRating
                                            .toString(),
                                        fLabel:
                                            "${state.fBuddyModel.reviews.count.formatNumToCompact()} ${context.loc.setReviews(state.fBuddyModel.reviews.count)}"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
    this.fLabel,
    this.fRating = false,
    this.fOntap,
  });
  final String fValue;
  final String? fLabel;
  final bool fRating;
  final void Function()? fOntap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fOntap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
          !fLabel.checkIsNull
              ? Text(fLabel ?? '',
                  style: context.textTheme.headlineSmall!
                      .copyWith(color: context.appColors.darkGreyColor))
              : const SizedBox(),
        ],
      ),
    );
  }
}
