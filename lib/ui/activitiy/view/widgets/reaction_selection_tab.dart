import 'package:flutter/material.dart';

class ReactionsSelectionTabComponent extends StatelessWidget {
  const ReactionsSelectionTabComponent({
    super.key,
    required this.reactions,
    required this.onSelect,
  });

  final List<String> reactions; // List of reactions (GIFs)
  final Function(String) onSelect; // Callback to handle selection

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Allow horizontal scrolling
      child: SizedBox(
        width:
            MediaQuery.of(context).size.width, // Set the width to screen width
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            reactions.length,
            (index) {
              return GestureDetector(
                onTap: () {
                  onSelect(reactions[index]); // Trigger the onSelect callback
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 6), // Add space between reactions
                  child: Image.asset(
                    reactions[index], // Load the reaction image (GIF)
                    width: 40, // Set the size of the reaction
                    height: 40,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
