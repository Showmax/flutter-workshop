import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

// TODO #1: Investigate shared code for each loader

class API {

  String basePath;

  API() {
    basePath = Platform.isAndroid 
                ? "https://api.showmax.com/v115.0/android" 
                : "https://api.showmax.com/v115.0/ios";
  }

  Future<http.Response> get(String endpoint) {
    final url = [basePath, endpoint].join('/');
    print("Requesting $url");
    return http.get(url);
  }
}