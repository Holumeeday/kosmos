import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/connection_type_enum.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/buddy_profile/cubit/buddy_profile_cubit.dart';
import 'package:playkosmos_v3/ui/buddy_profile/view/widgets/build_image_grid.dart';
import 'package:playkosmos_v3/ui/buddy_profile/view/widgets/stats_section.dart';

/// A profile page that displays buddy information
/// @author: Chidera
class BuddyProfilePage extends StatelessWidget {
  const BuddyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuddyProfileCubit, BuddyProfileState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: CustomAppBar(
              fElevation: 0,
              fShowBackButton: true,
              // fLeadingWidth: 220,
              fTitle: Text(context.loc.profile,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.displayLarge!
                      .copyWith(color: context.colors.onSurface, fontSize: 28)),
              fActions: [
                // follow, following, unfollow button
                state.fBuddyModel.connectionType.toConnectionButton(context),

                const HRelativeSpace(10),
                // Message Button
                InkWell(
                  child: SvgPicture.asset(Assets.svgs.icons.messageIcon.path,
                      colorFilter: ColorFilter.mode(
                          context.colors.onSurface, BlendMode.srcIn)),
                ),
                const HRelativeSpace(10),
                //  Menu Button
                PopupMenuButton<String>(
                  onSelected: (t) {},
                  itemBuilder: (BuildContext context) {
                    return {'Logout', 'Settings'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            body: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const VSpace(12),
                        // Image Page View
                        SizedBox(
                          width: double.infinity,
                          height: getScreenHeight(context) * 0.6,
                          child: CarouselWidget(
                            images: state.fBuddyModel.profileImages,
                          ),
                        ),

                        // User Content Section
                        // _buildUserContent(),

                        // Stats Section
                        const VSpace(8),
                        const UserStatsSection(),

                        // Activity Section
                        const Divider(),
                      ],
                    ),
                  ),
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                      pinned: true,
                      stretch: false,
                      toolbarHeight: 0,
                      floating: true,
                      snap: true,
                      forceElevated: innerBoxIsScrolled,
                      automaticallyImplyLeading: false,
                      bottom: CustomTabbar(
                        fTabs: [
                          Tab(
                              text:
                                  '${context.loc.setActivities(state.fBuddyModel.activities.length)} (${state.fBuddyModel.activities.length})'),
                          Tab(
                              text:
                                  '${context.loc.setPosts(state.fBuddyModel.posts.length)}  (${state.fBuddyModel.posts.length})'),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: // Tabbar view
                  TabBarView(children: [
                BuildImageGrid(
                  fImages: state.fBuddyModel.activities,
                  fLabel: context.loc.activity,
                ),
                BuildImageGrid(
                  fImages: state.fBuddyModel.posts,
                  fLabel: context.loc.post,
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}
