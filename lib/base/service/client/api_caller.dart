import 'dart:convert';

import 'package:dio/dio.dart';

import '../../configs_app/app_constant.dart';
import '../../widget/loading_dialog.dart';
import '../../widget/toast_view.dart';
import '../model/base_response.dart';
import 'rest_client.dart';

class ApiCaller {
  static final ApiCaller _instance = ApiCaller();

  static ApiCaller get instance {
    return _instance;
  }

  ApiCaller();

  Future<Response?> downloadFile(String path) async {
    try {
      final response = await RestClient.instance.downloadFile(path);
      return response;
    } on DioException catch (e) {
      _errorException(dioError: e);
      return null;
    } on Exception {
      _errorException();
      return null;
    } finally {}
  }

  // Future<dynamic> uploadFile(
  //   String path,
  //   Map<String, dynamic> params, {
  //   bool isLoading = true,
  //   isShowErrorMessage = true,
  //   isShowSuccessMessage = false,
  // }) async {
  //   if (isLoading) {
  //     showLoading();
  //   }
  //   try {
  //     final response = await RestClient.instance.uploadFile(
  //       path,
  //       params,
  //       (count, total) {
  //         String kq = (count / total * 100).toStringAsFixed(0);
  //         print('progress: $kq% ($count/$total)');
  //
  //         loadingDialog?.updateProgress(count / total);
  //       },
  //     );
  //     return _response(response, isShowErrorMessage, isShowSuccessMessage);
  //   } on DioException catch (e) {
  //     return _errorException(dioError: e);
  //   } on Exception {
  //     return _errorException();
  //   } finally {
  //     if (isLoading) {
  //       hideLoading();
  //     }
  //   }
  // }
  //
  // Future<dynamic> put(
  //   String path,
  //   Map<String, dynamic> params, {
  //   bool isLoading = true,
  //   isShowErrorMessage = true,
  //   isShowSuccessMessage = false,
  // }) async {
  //   if (isLoading) {
  //     showLoading();
  //   }
  //   try {
  //     final response = await RestClient.instance.put(path, params);
  //     return _response(response, isShowErrorMessage, isShowSuccessMessage);
  //   } on DioException catch (e) {
  //     return _errorException(dioError: e);
  //   } on Exception {
  //     return _errorException();
  //   } finally {
  //     if (isLoading) {
  //       hideLoading();
  //     }
  //   }
  // }

  Future<dynamic> post(
    String path,
    Map<String, dynamic> params, {
    bool isLoading = true,
    isShowErrorMessage = true,
    isShowSuccessMessage = false,
  }) async {
    if (isLoading) {
      showLoading();
    }
    try {
      final response = await RestClient.instance.post(path, params);
      return _response(response, isShowErrorMessage, isShowSuccessMessage);
    } on DioException catch (e) {
      return _errorException(dioError: e);
    } on Exception {
      return _errorException();
    } finally {
      if (isLoading) {
        hideLoading();
      }
    }
  }

  Future<dynamic> postJson(
    String path,
    Map<String, dynamic> params, {
    bool isLoading = true,
    isShowErrorMessage = true,
    isShowSuccessMessage = false,
  }) async {
    if (isLoading) {
      showLoading();
    }
    try {
      final response = await RestClient.instance.postJson(path, params);
      return _response(response, isShowErrorMessage, isShowSuccessMessage);
    } on DioException catch (e) {
      return _errorException(dioError: e);
    } on Exception {
      return _errorException();
    } finally {
      if (isLoading) {
        hideLoading();
      }
    }
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? params,
    bool isLoading = true,
    isShowErrorMessage = true,
    isShowSuccessMessage = false,
  }) async {
    if (isLoading) {
      showLoading();
    }
    try {
      final response = await RestClient.instance.get(path, params: params);
      return _response(response, isShowErrorMessage, isShowSuccessMessage);
    } on DioException catch (e) {
      _errorException(dioError: e);
      rethrow;
    } on Exception {
      _errorException();
      rethrow;
    } finally {
      if (isLoading) {
        hideLoading();
      }
    }
  }

  Future _errorException({DioException? dioError}) async {
    String message = "Kết nối đến máy chủ thất bại!";
    // không hiểu sao không dùng dc switch case ở đây
    if (dioError?.type == DioExceptionType.connectionTimeout ||
        dioError?.type == DioExceptionType.sendTimeout ||
        dioError?.type == DioExceptionType.receiveTimeout) {
      // hết thời gian chờ sẽ vào đây
      message = "Máy chủ không phản hồi!";
      // } else if (dioError?.type == DioExceptionType.badCertificate) {
      //   message = "Lỗi chưa xác nhận chứng chỉ";
    } else if (dioError?.type == DioExceptionType.badResponse) {
      // api sai link vào đây
      // message = "Hệ thống sai đường dẫn";
      message = "Máy chủ không hoạt động!";
    } else if (dioError?.type == DioExceptionType.cancel) {
      // api bị huỷ giữa chừng sẽ vào đây
      message = "Yêu cầu được Hủy bỏ!";
      // } else if (dioError?.type == DioExceptionType.connectionError) {
    } else {
      // Api chưa xác định sẽ vào đây
      // dioError?.type == DioExceptionType.unknown
      final response = dioError?.response;
      if (response != null) {
        switch (response.statusCode) {
          case AppConstant.statusSuccess:
            message = "Cú pháp không hợp lệ (400)";
            break;

          case AppConstant.status401:
          case AppConstant.status403:
            message = "Có vấn đề khi xác thực trong tài khoản của bạn (403)";
            break;

          case AppConstant.status404:
            message = "Không thể truy cập đến máy chủ (404)";
            break;

          case AppConstant.status413:
            message = "Tải dữ liệu quá lớn, không thành công (413)";
            break;

          case AppConstant.status500:
            message = "Máy chủ gặp lỗi (500)";
            break;

          default:
            message = "Kết nối đến máy chủ thất bại!";
            break;
        }
      }
    }
    showErrorToast(message);
    // return BaseResponse(
    //   status: Constant.statusApiError,
    //   message: MessageResponse(
    //     content: message,
    //     type: dioError?.response?.statusCode,
    //   ),
    // );
  }

  Map<String, dynamic> _response(
    dynamic response,
    bool isShowErrorMessage,
    bool isShowSuccessMessage,
  ) {
    final responseJson =
        json.decode(response.toString()) as Map<String, dynamic>;
    BaseResponse data = BaseResponse.fromJson(
      responseJson,
      (json) => null,
    );

    if (isShowErrorMessage = true && data.status == AppConstant.statusError) {
      showErrorToast(data.message?.content ?? "Thất bại");
    }

    if (isShowSuccessMessage == true &&
        data.status == AppConstant.statusSuccess) {
      showSuccessToast(data.message?.content ?? "Thành công");
    }
    return responseJson;
  }

  void showLoading() {
    loadingDialog?.show();
  }

  void hideLoading() {
    loadingDialog?.hide();
  }
}

LoadingDialog? loadingDialog;
