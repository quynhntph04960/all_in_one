import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastStyle { success, error, warning, normal }

class ToastMessage {
  static void show(String message, ToastStyle style) {
    Color bgColor = Colors.greenAccent;
    Color textColor = Colors.white;
    if (style == ToastStyle.success) {
      // bgColor = AppColor.primaryColor;
      bgColor = Colors.blue;
    } else if (style == ToastStyle.warning) {
      bgColor = Colors.yellow.shade900;
      // bgColor = getColor("#198754");
      // bgColor = Colors.blue;
    } else if (style == ToastStyle.error) {
      bgColor = Colors.redAccent;
    } else {
      bgColor = Colors.black;
    }
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor,
        textColor: textColor,
        fontSize: 14.0);
  }
}

void showErrorToast(String text) {
  ToastMessage.show(text, ToastStyle.error);
}

void showSuccessToast(String text) {
  ToastMessage.show(text, ToastStyle.success);
}

void showWarningToast(String text) {
  ToastMessage.show(text, ToastStyle.warning);
}
