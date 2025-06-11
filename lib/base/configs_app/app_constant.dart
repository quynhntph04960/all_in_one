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

  // static const String ddMmYyyyTHhMmSsZ = "yyyy-MM-dd'T'HH:mm:ss'Z'";

  // static const String ddMmYyyyHHmmSs2 = "dd-MM-yyyy HH:mm:ss";

  static const String ddMmYyyyHhMmSs = "dd/MM/yyyy HH:mm:ss";

  static const String ddMmYyyyHHmm = "dd/MM/yyyy HH:mm";

  // static const String ddMmYyyyHHmm2 = "dd-MM-yyyy HH:mm";

  static const String ddMmYyyy = "dd/MM/yyyy";

  // static const String ddMmYyyy2 = "dd-MM-yyyy";

  // static const String yyyyMMdd = "yyyy-MM-dd";

  static const String hhMm = "HH:mm";

  static const String hhMmSs = "HH:mm:ss";

  static const String mmHH = "mm:HH";

  static const String yyyy = "yyyy";

  static const String dd = "dd";

  static const String mM = "MM";

  static const String video = "video";
  static const String image = "image";

  /// qrCode
  static const String typeQRCodeImageCustomer = "ImageCustomer";
  static const String typeQRCodeCRM = "CRM";

  /// id tiện ích home
  static const String typeHomeIdCrm = "crm";
  static const String typeHomeIdSellKit = "customer";
  static const String typeHomeIdContacts = "contact";
}
