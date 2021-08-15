import 'package:awesome/constants/UrlConstants.dart';
import 'package:awesome/model/response/BaseResponse.dart';
import 'package:awesome/model/response/PhotoResponse.dart';
import 'package:awesome/utils/injector.dart';
import 'package:dio/dio.dart';

class PhotoRepository {
  final Dio dio = locator<Dio>();

  Future<BaseResponse<PhotoResponse>> doGetPhoto(int page,
      int rowsPage) async {
    try {
      dio.options.contentType = "application/json";
      Response response =
      await dio.get(UrlConstants.GET_PHOTOS_URL,
          queryParameters: {'page': page, 'per_page': rowsPage});

      return BaseResponse<PhotoResponse>.fromJson(
          response.data, PhotoResponse.fromJson);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse<PhotoResponse>.withError("$error");
    }
  }
}