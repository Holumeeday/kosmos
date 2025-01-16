import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/enums/gender_enum.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/activitiy/cubit/reaction_cubit.dart';
import 'package:playkosmos_v3/ui/activitiy/view/widgets/list.dart';
import 'package:playkosmos_v3/ui/activitiy/view/widgets/reaction_selection_tab.dart';

class ReactionWrapper extends StatelessWidget {
  const ReactionWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReactionCubit(),
      child: BlocBuilder<ReactionCubit, ReactionState>(
        builder: (context, state) {
          if (state.isSelectingReaction) {
            return ReactionsSelectionTabComponent(
              reactions: reactions,
              onSelect: (reaction) {
                context.read<ReactionCubit>().selectReaction(reaction);
              },
            );
          } else {
            return ReactionTab(
              taggedImages: taggedImages,
              selectedReaction: state.selectedReaction,
              onTabClick: () {
                context.read<ReactionCubit>().toggleReactionSelection();
              },
            );
          }
        },
      ),
    );
  }
}

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
                    SvgPicture.asset(
                      Assets.svgs.icons.like.path,
                      width: 18,
                      height: 18,
                    ),
                    const HSpace(5),
                    SvgPicture.asset(
                      Assets.svgs.icons.clap.path,
                      width: 18,
                      height: 18,
                    ),
                    const HSpace(5),
                    SvgPicture.asset(
                      Assets.svgs.icons.red_heart.path,
                      width: 16,
                      height: 16,
                    ),
                    const HSpace(5),
                  const  Text(
                      "18.6k",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              const  VSpace(5),
              const  Text(
                  '4.7k Shares',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            GestureDetector(
                onTap: onTabClick,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.red.withOpacity(.2),
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      Assets.svgs.icons.gradient_like.path,
                      width: 10,
                      height: 10,
                    ),
                  ),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const VSpace(5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.2),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text(
                    "Buddies attending",
                    style: TextStyle(fontSize: 12, color: Colors.black38),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
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
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Divider(
            
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                     SvgPicture.asset(
                        Assets.svgs.icons.comment.path,
                        width: 18,
                        height: 18,
                      ),
                       Text("30", style: context.textTheme.bodyMedium)
                    ],
                  ),
                  const SizedBox(
                    width: 17,
                  ),
                  Column(
                    children: [
                     SvgPicture.asset(
                        Assets.svgs.icons.question_answer.path,
                        width: 18,
                        height: 18,
                      ),
                      Text("11",style: context.textTheme.bodyMedium)
                    ],
                  ),
                  const SizedBox(
                    width: 17,
                  ),
                  Column(
                    children: [
                      SvgPicture.asset(
                        Assets.svgs.icons.group_user.path,
                        width: 18,
                        height: 18,
                      ),
                     Text("247", style: context.textTheme.bodyMedium)
                    ],
                  ),
                  const SizedBox(
                    width: 17,
                  ),
                  Column(
                    children: [
                      SvgPicture.asset(
                        Assets.svgs.icons.star.path,
                        width: 18,
                        height: 18,
                      ),
                      Text("14k", style: context.textTheme.bodyMedium)
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
                    border: Border.all(color: Colors.red, width: 1)),
                child: const Icon(
                  Icons.chevron_right,
                  color: Colors.pink
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
