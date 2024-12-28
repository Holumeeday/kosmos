class GenericResponse {
  bool status;
  String message;
  dynamic data;

  GenericResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory GenericResponse.fromJson(Map<dynamic, dynamic> json) {
    return GenericResponse(
      status: json['status'] == 'success',
      message: json['status'] != 'success'
          ? (json['error'] ?? json['data']['error']) as String
          : '',
      data: json['data'] as Map?,
    );
  }
}
