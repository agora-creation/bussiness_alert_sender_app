import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const kBaseColor = Color(0xFF9E9E9E);
const kWhiteColor = Color(0xFFFFFFFF);
const kBlackColor = Color(0xFF333333);
const kGreyColor = Color(0xFF9E9E9E);
const kRedColor = Color(0xFFF44336);
const kBlueColor = Color(0xFF2196F3);
const kCyanColor = Color(0xFF00BCD4);
const kOrangeColor = Color(0xFFFF9800);

ThemeData customTheme() {
  return ThemeData(
    scaffoldBackgroundColor: kBaseColor,
    fontFamily: 'SourceHanSansJP-Regular',
    appBarTheme: const AppBarTheme(
      color: kBaseColor,
      elevation: 0,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: TextStyle(
        color: kBlackColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'SourceHanSansJP-Bold',
      ),
      iconTheme: IconThemeData(color: kBlackColor),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: kBlackColor),
      bodyMedium: TextStyle(color: kBlackColor),
      bodySmall: TextStyle(color: kBlackColor),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    unselectedWidgetColor: kGreyColor,
  );
}

const SliverGridDelegate kHomeGrid = SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  childAspectRatio: 0.9,
  crossAxisSpacing: 4,
  mainAxisSpacing: 4,
);
