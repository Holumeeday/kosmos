import 'package:flutter/material.dart';
import 'package:playkosmos_v3/enums/create_activity_post_status_enum.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/// Show the create activity, status and post model
///
/// @author: Godwin Mathias
class CreateActivityPostStatusModal extends StatelessWidget {
  const CreateActivityPostStatusModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Activity
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              onTap: () {
                Navigator.pop(
                  context,
                  CreateActivityPostStatusEnum.activity,
                );
              },
              title: Text(
                context.loc.activity,
                style: context.appTextTheme.buttonLarge,
              ),
              subtitle: Text(
                context.loc.bringPeopleTogetherCreateActivities,
                style: context.appTextTheme.caption,
              ),
            ),
            const Divider(),

            // Post
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              onTap: () {
                Navigator.pop(
                  context,
                  CreateActivityPostStatusEnum.post,
                );
              },
              title: Text(
                context.loc.post,
                style: context.appTextTheme.buttonLarge,
              ),
              subtitle: Text(
                context.loc.letYourCreativityShineExpressYourself,
                style: context.appTextTheme.caption,
              ),
            ),
            const Divider(),

            // Status
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              onTap: () {
                Navigator.pop(
                  context,
                  CreateActivityPostStatusEnum.status,
                );
              },
              title: Text(
                context.loc.status,
                style: context.appTextTheme.buttonLarge,
              ),
              subtitle: Text(
                context.loc.shareAnythingYouLike,
                style: context.appTextTheme.caption,
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
