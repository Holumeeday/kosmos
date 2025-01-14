import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/profile_image_with_story_indicator.dart';

import '../../../../common_widgets/sizes.dart';
import 'stat_container.dart';

class StatWithProfilePicture extends StatelessWidget {
  const StatWithProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
       padding:  EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stat_Container(
            counterType: 'Following',
            stat: 5.3,
            suffix: 'K',
          ),
          HSpace(5),
          Stat_Container(
            stat: 4.2,
            suffix: 'm',
            counterType: 'Followers',
          ),
          HSpace(5),
          Stat_Container(counterType: "Buddies", stat: 3.2, suffix: 'm'),
          HSpace(10),
          ProfileImageWithStoryIndicator(),
        ],
      ),
    );
  }
}
