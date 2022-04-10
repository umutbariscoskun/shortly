import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xff25d0d0);
const Color kSecondaryColor = Color(0xff382c53);
const Color kWhite = Color(0xffffffff);
const Color kBlack = Color(0xff000000);
const Color kDisabledButtonColor = Color(0xffDADADA);
const Color kBackGroundColor = Color(0xfff0f1f6);
const Color kGrey = Color(0xffBBBCC7);

const double defaultSizeBoxPadding = 10;
const double horizontalPadding = 17;

TextStyle kLargeTitleStyle(Color color) {
  return TextStyle(
    color: color,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
}

TextStyle kTitleStyle(Color color) {
  return TextStyle(
    color: color,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
}

TextStyle kContentStyleBold(Color color) {
  return TextStyle(
    color: color,
    fontSize: 17,
    fontWeight: FontWeight.w500,
  );
}

TextStyle kButtonTextStyle(Color color) {
  return TextStyle(
    color: color,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}

TextStyle kHintTextStyle(Color color) {
  return TextStyle(
    color: color,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}
