import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';
import 'package:playkosmos_v3/common_widgets/username_and_plan.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/activitiy/cubit/bookmark_cubit.dart';
import 'package:playkosmos_v3/ui/activitiy/view/widgets/activity_share_modal.dart';
import 'package:playkosmos_v3/ui/activitiy/view/widgets/more_activity_modal.dart';
import 'package:playkosmos_v3/ui/activitiy/view/widgets/reaction_tab.dart';
import 'package:playkosmos_v3/ui/activitiy/view/widgets/reaction_wrapper.dart';
import 'package:playkosmos_v3/utils/pop_up_util.dart';

import '../../../common_widgets/common_widgets.dart';

class ActivityCard extends StatefulWidget {
  const ActivityCard({super.key});

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  final List<String> imageUrls = [
    'https://media.istockphoto.com/id/494924054/photo/the-concept-of-choice.webp?s=1024x1024&w=is&k=20&c=Nc6OZ2jK8lVeOLAyWy8wyLNq_LCAEc_FbT9p3-v--Mo=',
    'https://media.istockphoto.com/id/1310338470/photo/vintage-overhead-view-of-a-dungeons-and-dragons-equipment.webp?s=1024x1024&w=is&k=20&c=NLAjrXJ5e2C2pu5OyEoe6numZRSQvJdXpvbPLD1Iii0=',
    'https://media.istockphoto.com/id/1132091114/photo/red-casino-dice.jpg?s=1024x1024&w=is&k=20&c=HP7GOFZIwKXPVnOVQscIAl6nn9Jcnfr5gJKXBvgVrig='
  ];

  final List<String> taggedImages = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookmarkCubit(), // Provide the BookmarkCubit
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Card(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ProfilePicture(
                        fProfilePicture: const $AssetsWebpGen()
                            .onboarding
                            .createOnboarding
                            .path,
                        fRadius: 25,
                        fUserName: '',
                      ),
                      const HSpace(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const UserNameAndPlan(
                                fUserName: 'Jon Doe',
                                fTextSize: 15,
                              ),
                              const HSpace(2),
                              Assets.svgs.icons.bronzeSubscriptionPlan
                                  .svg(width: 15, height: 15)
                            ],
                          ),
                          Text(
                            '5hr ago',
                            style: context.textTheme.labelSmall!.copyWith(color: Colors.grey.shade500),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Activity_menu_button(
                        onTap: (BuildContext context) {
                          showDefaultModal(
                            context,
                            maxHeight: 50,
                            child: const ActivityShareModal(),
                          );
                        },
                        icon: SvgPicture.asset(
                          Assets.svgs.icons.share.path,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      BlocBuilder<BookmarkCubit, bool>(
                        builder: (context, isBookmarked) {
                          return Activity_menu_button(
                            onTap: (BuildContext context) {
                              context.read<BookmarkCubit>().toggleBookmark();
                            },
                            icon: Icon(
                              isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_outline,
                              color: isBookmarked ? Colors.orange : Colors.grey,
                            ),
                          );
                        },
                      ),
                      Activity_menu_button(
                        onTap: (BuildContext context) {
                          showDefaultModal(
                            context,
                            maxHeight: 35,
                            child: const MoreActivityModal(),
                          );
                        },
                        icon: SvgPicture.asset(
                          Assets.svgs.icons.more.path,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  fTagged_images(taggedImages: taggedImages),

                  const HSpace(15),
                  const fLocation_tagged(),
                  const HSpace(10),
                ],
              ),
              const VSpace(5),
              SizedBox(
                height: 409,
                child: CarouselWidget(images: imageUrls),
              ),
              const VSpace(5),
              const ReactionWrapper(),
            ],
          ),
        ),
      ),
    );
  }
}

class fLocation_tagged extends StatelessWidget {
  const fLocation_tagged({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 113,
      height: 28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFF27121).withOpacity(.10),
      ),
      padding:
          const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Center(
        child: Row(
          children: [
            SvgPicture.asset(
              Assets.svgs.icons.location.path,
              width: 12,
              height: 12,
            ),
           const HSpace(2), 
            Expanded(
              child:  Text(
                "20 miles away",
                style: context.textTheme.bodySmall!
                    .copyWith(color: Color(0xFFF27121)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class fTagged_images extends StatelessWidget {
  const fTagged_images({
    super.key,
    required this.taggedImages,
  });

  final List<String> taggedImages;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      padding:
          const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      child: Row(
        children: [
          SizedBox(
            width: (taggedImages.length) * 15.0 + 30,
            height: 24,
            child: Stack(
              clipBehavior: Clip.none,
              children: List.generate(
                taggedImages.length,
                (index) {
                  return Positioned(
                    left: index * 15.0,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundImage:
                          AssetImage(taggedImages[index]),
                      backgroundColor: Colors.white,
                    ),
                  );
                },
              )
                // Add text on top of the last image
                ..add(
                  Positioned(
                    left: (taggedImages.length) * 15.0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      alignment: Alignment.center,
                      child: Container(
                        width: 20,
                        height: 20,
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.red.withOpacity(.5)),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            "+2",
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.red.shade300,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ),
          ),
          // const SizedBox(width: 2), // Space between avatars and text
         Text(
            "Tagged",
            style: context.textTheme.bodySmall!
                .copyWith(color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
