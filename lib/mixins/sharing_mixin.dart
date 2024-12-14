import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/utils.dart';
import 'package:share_plus/share_plus.dart';

/*
The mixin to handle everything involved with sharing a link
@author: Ugochukwu Umeh
 */

mixin SharingLinkMixin {
  /// To share a link
  ///
  /// [context] is the current context of the screen. [linkLocation] is the
  /// name of the screen combined with its pathParameter or queryParameter as
  /// the case may be. [repaintKey] is used to convert a widget into an image
  /// hence its for links that contain images
  Future<void> shareLink({
    required BuildContext context,
    required String linkLocation,
    GlobalKey<State<StatefulWidget>>? repaintKey,
  }) async {
    try {
      /// The box for the share dialog
      final box = context.findRenderObject() as RenderBox?;

      // if the repaint key is not null then share it with an image
      if (repaintKey != null) {
        // Converting the repaint boundary widget to an image
        final pngBytes = await WidgetUtil.screenshot(widgetKey: repaintKey);

        // Save the image bytes to a temporary file
        final tempDir = await getTemporaryDirectory();
        final tempFile = File(
            '${tempDir.path}/shared_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.png');
        await tempFile.writeAsBytes(pngBytes);

        // Share the link along with the image
        await Share.shareXFiles(
          [XFile(tempFile.path)],
          text: linkLocation,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        );

        // Delete the saved image
        tempFile.delete();
      }

      // else share it without
      else {
        await Share.share(
          linkLocation,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        );
      }
    } catch (e) {
      // In case of any exception show a dialog only if the screen is currently
      // mounted
      if (context.mounted) {
        showDialogWithOneAction(
          context,
          title: context.loc.error,
          subtitle: context.loc.unexpectedErrorOccurredTryAgain,
          trueActionText: context.loc.ok,
        );
      }
    }
  }
}
