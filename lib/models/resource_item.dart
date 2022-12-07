
import 'package:json_annotation/json_annotation.dart';
part 'resource_item.g.dart';

@JsonSerializable()
class ResourceItem {

  String id;
  String name;
  String worksheetId;
  String url;
  String svgContent;

  String fontFamily;
  String fontColor;
  double fontSize;

  double x;
  double y;
  double rotation;
  double width;
  double height;

  ResourceItem({ 
    required this.id, 
    required this.name, 
    required this.fontColor, 
    required this.fontFamily, 
    required this.fontSize, 
    required this.x, 
    required this.y, 
    required this.rotation, 
    required this.width, 
    required this.height, 
    required this.url, 
    required this.svgContent, 
    required this.worksheetId, 
  });

  factory ResourceItem.fromJson(Map<String, dynamic> json) => _$ResourceItemFromJson(json);

  Map<String, dynamic> toJson() => _$ResourceItemToJson(this);
}