import 'dart:io';

import 'package:equatable/equatable.dart';

/// Gender types
enum GenderEnum {
  male,
  female,
  preferNotToSay,
}

class ProfileCreationFlowModel extends Equatable {
  /// Image upload list
  final List<File?>? profilePicsList;

  /// Date of birth
  final DateTime? dateOfBirth;

  /// Gender
  final GenderEnum? gender;

  /// The interests of the user
  final List<String>? interests;

  /// The latitude
  final double? latitude;

  /// User's location longitude
  final double? longitude;

  /// The radius of coverage in meters
  final double? radius;

  /// The unit of radius: miles or kilometers
  final String? radiusUnits;

  /// The location of the user
  final String? location;

  const ProfileCreationFlowModel({
    this.dateOfBirth,
    this.gender,
    this.profilePicsList,
    this.interests,
    this.latitude,
    this.longitude,
    this.radius,
    this.radiusUnits,
    this.location,
  });

  /// To update the info
  ProfileCreationFlowModel copyWith({
    GenderEnum? gender,
    List<File?>? profilePicsList,
    List<String>? interests,
    double? latitude,
    double? longitude,
    double? radius,
    String? radiusUnits,
    String? location,
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
      location: location ?? this.location,
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
        '   location: $location\n'
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
      'location': location,
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
        location,
      ];
}
