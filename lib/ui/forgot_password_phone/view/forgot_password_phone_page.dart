import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/forgot_password_phone/cubit/forgot_password_phone_cubit.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// Forgot password using phone number page
///
///@author: Godwin Mathias
class ForgotPasswordPhonePage extends StatelessWidget {
  const ForgotPasswordPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ForgotPasswordPhone();
  }
}

class _ForgotPasswordPhone extends StatefulWidget {
  const _ForgotPasswordPhone();

  @override
  State<_ForgotPasswordPhone> createState() => _ForgotPasswordPhoneState();
}

class _ForgotPasswordPhoneState extends State<_ForgotPasswordPhone> {
  /// The phone number controller
  late TextEditingController _fPhoneController;

  /// The global key for validation of the form
  final _fFormKey = GlobalKey<FormState>();

  /// If the user can click the next button
  bool _dCanNext = false;

  @override
  void initState() {
    super.initState();
    _fPhoneController = TextEditingController()
      ..addListener(() {
        if (mounted) {
          _dCanNext =
              ValidationUtil.numberValidator(_fPhoneController.text) == null;
          if (_dCanNext) {
            context
                .read<ForgotPasswordPhoneCubit>()
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
      fInAsync: context.select((ForgotPasswordPhoneCubit cubit) =>
          cubit.state.status == ForgotPasswordPhoneStatus.loading),
      fChild: BlocListener<ForgotPasswordPhoneCubit, ForgotPasswordPhoneState>(
        listener: (context, state) {
          if (state.status == ForgotPasswordPhoneStatus.success) {
            if (state.data?.status == true) {
              showCustomDialog(
                barrierDismissible: false,
                context,
                builder: (_) => Dialog(
                  child: AuthSuccessInfoDialog(
                    fTitle: context.loc.checkYourMessage,
                    fMessage: context.loc.dingDingCheckInboxMessage,
                    fOnLetGo: () {
                      context.goNamed(
                        AppRoute.forgotPasswordOtpScreen,
                        queryParameters: {
                          'phone': context
                              .read<ForgotPasswordPhoneCubit>()
                              .getFullPhoneNumber(),
                          'is-email': false.toString()
                        },
                      );
                    },
                  ),
                ),
              );
            }
          } else if (state.status == ForgotPasswordPhoneStatus.failure &&
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
            child: Form(
              key: _fFormKey,
              child: Column(
                children: <Widget>[
                  // Forgot password text
                  Text(
                    context.loc.forgotPassword2,
                    textAlign: TextAlign.center,
                    style: context.appTextTheme.header1,
                  ),
                  const VSpace(10),
                  Text(
                    context.loc.noWorriesForgotPasswordCaption,
                    textAlign: TextAlign.center,
                    style: context.appTextTheme.body?.copyWith(
                      color: context.appColors.greyShade85Color,
                    ),
                  ),
                  const VSpace(40),

                  // Phone text field
                  CustomPhoneField(
                    fOnCountryChanged: (v) {
                      context
                          .read<ForgotPasswordPhoneCubit>()
                          .setCountryCode(v);
                    },
                    fTextController: _fPhoneController,
                    fValidator: ValidationUtil.numberValidator,
                  ),

                  const VSpace(56),

                  // Next button
                  PrimaryGradientButton(
                    fDisabled: !_dCanNext,
                    fOnPressed: () {
                      context
                          .read<ForgotPasswordPhoneCubit>()
                          .forgotPasswordPhone();
                    },
                    fChild: Text(context.loc.nextText),
                  ),
                  const VSpace(24),

                  // Otp selection method
                  const _OtpMethodSelection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OtpMethodSelection extends StatelessWidget {
  const _OtpMethodSelection();

  @override
  Widget build(BuildContext context) {
    final fSelectedOtpMethod = context.select(
        (ForgotPasswordPhoneCubit cubit) => cubit.state.fSelectedOtpOption);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Code receive method message
        Text(
          context.loc.howWouldYouLikeToReceiveCode,
          style: context.appTextTheme.title?.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        // Whatsapp
        RadioListTile(
          contentPadding: EdgeInsets.zero,
          value: PhoneOtpMethodEnum.whatsapp,
          groupValue: fSelectedOtpMethod,
          title: Text(context.loc.whatsapp),
          onChanged: (v) {
            context.read<ForgotPasswordPhoneCubit>().changeOtpMethod(v!);
          },
        ),
        // Sms
        RadioListTile(
          contentPadding: EdgeInsets.zero,
          value: PhoneOtpMethodEnum.sms,
          groupValue: fSelectedOtpMethod,
          title: Text(context.loc.sms),
          onChanged: (v) {
            context.read<ForgotPasswordPhoneCubit>().changeOtpMethod(v!);
          },
        ),
      ],
    );
  }
}
