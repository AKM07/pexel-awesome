import 'package:awesome/constants/Constants.dart';
import 'package:awesome/constants/UrlConstants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() async {
  final dio = Dio(BaseOptions(
      baseUrl: UrlConstants.BASE_URL,
      connectTimeout: 60000,
      receiveTimeout: 3000,
      headers: {"Authorization": Constants.pexelApiKey}));
  final dioAdapter = DioAdapter(dio: dio);

  dio.httpClientAdapter = dioAdapter;

  test('Get Photos test', () async {
    const path = UrlConstants.GET_PHOTOS_URL;
    const photoData = <String, dynamic>{
      'page': 1,
      'per_page': 1,
      'photos': <String, dynamic>{
        "id": 2425232,
        "width": 1699,
        "height": 2550,
        "url": "https://www.pexels.com/photo/art-dark-pattern-texture-2425232/",
        "photographer": "Stacey Gabrielle Koenitz Rozells",
        "photographer_url": "https://www.pexels.com/@goldcircuits",
        "photographer_id": 1272132,
        "avg_color": "#272727",
        "src": <String, dynamic>{
          "original":
              "https://images.pexels.com/photos/2425232/pexels-photo-2425232.jpeg",
          "large2x":
              "https://images.pexels.com/photos/2425232/pexels-photo-2425232.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
          "large":
              "https://images.pexels.com/photos/2425232/pexels-photo-2425232.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
          "medium":
              "https://images.pexels.com/photos/2425232/pexels-photo-2425232.jpeg?auto=compress&cs=tinysrgb&h=350",
          "small":
              "https://images.pexels.com/photos/2425232/pexels-photo-2425232.jpeg?auto=compress&cs=tinysrgb&h=130",
          "portrait":
              "https://images.pexels.com/photos/2425232/pexels-photo-2425232.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
          "landscape":
              "https://images.pexels.com/photos/2425232/pexels-photo-2425232.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
          "tiny":
              "https://images.pexels.com/photos/2425232/pexels-photo-2425232.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
        },
        "liked": false
      },
    };

    dioAdapter.onGet(
      path,
      (server) => server.reply(200, photoData),
    );
    final onGetResponse = await dio.get(path, queryParameters: {'page': 1, 'per_page': 1} );
    expect(onGetResponse.statusCode, 200);
  });
}
