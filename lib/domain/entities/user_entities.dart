class UserEntities {
  String? name;
  String? avatar;
  String? account;

  UserEntities({this.name, this.avatar, this.account});

  UserEntities.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    account = json['account'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['account'] = this.account;
    return data;
  }
}
