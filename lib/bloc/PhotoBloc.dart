import 'package:awesome/model/response/BaseResponse.dart';
import 'package:awesome/model/response/PhotoResponse.dart';
import 'package:awesome/repository/PhotoRepository.dart';
import 'package:rxdart/rxdart.dart';

class PhotoBloc {
  final PhotoRepository repository = PhotoRepository();
  List<PhotoResponse> _photosData = [];

  final BehaviorSubject<BaseResponse<PhotoResponse>> getPhotoSubject =
      BehaviorSubject<BaseResponse<PhotoResponse>>();

  doGetPhotos(int page, int rowsPage) async {
    getPhotoSubject.add(BaseResponse.loading());
    try {
      BaseResponse<PhotoResponse> response =
          await repository.doGetPhoto(page, rowsPage);
      _photosData.clear();
      _photosData.addAll(response.photos!);

      getPhotoSubject.add(BaseResponse.completed(_photosData));
    } catch (error, stacktrace) {
      print(
          "Menu stacktrace " + error.toString() + " " + stacktrace.toString());
      getPhotoSubject.sink.add(BaseResponse.error());
    }
  }

  doGetNextPhotos(int page, int rowsPage) async {
    try {
      BaseResponse<PhotoResponse> response =
      await repository.doGetPhoto(page, rowsPage);
      _photosData.addAll(response.photos!);
      getPhotoSubject.add(BaseResponse.completed(_photosData));
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
