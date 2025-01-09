import 'package:flutter/material.dart';

class OverlappingProfiles extends StatelessWidget {
  const OverlappingProfiles({super.key, required this.fProfilePictures});
 final  List<String> fProfilePictures;
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 26,
      width: 60,
      child: Stack(
        children: [
          BuildProfileImage(imageUrl: "", leftPosition: 0),
          BuildProfileImage(imageUrl: "", leftPosition: 16),
          BuildProfileImage(imageUrl: "", leftPosition: 32),
        ],
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

  final String imageUrl;
  final double leftPosition;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: leftPosition,
      child: Container(
        width: size ?? 24,
        height: size ?? 24,
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
          // image: DecorationImage(
          //   image: AssetImage(imageUrl),
          //   fit: BoxFit.cover,
          // ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
      ),
    );
  }
}
