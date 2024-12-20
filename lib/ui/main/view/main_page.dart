import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/buddies/view/buddies_page.dart';
import 'package:playkosmos_v3/ui/main/cubit/main_page_cubit.dart';
import 'package:playkosmos_v3/ui/main/view/widgets/bottom_nav_bar.dart';
import 'package:playkosmos_v3/ui/main/view/widgets/home_page.dart';

/// The main page that defines the Home, Buddies, Inbox and Profile
/// tabs. It manages the navigation between them
///
/// @author: Godwin Mathias
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  /// The main page controller
  late PageController _fPageController;

  @override
  void initState() {
    super.initState();
    _fPageController = PageController();
  }

  @override
  void dispose() {
    _fPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// The landing index
    final int fLandingIndex = context.select(
      (MainPageCubit cubit) => cubit.state.dSelectedTabIndex,
    );

    return Scaffold(
      appBar: CustomAppBar(
        fElevation: 0,
        fSemanticLabel: context.loc.playkosmosMainScreen,
        fLeadingWidth: 220,
        fLeading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Assets.svgs.branding.logoColoredBg.svg(
                height: 32,
                width: 32,
              ),
              const HSpace(16),
              Assets.svgs.branding.logoText.svg(
                height: 17,
                width: 119,
              ),
            ],
          ),
        ),
        fActions: [
          //Search
          Visibility(
            visible: fLandingIndex != 4,
            child: IconButton(
              onPressed: () {},
              iconSize: 25,
              icon: const Icon(Icons.search_rounded),
            ),
          ),

          const MessagesNotificationBadge(),
          const HSpace(18),

          //Notifications
          Padding(
            padding: EdgeInsets.only(
              right: (fLandingIndex == 4) ? 0 : 10,
            ),
            child: Semantics(
              label:
                  '${context.loc.notificationBadge}. ${context.loc.youHaveNNewNotifications(11)}',
              button: true,
              excludeSemantics: true,
              child: Assets.svgs.icons.settingsIcon.svg(
                colorFilter: ColorFilter.mode(
                  context.appColors.textColor!,
                  BlendMode.srcIn,
                ),
                height: 25,
                width: 25,
              ),
            ),
          ),

          // More
          Visibility(
            visible: fLandingIndex == 4,
            child: Semantics(
              label: context.loc.moreOptions,
              button: true,
              excludeSemantics: true,
              child: IconButton(
                onPressed: () {},
                iconSize: 30,
                icon: const Icon(Icons.menu_rounded),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: PageView(
          controller: _fPageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            // Home
            HomePage(),

            // Buddies
            BuddiesPage(),

            // Inbox
            SizedBox(),

            // Profile
            SizedBox(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(fPageController: _fPageController),
    );
  }
}

/// General notification counter
class MessagesNotificationBadge extends StatelessWidget {
  const MessagesNotificationBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBadge(
      fIcon: Assets.svgs.icons.notificationIcon.path,
      fNumber: 100,
      fIconPressed: () {},
    );
  }
}
