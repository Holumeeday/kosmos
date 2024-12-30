import 'dart:convert';

class FileUploadPartModel {
  final List<FileUploadUrl>? url;

  FileUploadPartModel({
    this.url,
  });

  FileUploadPartModel copyWith({
    List<FileUploadUrl>? url,
  }) =>
      FileUploadPartModel(
        url: url ?? this.url,
      );

  factory FileUploadPartModel.fromJson(String str) =>
      FileUploadPartModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FileUploadPartModel.fromMap(Map<String, dynamic> json) =>
      FileUploadPartModel(
        url: json["url"] == null
            ? []
            : List<FileUploadUrl>.from(
                json["url"]!.map((x) => FileUploadUrl.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "url":
            url == null ? [] : List<dynamic>.from(url!.map((x) => x.toMap())),
      };
}

class FileUploadUrl {
  final String? filePath;
  final String? uploadUrl;
  final String? fileUrl;

  FileUploadUrl({
    this.filePath,
    this.uploadUrl,
    this.fileUrl,
  });

  FileUploadUrl copyWith({
    String? filePath,
    String? uploadUrl,
    String? fileUrl,
  }) =>
      FileUploadUrl(
        filePath: filePath ?? this.filePath,
        uploadUrl: uploadUrl ?? this.uploadUrl,
        fileUrl: fileUrl ?? this.fileUrl,
      );

  factory FileUploadUrl.fromJson(String str) =>
      FileUploadUrl.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FileUploadUrl.fromMap(Map<String, dynamic> json) => FileUploadUrl(
        filePath: json["filePath"],
        uploadUrl: json["uploadUrl"],
        fileUrl: json["fileUrl"],
      );

  Map<String, dynamic> toMap() => {
        "filePath": filePath,
        "uploadUrl": uploadUrl,
        "fileUrl": fileUrl,
      };
}
