import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/common_widgets/profile_image_with_story_indicator.dart';
import 'package:playkosmos_v3/extensions/connection_type_extention.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/buddy_connections/cubit/buddy_connections_cubit.dart';
import 'package:playkosmos_v3/ui/buddy_connections/view/widgets/search_field.dart';
import 'package:playkosmos_v3/utils/utils.dart';
import 'package:sliver_tools/sliver_tools.dart';

/// A page to display followers categorized into mutual and all followers.
///
/// Includes:
/// - A search field for filtering followers.
/// - A mutual followers section with the ability to toggle "Show All".
/// - A complete list of all followers with connection actions.
///
/// @author:
/// Chidera Chijama
class FollowersPage extends StatelessWidget {
  const FollowersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Search Field for followers
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: SearchField(),
          ),
        ),

        // Mutual Followers Section
        MultiSliver(
          pushPinnedChildren: true,
          children: [
            // Section Header for Mutual Followers
            SliverPinnedHeader(
              child: TextWithBackground(
                fText: context.loc.mutualBuddies,
                fTextColor: AppColor.fTextColor,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Mutual Followers List
            BlocBuilder<BuddyConnectionsCubit, BuddyConnectionsState>(
              builder: (context, state) {
                final mutualFollowersList = state.fFollowersListBuddies;
                final displayedList = state.fFollowersShowAll
                    ? mutualFollowersList
                    : mutualFollowersList.take(4).toList();

                return SliverClip(
                  child: MultiSliver(
                    children: [
                      // List of Mutual Followers
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final buddy = displayedList[index];
                            return Column(
                              children: [
                                ListTile(
                                  leading: ProfileImageWithStoryIndicator(
                                    fImage: buddy.profileImages[0],
                                  ),
                                  title: Text(
                                    buddy.userName,
                                    style: context.textTheme.bodyLarge,
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            );
                          },
                          childCount: displayedList.length,
                        ),
                      ),

                      // Show All / Show Less Button for Mutual Followers
                      if (mutualFollowersList.length > 4)
                        SliverToBoxAdapter(
                          child: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                context
                                    .read<BuddyConnectionsCubit>()
                                    .toggleFollowersShowAll();
                              },
                              child: ShowAllButton(
                                fShowAll: state.fFollowersShowAll,
                                fText1:
                                    "${mutualFollowersList.length - 4} more",
                                fText2: context.loc.showLess,
                              ),
                            ),
                          ),
                        ),
                      const SliverToBoxAdapter(child: SizedBox(height: 16)),
                    ],
                  ),
                );
              },
            ),
          ],
        ),

        // All Followers Section
        MultiSliver(
          children: [
            // Section Header for All Followers
            SliverPinnedHeader(
              child: TextWithBackground(
                fText: "${context.loc.all} ${context.loc.followers}",
                fTextColor: AppColor.fTextColor,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Complete List of Followers
            SliverClip(
              child: BlocBuilder<BuddyConnectionsCubit, BuddyConnectionsState>(
                builder: (context, state) {
                  final followersList = state.fFollowers;

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final follower = followersList[index];
                        return Column(
                          children: [
                            ListTile(
                              leading: ProfileImageWithStoryIndicator(
                                fImage: follower.profileImages[0],
                              ),
                              title: Text(
                                follower.userName,
                                style: context.textTheme.bodyLarge,
                              ),
                              trailing: IntrinsicWidth(
                                  child: follower.connectionType
                                      .toConnectionButton(
                                context,
                                height: 40,
                              )),
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      },
                      childCount: followersList.length,
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        // Bottom Padding
        const SliverToBoxAdapter(
          child: SizedBox(height: 16),
        ),
      ],
    );
  }
}
