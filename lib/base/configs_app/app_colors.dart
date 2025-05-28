import 'package:flutter/material.dart';

final appColors = AppColors.instance;

class AppColors {
  AppColors._();

  static final AppColors _instance = AppColors._();

  static AppColors get instance => _instance;

  Color colorFF6105 = const Color(0xFFFF6105);
}
