import 'package:flutter/material.dart';

/// Segmented date picker
///
/// @author: Godwin Mathias
class SegmentedDatePicker extends StatefulWidget {
  /// On selection of date
  final void Function(DateTime?) fOnDateSelected;

  /// Initial date
  final DateTime? fInitialDate;

  const SegmentedDatePicker({
    super.key,
    required this.fOnDateSelected,
    this.fInitialDate,
  });

  @override
  State<SegmentedDatePicker> createState() => _SegmentedDatePickerState();
}

class _SegmentedDatePickerState extends State<SegmentedDatePicker> {
  final TextEditingController dayController = TextEditingController();

  final TextEditingController monthController = TextEditingController();

  final TextEditingController yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.fInitialDate != null) {
      dayController.text = widget.fInitialDate!.day.toString();
      monthController.text = widget.fInitialDate!.month.toString();
      yearController.text = widget.fInitialDate!.year.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (selectedDate != null) {
          dayController.text = selectedDate.day.toString();
          monthController.text = selectedDate.month.toString();
          yearController.text = selectedDate.year.toString();
          widget.fOnDateSelected(selectedDate);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                ignorePointers: true,
                controller: dayController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 2,
                decoration: const InputDecoration(
                  hintText: "DD",
                  counterText: "",
                ),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: TextField(
                ignorePointers: true,
                controller: monthController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 2,
                decoration: const InputDecoration(
                  hintText: "MM",
                  counterText: "",
                ),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: TextField(
                ignorePointers: true,
                controller: yearController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 4,
                decoration: const InputDecoration(
                  hintText: "YYYY",
                  counterText: "",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
