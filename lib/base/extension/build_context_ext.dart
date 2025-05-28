import 'package:flutter/material.dart';

GlobalKey<NavigatorState> mainGlobalKey = GlobalKey<NavigatorState>();

extension BuildContextExtension on BuildContext {
  // // bottom này tính iphoneX thì bottom > 0
  // /// hiện tại dùng khi page đó không có chân trang
  // double get paddingBottom => MediaQuery.paddingOf(this).bottom;
  //
  // /// paddingBottom và spaceBottomNaviBar là 2 khoảng cách khác nhau
  // /// ví dụ
  // /// paddingBottom = 20
  // /// spaceBottomNaviBar = paddingBottom + 10
  // /// hiện tại dùng khi page đó có chân trang
  // double get spaceBottomNaviBar =>
  //     paddingBottom > 0 ? paddingBottom - (isMobile ? 10 : 0) : kBottomNavigationBarHeight;
  //
  // // height trên BottomNaviBar
  // double get topBottomNaviBar => spaceBottomNaviBar + 36;

  /// dùng để lấy theme mặc định của project
  ThemeData get themeConfigs => Theme.of(this);
  // size 22
  TextStyle get themeHeaderText => themeConfigs.textTheme.titleLarge!
      .copyWith(fontWeight: FontWeight.w700, color: Colors.black);
  // size 16
  TextStyle get themeTitleText => themeConfigs.textTheme.titleMedium!
      .copyWith(fontWeight: FontWeight.w600, color: Colors.black);
  // size 14
  TextStyle get themeDefaultText => themeConfigs.textTheme.titleSmall!
      .copyWith(fontWeight: FontWeight.w400, color: Colors.black);
  // size 12
  TextStyle get themeSubText => themeConfigs.textTheme.labelMedium!
      .copyWith(fontWeight: FontWeight.w200, color: Colors.black);

  MediaQueryData get data => MediaQuery.of(this);

  /// Các hàm dưới dùng để xác định thiết bị
  // Để lấy screen size (context.screenSize)
  double get screenHeight => data.size.height;

  double get screenWidth => data.size.width;

  Orientation get orientation => data.orientation;

  // ScreenType get screenType {
  //   final deviceWidth = kIsWeb ? screenSize.width : screenSize.shortestSide;
  //
  //   if (deviceWidth >= _defaultBreakpoints[ScreenType.desktop]!) {
  //     return ScreenType.desktop;
  //   } else if (deviceWidth >= _defaultBreakpoints[ScreenType.tablet]!) {
  //     return ScreenType.tablet;
  //   } else if (deviceWidth < _defaultBreakpoints[ScreenType.watch]!) {
  //     return ScreenType.watch;
  //   }
  //
  //   return ScreenType.mobile;
  // }

  // bool get isMobile => screenType == ScreenType.mobile;
  //
  // bool get isTablet => screenType == ScreenType.tablet;
  //
  // bool get isDesktop => screenType == ScreenType.desktop;
  //
  // bool get isLandscape => orientation == Orientation.landscape;
  //
  // bool get isPortrait => orientation == Orientation.portrait;
}

// Map<ScreenType, double> _defaultBreakpoints = {
//   ScreenType.desktop: 950,
//   ScreenType.tablet: 600,
//   ScreenType.watch: 300,
// };
//
// enum ScreenType {
//   mobile,
//   desktop,
//   tablet,
//   watch,
// }
