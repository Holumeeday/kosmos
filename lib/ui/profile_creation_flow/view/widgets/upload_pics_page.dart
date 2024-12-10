import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/// This is the page for uploading pics for the profile cretion
/// section
///
/// @author: Godwin Mathias
class UploadPicsPage extends StatelessWidget {
  const UploadPicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Title
        Text(
          "Upload your pics",
          style: context.appTextTheme.header1,
        ),
        const VSpace(12),
        Text(
          'Time to show off your awesome self! Upload your profile pic!',
          style: context.appTextTheme.caption,
        ),
        const VSpace(40),
      ],
    );
  }
}
