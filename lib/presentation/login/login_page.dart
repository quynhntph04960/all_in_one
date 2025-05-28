import 'package:all_in_one/base/extension/build_context_ext.dart';
import 'package:all_in_one/base/widget/button_widget.dart';
import 'package:all_in_one/base/widget/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final accountController = TextEditingController();
  final passwordController = TextEditingController();
  final _cubit = LoginCubit();

  @override
  void initState() {
    _cubit.initialize();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        padding: const EdgeInsets.all(40),
        child: BlocBuilder<LoginCubit, LoginState>(
          bloc: _cubit,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Đăng nhập", style: context.themeHeaderText),
                const SizedBox(height: 16),
                const SizedBox(height: 16),
                InputWidget(
                  controller: accountController,
                  labelText: "Tài khoản",
                  hintText: "Nhập tài khoản",
                ),
                const SizedBox(height: 16),
                InputWidget(
                  controller: passwordController,
                  labelText: "Mật khẩu",
                  hintText: "Nhập mật khẩu",
                ),
                const SizedBox(height: 16),
                ButtonWidget.basic(
                  title: "Đăng nhập",
                  onClickButton: () async {
                    await _cubit.login(
                      accountController.text,
                      passwordController.text,
                      context,
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
