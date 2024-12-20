import 'dart:convert';

import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/models/activity_interest_groups.dart';
import 'package:playkosmos_v3/models/location_model.dart';

class UserModel {
  final UserDataModel? data;

  UserModel({
    this.data,
  });

  UserModel copyWith({
    UserDataModel? data,
  }) =>
      UserModel(
        data: data ?? this.data,
      );

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        data: json["data"] == null ? null : UserDataModel.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class UserDataModel {
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
  final int? searchRadius;

  UserDataModel({
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

  UserDataModel copyWith({
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
    int? searchRadius,
  }) =>
      UserDataModel(
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

  factory UserDataModel.fromJson(String str) =>
      UserDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserDataModel.fromMap(Map<String, dynamic> json) => UserDataModel(
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

  Map<String, dynamic> toMap() => {
        "id": id,
        "fullName": fullName,
        "email": email,
        "phone": phone,
        "emailVerified": emailVerified,
        "phoneVerified": phoneVerified,
        "bio": bio,
        "pictures":
            pictures == null ? [] : List<dynamic>.from(pictures!.map((x) => x)),
        if (birthday != null)
          "birthday":
              "${birthday!.year.toString().padLeft(4, '0')}-${birthday!.month.toString().padLeft(2, '0')}-${birthday!.day.toString().padLeft(2, '0')}",
        "gender": gender?.name,
        "interests": interests?.toJson(),
        "locations": locations?.toMap(),
        "searchRadius": searchRadius,
      };
}
