import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/app_router/app_router.dart';

class BuddyActivitiesPage extends StatelessWidget {
  const BuddyActivitiesPage({super.key, required this.fIsCreator});
  final bool fIsCreator;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        fTitleText: "name ${context.loc.setActivities(0)}",
        fIsLargeDisplayTitle: true,
      ),
      body: SafeArea(
          child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        // Divider separating sections
                        Divider(
                          color: context.appColors.fDividerColor,
                          height: 1,
                        ),
                        // Section displaying overall ratings
                        InfoSummaryContainer(
                          fContainerColor: context.colors.surface,
                          fChild: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Label for overall ratings
                              Text(
                                fIsCreator
                                    ? context.loc.activitiesCreated
                                    : context.loc.activitiesJoined,
                                style: context.appTextTheme.buttonMedium!
                                    .copyWith(
                                        color: context.appColors.textColor),
                              ),
                              // Display of  total activities
                              Text(
                                '300',
                                style: context.textTheme.displayLarge!
                                    .copyWith(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverAppBar(
                      pinned: true,
                      floating: true,
                      snap: true,
                      automaticallyImplyLeading: false,
                      toolbarHeight: 0,
                      bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(45),
                          child: TextWithBackground(
                            fText:
                                "${context.loc.all} ${fIsCreator ? context.loc.activitiesCreated : context.loc.activitiesJoined}",
                          )))
                ];
              },
              body: CustomScrollView(slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverList.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Container(
                          height: 80,
                          width: 80,
                          color: Colors.purple,
                        ),
                        title: Text(
                          'Activity title ',
                          style: context.appTextTheme.title,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: InkWell(
                          onTap: () {
                            context.push(AppRoute.activityDetailsScreenPath);
                          },
                          child: Text(
                            context.loc.viewActivity,
                            style: context.appTextTheme.header3!
                                .copyWith(color: context.colors.primary),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const VSpace(32);
                    },
                  ),
                ),
              ]))),
    );
  }
}
