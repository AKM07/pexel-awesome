import '../LoadApiStatus.dart';

class BaseResponse<T> {
  int? page;
  int? per_page;
  List<T>? photos;
  int? total_results;
  String? next_page;
  LoadApiStatus? loadStatus;

  BaseResponse({this.page, this.per_page, this.photos, this.total_results, this.next_page});

  BaseResponse.loading() : loadStatus = LoadApiStatus.LOADING;
  BaseResponse.completed(this.photos) : loadStatus = LoadApiStatus.COMPLETED;
  BaseResponse.error() : loadStatus = LoadApiStatus.ERROR;

  factory BaseResponse.fromJson(
      Map<String, dynamic> jsonData, Function fromJson) {
    final items = jsonData['photos'];

    List<T> output = [];

    if (items is Iterable) {
      for (Map<String, dynamic> json in items) {
        output.add(fromJson(json));
      }
    } else {
      output.add(fromJson(items));
    }

    return BaseResponse<T>(
      page: jsonData["page"],
      per_page: jsonData["per_page"],
      photos: output,
      total_results: jsonData["total_results"],
      next_page: jsonData["next_page"],
    );
  }

  BaseResponse.withError(String errorValue)
      : page = 0,
        per_page = 0,
        photos = [],
        total_results = 0,
        next_page = "";
}
