import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/activity_post_tab.dart';
import 'package:playkosmos_v3/common_widgets/profile_image_with_story_indicator.dart';
import 'package:playkosmos_v3/ui/activitiy/view/activity_card.dart';
import 'package:playkosmos_v3/ui/main/cubit/main_page_cubit.dart';

/// The home page (tab)
///
/// @author: Godwin Mathias
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          const SliverToBoxAdapter(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ProfileImageWithStoryIndicator(),
                )
                ],
            ),
          ),

         const _ActivityTab(),
        ],
        body: const _ActivityPostTabBarView(),
      ),
    );
  }
}

class _ActivityTab extends StatelessWidget {
  const _ActivityTab();

  @override
  Widget build(BuildContext context) {
    final dSelectedActivitySource = context
        .select((MainPageCubit cubit) => cubit.state.dSelectedActivitySource);
    return ActivityPostTab(
        fActivitySource: dSelectedActivitySource,
        fOnSelectActivitySource: (v) {
          context.read<MainPageCubit>().setSelectedActivitySource(v);
        });
  }
}

class _ActivityPostTabBarView extends StatelessWidget {
  const _ActivityPostTabBarView();

  @override
  Widget build(BuildContext context) {
    return const TabBarView(children: [
      Activity(),
      Post(),
    ]);
  }
}

class Activity extends StatelessWidget {
  const Activity({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomScrollView(
      slivers: [
         SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return const ActivityCard();
            },
            childCount: 4, 
          ),
        ),
      ],
    );
  }
}

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView();
  }
}
