import 'package:flutter/material.dart';

/*
  DateTime.parse(String input) just accept input format same:
  "2012-02-27"
  "2012-02-27 13:27:00"
  "2012-02-27 13:27:00.123456789z"
  "2012-02-27 13:27:00,123456789z"
  "20120227 13:27:00"
  "20120227T132700"
  "20120227"
  "+20120227"
  "2012-02-27T14Z"
  "2012-02-27T14+00:00"
  "-123450101 00:00:00 Z": in the year -12345.
  "2002-02-27T14:00:00-0500": Same as "2002-02-27T19:00:00Z"
  NOT accept:
  18-11-2020
  Nov, 20 2020
  19/11/2020
  12/30/2020
 */
extension StringExtension on String {
  get firstLetterToUpperCase {
    if (isNullOrEmpty) {
      return this[0].toUpperCase() + substring(1);
    } else {
      return null;
    }
  }

  String getFirstChar() {
    return (this[0]).toLowerCase();
  }

  bool get isNullOrEmpty {
    return (isEmpty);
  }

  bool get isNotNullOrEmpty {
    return !isNullOrEmpty;
  }

  int parseInt() {
    return int.parse(this);
  }

  double parseDouble() {
    return double.parse(this);
  }

  Color toColor() {
    if (isNullOrEmpty) {
      return Color(int.parse("0xffffff"));
    }
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return Color(int.parse("0xffffff"));
  }

  DateTime toDate() {
    if (isNullOrEmpty) {
      return DateTime.now();
    }
    return DateTime.parse(this);
  }

  // // String toDateTimeFormat({String format = Constant.ddMMyyyyHHmm2}) {
  // String toDateTimeFormat(String format) {
  //   if (isNullOrEmpty) {
  //     return "";
  //   }
  //   switch (format) {
  //     case Constant.ddMmYyyyHHmm2:
  //     case Constant.ddMmYyyyHHmm:
  //     case Constant.ddMmYyyyHhMmSs:
  //     case Constant.ddMmYyyyHHmmSs2:
  //     case Constant.hhMm:
  //     case Constant.yyyy:
  //     case Constant.dd:
  //     case Constant.mM:
  //       return DateFormat(format).format(DateTime.parse(this));
  //
  //     case Constant.ddMmYyyy:
  //     case Constant.ddMmYyyy2:
  //       if (num.tryParse(this) != null) {
  //         return DateFormat(format)
  //             .format(DateTime.fromMillisecondsSinceEpoch(int.parse(this)));
  //       }
  //       return DateFormat(format).format(DateTime.parse(this));
  //
  //     default:
  //       return "";
  //   }
  // }

  // regex for email
  bool isEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  // regex for phone
  bool isPhone() {
    return RegExp(r"^[0-9]{10,11}$").hasMatch(this);
  }
}
