import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/models/flyer_details_model.dart';
import 'package:playkosmos_v3/models/flyer_model.dart';

/*
The flyer portion of the activity
@author: Ugochukwu Umeh
*/
class ActivityFlyerWidget extends StatelessWidget {
  /// The flyer
  final FlyerModel fFlyer;

  /// The properties and their positions on [fFlyer]
  final FlyerDetailsModel fFlyerDetails;

  const ActivityFlyerWidget({
    super.key,
    required this.fFlyer,
    required this.fFlyerDetails,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Stack(
        children: [
          // The flier image
          SvgPicture.network(
            fFlyer.flyerUrl ?? '',
            width: 335,
            height: 335,
            placeholderBuilder: (_) => SizedBox(
              height: 335,
              width: 335,
              child: ColoredBox(
                color: context.colors.tertiary,
              ),
            ),
          ),

          // Title selector
          _PositionText(
            fPosition: fFlyer.positions[0],
            fText: fFlyerDetails.title,
          ),

          // Details selector
          _PositionText(
            fPosition: fFlyer.positions[1],
            fText: fFlyerDetails.details,
          ),

          // Activity Type
          _PositionText(
            fPosition: fFlyer.positions[2],
            fText: context.loc
                .setActivityTypeText(fFlyerDetails.type.checkNullDash),
          ),

          // Activity interest
          _PositionText(
            fPosition: fFlyer.positions[3],
            fText: context.loc
                .setInterestName(fFlyerDetails.interest.checkNullDash),
          ),

          // Duration
          _PositionText(
            fPosition: fFlyer.positions[4],
            fText: fFlyerDetails.duration.checkNullDash,
          ),

          // Date
          _PositionText(
            fPosition: fFlyer.positions[5],
            fText:
                fFlyerDetails.dateTime.convertToString('yMMMMd').checkNullDash,
          ),

          // Time
          _PositionText(
            fPosition: fFlyer.positions[6],
            fText: fFlyerDetails.dateTime.getTimeZoneOffset().checkNullDash,
          ),

          // City
          _PositionText(
            fPosition: fFlyer.positions[7],
            fText: fFlyerDetails.city,
          ),

          // Country
          _PositionText(
            fPosition: fFlyer.positions[8],
            fText: fFlyerDetails.country,
          ),

          // Venue selector
          _PositionText(
            fPosition: fFlyer.positions[9],
            fText: context.loc.setVenueText(fFlyerDetails.venue.checkNullDash),
          ),

          // Price
          _PositionText(
            fPosition: fFlyer.positions[10],
            fText: fFlyerDetails.price,
          ),

          // Changeable Image
          _PositionImage(
            fImagePosition: fFlyer.imagePosition,
          ),
        ],
      ),
    );
  }
}

/*
This class defines the positioning of a flier property excluding image
@author: Ugochukwu Umeh
*/
class _PositionText extends StatelessWidget {
  /// The positioned model of the property
  final ParameterPosition fPosition;

  ///The text to display
  final String? fText;

  const _PositionText({
    required this.fPosition,
    required this.fText,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: fPosition.top,
      left: fPosition.left,
      right: fPosition.right,
      child: Transform.rotate(
        angle: fPosition.angle,
        child: Row(
          mainAxisAlignment: fPosition.rowAlign,
          children: [
            Flexible(
              child: MediaQuery.withNoTextScaling(
                child: Text(
                  fText.checkNullDash,
                  maxLines: fPosition.lines,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: fPosition.fontFamily,
                    fontWeight: fPosition.fontWeight,
                    fontSize: fPosition.fontSize,
                    color: fPosition.fontColour,
                    fontStyle: fPosition.fontStyle,
                  ),
                  textAlign: fPosition.textAlign,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
For positioning the image of the flyer
@author: Ugochukwu Umeh
*/
class _PositionImage extends StatelessWidget {
  /// The positioned model of the property
  final ParameterImagePosition? fImagePosition;

  const _PositionImage({required this.fImagePosition});

  @override
  Widget build(BuildContext context) {
    if (fImagePosition == null) {
      return const SizedBox();
    }
    return Positioned(
      top: fImagePosition!.top,
      left: fImagePosition!.left,
      right: fImagePosition!.right,
      height: fImagePosition!.height,
      child: Transform.rotate(
        angle: fImagePosition!.angle,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            shape: fImagePosition!.boxShape,
          ),
          child: BaseCachedNetworkImage(
            fImage: fImagePosition!.image ?? fImagePosition!.placeholderImage,
          ),
        ),
      ),
    );
  }
}
