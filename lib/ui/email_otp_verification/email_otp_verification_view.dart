import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/email_otp_verification/email_otp_verification_view_model.dart';
import 'package:playkosmos_v3/utils/utils.dart';
import 'package:provider/provider.dart';

/// Email OTP verification screen
///
///@author: Godwin Mathias
class EmailOtpVerificationView extends StatelessWidget {
  const EmailOtpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        fElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ChangeNotifierProvider(
          create: (context) => EmailOTPVerificationViewModel(),
          child: const OTPForm(),
        ),
      ),
    );
  }
}

class OTPForm extends StatefulWidget {
  const OTPForm({
    super.key,
    this.fPageTitle,
    this.fPageSubTitle,
    this.fTextFieldLabel,
    this.fOnResendCode,
    this.fOnNextButton,
  });

  /// The OTP page title
  final String? fPageTitle;

  /// The page subtitle
  final String? fPageSubTitle;

  /// OTP code text field label
  final String? fTextFieldLabel;

  /// On click resend code
  final VoidCallback? fOnResendCode;

  /// On next button click
  final VoidCallback? fOnNextButton;

  @override
  State<OTPForm> createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  /// The form key for validation
  final _fFormKey = GlobalKey<FormState>();

  /// OTP field controller
  late TextEditingController _fOtpController;

  /// If the next button should be enabled
  bool _dCanNext = false;

  @override
  void initState() {
    super.initState();
    _fOtpController = TextEditingController()
      ..addListener(() {
        if (mounted) {
          // Only enable the button if the otp is valid
          // i.e it equals 6 and it's a number (integer)
          _dCanNext = _fOtpController.text.length == 6 &&
              int.tryParse(_fOtpController.text) != null;
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _fOtpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const VSpace(20),

        // Enter OTP code header
        Text(
          context.loc.enterYourCode,
          style: context.appTextTheme.header1,
        ),
        const VSpace(16),

        // Let double check your info message
        Text(
          context.loc.letDoubleCheckYourInfoMessage,
          style: context.appTextTheme.caption,
        ),
        const VSpace(40),

        // The otp form field
        Form(
          key: _fFormKey,
          child: CustomOtpInput(
            fPinController: _fOtpController,
            fValidator: ValidationUtil.otpValidatorWithoutCode,
          ),
        ),
        const VSpace(24),

        // Resend otp
        ResendCountdown(
          fCantResendOtp: context.select(
            (EmailOTPVerificationViewModel viewModel) =>
                viewModel.dCantResendOtp,
          ),
          fResendOtpCall: () {
            FocusManager.instance.primaryFocus?.unfocus();
            context.read<EmailOTPVerificationViewModel>().resendOtp();
          },
          fEndCountdown: () => context
              .read<EmailOTPVerificationViewModel>()
              .setResendingOtp(false),
        ),
        const VSpace(40),

        // Next button
        PrimaryGradientButton(
          fDisabled: !_dCanNext,
          fOnPressed: () {
            context.read<EmailOTPVerificationViewModel>().showSuccessDialog();
          },
          fChild: Text(context.loc.nextText),
        )
      ],
    );
  }
}
