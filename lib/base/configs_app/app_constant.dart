final appConstant = AppConstant.instance;

class AppConstant {
  AppConstant._();

  static final AppConstant _instance = AppConstant._();

  static AppConstant get instance => _instance;

  /// firebase
  final listUser = "users";
}
