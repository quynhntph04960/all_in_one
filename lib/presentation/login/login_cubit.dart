import 'dart:convert';

import 'package:all_in_one/base/service/firebase_service.dart';
import 'package:all_in_one/domain/entities/user_entities.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/service/client/rest_client.dart';
import '../../base/utils/common_function.dart';
import '../../base/utils/common_navigator.dart';
import '../../base/widget/loading_dialog.dart';
import '../../base/widget/toast_view.dart';
import '../../chat/presentation/list_user/list_user_page.dart';
import '../../di/di.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  Future initialize() async {
    emit(
      state.copyWith(
        listUserSystem: await firebaseService.getListUserSystem(),
      ),
    );
  }

  Future login(String account, String password, BuildContext context) async {
    showLoading();
    final dataSearch = state.listUserSystem?.firstWhere(
      (e) => e.account == account,
      orElse: () => UserEntities(),
    );
    final bytes = utf8.encode(password); // convert to bytes
    final digest = sha256.convert(bytes); // hash
    hideLoading();
    if (state.isNotAccount == true) {
      if (isNullOrEmpty(dataSearch?.account)) {
        final user = UserEntities(
          account: account,
          password: digest.toString(),
        );
        await firebaseService.createAccount(user);
        showSuccessToast("Đăng ký tài khoản thành công");
        if (context.mounted) {
          accountLogin = accountLogin.copyWithObject(data: user);
          pushAndRemoveUntil(context, const ListUserPage());
        }
      } else {
        showErrorToast(
            "Đã có tài khoản đăng ký, vui lòng sử dụng tài khoản khác");
      }
    } else {
      if (isNullOrEmpty(dataSearch?.account)) {
        showErrorToast("Chưa đăng ký tài khoản");
      } else {
        if (dataSearch?.password != digest.toString()) {
          showErrorToast("Tài khoản chưa đúng, vui lòng kiểm tra lại");
        } else {
          accountLogin = accountLogin.copyWithObject(data: dataSearch!);
          if (context.mounted) {
            pushAndRemoveUntil(context, const ListUserPage());
          }
        }
      }
    }
  }

  Future login2(String account, String password, BuildContext context) async {
    // final response = await http.post(
    //   Uri.parse('https://kworktest.kangnam.com.vn/api/v1/auth/login'),
    //   body: {"login": account, "password": password},
    //   headers: {'Content-Type': 'application/json'},
    // );
    // print(response.body);

    // final url = Uri.parse('https://dev.scigroup.com.vn/api/v1/auth/login');
    // final response = await http.post(
    //   url,
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode(
    //     {'login': account, 'password': password},
    //   ),
    // );
    //
    // print(response.body);

    // var headers = {
    //   'Content-Type': 'application/json',
    // };
    // var request = http.Request(
    //     'POST', Uri.parse('https://dev.scigroup.com.vn/api/v1/auth/login'));
    // request.body = json.encode({"login": "test", "password": "1"});
    // request.headers.addAll(headers);
    //
    // http.StreamedResponse response = await request.send();
    //
    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }

    final response = await RestClient.instance.post(
      "/api/test/v1/auth/login",
      {
        "login": account,
        "password": password,
      },
    );
    print('-----------------------LoginCubit.login-----------------------');
    print(response.toString());

    // var headers = {
    //   'Content-Type': 'application/json',
    // };
    // var data = json.encode({"login": "test", "password": "1"});
    // var dio = Dio();
    // var response2 = await dio.post(
    //   'https://dev.scigroup.com.vn/api/v1/auth/login',
    //   options: Options(
    //     method: 'POST',
    //     headers: headers,
    //   ),
    //   data: data,
    // );
    //
    // if (response2.statusCode == 200) {
    //   print(json.encode(response2.data));
    // } else {
    //   print(response2.statusMessage);
    // }
  }

  Future registerAccount() async {
    emit(state.copyWith(isNotAccount: !(state.isNotAccount ?? false)));
  }
}

class LoginState extends Equatable {
  // danh sách người dụng trong hệ thống
  final List<UserEntities>? listUserSystem;
  final bool? isNotAccount;

  const LoginState({
    this.listUserSystem,
    this.isNotAccount = false,
  });

  @override
  List<Object?> get props => [
        listUserSystem,
        isNotAccount,
      ];

  LoginState copyWith({
    List<UserEntities>? listUserSystem,
    bool? isNotAccount,
  }) {
    return LoginState(
      listUserSystem: listUserSystem ?? this.listUserSystem,
      isNotAccount: isNotAccount ?? this.isNotAccount,
    );
  }
}
