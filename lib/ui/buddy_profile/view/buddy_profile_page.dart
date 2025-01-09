import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/connection_type_extention.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/buddies/view/widgets/interest_chips.dart';
import 'package:playkosmos_v3/ui/buddy_profile/cubit/buddy_profile_cubit.dart';
import 'package:playkosmos_v3/ui/buddy_profile/view/widgets/build_image_grid.dart';
import 'package:playkosmos_v3/ui/buddy_profile/view/widgets/stats_section.dart';
import 'package:playkosmos_v3/utils/app_router/app_router.dart';
import 'package:playkosmos_v3/utils/pop_up_util.dart';
import 'package:playkosmos_v3/utils/snack_bar_util.dart';

/// A profile page that displays buddy information
/// @author: Chidera
class BuddyProfilePage extends StatefulWidget {
  const BuddyProfilePage({super.key, required this.buddyId});
  final String buddyId;

  @override
  State<BuddyProfilePage> createState() => _BuddyProfilePageState();
}

class _BuddyProfilePageState extends State<BuddyProfilePage> {
  bool panEnable = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuddyProfileCubit, BuddyProfileState>(
      builder: (context, state) {
        final fProfile = state.fBuddyModel;
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: CustomAppBar(
              fElevation: 0,
              fShowBackButton: true,
              // fLeadingWidth: 220,
              fTitleText: fProfile.userName,
              fIsLargeDisplayTitle: true,

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
                AppBarMenu(),
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
                          child: Stack(children: [
                            // Background Image
                            if (fProfile.profileImages.isNotEmpty)
                              CarouselWidget(
                                images: fProfile.profileImages,
                              ),
                            Positioned(
                              // left: 0,
                              bottom: 140,
                              right: 0,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: GestureDetector(
                                    onTap: () => setState(() {
                                      panEnable = !panEnable;
                                    }),
                                    child: CircleAvatar(
                                        backgroundColor:
                                            Colors.white.withOpacity(0.7),
                                        child: Icon(
                                          panEnable
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: Colors.black,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                // Gradient Overlay at the bottom
                                panEnable
                                    ? IgnorePointer(
                                        ignoring: panEnable,
                                        child: Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.black
                                                      .withOpacity(0.05),
                                                  Colors.black87
                                                      .withOpacity(0.5),
                                                  Colors.black,
                                                ],
                                                stops: [
                                                  // 0.6,
                                                  // 0.75,
                                                  // 0.85,
                                                  getRelativeScreenHeight(
                                                      0.65, context),
                                                  getRelativeScreenHeight(
                                                      0.8, context),
                                                  getRelativeScreenHeight(
                                                      0.9, context),
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const IgnorePointer(
                                        child: SizedBox(),
                                      ),

                                // Bottom Content
                                panEnable
                                    ? Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextScaleFactorClamp(
                                                fChild: Text(fProfile.userName,
                                                    style: context
                                                        .textTheme.displayLarge!
                                                        .copyWith(
                                                            color: Colors.white,
                                                            fontSize: 28)),
                                              ),
                                              const VSpace(12),
                                              Text(
                                                fProfile.bio,
                                                style: context
                                                    .appTextTheme.body!
                                                    .copyWith(
                                                        color: const Color(
                                                            0xFFCFCDCD)),
                                              ),
                                              const VSpace(12),

                                              // Interests Chips
                                              InterestChips(
                                                // Should only show few interests here
                                                fInterests: fProfile.interests
                                                    .take(4)
                                                    .toList(),
                                                fIsProfile: true,
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : const IgnorePointer(
                                        child: SizedBox(),
                                      )
                                // Bo,
                              ],
                            )
                          ]),
                        ),

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

class AppBarMenu extends StatelessWidget {
  const AppBarMenu({super.key});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.more_vert),
      onPressed: () {
        showDefaultModal(
          context,
          child: Wrap(children: [
            Column(
              children: [
                ListTile(
                  title: Text(context.loc.copyProfileURL,
                      style: context.textTheme.headlineLarge!),
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(
                        text: 'https://playkosmos.com/buddy/1234'));
                    Navigator.pop(context);

                    SnackBarUtil.showInfo(
                        message: context.loc.copiedToClipboard);
                  },
                ),
                const Divider(),
                ListTile(
                  title: Text(context.loc.notification,
                      style: context.textTheme.headlineLarge!),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  title: Text(context.loc.report,
                      style: context.textTheme.headlineLarge!),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    context.loc.block,
                    style: context.textTheme.headlineLarge!.copyWith(
                      color: const Color(0xffAA0606),
                    ),
                  ),
                  onTap: () {},
                ),
                const Divider(),
              ],
            ),
          ]),
        );
      },
    );
  }
}
