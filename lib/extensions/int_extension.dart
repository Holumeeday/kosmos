///int extensions
extension IntExtension on int {
  ///Gets the duration of a video and converts it into minute:second format
  String getVideoDuration() {
    final Duration duration = Duration(seconds: this);
    final String minute = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final String second = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minute:$second';
  }
}
