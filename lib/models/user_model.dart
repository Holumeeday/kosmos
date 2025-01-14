import 'dart:convert';

import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/models/activity_interest_groups.dart';
import 'package:playkosmos_v3/models/location_model.dart';

class UserModel {
  final String? id;
  final String? fullName;
  final String? email;
  final String? phone;
  final bool? emailVerified;
  final bool? phoneVerified;
  final String? bio;
  final List<String>? pictures;
  final DateTime? birthday;
  final GenderEnum? gender;
  final ActivityInterestGroupsList? interests;
  final Locations? locations;
  final double? searchRadius;

  UserModel({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.emailVerified,
    this.phoneVerified,
    this.bio,
    this.pictures,
    this.birthday,
    this.gender,
    this.interests,
    this.locations,
    this.searchRadius,
  });

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    bool? emailVerified,
    bool? phoneVerified,
    String? bio,
    List<String>? pictures,
    DateTime? birthday,
    GenderEnum? gender,
    ActivityInterestGroupsList? interests,
    Locations? locations,
    double? searchRadius,
  }) =>
      UserModel(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        emailVerified: emailVerified ?? this.emailVerified,
        phoneVerified: phoneVerified ?? this.phoneVerified,
        bio: bio ?? this.bio,
        pictures: pictures ?? this.pictures,
        birthday: birthday ?? this.birthday,
        gender: gender ?? this.gender,
        interests: interests ?? this.interests,
        locations: locations ?? this.locations,
        searchRadius: searchRadius ?? this.searchRadius,
      );

  String toJson() => json.encode(toMap());

  factory UserModel.fromMapLocal(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        fullName: json["fullName"],
        email: json["email"],
        phone: json["phone"],
        emailVerified: json["emailVerified"],
        phoneVerified: json["phoneVerified"],
        bio: json["bio"],
        pictures: json["pictures"] == null
            ? []
            : List<String>.from(json["pictures"]!.map((x) => x)),
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        gender: json["gender"] != null
            ? GenderEnum.fromString(json['gender'])
            : null,
        interests: json["interests"] == null
            ? null
            : ActivityInterestGroupsList.fromJson(json["interests"]),
        locations: json["locations"] == null
            ? null
            : Locations.fromMap(json["locations"]),
        searchRadius: json["searchRadius"],
      );

  factory UserModel.fromMapRemote(Map<String, dynamic> json) => UserModel(
        id: json['data']["id"],
        fullName: json['data']["fullName"],
        email: json['data']["email"],
        phone: json['data']["phone"],
        emailVerified: json['data']["emailVerified"],
        phoneVerified: json['data']["phoneVerified"],
        bio: json['data']["bio"],
        pictures: json['data']["pictures"] == null
            ? []
            : List<String>.from(json['data']["pictures"]!.map((x) => x)),
        birthday: json['data']["birthday"] == null
            ? null
            : DateTime.parse(json['data']["birthday"]),
        gender: json['data']["gender"] != null
            ? GenderEnum.fromString(json['data']['gender'])
            : null,
        interests: json['data']["interests"] == null
            ? null
            : ActivityInterestGroupsList.fromJson(json['data']["interests"]),
        locations: json['data']["locations"] == null
            ? null
            : Locations.fromMap(json['data']["locations"]),
        searchRadius: json['data']["searchRadius"],
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id,
        if (fullName != null) "fullName": fullName,
        if (email != null) "email": email,
        if (phone != null) "phone": phone,
        if (emailVerified != null) "emailVerified": emailVerified,
        if (phoneVerified != null) "phoneVerified": phoneVerified,
        if (bio != null) "bio": bio,
        if (pictures != null)
          "pictures": List<dynamic>.from(pictures!.map((x) => x)),
        if (birthday != null)
          "birthday":
              "${birthday!.year.toString().padLeft(4, '0')}-${birthday!.month.toString().padLeft(2, '0')}-${birthday!.day.toString().padLeft(2, '0')}",
        if (gender != null) "gender": gender?.backendName,
        if (interests != null) "interests": interests?.toJson(),
        if (locations != null) "locations": locations?.toMap(),
        if (searchRadius != null) "searchRadius": searchRadius,
      };
}
