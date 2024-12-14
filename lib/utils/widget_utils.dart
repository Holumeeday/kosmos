import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Utility class for dealing with widgets
/// author: Godwin Mathias

class WidgetUtil {
  /// Takes the screenshot of a widget
  static Future<Uint8List> screenshot({
    // The global key passed to the widget
    required GlobalKey widgetKey,
    // The width and height should be between 200 and 400 for best result
    int fWidth = 200,
    int fHeight = 200,
  }) async {
    RenderRepaintBoundary boundary =
        widgetKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    double devicePixelRatio =
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    final size = boundary.size;
    int width = (fWidth * devicePixelRatio).toInt();
    int height = (fHeight * devicePixelRatio).toInt();

    final scaleFactor = min(
      width / size.width,
      height / size.height,
    );
    final image = await boundary.toImage(pixelRatio: scaleFactor);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    return pngBytes;
  }
}
