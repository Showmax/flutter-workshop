import 'dart:async';

import 'package:mockito/mockito.dart';
import 'package:showmax/api/entities/Asset.dart';
import 'package:showmax/api/entities/Image.dart';
import 'package:showmax/modules/home/HomeLoader.dart';
import 'package:showmax/modules/home/HomeViewModel.dart';
import 'package:test/test.dart';

class HomeLoaderMock extends Mock implements HomeLoader {}

void main() {
  group('home', () {
    test("happy path", () async {
      //instantiate mocks
      final _loaderMock = HomeLoaderMock();
      const TEST_SIZE = 60;
      //instantiate class to test
      HomeViewModel _homeViewModel = HomeViewModel(_loaderMock);
      List<Asset> response = List.generate(
          TEST_SIZE,
          (int index) =>
              Asset(id: "id $index", title: "title $index", images: [Image(type: "poster", orientation: "portrait")]));
      //setup mocks
      Completer<List<Asset>> completer = Completer();
      completer.complete(response);
      when(_loaderMock.loadPopular()).thenAnswer((_) => completer.future);

      // function to test
      _homeViewModel.load();

      var events = await _homeViewModel.items.take(1).toList();
      var event1 = events[0];
      expect(event1.length, TEST_SIZE);
    });

    test("unhappy path", () async {
      //instantiate mocks
      final _loaderMock = HomeLoaderMock();
      //instantiate class to test
      HomeViewModel _homeViewModel = HomeViewModel(_loaderMock);
      //setup mocks
      Completer<List<Asset>> completer = Completer();
      var error = NullThrownError();
      completer.completeError(error);
      when(_loaderMock.loadPopular()).thenAnswer((_) => completer.future);

      // function to test
      _homeViewModel.load();

      expect(_homeViewModel.items, emitsInOrder([emitsError(error)]));
    });
  });
}
