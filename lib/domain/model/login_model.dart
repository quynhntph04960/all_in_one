class LoginModel {
  String? jsonrpc;
  Null? id;
  Result? result;

  LoginModel({this.jsonrpc, this.id, this.result});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  String? avatar;
  String? message;

  Result({this.stage, this.data, this.avatar, this.message});

  Result.fromJson(Map<String, dynamic> json) {
    stage = json['stage'];
    data = json['data'];
    avatar = json['avatar'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stage'] = this.stage;
    data['data'] = this.data;
    data['avatar'] = this.avatar;
    data['message'] = this.message;
    return data;
  }
}
