import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
This widget shows the otp pin
@author: Ugochukwu Umeh
*/
class CustomOtpInput extends StatefulWidget {
  final String? Function(String?)? fValidator;
  final TextEditingController fPinController;

  const CustomOtpInput({
    super.key,
    required this.fValidator,
    required this.fPinController,
  });

  @override
  State<CustomOtpInput> createState() => _CustomOtpInputState();
}

class _CustomOtpInputState extends State<CustomOtpInput> {
  ///The focus node
  final FocusNode _fPinFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _fPinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Used to store the default pin theme color
    final fDefaultPinTheme = PinTheme(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.appColors.greyShade85Color!,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      textStyle: context.textTheme.displayMedium,
    );

    // Wen a pin is focused
    final fFocusedPinTheme = PinTheme(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      textStyle: context.textTheme.displayMedium,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.appColors.greyShade85Color!,
          ),
        ),
      ),
    );

    return Pinput(
      defaultPinTheme: fDefaultPinTheme,
      focusedPinTheme: fFocusedPinTheme,
      validator: widget.fValidator,
      length: 6,
      autofocus: true,
      showCursor: true,
      focusNode: _fPinFocusNode,
      controller: widget.fPinController,
      errorTextStyle: context.textTheme.bodyMedium?.copyWith(
        color: context.colors.error,
      ),
    );
  }
}
