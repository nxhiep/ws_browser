
import 'package:json_annotation/json_annotation.dart';
part 'worksheet.g.dart';

@JsonSerializable()
class Worksheet {

  String id;
  String title;
  String description;
  int totalPages;
  int type;
  String thumbnail;

  Worksheet({ 
    required this.id, 
    required this.title, 
    required this.description, 
    required this.totalPages, 
    required this.type, 
    required this.thumbnail, 
  });

  factory Worksheet.fromJson(Map<String, dynamic> json) => _$WorksheetFromJson(json);

  Map<String, dynamic> toJson() => _$WorksheetToJson(this);
}