import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/forgot_password_email/cubit/forgot_password_email_cubit.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// Forgot password using email page
///
///@author: Godwin Mathias
class ForgotPasswordEmailPage extends StatelessWidget {
  const ForgotPasswordEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ForgotPasswordEmailForm();
  }
}

class _ForgotPasswordEmailForm extends StatefulWidget {
  const _ForgotPasswordEmailForm({super.key});

  @override
  State<_ForgotPasswordEmailForm> createState() =>
      __ForgotPasswordEmailFormState();
}

class __ForgotPasswordEmailFormState extends State<_ForgotPasswordEmailForm> {
  /// The email controller
  late TextEditingController _fEmailController;

  /// The global key for validation of the form
  final _fFormKey = GlobalKey<FormState>();

  /// If the user can click the next button
  bool _dCanNext = false;

  @override
  void initState() {
    super.initState();
    _fEmailController = TextEditingController()
      ..addListener(() {
        if (mounted) {
          _dCanNext =
              ValidationUtil.emailValidator(_fEmailController.text) == null;
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _fEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShowAsyncBusyIndicator(
      fInAsync: context.select((ForgotPasswordEmailCubit cubit) =>
          cubit.state.status == ForgotPasswordEmailStatus.loading),
      fChild: BlocListener<ForgotPasswordEmailCubit, ForgotPasswordEmailState>(
        listener: (context, state) {
          if (state.status == ForgotPasswordEmailStatus.success) {
            if (state.data?.status == true) {
              showCustomDialog(
                barrierDismissible: false,
                context,
                builder: (_) => Dialog(
                  child: AuthSuccessInfoDialog(
                    fTitle: context.loc.checkYourEmail,
                    fMessage: context.loc.dingDingCheckInboxMessage,
                    fOnLetGo: () {
                      context.goNamed(
                        AppRoute.forgotPasswordOtpScreen,
                        queryParameters: {
                          'email': _fEmailController.text,
                          'is-email': true.toString()
                        },
                      );
                    },
                  ),
                ),
              );
            }
          } else if (state.status == ForgotPasswordEmailStatus.failure) {
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
                  // Enter email address text
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

                  // Email text field
                  CustomTextFormField(
                    fTextController: _fEmailController,
                    fLabelText: context.loc.emailHint,
                    fInputAction: TextInputAction.done,
                    fTextType: TextInputType.emailAddress,
                    fAutoFillHints: const [AutofillHints.email],
                    fValidator: ValidationUtil.emailValidator,
                  ),

                  const VSpace(56),

                  // Next button
                  PrimaryGradientButton(
                    fDisabled: !_dCanNext,
                    fOnPressed: () {
                      context
                          .read<ForgotPasswordEmailCubit>()
                          .forgotPasswordEmail(email: _fEmailController.text);
                    },
                    fChild: Text(context.loc.nextText),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
