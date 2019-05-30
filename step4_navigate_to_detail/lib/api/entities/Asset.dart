
import 'package:json_annotation/json_annotation.dart';
import 'package:showmax/api/entities/Image.dart';
import 'package:showmax/api/entities/Video.dart';
part 'Asset.g.dart';

@JsonSerializable()
class Asset {
  @JsonKey(required: true, disallowNullValue: true)
  final String id;
  @JsonKey(required: true, disallowNullValue: true)
  final String title;
  @JsonKey(defaultValue: [])
  List<Image> images;
  @JsonKey(defaultValue: [])
  List<Video> videos;
  @JsonKey(defaultValue: "")
  final String description; 
  
  Asset({
    this.id, 
    this.title,
    this.images,
    this.videos,
    this.description,
  });

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
}