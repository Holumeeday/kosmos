import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// A customizable TabBar widget with enhanced styling and responsive design.
///
/// This widget allows setting a custom list of tabs, a controller for managing state,
/// and a callback function to handle tab selection events.
/// @author- Chidera Chijama
class CustomTabbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabbar({
    super.key,
    required this.fTabs,
    this.fController,
    this.fOnTap,
    this.fIsScrollable = false,
    this.fTabAlignment,
  });

  /// A list of widgets to display as tabs.
  final List<Widget> fTabs;

  /// A controller to manage the tab selection state.
  final TabController? fController;

  /// A callback function triggered when a tab is tapped.
  final void Function(int)? fOnTap;
  final TabAlignment? fTabAlignment;

  final bool fIsScrollable;

  /// Defines the preferred height for the TabBar.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      onTap: fOnTap,
      controller: fController,
      isScrollable: fIsScrollable,

      // Divider settings for the TabBar
      dividerColor: context.appColors.fDividerColor,
      dividerHeight: 1,

      // Style for the selected tab's label
      labelStyle: context.textTheme.displayLarge!.copyWith(
        fontSize: getRelativeScreenWidth(18, context),
      ),
      labelColor: AppColor.fPrimaryColor,

      // Alignment for tabs
      tabAlignment: fTabAlignment ?? TabAlignment.fill,

      // Style for the unselected tab's label
      unselectedLabelColor: context.colors.onSurface,

      // Custom indicator with gradient and rounded corners
      indicator: BoxDecoration(
        gradient: const LinearGradient(
          stops: [.5, .8, 1],
          colors: AppColor.fPrimaryGradient,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      indicatorWeight: 3,
      indicatorSize: TabBarIndicatorSize.tab,

      // Padding for the indicator
      indicatorPadding: const EdgeInsets.only(
        top: 46,
      ),

      // Tabs to display
      tabs: fTabs,
    );
  }
}
