import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';
import 'package:playkosmos_v3/utils/app_router/app_router.dart';

class MenuItem {
  final Widget icon;
  final String ? title;
  final void Function(BuildContext context) onTap;

  MenuItem({
    required this.icon,
     this.title,
    required this.onTap,
  });
}

final List<MenuItem> accountItems = [
  MenuItem(
    icon: SvgPicture.asset(
      Assets.svgs.icons.profileOutlined.path,
      width: 18,
      height: 18,
    ),
    title: 'Account Information',
    onTap: (BuildContext context) {
      context.push(AppRoute.accountInformationPage);
    },
  ),
  MenuItem(
  icon: SvgPicture.asset(
      Assets.svgs.icons.notificationn.path,
      width: 18,
      height: 18,
    ),
    title: 'Activity Manager',
    onTap: (BuildContext context) {
     
    },
  ),
  MenuItem(
    icon: SvgPicture.asset(
      Assets.svgs.icons.saved.path,
      width: 18,
      height: 18,
    ),
    title: 'Saved',
    onTap: (BuildContext context) {
     
    },
  ),
  MenuItem(
    icon: SvgPicture.asset(
      Assets.svgs.icons.wallet.path,
      width: 18,
      height: 18,
    ),
    title: 'Wallet',
    onTap: (BuildContext context) {
     
    },
  ),
  MenuItem(
   icon: SvgPicture.asset(
      Assets.svgs.icons.payment_info.path,
      width: 18,
      height: 18,
    ),
    title: 'Payment Information',
    onTap: (BuildContext context) {
      
    },
  ),
    MenuItem(
    icon: SvgPicture.asset(
      Assets.svgs.icons.payment_info.path,
      width: 18,
      height: 18,
    ),
    title: 'Play Points',
    onTap: (BuildContext context) {},
  ),
    MenuItem(
   icon: SvgPicture.asset(
      Assets.svgs.icons.subscription.path,
      width: 18,
      height: 18,
    ),
    title: 'Subscription',
    onTap: (BuildContext context) {},
  ),
    MenuItem(
   icon: SvgPicture.asset(
      Assets.svgs.icons.QR_code.path,
      width: 18,
      height: 18,
    ),
    title: 'My QR Code',
    onTap: (BuildContext context) {},
  ),
    MenuItem(
   icon: SvgPicture.asset(
      Assets.svgs.icons.locationSearch.path,
      width: 18,
      height: 18,
    ),
    title: 'Location & Search radius',
    onTap: (BuildContext context) {},
  ),
    MenuItem(
   icon: SvgPicture.asset(
      Assets.svgs.icons.blocked.path,
      width: 18,
      height: 18,
    ),
    title: 'Blocked',
    onTap: (BuildContext context) {},
  ),
];

final List<MenuItem> preferenceItems = [
  MenuItem(
   icon: SvgPicture.asset(
      Assets.svgs.icons.theme.path,
      width: 18,
      height: 18,
    ),
    title: 'Theme',
    onTap: (BuildContext context) {
     
    },
  ),
  MenuItem(
   icon: SvgPicture.asset(
      Assets.svgs.icons.language.path,
      width: 18,
      height: 18,
    ),
    title: 'Language',
    onTap: (BuildContext context) {
      
    },
  ),
    MenuItem(
    icon: SvgPicture.asset(
      Assets.svgs.icons.notificationn.path,
      width: 18, 
      height: 18, 
    ),
    title: 'Notification',
    onTap: (BuildContext context) {},
  ),
    MenuItem(
    icon: SvgPicture.asset(
      Assets.svgs.icons.privacy.path,
      width: 18,
      height: 18,
    ),
    title: 'Privacy',
    onTap: (BuildContext context) {},
  ),
];

final List<MenuItem> supportItems = [
  MenuItem(
   icon: SvgPicture.asset(
      Assets.svgs.icons.about.path,
      width: 18,
      height: 18,
    ),
    title: 'About Us',
    onTap: (BuildContext context) {
      
    },
  ),
  MenuItem(
   icon: SvgPicture.asset(
      Assets.svgs.icons.feedback.path,
      width: 18,
      height: 18,
    ),
    title: 'Feedback & Ratings',
    onTap: (BuildContext context) {},
  ),
  MenuItem(
  icon: SvgPicture.asset(
      Assets.svgs.icons.helpdesk.path,
      width: 18,
      height: 18,
    ),
    title: 'PlayKosmos Helpdesk',
    onTap: (BuildContext context) {},
  ),
  MenuItem(
   icon: SvgPicture.asset(
      Assets.svgs.icons.report.path,
      width: 18,
      height: 18,
    ),
    title: 'Report a problem',
    onTap: (BuildContext context) {},
  ),
];

final List<MenuItem> termsItems = [
  MenuItem(
   icon: SvgPicture.asset(
      Assets.svgs.icons.guidelines.path,
      width: 18,
      height: 18,
    ),
    title: 'PlayKosmos Guidlines',
    onTap: (BuildContext context) {},
  ),
  MenuItem(
   icon: SvgPicture.asset(
      Assets.svgs.icons.policy.path,
      width: 18,
      height: 18,
    ),
    title: 'Privacy Policy',
    onTap: (BuildContext context) {},
  ),
  MenuItem(
   icon: SvgPicture.asset(
      Assets.svgs.icons.policy.path,
      width: 18,
      height: 18,
    ),
    title: 'Cookies Policy',
    onTap: (BuildContext context) {},
  ),
  MenuItem(
   icon: SvgPicture.asset(
      Assets.svgs.icons.terms.path,
      width: 18,
      height: 18,
    ),
    title: 'Terms of Service',
    onTap: (BuildContext context) {},
  ),
];

final List<MenuItem> loginItem = [
  MenuItem(
   icon: SvgPicture.asset(
      Assets.svgs.icons.logout.path,
      width: 18,
      height: 18,
    ),
    title: 'Log out',
    onTap: (BuildContext context) {},
  ),
 
];
