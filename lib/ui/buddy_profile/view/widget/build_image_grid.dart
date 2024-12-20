import 'package:flutter/material.dart';

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
          padding: const EdgeInsets.all(8.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(fImages[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        // Add functionality for selection if needed
                      },
                    ),
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
