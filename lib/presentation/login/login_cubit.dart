import 'dart:developer';

import 'package:all_in_one/base/service/firebase_service.dart';
import 'package:all_in_one/base/utils/common_function.dart';
import 'package:all_in_one/base/utils/common_navigator.dart';
import 'package:all_in_one/chat/presentation/list_user/list_user_page.dart';
import 'package:all_in_one/domain/entities/user_entities.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// danh sách người dụng trong hệ thống
final List<UserEntities> listUserSystem = [];

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  Future initialize() async {
    listUserSystem.addAll(await firebaseService.getListUserSystem());
  }

  Future login(String account, String password, BuildContext context) async {
    final dataSearch = listUserSystem.firstWhere(
      (e) => e.account == account,
      orElse: () => UserEntities(),
    );
    if (isNullOrEmpty(dataSearch.name)) {
      final user = UserEntities(
        name: account,
        account: account,
        avatar: linkTest,
      );
      await firebaseService.createAccount(user);
      log("Đăng ký thành công");
    }
    if (context.mounted) {
      pushPage(context, const ListUserPage());
    }
  }
}

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}
