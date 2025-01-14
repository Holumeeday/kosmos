import 'package:flutter/material.dart';

import '../../../../common_widgets/sizes.dart';
import '../../../../constants/text_styles.dart';

class ActivitiesSummary extends StatelessWidget {
  final bool showBorder;
  final String title;
  final int stat;
  final double rating;
  final int reviews;

  const ActivitiesSummary({
    super.key,
    this.showBorder = false,
    required this.title,
    required this.stat,
    required this.rating,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      width: 180,
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
      decoration: BoxDecoration(
        border: showBorder
            ? Border(
                right: BorderSide(
                  color: Colors.grey.shade300,
                  width: .6,
                ),
              )
            : null,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: counterTypeStyle,
          ),
          const VSpace(15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1.2,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Text(
                          stat.toString(),
                          style: bigTextStyle,
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20.0),
                        const HSpace(2),
                        Text(
                          rating.toString(),
                          style: fCountStyle,
                        ),
                      ],
                    ),
                    Text(
                      '$reviews Reviews',
                      style: counterTypeStyle,
                    )
                  ],
                )
              ],
            ),
          ),
          Divider(
            color: Colors.grey.withOpacity(.2),
          )
        ],
      ),
    );
  }
}
