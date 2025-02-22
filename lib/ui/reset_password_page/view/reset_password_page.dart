import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/reset_password_page/cubit/reset_password_cubit.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// The reset password form page
///
/// @author: Godwin Mathias
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({
    super.key,
    this.fEmail,
    this.fPhone,
    required this.fIsEmail,
  });

  /// The user email address
  final String? fEmail;

  /// The user phone number
  final String? fPhone;

  /// If the user is using email
  final bool fIsEmail;

  @override
  State<ResetPasswordPage> createState() => __ResetPasswordPageState();
}

class __ResetPasswordPageState extends State<ResetPasswordPage> {
  /// The password controller
  late TextEditingController _fPasswordController;

  /// The global key for validation of the form
  final _fFormKey = GlobalKey<FormState>();

  /// If the user can click the next button
  bool _dCanNext = false;

  @override
  void initState() {
    super.initState();
    _fPasswordController = TextEditingController()
      ..addListener(() {
        if (mounted) {
          _dCanNext =
              ValidationUtil.passwordValidator(_fPasswordController.text) ==
                  null;
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _fPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state.status == ResetPasswordStatus.success) {
          if (state.data?.status == true) {
            showCustomDialog(context, barrierDismissible: false,
                builder: (BuildContext dialogContext) {
              return Dialog(
                child: AuthSuccessInfoDialog(
                  fTitle: context.loc.passswordResetSuccessful,
                  fMessage: context.loc.yourPasswordResetWasSuccessfulMessage,
                  fOnLetGo: () {
                    context.go(
                      widget.fIsEmail
                          ? AppRoute.signInEmailScreenPath
                          : AppRoute.signInPhoneScreenPath,
                    );
                  },
                ),
              );
            });
          } else if (state.status == ResetPasswordStatus.failure &&
              state.errorMessage != null) {
            SnackBarUtil.showError(message: state.errorMessage!);
          }
        }
      },
      child: ShowAsyncBusyIndicator(
        fInAsync: context.select(
          (ResetPasswordCubit cubit) =>
              cubit.state.status == ResetPasswordStatus.loading,
        ),
        fChild: Scaffold(
          appBar: const CustomAppBar(
            fShowBackButton: false,
            fElevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _fFormKey,
              child: Column(
                children: <Widget>[
                  // Enter password text
                  Text(
                    context.loc.resetPassword,
                    textAlign: TextAlign.center,
                    style: context.appTextTheme.header1,
                  ),
                  const VSpace(40),

                  // Password text field
                  CustomPasswordField(
                    fPasswordController: _fPasswordController,
                  ),
                  const VSpace(12),

                  // text label
                  Text(
                    context.loc.timeToLockThingsDownPasswordCreationMessage,
                    style: context.appTextTheme.caption,
                  ),
                  const VSpace(56),

                  // Next button
                  PrimaryGradientButton(
                    fDisabled: !_dCanNext,
                    fOnPressed: () {
                      context.read<ResetPasswordCubit>().resetPassword(
                            email: widget.fEmail,
                            phone: widget.fPhone,
                            password: _fPasswordController.text,
                          );
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
