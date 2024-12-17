import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/* InterestChips
 Displays a list of user interests as chips.
 @author: Chidera Chijama 
 */
class InterestChips extends StatelessWidget {
  const InterestChips({
    super.key,
    required this.kInterests,
  });

  final List<String> kInterests;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 7,
      runSpacing: 0,
      children: kInterests.map((interest) {
        return Chip(
          labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          backgroundColor: Colors.black,
          label: Text(interest,
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
