import 'package:flutter/material.dart';
/// Displays a stack of overlapping profile images based on the provided list of image URLs.
///
/// @author: Chidera Chijama
class OverlappingProfiles extends StatelessWidget {
  const OverlappingProfiles({super.key, required this.fProfilePictures});

  /// List of profile picture URLs to display as overlapping images
  final List<String> fProfilePictures;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      width: (fProfilePictures.length * 16.0) + 18, // Dynamically adjust width
      child: Stack(
        children: List.generate(
          fProfilePictures.length,
          (index) => BuildProfileImage(
            imageUrl: fProfilePictures[index] ?? "",
            // fProfilePictures[index],
            leftPosition: index * 16.0, // Offset each image by 16 pixels
          ),
        ),
      ),
    );
  }
}

class BuildProfileImage extends StatelessWidget {
  const BuildProfileImage({
    super.key,
    required this.imageUrl,
    required this.leftPosition,
    this.size,
  });

  /// The URL of the profile image
  final String imageUrl;

  /// The position offset for overlapping effect
  final double leftPosition;

  /// Size of the image (default is 24x24)
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: leftPosition,
      child: Container(
        width: size ?? 24,
        height: size ?? 24,
        decoration: BoxDecoration(
          color: Colors.lightBlue, // Fallback color if no image URL is provided
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
          image: imageUrl.isNotEmpty
              ? DecorationImage(
                  image: NetworkImage(imageUrl), // Use image URL
                  fit: BoxFit.cover,
                )
              : null,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }
}
