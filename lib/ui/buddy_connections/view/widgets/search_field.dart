import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// A reusable search input field with an icon and placeholder text.
/// @author: Chidera Chijama
class SearchField extends StatelessWidget {
  final String placeholderText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  const SearchField({
    super.key,
    this.placeholderText = "Search following",
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColor.fTextBoxColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search_rounded,
            color: Colors.grey,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              controller: controller,
              onChanged: onChanged,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: placeholderText,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: Color(0xffC5C5C5),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
