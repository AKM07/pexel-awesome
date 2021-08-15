import 'package:awesome/model/response/PhotoResourceResponse.dart';
import 'package:awesome/model/response/PhotoResponse.dart';
import 'package:awesome/pages/PhotoDetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

Widget createPhotoDetailPage() {
  WidgetsFlutterBinding.ensureInitialized();
  PhotoResourceResponse srcResponse = new PhotoResourceResponse();
  srcResponse.original =
      "https://images.pexels.com/photos/2425232/pexels-photo-2425232.jpeg";
  srcResponse.large2x =
      "https://images.pexels.com/photos/2425232/pexels-photo-2425232.jpeg";
  srcResponse.large =
      "https://images.pexels.com/photos/2425232/pexels-photo-2425232.jpeg";
  srcResponse.medium =
      "https://images.pexels.com/photos/2425232/pexels-photo-2425232.jpeg";
  srcResponse.small =
      "https://images.pexels.com/photos/2425232/pexels-photo-2425232.jpeg";
  srcResponse.portrait =
      "https://images.pexels.com/photos/2425232/pexels-photo-2425232.jpeg";
  srcResponse.landscape =
      "https://images.pexels.com/photos/2425232/pexels-photo-2425232.jpeg";
  srcResponse.tiny =
      "https://images.pexels.com/photos/2425232/pexels-photo-2425232.jpeg";

  PhotoResponse response = new PhotoResponse();
  response.id = 2425232;
  response.width = 1699;
  response.height = 2550;
  response.url =
      "https://www.pexels.com/photo/art-dark-pattern-texture-2425232/";
  response.photographer = "Stacey Gabrielle Koenitz Rozells";
  response.photographerUrl = "https://www.pexels.com/@goldcircuits";
  response.photographerId = 1272132;
  response.avgColor = "#272727";
  response.src = srcResponse;
  response.liked = false;

  return MaterialApp(
    home: PhotoDetailPage(
      photoData: response,
    ),
  );
}

void main() {
  group('Passing data to detail page test', () {
    testWidgets('Displaying detail data test', (tester) async {
      await mockNetworkImagesFor(
          () async => await tester.pumpWidget(createPhotoDetailPage()));

      final photoGrapherNameFinder =
          find.text('Stacey Gabrielle Koenitz Rozells');
      final heightFinder = find.text('2550');
      final widthFinder = find.text('1699');
      final avgColorFinder = find.text('#272727');
      expect(photoGrapherNameFinder, findsWidgets);
      expect(heightFinder, findsOneWidget);
      expect(widthFinder, findsOneWidget);
      expect(avgColorFinder, findsOneWidget);
    });
  });
}
