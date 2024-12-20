import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';
import 'package:playkosmos_v3/common_widgets/buttons.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/extensions/context_extension.dart';
import 'package:playkosmos_v3/ui/main/cubit/main_page_cubit.dart';
import 'package:playkosmos_v3/ui/main/view/widgets/create_activity_status_post_modal.dart';
import 'package:playkosmos_v3/utils/utils.dart';
import 'package:provider/provider.dart';

/*
The bottom navigation bar
@author: Godwin Matthias
 */
class BottomNavBar extends StatelessWidget {
  // The page controller for the body items
  final PageController fPageController;

  const BottomNavBar({
    super.key,
    required this.fPageController,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: context.colors.primary.withOpacity(0.1),
        highlightColor: context.colors.primary.withOpacity(0.1),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 0.3, color: context.appColors.textBoxColor!),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: context.select(
            (MainPageCubit cubit) => cubit.state.dSelectedTabIndex,
          ),
          selectedItemColor: context.colors.primary,
          unselectedItemColor: context.appColors.darkGreyColor,
          unselectedFontSize: 14,
          selectedFontSize: 14,
          onTap: (index) {
            _handlePageRebuild(index, context);
          },
          items: [
            //Home bar
            BottomNavigationBarItem(
              icon: _BottomNavBarIcon(
                fIcon: Assets.svgs.icons.homeOutlined.path,
                fColor: context.appColors.textColor!,
              ),
              activeIcon: _BottomNavBarIcon(
                fIcon: Assets.svgs.icons.homeFilled.path,
              ),
              label: context.loc.homeNav,
            ),

            // Buddies
            BottomNavigationBarItem(
              icon: _BottomNavBarIcon(
                fIcon: Assets.svgs.icons.buddiesOutlined.path,
                fColor: context.appColors.textColor!,
              ),
              activeIcon: _BottomNavBarIcon(
                fIcon: Assets.svgs.icons.buddiesFilled.path,
              ),
              label: 'Buddies',
            ),

            // Activity or status
            BottomNavigationBarItem(
              icon: Semantics(
                label: context.loc.createPost,
                excludeSemantics: true,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: PrimaryGradientButton(
                    fHeight: 50,
                    fWidth: 50,
                    fOnPressed: () async {
                      final CreateActivityPostStatusEnum? result =
                          await showDefaultModal(
                        context,
                        maxHeight: 40,
                        child: const CreateActivityPostStatusModal(),
                      );
                      if (result != null) {
                        switch (result) {
                          case CreateActivityPostStatusEnum.activity:
                          // Navigate to create activity
                          case CreateActivityPostStatusEnum.status:
                          // Navigate to create status
                          case CreateActivityPostStatusEnum.post:
                          // Navigate to create post
                        }
                      }
                    },
                    fShape: BoxShape.circle,
                    fChild: Icon(
                      Icons.add,
                      size: 23,
                      color: context.colors.onSecondary,
                    ),
                  ),
                ),
              ),
              label: '',
            ),

            // Inbox
            BottomNavigationBarItem(
              icon: _BottomNavBarIcon(
                fIcon: Assets.svgs.icons.inboxOutlined.path,
                fColor: context.appColors.textColor!,
              ),
              activeIcon: _BottomNavBarIcon(
                fIcon: Assets.svgs.icons.inboxFilled.path,
              ),
              label: context.loc.inbox,
            ),

            // Profile
            BottomNavigationBarItem(
              icon: _BottomNavBarIcon(
                fIcon: Assets.svgs.icons.profileOutlined.path,
                fColor: context.appColors.textColor!,
              ),
              activeIcon: _BottomNavBarIcon(
                fIcon: Assets.svgs.icons.profileFilled.path,
              ),
              label: context.loc.profileNav,
            ),
          ],
        ),
      ),
    );
  }

  void _handlePageRebuild(int index, BuildContext context) {
    if (index != 2) {
      if (index > 1) {
        fPageController.jumpToPage(index - 1);
      } else {
        fPageController.jumpToPage(index);
      }
    }
    context.read<MainPageCubit>().setSelectedIndex(index);
  }
}

/*
This class defines the icon class for the bottom nav bar
@author: Ugochukwu Umeh
*/
class _BottomNavBarIcon extends StatelessWidget {
  ///The svg icon to be used
  final String fIcon;

  ///The color to be used
  final Color? fColor;

  ///Makes the svg icon have a height and width of 19
  const _BottomNavBarIcon({
    required this.fIcon,
    this.fColor,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      fIcon,
      colorFilter: fColor == null
          ? null
          : ColorFilter.mode(
              fColor!,
              BlendMode.srcIn,
            ),
      height: 19,
      width: 19,
    );
  }
}
