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
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              subtitle: Text(
                'Bring people together! Create activities that everyone can join and enjoy.',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
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
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              subtitle: Text(
                'Let your creativity shine, Express yourself and share your vibe in your post.',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
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
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              subtitle: Text(
                'Share anything you like, it’ll stay live for 24 hours.',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
