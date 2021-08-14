// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PhotoResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoResponse _$PhotoResponseFromJson(Map<String, dynamic> json) {
  return PhotoResponse()
    ..id = json['id'] as int?
    ..width = json['width'] as int?
    ..height = json['height'] as int?
    ..url = json['url'] as String?
    ..photographer = json['photographer'] as String?
    ..photographerUrl = json['photographer_url'] as String?
    ..photographerId = json['photographer_id'] as int?
    ..avgColor = json['avg_color'] as String?
    ..src = json['src'] == null
        ? null
        : PhotoResourceResponse.fromJson(json['src'] as Map<String, dynamic>)
    ..liked = json['liked'] as bool?;
}

Map<String, dynamic> _$PhotoResponseToJson(PhotoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'width': instance.width,
      'height': instance.height,
      'url': instance.url,
      'photographer': instance.photographer,
      'photographer_url': instance.photographerUrl,
      'photographer_id': instance.photographerId,
      'avg_color': instance.avgColor,
      'src': instance.src?.toJson(),
      'liked': instance.liked,
    };
