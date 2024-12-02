import 'package:flutter/material.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';

/*
This class displays the playkosmos text logo
@author: Godwin Mathias
*/
class PlaykosmosLogoText extends StatelessWidget {
  final double fHeight;

  const PlaykosmosLogoText({
    super.key,
    this.fHeight = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Assets.svgs.branding.logoText.svg(
      height: fHeight,
    );
  }
}
