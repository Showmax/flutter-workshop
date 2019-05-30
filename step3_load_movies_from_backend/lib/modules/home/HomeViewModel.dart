import 'dart:async';
import 'package:showmax/modules/home/HomeLoader.dart';
import 'package:showmax/api/entities/Asset.dart';

// Holds content for each grid tile
class HomeItem {
  final String title;
  final String imageLink;
  final String imageColor;
  HomeItem({this.title, this.imageLink, this.imageColor});
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

  // TODO #4: Fill view entity with real content

  void load() {
    _loader.loadPopular();
    var events = List<HomeItem>();
    for (var i = 1; i <= 100; i++) {
      events.add(_makeHomeItem(i));
    }
    _items.add(events);
  }

  HomeItem _makeHomeItem(int index) {
    return HomeItem(
      title: "Item #$index",
      imageLink: "https://picsum.photos/300/450?item-$index",
      imageColor: "FFA500",
    );
  }

  // SOLUTION #4:
  // Future load() async {
  //   try {
  //     final popular = await _loader.loadPopular();
  //     final homeItems = popular.map(_makeHomeItemFromAsset).toList();
  //     _items.add(homeItems);
  //   } catch (error) {
  //     _items.addError(error);
  //   }
  // }

  // HomeItem _makeHomeItemFromAsset(Asset asset) {
  //   final image = asset.images.firstWhere((i) => i.type == 'poster' && i.orientation == 'portrait');
  //   if (image == null) {
  //     throw "No image found for $asset";
  //   }
  //   final croppedLink = "${image.link}/300x";
  //   return HomeItem(
  //     title: asset.title,
  //     imageLink: croppedLink,
  //     imageColor: image.backgroundColor
  //   );
  // }
}
