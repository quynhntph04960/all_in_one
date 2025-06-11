import 'package:all_in_one/base/configs_app/app_constant.dart';
import 'package:intl/intl.dart';

import 'common_function.dart';

String getEspecially(String date, {String? format}) {
  return DateFormat(format).format(getDateTimeObject(date));
}

// String getDateTimeDefault(String date, {String? format}) {
//   return date.toDateTimeFormat(format ?? Constant.ddMmYyyyHHmmSs2);
// }
//
// String getFullDateTime(String date) {
//   return date.toDateTimeFormat(Constant.ddMmYyyyHHmmSs2);
// }
//
// String getDateTime(String date) {
//   return date.toDateTimeFormat(Constant.ddMmYyyyHHmm2);
// }
//
// String getTime(String date) {
//   return date.toDateTimeFormat(Constant.hhMm);
// }
//
// String getDate(String date) {
//   return date.toDateTimeFormat(Constant.ddMmYyyy);
// }

// convert String về string
String getDateTime2(String? data) {
  if (isNullOrEmpty(data)) return "";
  // Định dạng ngày gốc
  DateFormat dateOrigin = DateFormat(AppConstant.ddMmYyyyHhMmSs);
  // Chuyển đổi sang định dạng mong muốn
  DateFormat dateNew = DateFormat(AppConstant.ddMmYyyy);
  // Parse ngày gốc thành đối tượng DateTime
  DateTime dateTime = dateOrigin.parse(data ?? "");
  // Format lại ngày thành định dạng mong muốn
  String result = dateNew.format(dateTime);
  return result;
}

DateTime getDateTimeObject(String date, {String? format}) {
  if (isNullOrEmpty(date)) {
    return DateTime(0);
  }
  if (isNullOrEmpty(format)) {
    String format = AppConstant.ddMmYyyyHHmm;
    int count = date.length - date.replaceAll(":", "").length;
    if (date.contains("T")) {
      return DateTime.parse(date);
    } else if (count == 0) {
      format = AppConstant.ddMmYyyy;
    } else if (count == 2) {
      format = AppConstant.ddMmYyyyHhMmSs;
    }
    return DateFormat(format).parse(date);
  }
  return DateFormat(format).parse(date);
}

// lấy thời gian hiện tại
String getCurrentDate(String format) {
  return DateFormat(format).format(DateTime.now());
}

// đổi String về dateTime
DateTime? stringToDateTime(String time,
    {String format = AppConstant.ddMmYyyyHhMmSs}) {
  if (isNullOrEmpty(time)) return null;
  return DateFormat(format).parse(time);
}

// đổi dateTime về String
String dateTimeToString(DateTime time,
    {String format = AppConstant.ddMmYyyyHhMmSs}) {
  if (isNullOrEmpty(time)) return "";
  String date = DateFormat(format).format(time);
  return date;
}

// kiểm tra thời gian đã đúng định dạng chưa
bool isDateTimeValid(String input, {String format = AppConstant.ddMmYyyy}) {
  try {
    // hợp lẹ
    DateFormat(format).parseStrict(input);
    return true;
  } catch (e) {
    // không hợp lệ
    return false;
  }
}

bool compareDateTime(String time1Str, String time2Str) {
  // Định dạng ngày giờ
  DateFormat dateFormat = DateFormat(AppConstant.ddMmYyyyHhMmSs);

  // Chuyển chuỗi thành DateTime
  DateTime time1 = dateFormat.parse(time1Str);
  DateTime time2 = dateFormat.parse(time2Str);

  // Kiểm tra time1 có lớn hơn time2 không
  if (time1.isAfter(time2)) {
    return true;
  } else {
    return false;
  }
}
