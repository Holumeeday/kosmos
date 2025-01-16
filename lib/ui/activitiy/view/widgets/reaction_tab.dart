import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/enums/gender_enum.dart';
import 'package:playkosmos_v3/ui/activitiy/view/activity_card.dart';

class ReactionTab extends StatelessWidget {
  const ReactionTab({
    super.key,
    required this.taggedImages,
    required this.onTabClick,
    required this.selectedReaction,
  });

  final List<String> taggedImages;
  final VoidCallback onTabClick;
  final String selectedReaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Activity_menu_button(
                        onTap: (BuildContext context) {},
                        icon: SvgPicture.asset(
                          Assets.svgs.icons.red_heart.path,
                          width: 20,
                          height: 20,
                        )),
                    SizedBox(width: 5),
                    SvgPicture.asset(
                      Assets.svgs.icons.clap.path,
                      width: 18,
                      height: 18,
                    ),
                    HSpace(5),
                    SvgPicture.asset(
                      Assets.svgs.icons.red_heart.path,
                      width: 18,
                      height: 18,
                    ),
                    HSpace(5),
                    Text("18.6k",
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                VSpace(5),
                Text('4.7k Shares',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            GestureDetector(
              onTap: onTabClick,
              child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 50,
                        height: 50,
                        color: Colors.red.withOpacity(.3),
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(selectedReaction,
                            width: 30, height: 30),
                      ),
                    )
                 
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const VSpace(5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    "Buddies attending",
                    style: TextStyle(fontSize: 12, color: Colors.black38),
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey.shade200,
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
                          )..add(
                              Positioned(
                                left: (taggedImages.length - 0) * 10.0,
                                top: 0,
                                bottom: 0,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      border: Border.all(color: Colors.green),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const Text(
                                      "+2",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Image.asset('assets/comment.png', width: 20, height: 20),
                      const Text("30"),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      Image.asset('assets/qa.png', width: 20, height: 20),
                      const Text("11"),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      Image.asset('assets/user.png', width: 20, height: 20),
                      const Text("247"),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      Image.asset('assets/star.png', width: 20, height: 20),
                      const Text("14k"),
                    ],
                  ),
                ],
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(.3),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.red, width: 1),
                ),
                child: const Icon(Icons.chevron_right, color: Colors.green),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Activity_menu_button extends StatelessWidget {
  final Widget icon;
  final void Function(BuildContext context) onTap;
  const Activity_menu_button({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () => onTap(context), icon: icon);
  }
}
