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

/// Displays a page showing mutual buddies and all buddies with their respective details.
///
/// Includes functionalities such as search, show all/show less toggling,
/// and categorized lists.
///
/// @author: Chidera Chijama
class BuddiesTabPage extends StatelessWidget {
  const BuddiesTabPage({super.key});

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

        MultiSliver(
          pushPinnedChildren: true,
          children: [
            // Mutual Buddies Section Header
            SliverPinnedHeader(
              child: TextWithBackground(
                fText: context.loc.mutualBuddies,
                fTextColor: AppColor.fTextColor,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Mutual Buddies List
            BlocBuilder<BuddyConnectionsCubit, BuddyConnectionsState>(
              builder: (context, state) {
                final mutualBuddiesBuddiesList = state.fBuddiesListBuddies;
                final displayedList = state.fBuddiesShowAll
                    ? mutualBuddiesBuddiesList
                    : mutualBuddiesBuddiesList.take(4).toList();

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

                      // Show All / Show Less Button
                      if (mutualBuddiesBuddiesList.length > 4)
                        SliverToBoxAdapter(
                          child: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                context
                                    .read<BuddyConnectionsCubit>()
                                    .toggleBuddiesShowAll();
                              },
                              child: ShowAllButton(
                                fShowAll: state.fBuddiesShowAll,
                                fText1:
                                    "${mutualBuddiesBuddiesList.length - 4} more",
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

        MultiSliver(
          children: [
            // All Buddies Section Header
            SliverPinnedHeader(
              child: TextWithBackground(
                fText: "${context.loc.all} ${context.loc.buddies}",
                fTextColor: AppColor.fTextColor,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Full Buddies List
            SliverClip(
              child: BlocBuilder<BuddyConnectionsCubit, BuddyConnectionsState>(
                builder: (context, state) {
                  final buddiesList = state.fBuddies;

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Column(
                          children: [
                            ListTile(
                                leading: ProfileImageWithStoryIndicator(
                                  fImage: buddiesList[index].profileImages[0],
                                ),
                                title: Text(
                                  buddiesList[index].userName,
                                  style: context.textTheme.bodyLarge,
                                ),
                                trailing: IntrinsicWidth(
                                  child: buddiesList[index]
                                      .connectionType
                                      .toConnectionButton(context,
                                          height: 40, width: 130),
                                )),
                            const SizedBox(height: 16),
                          ],
                        );
                      },
                      childCount: buddiesList.length,
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        // Final Spacing
        const SliverToBoxAdapter(
          child: SizedBox(height: 16),
        ),
      ],
    );
  }
}
