import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/context_extension.dart';
import 'package:playkosmos_v3/utils/theme/app_colors.dart';

/* 
  Activities and Posts Grid Page
  Displays a grid of images under Activities and Posts tabs.

  @author: Chidera Chijama
*/

class ActivitiesPostsPage extends StatefulWidget {
  const ActivitiesPostsPage({super.key});

  @override
  State<ActivitiesPostsPage> createState() => _ActivitiesPostsPageState();
}

class _ActivitiesPostsPageState extends State<ActivitiesPostsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  /// Sample data for activities and posts
  final List<String> kActivities = [
    'assets/images/activity1.jpg',
    'assets/images/activity2.jpg',
    'assets/images/activity3.jpg',
    'assets/images/activity4.jpg',
    'assets/images/activity5.jpg',
    'assets/images/activity6.jpg',
    'assets/images/activity7.jpg',
    'assets/images/activity8.jpg',
    'assets/images/activity9.jpg',
  ];

  final List<String> kPosts = [
    'assets/images/post1.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 900,
      width: double.infinity,
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  // expandedHeight: 200,
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  automaticallyImplyLeading: false,
                  bottom: TabBar(
                    labelStyle:
                        context.textTheme.displayLarge!.copyWith(fontSize: 18),
                    controller: _tabController,
                    labelColor: AppColor.fPrimaryColor,
                    unselectedLabelColor: context.colors.surface,
                    indicatorColor: AppColor.fPrimaryColor,
                    tabs: [
                      Tab(text: 'Activities (${kActivities.length})'),
                      Tab(text: 'Post (${kPosts.length})'),
                    ],
                  ),
                ),
              ];
            },
            body:
                // Tabbar view
                TabBarView(controller: _tabController, children: [
              BuildImageGrid(images: List.empty()),
              BuildImageGrid(images: kPosts)
            ])),
      ),
    );
  }
}

class BuildImageGrid extends StatelessWidget {
  const BuildImageGrid({
    super.key,
    required this.images,
  });
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(childCount: images.length,
                (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 items per row
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(images[index]),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.check_box_outline_blank,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () {
                            // Add functionality for selection if needed
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
            itemExtent: 50)
      ],
    );
  }
}
