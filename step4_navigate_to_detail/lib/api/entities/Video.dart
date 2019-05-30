import 'package:json_annotation/json_annotation.dart';

part 'Video.g.dart';

@JsonSerializable()
class Video {

  @JsonKey(required: true, disallowNullValue: true)
  final String id;
  
  @JsonKey(required: true, disallowNullValue: true)
  final String link;

  @JsonKey(required: true, disallowNullValue: true)
  final String usage;

  Video({
    this.id, 
    this.link,
    this.usage
  });

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
}
