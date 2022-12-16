// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resource_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResourceItem _$ResourceItemFromJson(Map<String, dynamic> json) => ResourceItem(
      id: json['id'] as String,
      name: json['name'] as String,
      fontColor: json['fontColor'] as String,
      fontFamily: json['fontFamily'] as String,
      fontSize: (json['fontSize'] as num).toDouble(),
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      rotation: (json['rotation'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      url: json['url'] as String,
      svgContent: json['svgContent'] as String,
      worksheetId: json['worksheetId'] as String,
      type: json['type'] as int,
      page: json['page'] as int,
    );

Map<String, dynamic> _$ResourceItemToJson(ResourceItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'worksheetId': instance.worksheetId,
      'url': instance.url,
      'svgContent': instance.svgContent,
      'fontFamily': instance.fontFamily,
      'fontColor': instance.fontColor,
      'fontSize': instance.fontSize,
      'page': instance.page,
      'x': instance.x,
      'y': instance.y,
      'rotation': instance.rotation,
      'width': instance.width,
      'height': instance.height,
      'type': instance.type,
    };
