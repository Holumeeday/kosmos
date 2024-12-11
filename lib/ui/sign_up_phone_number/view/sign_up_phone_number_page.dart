import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/action_dialog.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/forgot_password_phone/view/forgot_password_phone_page.dart';
import 'package:playkosmos_v3/ui/sign_up_phone_number/cubit/sign_up_phone_number_cubit.dart';
import 'package:playkosmos_v3/ui/sign_up_phone_number/view/widgets/custom_radio_tile.dart';
import 'package:playkosmos_v3/utils/utils.dart';


/// This class represents the main page for signing up with a phone number.

/// The page contains:
/// - A form for entering the phone number.
/// - A button to proceed after validation.
/// - A dialog to select how to receive the OTP (via SMS or WhatsApp).

/// The page interacts with the SignUpWithPhoneNumberCubit for managing state.

/// @author: Chidera Chijama
class SignUpPhoneNumberPage extends StatefulWidget {
  const SignUpPhoneNumberPage({super.key});

  @override
  State<SignUpPhoneNumberPage> createState() => _SignUpPhoneNumberPageState();
}

class _SignUpPhoneNumberPageState extends State<SignUpPhoneNumberPage> {
  // Email controller
  late TextEditingController _fPhoneController;

  /// The global key for validation of the form
  final _fFormKey = GlobalKey<FormState>();

  /// If email is valid
  bool? _dIsValidPhone;

  // User name
  final fUsername = 'John Doe';

  @override
  void initState() {
    super.initState();
    _fPhoneController = TextEditingController()
      ..addListener(() {
        if (mounted) {
          _dIsValidPhone =
              ValidationUtil.numberValidator(_fPhoneController.text) == null;
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _fPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        fElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child:
            BlocBuilder<SignUpWithPhoneNumberCubit, SignUpWithPhoneNumberState>(
          builder: (context, state) {
            return Form(
              key: _fFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      context.loc.enterYourNumber,
                      style: context.appTextTheme.header1,
                    ),
                  ),
                  const VSpace(56),

                  // Phone number text field
                  CustomPhoneField(
                    fTextController: _fPhoneController,
                    fValidator: ValidationUtil.numberValidator,
                    fOnCountryChanged: (value) {
                      context
                          .read<SignUpWithPhoneNumberCubit>()
                          .setCountryCode(value);
                    },
                  ),
                  const VSpace(56),

                  // Login button
                  PrimaryGradientButton(
                    fDisabled: !(_dIsValidPhone ?? false),
                    fOnPressed: () {
                      showCustomDialog(
                         context,
                        barrierDismissible: true,
                        builder: (_) {
                          return Dialog(
                              child: ActionDialog(
                            fTitle: context.loc.howWouldYouLikeToReceiveTheCode,
                            fcontent: Column(
                              children: [
                                CustomRadioTile(
                                  title: context.loc.sms,
                                  subtitle: context.loc.onlyOnce,
                                  value: context.loc.sms,
                                  groupValue: state.fSelectedOtpOption,
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      context
                                          .read<SignUpWithPhoneNumberCubit>()
                                          .setOtpOption(value);
                                    }
                                  },
                                  activeColor: context.colors.secondary,
                                ),
                                CustomRadioTile(
                                  title: context.loc.whatsApp,
                                  subtitle: context.loc.unlimited,
                                  value: context.loc.whatsApp,
                                  groupValue: state.fSelectedOtpOption,
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      context
                                          .read<SignUpWithPhoneNumberCubit>()
                                          .setOtpOption(value);
                                    }
                                  },
                                  activeColor: context.colors.secondary,
                                ),
                              ],
                            ),
                            fOnLetGo: () {
                              //  context
                              // .push(const ForgotPasswordOtpVerificationPage());
                            },
                          ));
                        },
                      );
                    },
                    fChild: Text(context.loc.loginText),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
