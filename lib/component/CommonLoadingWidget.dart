import 'package:awesome/constants/Constants.dart';
import 'package:flutter/material.dart';

class CommonLoadingWidget extends StatelessWidget {
  const CommonLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Color(Constants.appMainColor),
      ),
    );
  }
}
