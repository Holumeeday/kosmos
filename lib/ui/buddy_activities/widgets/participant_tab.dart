import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/common_widgets/activity_more_option_user_modal.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/constants/buddies_list.dart';
import 'package:playkosmos_v3/extensions/connection_type_extention.dart';
import 'package:playkosmos_v3/extensions/context_extension.dart';
import 'package:playkosmos_v3/ui/buddy_connections/view/widgets/search_field.dart';
import 'package:playkosmos_v3/utils/utils.dart';

class ParticipantTab extends StatefulWidget {
  const ParticipantTab({
    super.key,
  });

  @override
  State<ParticipantTab> createState() => _ParticipantTabState();
}

class _ParticipantTabState extends State<ParticipantTab> {
  bool userisCreatorOfActivity = random.nextBool();
  bool userisParticipantOfActivity = true;
  bool userHasReviewedParticipant = true;

  Widget trailing(int index, BuildContext context) {
    if (userisParticipantOfActivity || userisCreatorOfActivity) {
      if (userHasReviewedParticipant) {
        // Show 3-dot IconButton for editing or deleting reviews
        return IntrinsicWidth(
          child: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showDefaultModal(
                context,
                maxHeight: 18,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        context.loc.edit,
                        style: context.textTheme.headlineLarge!
                      ),
                      onTap: () {
                        context.push(AppRoute.editReviewPath);
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        context.loc.delete,
                        style: context.textTheme.headlineLarge!.copyWith(
                          color: Color(0xffAA0606),
                        ),
                      ),
                      onTap: () {},
                    ),
                    Divider(),
                  ],
                ),
              );
            },
          ),
        );
      } else {
        // Show "Write Review" button
        return IntrinsicWidth(
          child: PrimaryGradientButton(
            fPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9.5),
            fOnPressed: () {},
            fChild: Text(
              context.loc.setReviews(1),
              style: context.appTextTheme.header3
                  ?.copyWith(color: Colors.white, fontSize: 16),
            ),
          ),
        );
      }
    }

    // If neither participant nor creator, show connection type button
    return IntrinsicWidth(
      child: followingList[index].connectionType.toConnectionButton(
            context,
            height: 40,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: SearchField(),
        ),
        const Divider(),
        const VSpace(20),
        Expanded(
            child: ListView.builder(
          itemCount: followingList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                    leading: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        ProfilePicture(
                          fRadius: 40,
                          fProfilePicture:
                              followingList[index].profileImages[0],
                          fUserName: followingList[index].userName,
                        ),
                        // Add Button
                        Positioned(
                          bottom: 0,
                          right: 5,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                  colors: AppColor.fPrimaryGradient),
                              border: Border.all(
                                color: context.colors.surface,
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    title: Text(
                      followingList[index].userName,
                      style: context.textTheme.bodyLarge,
                    ),
                    trailing: trailing(index, context)),
                const SizedBox(height: 16),
              ],
            );
          },
        ))
      ],
    );
  }
}
