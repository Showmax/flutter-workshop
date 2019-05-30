import 'package:json_annotation/json_annotation.dart';

part 'PlaybackPlay.g.dart';

@JsonSerializable()
class PlaybackPlay {

  @JsonKey(name: "asset_id", required: true, disallowNullValue: true)
  final String id;
  
  @JsonKey(required: true, disallowNullValue: true)
  final String url;

  PlaybackPlay({
    this.id, 
    this.url,
  });

  factory PlaybackPlay.fromJson(Map<String, dynamic> json) => _$PlaybackPlayFromJson(json);
}
