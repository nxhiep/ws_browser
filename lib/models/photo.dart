
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

  String getImageRaw() => urls['raw'] ?? "";
  String getImageFull() => urls['full'] ?? "";
  String getImageThumb() => urls['thumb'] ?? "";
  String getImageSmall() => urls['small'] ?? "";
  String getImageRegular() => urls['regular'] ?? "";

  String getLinkSelf() => links['self'] ?? "";
  String getLinkHTML() => urls['html'] ?? "";
  String getLinkDownload() => urls['download'] ?? "";
  String getLinkDownLoadLocation() => urls['download_location'] ?? "";
}