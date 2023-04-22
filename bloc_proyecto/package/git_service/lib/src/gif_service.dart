import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;


class GifService {

  GifService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;
  final String baseUrl = "api.giphy.com";
  final String endPoint = '/v1/gifs/trending'; //TODO: no entendi bien esta linea
  final String apiKey = 'LQeY3ExBj3UZ4VZnv6HlAkPVHgIlaoMv'; //TODO:  no entendi bien esta linea

  Future<List<String>> fetchGifs() async {
    final uri = Uri.http(baseUrl, endPoint, {'api_key': apiKey});

    http.Response response;
    List body;
    try {
      response = await _httpClient.get(uri);
    } on Exception {
      throw Exception();
    }
    if (response.statusCode != 200) {
      throw HttpRequestException();
    }
    try {
      body = jsonDecode(response.body)['data'] as List;
    } on Exception {
      throw JsonDecodeException();
    }
    return body
        .map((url) => url['images']['original']['url'].toString())
        .toList();
  }
}

class HttpRequestException implements Exception {}

class JsonDecodeException implements Exception {}

