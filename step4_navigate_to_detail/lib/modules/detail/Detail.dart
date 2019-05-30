import 'dart:async';
import 'package:showmax/api/entities/Image.dart';
import 'package:showmax/api/entities/Asset.dart';
import 'package:showmax/api/entities/Video.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:showmax/helpers/HexColor.dart';

// Entity

class Detail {
  final Asset asset;
  final String imageLink;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color highlightColor;
  final Color highlightContrastColor;
  final String title;
  final Video watchButtonVideo;
  final String description;

  Detail({
    this.asset,
    this.imageLink, 
    this.backgroundColor, 
    this.foregroundColor, 
    this.highlightColor,
    this.highlightContrastColor,
    this.title,
    this.watchButtonVideo,
    this.description
  });

  factory Detail.from(Asset asset) {
    final image = _image(asset);
    if (image == null) {
      return null;
    }
    return Detail(
        asset: asset,
        backgroundColor: HexColor(image.backgroundColor),
        foregroundColor: HexColor(image.backgroundTextColor),
        highlightColor: HexColor(image.highlightColor),
        highlightContrastColor: HexColor(image.buttonTextColor),
        imageLink: image.link,
        title: asset.title,
        watchButtonVideo: _firstTrailerFor(asset.videos),
        description: asset.description
    );
  }
}

// - Helpers -

Image _image(Asset asset) {
  return asset.images.firstWhere((i) => i.type == 'background' && i.orientation == 'landscape')
      ?? asset.images.firstWhere((i) => i.type == 'poster' && i.orientation == 'portrait');
}

Video _firstTrailerFor(List<Video> videos) {
  return videos.firstWhere((v) => v.usage == "trailer", orElse: (){});
}
