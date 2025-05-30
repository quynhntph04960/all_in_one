class UserEntities {
  String? idUser;
  String? name;
  String? avatar;
  String? account;
  String? password;
  List<String>? friends;

  UserEntities({
    this.idUser,
    this.name,
    this.avatar,
    this.account,
    this.password,
    this.friends,
  });

  UserEntities.fromJson(Map<String, dynamic> json) {
    idUser = json['id_user'];
    name = json['name'];
    avatar = json['avatar'];
    account = json['account'];
    password = json['password'];
    if (json['friends'] != null && json['friends'] is List) {
      friends = List<String>.from(json['friends']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_user'] = idUser;
    data['name'] = name;
    data['avatar'] = avatar;
    data['account'] = account;
    data['password'] = password;
    data['friends'] = friends;
    data.removeWhere((key, value) => value == null);
    return data;
  }

  UserEntities copyWithObject({required UserEntities data}) {
    return UserEntities(
      idUser: data.idUser ?? idUser,
      name: data.name ?? name,
      avatar: data.avatar ?? avatar,
      account: data.account ?? account,
      password: data.password ?? password,
      friends: data.friends ?? friends,
    );
  }

  UserEntities copyWith({
    String? idUser,
    String? name,
    String? avatar,
    String? account,
    String? password,
    List<String>? friends,
  }) {
    return UserEntities(
      idUser: idUser ?? this.idUser,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      account: account ?? this.account,
      password: password ?? this.password,
      friends: friends ?? this.friends,
    );
  }
}
