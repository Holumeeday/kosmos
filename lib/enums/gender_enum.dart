import 'package:playkosmos_v3/extensions/extensions.dart';

/// Gender types
enum GenderEnum {
  male('male'),
  female('female'),
  preferNotToSay('prefer_not_to_say');

  final String backendName;
  const GenderEnum(this.backendName);

  factory GenderEnum.fromString(String value) {
    return GenderEnum.values.search((e) => e.backendName == value) ??
        GenderEnum.preferNotToSay;
  }
}
