import 'dart:async';
import 'package:showmax/api/entities/Image.dart';
import 'package:showmax/api/entities/Asset.dart';
import 'package:showmax/api/entities/Video.dart';

// Entity

class Detail {
  final Asset asset;
  final String imageLink;
  final String backgroundColor;
  final String foregroundColor;
  final String highlightColor;
  final String highlightContrastColor;
  final String title;
  final Video watchButtonVideo;
  Detail({
    this.asset,
    this.imageLink, 
    this.backgroundColor, 
    this.foregroundColor, 
    this.highlightColor,
    this.highlightContrastColor,
    this.title,
    this.watchButtonVideo
  });
}

// View model

class DetailViewModel {

  // - Internal properties - 

  Asset _asset;
  StreamController<Detail> _content;
  
  // - Public interface - 

  Stream<Detail> content;  

  DetailViewModel(Asset asset) {
    _asset = asset;
    _content = StreamController<Detail>();
    content = _content.stream;
    try {
      final detail = _detailFromAsset(_asset);
      _content.add(detail);
    } catch (error) {
      _content.addError(error);
    }
  }

  // - Helpers - 
  
  Detail _detailFromAsset(Asset asset) {
    final image = _image(asset);
    if (image == null) {
      throw "No image for asset.";
    }
    return Detail(
      asset: asset,
      backgroundColor: image.backgroundColor,
      foregroundColor: image.backgroundTextColor,
      highlightColor: image.highlightColor,
      highlightContrastColor: image.buttonTextColor,
      imageLink: image.link,
      title: asset.title,
      watchButtonVideo: _firstTrailerFor(asset.videos)
    );
  }

  Image _image(Asset asset) {
    return asset.images.firstWhere((i) => i.type == 'background' && i.orientation == 'landscape')
                  ?? asset.images.firstWhere((i) => i.type == 'poster' && i.orientation == 'portrait');
  }

  Video _firstTrailerFor(List<Video> videos) {
    return videos.firstWhere((v) => v.usage == "trailer", orElse: (){});
  }
}