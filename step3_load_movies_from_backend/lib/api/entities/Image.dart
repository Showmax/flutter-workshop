import 'package:json_annotation/json_annotation.dart';

part 'Image.g.dart';

@JsonSerializable()
class Image {

  @JsonKey(required: true, disallowNullValue: true)
  final String id;
  
  @JsonKey(required: true, disallowNullValue: true)
  final String link;

  @JsonKey(required: true, disallowNullValue: true)
  final String type;

  @JsonKey(required: true, disallowNullValue: true)
  final String orientation;

  @JsonKey(name: 'background_color', defaultValue: "000000")
  final String backgroundColor;

  @JsonKey(name: 'background_text_color', defaultValue: "FFFFFF")
  final String backgroundTextColor;

  @JsonKey(name: 'button_text_color', defaultValue: "000000")
  final String buttonTextColor;

  @JsonKey(name: 'highlight_color', defaultValue: "FFFFFF")
  final String highlightColor;

  Image({
    this.id, 
    this.link,
    this.type,
    this.orientation,
    this.backgroundColor,
    this.backgroundTextColor,
    this.buttonTextColor,
    this.highlightColor
  }) ;

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}
