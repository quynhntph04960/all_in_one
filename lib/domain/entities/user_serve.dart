class UserServe {
  int? status;
  Message? message;
  Data? data;

  UserServe({this.status, this.message, this.data});

  UserServe.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Message {
  int? type;
  String? content;

  Message({this.type, this.content});

  Message.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['content'] = this.content;
    return data;
  }
}

class Data {
  String? name;
  String? code;
  Null? phone;
  String? birthday;
  String? workEmail;
  String? jobId;
  String? company;
  CompanyErpId? companyErpId;
  String? avatar;
  String? department;
  String? sector;
  String? brand;
  String? area;
  List<CompanyErpId>? companyErp;
  int? employeeErpId;
  int? userErpId;

  Data(
      {this.name,
      this.code,
      this.phone,
      this.birthday,
      this.workEmail,
      this.jobId,
      this.company,
      this.companyErpId,
      this.avatar,
      this.department,
      this.sector,
      this.brand,
      this.area,
      this.companyErp,
      this.employeeErpId,
      this.userErpId});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    phone = json['phone'];
    birthday = json['birthday'];
    workEmail = json['work_email'];
    jobId = json['job_id'];
    company = json['company'];
    companyErpId = json['company_erp_id'] != null
        ? new CompanyErpId.fromJson(json['company_erp_id'])
        : null;
    avatar = json['avatar'];
    department = json['department'];
    sector = json['sector'];
    brand = json['brand'];
    area = json['area'];
    if (json['company_erp'] != null) {
      companyErp = <CompanyErpId>[];
      json['company_erp'].forEach((v) {
        companyErp!.add(new CompanyErpId.fromJson(v));
      });
    }
    employeeErpId = json['employee_erp_id'];
    userErpId = json['user_erp_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['phone'] = this.phone;
    data['birthday'] = this.birthday;
    data['work_email'] = this.workEmail;
    data['job_id'] = this.jobId;
    data['company'] = this.company;
    if (this.companyErpId != null) {
      data['company_erp_id'] = this.companyErpId!.toJson();
    }
    data['avatar'] = this.avatar;
    data['department'] = this.department;
    data['sector'] = this.sector;
    data['brand'] = this.brand;
    data['area'] = this.area;
    if (this.companyErp != null) {
      data['company_erp'] = this.companyErp!.map((v) => v.toJson()).toList();
    }
    data['employee_erp_id'] = this.employeeErpId;
    data['user_erp_id'] = this.userErpId;
    return data;
  }
}

class CompanyErpId {
  int? id;
  String? name;

  CompanyErpId({this.id, this.name});

  CompanyErpId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
