class LoginModel {
  String? jsonrpc;
  dynamic id;
  Result? result;

  LoginModel({this.jsonrpc, this.id, this.result});

  LoginModel fromJson(dynamic json) {
    return LoginModel.fromJson(json);
  }

  LoginModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    data['id'] = this.id;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  int? stage;
  String? data;
  String? message;

  Result({this.stage, this.data, this.message});

  Result.fromJson(Map<String, dynamic> json) {
    stage = json['stage'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stage'] = this.stage;
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }
}
