import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// OTP form view for the authentication pages.
/// This widget handles the OTP input field, the resend OTP functionality, and
/// the next button for progressing the user through the authentication flow.
///
/// It provides:
/// - An OTP input field that validates the entered code.
/// - A countdown for resending the OTP code, with a customizable label.
/// - A button to move to the next step, which is enabled when the OTP is valid.
///
/// @author: Godwin Mathias
class AuthOTPForm extends StatefulWidget {
  /// Constructs an OTP form widget with the provided parameters.
  ///
  /// [fPageTitle] - The main title of the OTP page.
  /// [fPageSubTitle] - The subtitle of the OTP page.
  /// [fTextFieldLabel] - The optional label for the OTP input field.
  /// [fOnResendCode] - The callback function to trigger when the "Resend OTP" button is clicked.
  /// [fOnNextButton] - The callback function to trigger when the "Next" button is clicked.
  /// [fCanResendOtp] - Whether the user can resend the OTP.
  /// [fOnEndCountdown] - The callback function to trigger when the countdown ends.
  const AuthOTPForm({
    super.key,
    required this.fPageTitle,
    required this.fPageSubTitle,
    this.fTextFieldLabel,
    required this.fOnResendCode,
    required this.fOnNextButton,
    required this.fCanResendOtp,
    required this.fOnEndCountdown,
    required this.fOnChanged,
  });

  /// The OTP page title that will be displayed at the top of the form.
  final String fPageTitle;

  /// The subtitle that provides further instructions or information about the OTP.
  final String fPageSubTitle;

  /// The label displayed for the OTP input field. This can be customized.
  /// If not provided, no label is shown.
  final String? fTextFieldLabel;

  /// The callback function invoked when the "Resend OTP" button is pressed.
  final VoidCallback fOnResendCode;

  /// The callback function invoked when the "Next" button is pressed.
  final VoidCallback fOnNextButton;

  /// The callback function invoked when the OTP resend countdown ends.
  final VoidCallback fOnEndCountdown;

  /// A boolean value that determines whether the user is allowed to resend the OTP.
  final bool fCanResendOtp;

  /// On text field change
  final ValueChanged<String> fOnChanged;

  @override
  State<AuthOTPForm> createState() => _AuthOTPFormState();
}

class _AuthOTPFormState extends State<AuthOTPForm> {
  /// The form key used for validating the OTP input field.
  final _fFormKey = GlobalKey<FormState>();

  /// The controller that manages the OTP input field.
  late TextEditingController _fOtpController;

  /// A boolean flag that determines whether the "Next" button should be enabled.
  bool _dCanNext = false;

  @override
  void initState() {
    super.initState();
    // Initializing the OTP controller and adding a listener to track the input.
    _fOtpController = TextEditingController()
      ..addListener(() {
        if (mounted) {
          final _fCurrentText = _fOtpController.text;
          // Regex pattern to check if the input is a number and exactly 6 digits long.
          final isValidOtp = RegExp(r'^\d{6}$').hasMatch(_fCurrentText);

          // Enable the "Next" button if the OTP is 6 digits long and valid.
          _dCanNext = isValidOtp;
          if (isValidOtp) {
            widget.fOnChanged.call(_fCurrentText);
          }
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    // Dispose of the OTP controller when the widget is removed from the widget tree.
    _fOtpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const VSpace(20),

        // Display the page title (main heading).
        Text(
          widget.fPageTitle,
          style: context.appTextTheme.header1,
          textAlign: TextAlign.center,
        ),
        const VSpace(16),

        // Display the page subtitle (additional instruction or message).
        Text(
          widget.fPageSubTitle,
          style: context.appTextTheme.body?.copyWith(
            color: context.appColors.greyShade85Color,
          ),
          textAlign: TextAlign.center,
        ),
        const VSpace(40),

        // The OTP input field inside a form, with validation applied.
        Form(
          key: _fFormKey,
          child: CustomOtpInput(
            fPinController: _fOtpController,
            fValidator: ValidationUtil.otpValidatorWithoutCode,
          ),
        ),
        const VSpace(24),

        // The resend OTP section with countdown and callback functionality.
        ResendCountdown(
          fCountdownDuration: const Duration(minutes: 15),
          fText: widget.fTextFieldLabel,
          fCanResendOtp: widget.fCanResendOtp,
          fResendOtpCall: () {
            FocusManager.instance.primaryFocus?.unfocus();
            widget.fOnResendCode();
          },
          fEndCountdown: widget.fOnEndCountdown,
        ),
        const VSpace(40),

        // The "Next" button, which is only enabled when the OTP is valid.
        PrimaryGradientButton(
          fDisabled: !_dCanNext,
          fOnPressed: widget.fOnNextButton,
          fChild: Text(context.loc.nextText),
        )
      ],
    );
  }
}
