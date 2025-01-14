import 'package:flutter/material.dart';

import '../../../../constants/text_styles.dart';

class Stat_Container extends StatelessWidget {
  final double stat;
  final String counterType;
  final String suffix;
  const Stat_Container({
    super.key,
    required this.counterType,
    required this.stat,
    required this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
      decoration:  BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey.shade300,
            width: .6,
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            '${stat.toString()}$suffix',
            style: fCountStyle,
          ),
          Text(counterType, style: counterTypeStyle)
        ],
      ),
    );
  }
}
