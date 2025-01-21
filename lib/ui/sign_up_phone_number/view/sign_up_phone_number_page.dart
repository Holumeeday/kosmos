import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/data/repositories/auth_flow_storage.dart';
import 'package:playkosmos_v3/enums/phone_otp_method_enum.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/sign_up_phone_number/cubit/sign_up_phone_number_cubit.dart';
import 'package:playkosmos_v3/ui/sign_up_phone_number/view/widgets/otp_options.dart';
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
  // Phone controller
  late TextEditingController _fPhoneController;

  /// The global key for validation of the form
  final _fFormKey = GlobalKey<FormState>();

  /// If email is valid
  bool? _dIsValidPhone;

  @override
  void initState() {
    super.initState();
    _fPhoneController = TextEditingController()
      ..addListener(() {
        if (mounted) {
          _dIsValidPhone =
              ValidationUtil.numberValidator(_fPhoneController.text) == null;
          if (_dIsValidPhone ?? false) {
            context
                .read<SignUpWithPhoneNumberCubit>()
                .setPhoneNumber(_fPhoneController.text);
          }
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
    return ShowAsyncBusyIndicator(
      fInAsync: context.select(
        (SignUpWithPhoneNumberCubit cubit) =>
            cubit.state.status == SignUpWithPhoneStatus.loading,
      ),
      fChild:
          BlocListener<SignUpWithPhoneNumberCubit, SignUpWithPhoneNumberState>(
        listener: (context, state) {
          if (state.status == SignUpWithPhoneStatus.success) {
            // If sign up was successful
            if (state.data?.status == true) {
              context.read<AuthFlowStorage>().hasJustCreatedAccount();
              context.pushNamed(
                AppRoute.phoneNumberOtpVerificationScreen,
                pathParameters: {
                  'phone': context
                      .read<SignUpWithPhoneNumberCubit>()
                      .getFullPhoneNumber(),
                },
              );
            }
          } else if (state.status == SignUpWithPhoneStatus.failure &&
              state.errorMessage != null) {
            SnackBarUtil.showError(message: state.errorMessage!);
          }
        },
        child: Scaffold(
          appBar: const CustomAppBar(
            fElevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocBuilder<SignUpWithPhoneNumberCubit,
                SignUpWithPhoneNumberState>(
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
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (_) {
                              return BlocProvider.value(
                                value:
                                    context.read<SignUpWithPhoneNumberCubit>(),
                                child: Builder(builder: (context) {
                                  final fSelectedOtpMethod = context.select(
                                      (SignUpWithPhoneNumberCubit cubit) =>
                                          cubit.state.fSelectedOtpOption);
                                  return Dialog(
                                      child: OtpOptions(
                                    fTitle: context
                                        .loc.howWouldYouLikeToReceiveTheCode,
                                    fcontent: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // Whatsapp
                                        RadioListTile(
                                          contentPadding: EdgeInsets.zero,
                                          value: PhoneOtpMethodEnum.whatsapp,
                                          groupValue: fSelectedOtpMethod,
                                          title: Text(
                                            context.loc.whatsapp,
                                            style: context
                                                .appTextTheme.buttonLarge,
                                          ),
                                          onChanged: (v) {
                                            context
                                                .read<
                                                    SignUpWithPhoneNumberCubit>()
                                                .setOtpOption(v!);
                                          },
                                        ),
                                        // Sms
                                        RadioListTile(
                                          contentPadding: EdgeInsets.zero,
                                          value: PhoneOtpMethodEnum.sms,
                                          groupValue: fSelectedOtpMethod,
                                          title: Text(
                                            context.loc.sms,
                                            style: context
                                                .appTextTheme.buttonLarge,
                                          ),
                                          onChanged: (v) {
                                            context
                                                .read<
                                                    SignUpWithPhoneNumberCubit>()
                                                .setOtpOption(v!);
                                          },
                                        ),
                                      ],
                                    ),
                                    fOnLetGo: () {
                                      context.pop();
                                      context
                                          .read<SignUpWithPhoneNumberCubit>()
                                          .signUpPhone();
                                    },
                                  ));
                                }),
                              );
                            },
                          );
                        },
                        fChild: Text(context.loc.nextText),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
