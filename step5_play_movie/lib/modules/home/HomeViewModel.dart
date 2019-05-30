import 'dart:async';
import 'package:flutter/material.dart';
import 'package:showmax/api/entities/Asset.dart';
import 'package:showmax/modules/home/HomeLoader.dart';

class HomeItem {
  final Asset asset;
  final String title;
  final String imageLink;
  final String imageColor;
  HomeItem({this.asset, this.title, this.imageLink, this.imageColor});
}

class HomeViewModel {
  
  // - Internal properties -

  HomeLoader _loader;
  StreamController<List<HomeItem>> _items;

  // - Public interface -

  HomeViewModel(HomeLoader loader) {
    _loader = loader;
    _items = StreamController<List<HomeItem>>();
    items = _items.stream;
  }

  Stream<List<HomeItem>> items;

  Future load() async {
    try {
      final popular = await _loader.loadPopular();
      final homeItems = popular.map(_makeHomeItemFromAsset).toList();
      _items.add(homeItems);
    } catch (error) {
      print(error);
      _items.addError(error);
    }
  }

  // - Helpers -

  HomeItem _makeHomeItemFromAsset(Asset asset) {
    final image = asset.images.firstWhere((i) => i.type == 'poster' && i.orientation == 'portrait', orElse: () => throw "No image found for $asset");
    final croppedLink = "${image.link}/300x";
    return HomeItem(
      asset: asset,
      title: asset.title,
      imageLink: croppedLink,
      imageColor: image.backgroundColor
    );
  }
}
