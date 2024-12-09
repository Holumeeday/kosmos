import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
This widget shows the resend timer
@author: Ugochukwu Umeh
*/
class ResendCountdown extends StatelessWidget {
  ///If user can resend top
  final bool fCanResendOtp;

  ///To resend an otp call
  final VoidCallback fResendOtpCall;

  /// To end the countdown
  final VoidCallback fEndCountdown;

  /// Text
  final String? fText;

  /// Text button text
  final String? fButtonText;

  const ResendCountdown({
    super.key,
    required this.fCanResendOtp,
    required this.fResendOtpCall,
    required this.fEndCountdown,
    this.fText,
    this.fButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      runSpacing: 5,
      children: [
        Text(
          fText ?? context.loc.ifYouDidNotReceiveCodeRetry,
          style: context.appTextTheme.caption,
        ),
        const HSpace(8),
        fCanResendOtp
            ? GestureDetector(
                onTap: () {
                  fResendOtpCall.call();
                },
                child: Text(
                  fButtonText ?? context.loc.resend,
                  style: context.appTextTheme.buttonMedium?.copyWith(
                    color: context.appColors.fHyperLinkColor,
                  ),
                ),
              )
            : TweenAnimationBuilder<Duration>(
                tween: Tween(
                  begin: const Duration(minutes: 15),
                  end: const Duration(),
                ),
                duration: const Duration(minutes: 15),
                onEnd: fEndCountdown,
                builder: (_, value, __) {
                  final String minutes =
                      value.inMinutes.toString().padLeft(2, '0');
                  final seconds =
                      (value.inSeconds % 60).toString().padLeft(2, '0');
                  return Text(
                    '$minutes : $seconds',
                    style: context.appTextTheme.buttonMedium,
                  );
                },
              ),
      ],
    );
  }
}
