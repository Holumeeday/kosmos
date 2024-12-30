import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
This class helps to show a circular progress indicator when loading async calls
@author: Ugochukwu Umeh
*/
class ShowAsyncBusyIndicator extends StatelessWidget {
  ///The bool that tells when an async call is ongoing
  final bool fInAsync;

  ///The child
  final Widget fChild;

  ///The indicator. Defaults to a circular indicator
  final Widget? fCustomIndicator;

  ///This stacks a circular progress indicator over [fChild] when [fInAsync]
  ///is true (when an async call is ongoing)
  const ShowAsyncBusyIndicator({
    super.key,
    required this.fInAsync,
    required this.fChild,
    this.fCustomIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        fChild,
        if (fInAsync)
          ModalBarrier(
            dismissible: false,
            color: Colors.transparent.withOpacity(0.55),
          ),
        if (fInAsync)
          Center(
            child: fCustomIndicator ??
                CircularProgressIndicator.adaptive(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(context.colors.secondary),
                ),
          ),
      ],
    );
  }
}
