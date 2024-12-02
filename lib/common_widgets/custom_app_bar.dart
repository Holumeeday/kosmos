import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
This displays the app bar
@author: Ugochukwu Umeh
*/
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  ///The title text if any
  final String? fTitleText;

  ///To show back button. Defaults to true
  final bool fShowBackButton;

  ///When the back button is pressed. Defaults to navigator pop function
  final VoidCallback? fOnBackButtonPressed;

  ///The actions
  final List<Widget>? fActions;

  ///The back button icon. Defaults to the traditional back arrow <-
  final IconData? fBackButtonIcon;

  ///The elevation of the app bar
  final double? fElevation;

  ///If the title should be centered
  final bool? fCenterTitle;

  ///The app bar height
  final double fAppBarHeight;

  ///The title of the app bar
  final Widget? fTitle;

  ///The title text font size
  final double fTitleTextSize;

  ///For the bottom part of the app bar
  final PreferredSizeWidget? fBottom;

  ///When the body ---widgets--- of the scaffold is scrolled, its elevation
  final double? fScrolledUnderElevation;

  ///The color of the back button
  final Color? fBackButtonColor;

  ///Title text color
  final Color? fTitleTextColor;

  ///The background color of the app bar
  final Color? fAppBarColor;

  ///The leading widget if its not a back button
  final Widget? fLeading;

  ///The leading width
  final double? fLeadingWidth;

  /// App bar semantic label
  final String? fSemanticLabel;

  /// Back button semantic lable
  final String? fBackButtonSemanticLabel;

  ///This displays a custom app bar with certain things already fixed.
  ///[fShowBackButton] which decides if to show a black button defaults to true.
  ///[fOnBackButtonPressed] is the function of the back button and always
  ///default to the usual pop function. [fActions] is the list of actions
  ///usually buttons. [fAppBarHeight] this scales the app bar. Note if the app
  ///bar contains an action button with text, then set the app bar height
  ///using the context.scaleWithTextFactor function to scale the app bar
  ///height as a result of the change in text scale factor
  const CustomAppBar({
    super.key,
    this.fTitle,
    this.fShowBackButton = true,
    this.fOnBackButtonPressed,
    this.fActions,
    this.fBackButtonIcon,
    this.fElevation,
    this.fCenterTitle = false,
    this.fAppBarHeight = kToolbarHeight,
    this.fTitleText,
    this.fTitleTextSize = 20,
    this.fBottom,
    this.fScrolledUnderElevation,
    this.fBackButtonColor,
    this.fTitleTextColor,
    this.fAppBarColor,
    this.fLeadingWidth,
    this.fLeading,
    this.fSemanticLabel,
    this.fBackButtonSemanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    /// The leading width
    final double leadingWidth = fLeadingWidth ?? (fShowBackButton ? 50 : 0);
    return Semantics(
      container: true,
      // To make the screen-reader read the app bar content first
      sortKey: const OrdinalSortKey(0),
      header: true,
      label: fSemanticLabel ?? fTitleText,
      child: AppBar(
        // Disable the default semantic strategy for the app bar
        excludeHeaderSemantics: true,
        titleSpacing: 4,
        backgroundColor: fAppBarColor,
        leadingWidth: leadingWidth,
        toolbarHeight: fAppBarHeight,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: fScrolledUnderElevation,
        //If the title is null, check if there's a text, if there is use it else
        //there's no title widget
        title: fTitle ??
            (fTitleText != null
                ? Text(
                    fTitleText!,
                    style: TextStyle(
                      fontSize: fTitleTextSize,
                      fontWeight: FontWeight.w500,
                      color: fTitleTextColor ?? context.appColors.textColor,
                    ),
                  )
                : null),
        centerTitle: fCenterTitle,
        elevation: fElevation,
        leading: fLeading ??
            (fShowBackButton
                ? Semantics(
                    button: true,
                    label: fBackButtonSemanticLabel ??
                        context.loc.returnToPreviousScreen,
                    excludeSemantics: true,
                    child: IconButton(
                      icon: Icon(
                        fBackButtonIcon ?? Icons.arrow_back_rounded,
                      ),
                      color: fBackButtonColor,
                      onPressed: fOnBackButtonPressed ??
                          () {
                            if (Navigator.of(context).canPop()) {
                              Navigator.of(context)
                                  .pop(); // Perform the normal pop operation
                            } else {
                              // Exit the app if it's the last route
                              SystemNavigator.pop(); // This will quit the app
                            }
                          },
                      iconSize: 20,
                    ),
                  )
                : null),
        actions: fActions
            ?.map<Widget>(
              (action) => MediaQuery.withClampedTextScaling(
                maxScaleFactor: 1.5,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 180),
                  child: DefaultTextStyle.merge(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    child: action,
                  ),
                ),
              ),
            )
            .toList(),
        bottom: fBottom,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(fAppBarHeight);
}
