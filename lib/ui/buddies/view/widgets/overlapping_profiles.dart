import 'package:flutter/material.dart';

class OverlappingProfiles extends StatelessWidget {
  const OverlappingProfiles({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26, 
      width: 60,
      child: Stack(
        children: [
          _buildProfileImage(
            "",
            0,
          ),
          _buildProfileImage(
            "",
            16,
          ),
          _buildProfileImage(
            "",
            32,
          ),
        ],
      ),
    );
  }

  /// Helper function to create circular images with left margin
  Widget _buildProfileImage(String imageUrl, double leftPosition) {
    return Positioned(
      right: leftPosition,
      child: Container(
        width: 24,
        height: 24,
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
