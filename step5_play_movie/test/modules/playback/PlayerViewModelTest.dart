import 'dart:async';

import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:showmax/api/API.dart';
import 'package:showmax/api/entities/Video.dart';
import 'package:showmax/modules/player/PlayerViewModel.dart';
import 'package:test/test.dart';

class ApiMock extends Mock implements API {}

void main() {
  group('player', () {
    test("happy path", () async {
      //instantiate mocks
      final _apiMock = ApiMock();
      const TEST_ASSET_ID = "test asset id";
      const TEST_URL = "test url";
      //instantiate class to test
      PlayerViewModel _playerViewModel = PlayerViewModel(Video(), _apiMock);
      Response response = Response("{\"asset_id\":\"$TEST_ASSET_ID\", \"url\":\"$TEST_URL\"}", 200);
      //setup mocks
      Completer<Response> completer = Completer();
      completer.complete(response);
      when(_apiMock.directGet(any)).thenAnswer((_) => completer.future);

      // function to test
      _playerViewModel.load();

      var events = await _playerViewModel.content.take(1).toList();
      var event1 = events[0];
      expect(event1.url, TEST_URL);
      expect(event1.id, TEST_ASSET_ID);
    });

    test("unhappy path", () async {
      //instantiate mocks
      final _apiMock = ApiMock();
      //instantiate class to test
      PlayerViewModel _playerViewModel = PlayerViewModel(Video(), _apiMock);
      //setup mocks
      Completer<Response> completer = Completer();
      var error = NullThrownError();
      completer.completeError(error);
      when(_apiMock.directGet(any)).thenAnswer((_) => completer.future);

      // function to test
      _playerViewModel.load();

      expect(_playerViewModel.content, emitsInOrder([emitsError(error)]));
    });
  });
}
