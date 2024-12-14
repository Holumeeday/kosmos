class FlyerDetailsModel {
  final String? title;
  final String? details;
  final String? type;
  final String? interest;
  final DateTime? dateTime;
  final String? duration;
  final String? venue;
  final String? city;
  final String? country;
  final String? price;

  const FlyerDetailsModel({
    this.title,
    this.details,
    this.type,
    this.interest,
    this.dateTime,
    this.duration,
    this.venue,
    this.city,
    this.country,
    this.price,
});

  factory FlyerDetailsModel.fromJson(Map<String, dynamic> json){
    return FlyerDetailsModel(
      title: json['title'] as String?,
      details: json['details'] as String?,
      type: json['type'] as String?,
      interest: json['interest'] as String?,
      dateTime: DateTime.tryParse(json['dateTime'] as String? ?? '')?.toLocal(),
      duration: json['duration'] as String?,
      venue: json['venue'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      price: json['price'] as String?,
    );
  }
}