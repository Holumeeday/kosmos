import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
This class defines the error message for media files
@author: Ugochukwu Umeh
*/
class ErrorMedia extends StatelessWidget {
  const ErrorMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error,
              color: context.colors.onSecondary,
            ),
            const VSpace(8),
            Flexible(
              child: Text(
                context.loc.errorFetchingMedia,
                textAlign: TextAlign.center,
                style: context.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: context.colors.onSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
