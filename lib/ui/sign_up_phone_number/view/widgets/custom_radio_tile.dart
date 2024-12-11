import 'package:flutter/material.dart';

class CustomRadioTile extends StatelessWidget {
  /// The title of the radio tile
  final String title;

  /// The subtitle or additional text
  final String? subtitle;

  /// The value associated with this radio option
  final String value;

  /// The currently selected value (group value)
  final String groupValue;

  /// Callback when the radio tile is selected
  final ValueChanged<String?> onChanged;

  /// Optional active color for the radio button
  final Color? activeColor;

  const CustomRadioTile({
    Key? key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: RadioListTile.adaptive(

        activeColor: activeColor ?? Theme.of(context).colorScheme.secondary,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 18,
                      
                    ),

              ),
              if (subtitle != null)
                TextSpan(
                  text: " ($subtitle)",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                ),
            ],
          ),
        ),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}
