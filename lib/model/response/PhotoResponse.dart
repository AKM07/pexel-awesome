import 'package:json_annotation/json_annotation.dart';

import 'PhotoResourceResponse.dart';

part 'PhotoResponse.g.dart';

@JsonSerializable(explicitToJson: true)
class PhotoResponse {
  int? id;
  int? width;
  int? height;
  String? url;
  String? photographer;
  @JsonKey(name: "photographer_url")
  String? photographerUrl;
  @JsonKey(name: "photographer_id")
  int? photographerId;
  @JsonKey(name: "avg_color")
  String? avgColor;
  PhotoResourceResponse? src;
  bool? liked;

  Map<String, dynamic> toJson() => _$PhotoResponseToJson(this);

  static PhotoResponse fromJson(Map<String, dynamic> json) =>
      _$PhotoResponseFromJson(json);
}