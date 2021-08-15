import 'dart:io';

import 'package:flutter/material.dart';

class Constants {
  static const appName = "Mobile Skeleton";
  static const currencyFormat = "Rp #,###";
  static const decimalFormat = "#,###";
  static const appMainColor = 0xFF00796b;
  static const appBackgroundColor = 0xFFfffff4;
  static const pexelApiKey =
      "563492ad6f91700001000001ab808387eb014c6aa42a17aa7af097d2";

  static Future<bool> checkInternetAvailability() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
       return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
  }
}
