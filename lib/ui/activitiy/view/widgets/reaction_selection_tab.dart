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
      scrollDirection: Axis.horizontal, 
      child: SizedBox(
        width:
            MediaQuery.of(context).size.width, 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            reactions.length,
            (index) {
              return GestureDetector(
                onTap: () {
                  onSelect(reactions[index]); 
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 6), 
                  child: Image.asset(
                    reactions[index], 
                    width: 40, 
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
