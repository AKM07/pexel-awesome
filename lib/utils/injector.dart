import 'dart:io';

import 'package:awesome/constants/Constants.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../constants/UrlConstants.dart';
import '../interceptors/LoggingInterceptors.dart';
import 'PreferencesUtil.dart';

GetIt locator = GetIt.instance;

Future baseDio() async {
  final options = BaseOptions(
    baseUrl: UrlConstants.BASE_URL,
    connectTimeout: 60000,
    receiveTimeout: 3000,
    headers: {
      "Authorization" : Constants.pexelApiKey
    }
  );

  var dio = Dio(options);

  dio.interceptors.add(LoggingInterceptors());

  locator.registerSingleton<Dio>(dio);
}

Future setupLocator() async {
  PreferencesUtil util = (await PreferencesUtil.getInstance())!;
  locator.registerSingleton<PreferencesUtil>(util);
}
