import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/buddy_activities/widgets/activity_details_tab.dart';
import 'package:playkosmos_v3/ui/buddy_activities/widgets/participant_tab.dart';

class ActivityDetailsPage extends StatelessWidget {
  const ActivityDetailsPage({super.key});
 
  @override
  Widget build(BuildContext context) {
    final fTabs = [
      context.loc.activityDetails,
      context.loc.participant,
      context.loc.questionsAndAnswers,
      context.loc.comments,
      "${context.loc.creator} ${context.loc.reviews}"
    ];
    return Scaffold(
      appBar: const CustomAppBar(
        fTitleText: 'Activity Details',
        fIsLargeDisplayTitle: true,
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 5,
          child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  // Divider separating sections
                  SliverToBoxAdapter(
                    child: Divider(
                      color: context.appColors.fDividerColor,
                      height: 1,
                    ),
                  ),
                  SliverAppBar(
                      pinned: true,
                      floating: true,
                      snap: true,
                      automaticallyImplyLeading: false,
                      toolbarHeight: 0,
                      bottom: CustomTabbar(
                        fTabAlignment: TabAlignment.start,
                        fIsScrollable: true,
                        fTabs: fTabs.map((tab) => Tab(text: tab)).toList(),
                      )),
                  // VSpace( 21),
                ];
              },
              body:  const TabBarView(children: [
                ActivityDetailsTab(),
             ParticipantTab(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
              ])),
        ),
      ),
    );
  }
}
