import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/*
This class defines the create account text form field
@author: Ugochukwu Umeh
*/
class CustomTextFormField extends StatelessWidget {
  ///The text controller
  final TextEditingController fTextController;

  ///The hint text
  final String? fHintText;

  ///The label text
  final String? fLabelText;

  ///The input action of the keyboard
  final TextInputAction? fInputAction;

  ///The keyboard type
  final TextInputType? fTextType;

  ///The prefix icon data
  final IconData? fIconData;

  ///The suffix icon
  final Widget? fSuffixIcon;

  ///The validator function
  final String? Function(String?) fValidator;

  ///The padding of the text field
  final EdgeInsetsGeometry? fContentPadding;

  ///On tap function
  final void Function()? fOnTap;

  ///AutoFill hints
  final List<String>? fAutoFillHints;

  ///To show cursor
  final bool? fInteractiveSelection;

  ///The validation mode. Defaults to on user interaction
  final AutovalidateMode? fAutoValidateMode;

  ///The number of lines
  final int? fMaxLines;

  ///The prefix icon
  final Widget? fPrefixIcon;

  ///The text input formatters
  final List<TextInputFormatter>? fTextInputFormatters;

  /// The text style
  final TextStyle? fTextStyle;

  /// The prefix icon constraints
  final BoxConstraints? fPrefixIconConstraints;

  /// The suffix icon constraints
  final BoxConstraints? fSuffixIconConstraints;

  const CustomTextFormField({
    super.key,
    required this.fTextController,
    this.fLabelText,
    this.fHintText,
    this.fInputAction,
    this.fTextType = TextInputType.text,
    this.fOnTap,
    this.fAutoFillHints,
    this.fInteractiveSelection,
    this.fIconData,
    this.fSuffixIcon,
    required this.fValidator,
    this.fContentPadding,
    this.fAutoValidateMode = AutovalidateMode.onUserInteraction,
    this.fMaxLines = 1,
    this.fPrefixIcon,
    this.fTextInputFormatters,
    this.fTextStyle,
    this.fPrefixIconConstraints,
    this.fSuffixIconConstraints,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: fMaxLines,
      controller: fTextController,
      enableInteractiveSelection: fInteractiveSelection,
      style: fTextStyle ?? context.textTheme.titleMedium,
      textInputAction: fInputAction,
      keyboardType: fTextType,
      autofillHints: fAutoFillHints,
      inputFormatters: fTextInputFormatters,
      decoration: InputDecoration(
        labelText: fLabelText,
        hintText: fHintText,
        prefixIcon: (fIconData != null)
            ? Icon(
                fIconData,
                color: context.colors.tertiary,
                size: 23,
              )
            : fPrefixIcon,
        prefixIconConstraints: fPrefixIconConstraints,
        contentPadding: fContentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 18,
            ),
        suffixIcon: fSuffixIcon,
        suffixIconConstraints: fSuffixIconConstraints,
      ),
      onTap: fOnTap,
      autovalidateMode: fAutoValidateMode,
      validator: fValidator,
    );
  }
}

/*
This class defines the create account text form field
@author: Ugochukwu Umeh
*/
class CustomPasswordField extends StatefulWidget {
  ///The text controller
  final TextEditingController fPasswordController;

  const CustomPasswordField({
    super.key,
    required this.fPasswordController,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  ///Checks if password is obscured
  bool _dIsPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _dIsPasswordObscured,
      controller: widget.fPasswordController,
      style: context.textTheme.titleMedium,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: context.loc.passwordHint,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 18,
        ),
        suffixIcon: Semantics(
          obscured: _dIsPasswordObscured,
          label: _dIsPasswordObscured
              ? context.loc.showPassword
              : context.loc.hidePassword,
          child: GestureDetector(
            onTap: () {
              if (mounted) {
                setState(() {
                  _dIsPasswordObscured = !_dIsPasswordObscured;
                });
              }
            },
            child: Icon(
              _dIsPasswordObscured
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              size: 23,
            ),
          ),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: ValidationUtil.passwordValidator,
    );
  }
}
