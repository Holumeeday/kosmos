import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final void Function(double)?  onRatingChanged;


  const StarRating({super.key, this.starCount = 5, this.rating = .0, this.onRatingChanged,});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon =  Icon(
        Icons.star,
        color: context.appColors.darkGreyColor,
      );
    }
    else if (index > rating - 1 && index < rating) {
      icon =  const Icon(
        Icons.star_half,
        color:  Colors.amber,
      );
    } else {
      icon =  const Icon(
        Icons.star,
        color:  Colors.amber,
      );
    }
    return  InkResponse(
      onTap: () => onRatingChanged!(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Row(children:  List.generate(starCount, (index) => buildStar(context, index)));
  }
}