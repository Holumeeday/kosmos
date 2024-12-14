import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
This displays the tagged people and the time the post was made
@author: Ugochukwu Umeh
*/
class TaggedAndPostTime extends StatelessWidget {
  /// List of tagged people
  final List<String> fTaggedList;

  /// The time the post was made
  final DateTime? fPostTime;

  /// If its a shared activity
  final bool fIsShared;

  /// To move to the tagged screen
  final VoidCallback fOnTaggedTap;

  const TaggedAndPostTime({
    super.key,
    required this.fTaggedList,
    required this.fOnTaggedTap,
    required this.fPostTime,
    required this.fIsShared,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Tagged list
        _TaggedToActivity(
          fTagList: fTaggedList,
          fIsShared: fIsShared,
          fOnTagPressed: fOnTaggedTap,
        ),

        // Time
        Text(
          fPostTime.postNotificationTimePassed(),
          style: context.textTheme.labelLarge?.copyWith(
            color: context.colors.tertiary,
          ),
        ),
      ],
    );
  }
}

/*
The tagged people placed under the profile
@author: Ugochukwu Umeh
*/
class _TaggedToActivity extends StatelessWidget {
  /// The tagged list
  final List<String> fTagList;

  /// If its a shared activity or status
  final bool fIsShared;

  /// When tagged to pressed
  final VoidCallback fOnTagPressed;

  const _TaggedToActivity({
    required this.fTagList,
    required this.fOnTagPressed,
    required this.fIsShared,
  });

  @override
  Widget build(BuildContext context) {
    if (fTagList.isEmpty) {
      return const SizedBox();
    }

    /// The first tagged user name
    final String fFirstTaggedUser = fTagList.first;

    ///The remaining number of tagged people/users
    final int fRemainingTaggedUsers = fTagList.length - 1;
    return GestureDetector(
      onTap: fOnTagPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text.rich(
          TextSpan(
            text: fIsShared ? context.loc.sharedWith : context.loc.tagged,
            style: TextStyle(
              fontSize: 14,
              color: context.colors.secondary,
            ),
            children: [
              TextSpan(
                text:
                    ' $fFirstTaggedUser${context.loc.nRemainingTaggedUser(fRemainingTaggedUsers)}',
                style: context.textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
