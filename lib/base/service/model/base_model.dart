// import 'package:all_in_one/base/configs_app/app_constant.dart';
//
// import '../../utils/common_function.dart';
// import '../../widget/toast_view.dart';
// import 'base_response.dart';
//
// class BaseModel {
//   static BaseResponse resultObject<T>(
//       dynamic response, GetResultModel<T> getData) {
//     if (isNullOrEmpty(response)) return BaseResponse();
//     try {
//       final result =  BaseResponse<T>.fromJson(response, (dynamic json) {
//         return getData(json);
//       });
//
//       if (result.status == appConstant.statusError &&
//           result.message?.type == appConstant.statusError) {
//         // logout();
//       }
//
//       return result;
//     } catch (error) {
//       showErrorToast(error.toString());
//       rethrow;
//     }
//   }
//
//   static BaseResponse resultList<T>(
//       dynamic response, GetResultModel<T> getData) {
//     if (isNullOrEmpty(response)) return BaseResponse();
//     try {
//       final result =  BaseResponse<List<T>>.fromJson(response, (json) {
//         return (json as List)
//             .cast<Map<String, dynamic>>()
//             .map((json1) => getData(json1))
//             .toList();
//       });
//
//       if (result.status == appConstant.statusError &&
//           result.message?.type == appConstant.statusError) {
//         // logout();
//       }
//
//       return result;
//     } catch (error) {
//       showErrorToast(error.toString());
//       rethrow;
//     }
//   }
//
//   /// nguyên thuỷ
//   static BaseResponse resultPrimitive<T>(dynamic response) {
//     if (isNullOrEmpty(response)) return BaseResponse();
//     try {
//       final result = BaseResponse<T>.fromJson(response, (dynamic json) {
//         return json as T;
//       });
//
//       if (result.status == appConstant.statusError &&
//           result.message?.type == appConstant.statusError) {
//         // logout();
//       }
//
//       return result;
//     } catch (error) {
//       showErrorToast(error.toString());
//       rethrow;
//     }
//   }
//
//   static BaseResponse resultNull(dynamic response) {
//     if (isNullOrEmpty(response)) return BaseResponse();
//     try {
//       final result = BaseResponse.fromJson(response, (json) => null);
//
//       if (result.status == appConstant.statusError &&
//           result.message?.type == appConstant.statusError) {
//         // logout();
//       }
//
//       return result;
//     } catch (error) {
//       showErrorToast(error.toString());
//       rethrow;
//     }
//   }
// }
//
// typedef GetResultModel<T> = T Function(dynamic json);
