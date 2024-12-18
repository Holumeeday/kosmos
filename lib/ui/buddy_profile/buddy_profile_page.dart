import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/buddy_profile/cubit/buddy_profile_cubit.dart';
import 'package:playkosmos_v3/ui/buddy_profile/view/carousel.dart';
import 'package:playkosmos_v3/ui/buddy_profile/view/stats_section.dart';

/// Profile Page - Represents the user profile screen.
/// @author: Chidera
class BuddyProfilePage extends StatelessWidget {
  const BuddyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuddyProfileCubit, BuddyProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            fElevation: 0,
            fShowBackButton: true,
            // fLeadingWidth: 220,
            fTitle: Text('Profile',
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.displayLarge!
                    .copyWith(color: context.colors.onSurface, fontSize: 28)),
            fActions: [
              PrimaryGradientButton(
                  // fHeight: getRelativeScreenHeight(50, context),
                  fWidth: getRelativeScreenWidth(100, context),
                  fOnPressed: () {},
                  fChild: const Text('data')),
              const HRelativeSpace(10),
              SvgPicture.asset(Assets.svgs.icons.messageIcon.path,
                  colorFilter: ColorFilter.mode(
                      context.colors.onSurface, BlendMode.srcIn)),
              const HRelativeSpace(10),
              PopupMenuButton<String>(
                onSelected: (t) {},
                itemBuilder: (BuildContext context) {
                  return {'Logout', 'Settings'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          body: const SingleChildScrollView(
            child: Column(
              children: [
                VSpace(12),
                // Image Page View
                CarouselWidget(),

                // User Content Section
                // _buildUserContent(),

                // Stats Section
                SizedBox(height: 8),
                UserStatsSection(),

                // Activity Section
                Divider(),
                // _buildActivitySection(),
              ],
            ),
          ),
        );
      },
    );
  }

  /// User Content Widget
  // Widget _buildUserContent() {
  //   return const Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
  //       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //         Text(
  //           'Jordyn Vaccaro',
  //           style: TextStyle(
  //             fontSize: 28,
  //             fontWeight: FontWeight.bold,
  //             color: Colors.black,
  //           ),
  //         ),
  //         SizedBox(height: 8),
  //         Text(
  //           'Professional daydreamer, coffee enthusiast, and expert in pressing ‘Next Episode’. '
  //           'Living life one witty remark at a time.',
  //           style: TextStyle(
  //             color: Colors.black54,
  //             fontSize: 14,
  //           ),
  //         ),
  //         SizedBox(height: 12),
  //         // Interests Chips
  //         // Wrap(spacing: 8, children: [
  //         //   _buildInterestChip('Art'),
  //         //   _buildInterestChip('Hockey'),
  //         //   _buildInterestChip('Sport'),
  //         //   _buildInterestChip('Football'),
  //         // ])
  //       ]));
  // }
}
