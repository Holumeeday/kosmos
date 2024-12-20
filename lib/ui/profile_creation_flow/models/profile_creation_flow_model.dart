import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/models/activity_interest_groups.dart';

class ProfileCreationFlowModel extends Equatable {
  /// Image upload list
  final List<File?>? profilePicsList;

  /// Date of birth
  final DateTime? dateOfBirth;

  /// Gender
  final GenderEnum? gender;

  /// The interests of the user
  final List<ActivityInterestGroups>? interests;

  /// The latitude
  final double? latitude;

  /// User's location longitude
  final double? longitude;

  /// The radius of coverage in meters
  final double? radius;

  /// The unit of radius: miles or kilometers
  final String? radiusUnits;

  const ProfileCreationFlowModel({
    this.dateOfBirth,
    this.gender,
    this.profilePicsList,
    this.interests,
    this.latitude,
    this.longitude,
    this.radius,
    this.radiusUnits,
  });

  /// To update the info
  ProfileCreationFlowModel copyWith({
    GenderEnum? gender,
    List<File?>? profilePicsList,
    List<ActivityInterestGroups>? interests,
    double? latitude,
    double? longitude,
    double? radius,
    String? radiusUnits,
    DateTime? dateOfBirth,
  }) {
    return ProfileCreationFlowModel(
      gender: gender ?? this.gender,
      profilePicsList: profilePicsList ?? this.profilePicsList,
      interests: interests ?? this.interests,
      latitude: latitude ?? this.latitude,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      longitude: longitude ?? this.longitude,
      radius: radius ?? this.radius,
      radiusUnits: radiusUnits ?? this.radiusUnits,
    );
  }

  @override
  String toString() {
    return 'ProfileCreationFlowModel: {\n'
        '   profilePicsList: ${profilePicsList?.map((e) => e?.path)}, \n'
        '   interests: $interests, \n'
        '   latitude: $latitude, \n'
        '   gender: $gender, \n'
        '   longitude: $longitude, \n'
        '   radius: $radius, \n'
        '   radiusUnits: $radiusUnits, \n'
        '}';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'profile_pictures': profilePicsList,
      'gender': gender,
      'interests': interests,
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius,
      'radius_units': radiusUnits,
    };
  }

  @override
  List<Object?> get props => [
        profilePicsList,
        dateOfBirth,
        gender,
        interests,
        latitude,
        longitude,
        radius,
        radiusUnits,
      ];
}
