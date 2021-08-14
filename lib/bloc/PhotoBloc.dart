import 'package:awesome/model/response/BaseResponse.dart';
import 'package:awesome/model/response/PhotoResponse.dart';
import 'package:awesome/repository/PhotoRepository.dart';
import 'package:rxdart/rxdart.dart';

class PhotoBloc {
  final PhotoRepository repository = PhotoRepository();

  final BehaviorSubject<BaseResponse<PhotoResponse>> getPhotoSubject =
      BehaviorSubject<BaseResponse<PhotoResponse>>();

  doGetPhotos(String page, String rowsPage) async {
    getPhotoSubject.add(BaseResponse.loading());
    try {
      BaseResponse<PhotoResponse> response =
          await repository.doGetPhoto(page, rowsPage);

      getPhotoSubject.add(BaseResponse.completed(response.photos));
    } catch (error, stacktrace) {
      print(
          "Menu stacktrace " + error.toString() + " " + stacktrace.toString());
      getPhotoSubject.sink.add(BaseResponse.error());
    }
  }

  dispose() {
    getPhotoSubject.close();
  }
}

final photoBloc = PhotoBloc();
