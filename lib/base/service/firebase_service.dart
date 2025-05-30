import 'package:all_in_one/base/configs_app/app_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user_entities.dart';

final firebaseService = AppFirebaseService();

class AppFirebaseService {
  // Singleton
  static final AppFirebaseService _instance = AppFirebaseService._internal();
  factory AppFirebaseService() => _instance;
  AppFirebaseService._internal();

  final _storage = FirebaseFirestore.instance;

  /// lấy danh sách người dùng trong hệ thống
  Future<List<UserEntities>> getListUserSystem() async {
    final data = await _storage.collection(appConstant.listUser).get();
    final listData = data.docs
        .map(
          (doc) => UserEntities.fromJson(doc.data()),
        )
        .toList();
    return listData;
  }

  // isUpdate = false thì ghi đề, = true thì cập nhật thêm
  Future<bool> createAccount(UserEntities user,
      {bool isUpdate = false, String? keyDoc}) async {
    final doc = _storage.collection(appConstant.listUser).doc(keyDoc);
    user.idUser = doc.id;
    await doc.set(
      user.toJson(),
      SetOptions(merge: isUpdate),
    );
    return true;
  }
}
