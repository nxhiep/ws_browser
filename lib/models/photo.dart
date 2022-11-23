
import 'package:json_annotation/json_annotation.dart';
part 'photo.g.dart';

@JsonSerializable()
class Photo {

  String id;
  Map<String, String> urls;
  Map<String, String> links;

  double width;
  double height;

  Photo({ 
    required this.id, 
    required this.urls, 
    required this.links, 
    required this.width, 
    required this.height, 
  });

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);

  String getImage() => urls['full'] ?? "";
}