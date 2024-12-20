import 'package:playkosmos_v3/extensions/extensions.dart';

/// Gender types
enum GenderEnum {
  male,
  female,
  preferNotToSay;

  factory GenderEnum.fromString(String value) {
    return GenderEnum.values.search((e) => e.name == value) ??
        GenderEnum.preferNotToSay;
  }
}
