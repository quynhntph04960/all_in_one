import 'dart:developer';

class BaseResponse {
  int? status;
  dynamic data;
  MessageResponse? message;

  BaseResponse({this.status, this.message, this.data});

  BaseResponse.fromJson(Map<String, dynamic> json, dynamic responseData) {
    try {
      status = json['status'];
      if (responseData != null && json["data"] != null) {
        if (json["data"] is List) {
          data = [];
          json['data'].forEach((v) {
            responseData = responseData.fromJson(v);
            data.add(responseData);
          });
        } else {
          if (json["data"] == null || json["data"] == {}) {
            data = null;
          } else {
            responseData = responseData.fromJson(json["data"]);
            data = responseData;
          }
        }
      }
      message = json['message'] != null
          ? MessageResponse.fromJson(json['message'])
          : null;
    } on Exception catch (e) {
      log("BaseResponse - $e");
      status = 1998;
      message =
          MessageResponse(type: 1998, content: "Có lỗi khi phân tích gói tin");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (message != null) {
      data['message'] = message?.toJson();
    }
    return data;
  }
}

class MessageResponse {
  int? type;
  String? content;

  MessageResponse({this.type, this.content});

  MessageResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['content'] = content;
    return data;
  }
}
