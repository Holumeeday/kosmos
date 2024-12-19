import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/buddy_profile/cubit/buddy_profile_cubit.dart';
import 'package:playkosmos_v3/ui/buddy_profile/view/widget/activity_post_tab.dart';
import 'package:playkosmos_v3/ui/buddy_profile/view/widget/carousel.dart';
import 'package:playkosmos_v3/ui/buddy_profile/view/widget/stats_section.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// Profile Page - Represents the user profile screen.
/// @author: Chidera
class BuddyProfilePage extends StatefulWidget {
  const BuddyProfilePage({super.key});

  @override
  State<BuddyProfilePage> createState() => _BuddyProfilePageState();
}

class _BuddyProfilePageState extends State<BuddyProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  /// Sample data for activities and posts
  final List<String> kActivities = [
    "https://elections.civichive.org/wp-content/uploads/2022/12/Abiola-Latifu-Kolawole-PRP.jpg",
    "https://pbs.twimg.com/profile_images/1510691230555987973/agTnpSpG_400x400.jpg",
    "https://dailytrust.com/wp-content/uploads/2022/11/Prince-Adewole-Adebayo-1.jpg",
    "https://elections.civichive.org/wp-content/uploads/2022/12/Adenuga-Sunday-Oluwafemi-BP.jpg",
    "https://elections.civichive.org/wp-content/uploads/2022/12/Ado-Ibrahim-Abdulmalik-YPP.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/7/7c/Hamza_al-Mustapha_2023.jpg",
    "https://cdn.businessday.ng/2022/04/Abiru-1.png",
    "https://pbs.twimg.com/profile_images/1495721772523692034/GnC5MJjS_400x400.jpg",
    "https://pbs.twimg.com/profile_images/1530445927739162625/xtGDZZIm_400x400.jpg",
    "https://stears-elections.s3.eu-west-1.amazonaws.com/static/candidate-photos/president/APP-Charles-Nnadi.png"
  ];

  final List<String> kPosts = [
    'assets/images/post1.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                PrimaryGradientButton(
                    fHeight: getRelativeScreenHeight(50, context),
                    fWidth: getRelativeScreenWidth(100, context),
                    fOnPressed: () {},
                    fChild: Text(
                      context.loc.followUser,
                      style: context.textTheme.displayLarge!
                          .copyWith(color: Colors.white, fontSize: 16),
                    )),
                const HRelativeSpace(10),
                // Message Button
                SvgPicture.asset(Assets.svgs.icons.messageIcon.path,
                    colorFilter: ColorFilter.mode(
                        context.colors.onSurface, BlendMode.srcIn)),
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
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  const SliverToBoxAdapter(
                    child: Column(
                      children: [
                        VSpace(12),
                        // Image Page View
                        CarouselWidget(),

                        // User Content Section
                        // _buildUserContent(),

                        // Stats Section
                        SizedBox(height: 8),
                        UserStatsSection(),

                        // Activity Section
                        Divider(),
                      ],
                    ),
                  ),
                  SliverAppBar(
                    pinned: true,
                    stretch: false,
                    toolbarHeight: 0,
                    floating: true,
                    forceElevated: innerBoxIsScrolled,
                    automaticallyImplyLeading: false,
                    bottom: TabBar(
                      dividerColor: context.appColors.fDividerColor,
                      dividerHeight: 1,
                      controller: _tabController,
                      labelStyle: context.textTheme.displayLarge!.copyWith(
                          fontSize: getRelativeScreenWidth(18, context)),
                      labelColor: AppColor.fPrimaryColor,
                      tabAlignment: TabAlignment.fill,
                      unselectedLabelColor: context.colors.onSurface,
                      indicator: BoxDecoration(
                        gradient: const LinearGradient(
                            // center: Alignment.topCenter,
                            stops: [.5, .8, 1],
                            colors: AppColor.fPrimaryGradient),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      indicatorWeight: 3,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: const EdgeInsets.only(
                        top: 46,
                      ),
                      tabs: [
                        Tab(text: 'Activities (${kActivities.length})'),
                        Tab(text: 'Post (${kPosts.length})'),
                      ],
                    ),
                  ),
                ];
              },
              body: // Tabbar view
                  TabBarView(controller: _tabController, children: [
                BuildImageGrid(images: List.empty()),
                BuildImageGrid(images: kPosts)
              ]),
            ),
          ),
        );
      },
    );
  }
}
