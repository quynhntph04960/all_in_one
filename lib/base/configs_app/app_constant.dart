final appConstant = AppConstant.instance;

class AppConstant {
  AppConstant._();

  static final AppConstant _instance = AppConstant._();

  static AppConstant get instance => _instance;

  /// firebase
  final listUser = "users";

  static const int statusApiError = 18091998;
  static const int statusSuccess = 0;
  static const int statusError = 1;
  static const int statusWarning = 2; // khi status = 0 thì mới dùng
  static const int status200 = 200;
  static const int status400 = 400;
  static const int status401 = 401;
  static const int status403 = 403;
  static const int status404 = 404;
  static const int status413 = 413;
  static const int status500 = 500;
}
