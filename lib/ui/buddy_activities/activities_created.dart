import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

class BuddyActivities extends StatelessWidget {
  const BuddyActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        fTitleText: context.loc.setActivities(1),
        fIsLargeDisplayTitle: true,
      ),
      body: SafeArea(child: Column(
        children: [
          
        ],
      )),
    );
  }
}