
import 'package:json_annotation/json_annotation.dart';
part 'worksheet.g.dart';

@JsonSerializable()
class Worksheet {

  String id;
  String title;
  String description;

  Worksheet({ 
    required this.id, 
    required this.title, 
    required this.description, 
  });

  factory Worksheet.fromJson(Map<String, dynamic> json) => _$WorksheetFromJson(json);

  Map<String, dynamic> toJson() => _$WorksheetToJson(this);
}