
import 'package:json_annotation/json_annotation.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/functional/config.dart';

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

  int type;

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
    required this.type, 
  });

  factory ResourceItem.fromJson(Map<String, dynamic> json) => _$ResourceItemFromJson(json);

  Map<String, dynamic> toJson() => _$ResourceItemToJson(this);

  factory ResourceItem.init(String worksheetId) {
    return ResourceItem(
      id: '',
      fontColor: '#000000',
      fontFamily: '',
      fontSize: 0,
      height: 50,
      width: 100,
      name: 'Add a text',
      rotation: 0,
      type: FunctionalID.text.index,
      svgContent: '',
      url: '',
      worksheetId: worksheetId,
      x: 0,
      y: 0
    );
  }

  factory ResourceItem.createText(double size, String worksheetId) {
    return ResourceItem(
      id: '',
      fontColor: '#000000',
      fontFamily: '',
      fontSize: size,
      height: 50,
      width: 100,
      name: 'Add a text',
      rotation: 0,
      type: FunctionalID.text.index,
      svgContent: '',
      url: '',
      worksheetId: worksheetId,
      x: 0,
      y: 0
    );
  }

  factory ResourceItem.copyWith(ResourceItem item) {
    return ResourceItem(
      id: item.id,
      fontColor: item.fontColor,
      fontFamily: item.fontFamily,
      fontSize: item.fontSize,
      height: item.height,
      width: item.width,
      name: item.name,
      rotation: item.rotation,
      type: item.type,
      svgContent: item.svgContent,
      url: item.url,
      worksheetId: item.worksheetId,
      x: item.x,
      y: item.y
    );
  }

  factory ResourceItem.createShape(String imageUrl, String worksheetId) {
    return ResourceItem(
      id: '',
      fontColor: '#000000',
      fontFamily: '',
      fontSize: 0,
      height: 100,
      width: 100,
      name: 'Add a text',
      rotation: 0,
      type: FunctionalID.shapes.index,
      svgContent: '',
      url: imageUrl,
      worksheetId: worksheetId,
      x: 0,
      y: 0
    );
  }
}