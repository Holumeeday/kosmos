import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/context_extension.dart';
import 'package:playkosmos_v3/ui/buddy_connections/view/widgets/buddies_page.dart';
import 'package:playkosmos_v3/ui/buddy_connections/view/widgets/followers_page.dart';
import 'package:playkosmos_v3/ui/buddy_connections/view/widgets/following_page.dart';

/// This page displays tabs for Following, Followers, and Buddies with their respective data.
/// @author: Chidera Chijama
class BuddyConnectionsPage extends StatefulWidget {
  const BuddyConnectionsPage({super.key, required this.fInitialIndex});
  final int fInitialIndex;
  @override
  State<BuddyConnectionsPage> createState() => _BuddyConnectionsPageState();
}

class _BuddyConnectionsPageState extends State<BuddyConnectionsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    // Initialize TabController
    _tabController = TabController(
        length: 3, vsync: this, initialIndex: widget.fInitialIndex);

    // Add listener to update the tab index in the Bloc when the tab changes
    _tabController.addListener(_handleSelected);
  }

  void _handleSelected() {
    setState(() {
      _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fTabTitles = [
      context.loc.followingUser,
      context.loc.followers,
      context.loc.buddies,
    ];

    final tabCounts = [
      "4.2k ${context.loc.followingUser}",
      "1m ${context.loc.setFollowers(1)}",
      "1k ${context.loc.setBuddies(1)}",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          fTabTitles[_tabController.index],
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        bottom: CustomTabbar(
          fController: _tabController,
          fTabs: tabCounts.map((tab) => Tab(text: tab)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children:  const [
          FollowingPage(),
         
          FollowersPage(),
          BuddiesTabPage()
        ],
      ),
    );
  }
}
