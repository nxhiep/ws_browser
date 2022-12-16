// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worksheet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Worksheet _$WorksheetFromJson(Map<String, dynamic> json) => Worksheet(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      totalPages: json['totalPages'] as int,
      type: json['type'] as int,
      thumbnail: json['thumbnail'] as String,
    );

Map<String, dynamic> _$WorksheetToJson(Worksheet instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'totalPages': instance.totalPages,
      'type': instance.type,
      'thumbnail': instance.thumbnail,
    };
