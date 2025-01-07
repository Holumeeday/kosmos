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

/// A page to display following categorized into mutual and all following.
///
/// Includes:
/// - A search field for filtering following.
/// - A mutual following section with the ability to toggle "Show All".
/// - A complete list of all following with connection actions.
///
/// @author:
/// Chidera Chijama
class FollowingPage extends StatelessWidget {
  const FollowingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Search Field
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: SearchField(),
          ),
        ),
        MultiSliver(pushPinnedChildren: true, children: [
          // Mutual Buddies Section Header
          SliverPinnedHeader(
            child: TextWithBackground(
              fText: context.loc.mutualBuddies,
              fTextColor: AppColor.fTextColor,
            ),
          ),
          const SizedBox(height: 16),

          // Mutual Buddies List
          BlocBuilder<BuddyConnectionsCubit, BuddyConnectionsState>(
            builder: (context, state) {
              final mutualFollowingBuddiesList = state.fFollowingListBuddies;
              final displayedList = state.fFollowingShowAll
                  ? mutualFollowingBuddiesList
                  : mutualFollowingBuddiesList.take(4).toList();

              return SliverClip(
                child: MultiSliver(
                  children: [
                    // Buddy List
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
                                  style: context.appTextTheme.buttonMedium,
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          );
                        },
                        childCount: displayedList.length,
                      ),
                    ),

                    // Show All / Show Less Button
                    if (mutualFollowingBuddiesList.length > 4)
                      SliverToBoxAdapter(
                        child: Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              context
                                  .read<BuddyConnectionsCubit>()
                                  .toggleFollowingShowAll();
                            },
                            child: ShowAllButton(
                              fShowAll: state.fFollowingShowAll,
                              fText1:
                                  "${mutualFollowingBuddiesList.length - 4} more",
                              fText2: context.loc.showLess,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            },
          ),
        ]),

        MultiSliver(children: [
          // All Following Section Header
          SliverPinnedHeader(
            child: TextWithBackground(
              fText: "${context.loc.all} ${context.loc.followingUser}",
              fTextColor: AppColor.fTextColor,
            ),
          ),
          const SizedBox(height: 16),

          // Full Following List
          SliverClip(
            child: BlocBuilder<BuddyConnectionsCubit, BuddyConnectionsState>(
              builder: (context, state) {
                final followingList = state.fFollowing;

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: ProfileImageWithStoryIndicator(
                              fImage: followingList[index].profileImages[0],
                            ),
                            title: Text(
                              followingList[index].userName,
                              style: context.appTextTheme.buttonMedium,
                            ),
                            trailing: IntrinsicWidth(
                                child: followingList[index]
                                    .connectionType
                                    .toConnectionButton(
                                      context,
                                      height: 40,
                                    )),
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    },
                    childCount: followingList.length,
                  ),
                );
              },
            ),
          ),
        ]),

        const SliverToBoxAdapter(
          child: SizedBox(height: 16),
        ),
      ],
    );
  }
}
