import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/sizes.dart';

class ActivityShareModal extends StatelessWidget {
  const ActivityShareModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                'Share',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.tertiary,
                size: 23,
              ),
            ),
          ],
        ),
      ),
      const Divider(),
      const VSpace(20),
      
    ]);
  }
}
