import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/app_router/app_router.dart';

final List<Map<String, dynamic>> accountInfoItems = [
  {
    'title': 'Email Address',
    'onTap': (BuildContext context) {
     context.push(AppRoute.accountInformationemailPage);
    },
    'isDestructive': false,
  },
  {
    'title': 'Phone Number',
    'onTap': (BuildContext context) {
      context.push(AppRoute.accountInformationphonePage);

    },
    'isDestructive': false,
  },
  {
    'title': 'Password',
    'onTap': (BuildContext context) {
      context.push(AppRoute.accountInformationpaswordPage);

    },
    'isDestructive': false,
  },
  {
    'title': 'Delete Account',
    'onTap': (BuildContext context) {
     context.push(AppRoute.accountInformationdeletaccountPage);

    },
    'isDestructive': true,
  },
];
