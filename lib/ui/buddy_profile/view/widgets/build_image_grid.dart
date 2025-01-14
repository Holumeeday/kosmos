import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';
import 'package:playkosmos_v3/common_widgets/activity_added_media.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/context_extension.dart';

/* 
A responsive grid layout for displaying posts/activities.
 [fImages]: List of image URLs to display
 [fLabel]: Unique identifier for maintaining scroll state
  @author: Chidera Chijama
*/

class BuildImageGrid extends StatelessWidget {
  const BuildImageGrid({
    super.key,
    required this.fImages,
    required this.fLabel,
  });
  final List<String> fImages;
  final String fLabel;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: PageStorageKey(fLabel),
      slivers: [
        // Handle the overlap from the nested scroll view
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 8.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return GestureDetector(
                  child: Stack(
                    children: [
                      // Image in the background
                      Container(
                        height: getRelativeScreenWidth(146, context),
                        width: getRelativeScreenWidth(146, context),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(fImages[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Blurry container with icon on top
                      Positioned(
                        right: 4,
                        top: 4,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 10,
                                sigmaY: 10,
                              ),
                              child: Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(4)),
                                  ),
                                  child: SvgPicture.asset(
                                    const $AssetsSvgsIconsGen().multiPost.path,
                                   height: getRelativeScreenWidth(18, context),
                                  width: getRelativeScreenWidth(18, context),
                                    fit: BoxFit.scaleDown,
                                    colorFilter: ColorFilter.mode(
                                        context.colors.surface,
                                        BlendMode.srcIn),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: fImages.length,
            ),
          ),
        ),
      ],
    );
  }
}
