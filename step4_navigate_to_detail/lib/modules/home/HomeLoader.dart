import 'dart:async';
import 'dart:convert';
import 'package:showmax/api/API.dart';
import 'package:showmax/api/entities/Asset.dart';

class HomeLoader {
  final API _api;
  HomeLoader(this._api);

  Future<List<Asset>> loadPopular() async {
    final response = await _api.get('catalogue/grossing');
    final popular = _decodeAssets(json.decode(response.body));
    return popular;
  }

  List<Asset> _decodeAssets(Map<String, dynamic> json)  {
    return (json['items'] as List)
          ?.map((item) =>
              item == null ? null : Asset.fromJson(item as Map<String, dynamic>))
          ?.toList()
          ?? <Asset>[];
  }
}