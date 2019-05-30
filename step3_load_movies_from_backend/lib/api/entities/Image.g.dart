// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Image _$ImageFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['id', 'link', 'type', 'orientation'],
      disallowNullValues: const ['id', 'link', 'type', 'orientation']);
  return Image(
      id: json['id'] as String,
      link: json['link'] as String,
      type: json['type'] as String,
      orientation: json['orientation'] as String,
      backgroundColor: json['background_color'] as String ?? '000000',
      backgroundTextColor: json['background_text_color'] as String ?? 'FFFFFF',
      buttonTextColor: json['button_text_color'] as String ?? '000000',
      highlightColor: json['highlight_color'] as String ?? 'FFFFFF');
}

Map<String, dynamic> _$ImageToJson(Image instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('link', instance.link);
  writeNotNull('type', instance.type);
  writeNotNull('orientation', instance.orientation);
  val['background_color'] = instance.backgroundColor;
  val['background_text_color'] = instance.backgroundTextColor;
  val['button_text_color'] = instance.buttonTextColor;
  val['highlight_color'] = instance.highlightColor;
  return val;
}
