import 'dart:async';

// TODO #2: Investigate the view model. Look on its output (items) and input (load method).

// Holds content for each grid tile
class HomeItem {
  final String title;
  final String imageLink;
  final String imageColor;
  HomeItem({this.title, this.imageLink, this.imageColor});
}

class HomeViewModel {
  
  // - Internal properties -

  StreamController<List<HomeItem>> _items;

  // - Public interface -

  HomeViewModel() {
    _items = StreamController<List<HomeItem>>();
    items = _items.stream;
  }

  // Output: Produces asynchronously either items or error
  Stream<List<HomeItem>> items;

  // Input: Ask to load home items and forward them to the stream.
  void load() {
    var events = List<HomeItem>();
    for (var i = 1; i <= 100; i++) {
      events.add(_makeHomeItem(i));
    }
    _items.add(events);
    // TODO #5: Try producing error into items stream
    // _items.addError("Wrong JSON format");
  }

  HomeItem _makeHomeItem(int index) {
    return HomeItem(
      title: "Item #$index",
      imageLink: "https://picsum.photos/300/450?item-$index",
      imageColor: "FFA500",
    );
  }
}
