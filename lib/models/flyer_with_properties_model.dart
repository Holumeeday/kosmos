import 'package:playkosmos_v3/models/flyer_positioning_model.dart';
import 'package:playkosmos_v3/models/home_activity_model.dart';

class FlyerWithPropertiesModel {
  final FlyerPositioning flyer;
  final ActivityFlyerProperties flyerProperties;

  const FlyerWithPropertiesModel({
    required this.flyer,
    required this.flyerProperties,
  });
}
