import 'package:flutter/material.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';

/// This is the playkosmos logo with text on the vertical axis
/// author: Godwin Mathias

class PlaykosmosLogoVertical extends StatelessWidget {
  const PlaykosmosLogoVertical({
    super.key,
    this.fHeight,
    this.fWidth,
    this.fFit = BoxFit.contain,
  });

  final double? fWidth;
  final double? fHeight;
  final BoxFit fFit;

  @override
  Widget build(BuildContext context) {
    return Assets.svgs.auth.playkosmosLogoVerticalTransparent.svg(
      fit: fFit,
      width: fWidth,
      height: fHeight,
    );
  }
}
