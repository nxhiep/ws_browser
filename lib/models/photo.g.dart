// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo(
      id: json['id'] as String,
      urls: Map<String, String>.from(json['urls'] as Map),
      links: Map<String, String>.from(json['links'] as Map),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
    );

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'id': instance.id,
      'urls': instance.urls,
      'links': instance.links,
      'width': instance.width,
      'height': instance.height,
    };
