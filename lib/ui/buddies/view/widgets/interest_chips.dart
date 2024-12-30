import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/* InterestChips
 Displays a list of user interests as chips.
 @author: Chidera Chijama 
 */
class InterestChips extends StatelessWidget {
  const InterestChips({
    super.key,
    required this.fInterests,
  });

  final List<String> fInterests;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 7,
      runSpacing: 0,
      children: fInterests.map((interest) {
        return Chip(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          labelPadding: EdgeInsets.zero,
          backgroundColor: Colors.black,
          label: Text(context.loc.setInterests(interest),
              style:
                  context.textTheme.bodyMedium!.copyWith(color: Colors.white)),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white24, width: .7),
            borderRadius: BorderRadius.circular(40),
          ),
        );
      }).toList(),
    );
  }
}
