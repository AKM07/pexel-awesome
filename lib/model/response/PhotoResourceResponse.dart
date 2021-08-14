import 'package:json_annotation/json_annotation.dart';

part 'PhotoResourceResponse.g.dart';

@JsonSerializable()
class PhotoResourceResponse {
  String? original;
  String? large2x;
  String? large;
  String? medium;
  String? small;
  String? portrait;
  String? landscape;
  String? tiny;

  Map<String, dynamic> toJson() => _$PhotoResourceResponseToJson(this);

  static PhotoResourceResponse fromJson(Map<String, dynamic> json) =>
      _$PhotoResourceResponseFromJson(json);
}