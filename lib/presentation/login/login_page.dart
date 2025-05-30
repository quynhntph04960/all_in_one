import 'package:all_in_one/base/extension/build_context_ext.dart';
import 'package:all_in_one/base/utils/common_function.dart';
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
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [Colors.blue, Colors.white],
        //     begin: Alignment.topRight,
        //     end: Alignment.bottomLeft,
        //   ),
        // ),
        padding: const EdgeInsets.all(40),
        child: BlocBuilder<LoginCubit, LoginState>(
          bloc: _cubit,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text("Đăng nhập", style: context.themeHeaderText),
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 16),
                InputWidget(
                  controller: accountController,
                  labelText: "Tài khoản",
                  hintText: "Nhập tài khoản",
                  onChanged: (value) => setState(() {}),
                ),
                const SizedBox(height: 16),
                InputWidget(
                  controller: passwordController,
                  labelText: "Mật khẩu",
                  hintText: "Nhập mật khẩu",
                  onChanged: (value) => setState(() {}),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 32),
                  child: InkWell(
                    onTap: _cubit.registerAccount,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(
                            state.isNotAccount != true
                                ? Icons.square_outlined
                                : Icons.check_box_sharp,
                            color: state.isNotAccount != true
                                ? Colors.grey
                                : Colors.green,
                          ),
                          Text(
                            "  Chưa có tài khoản",
                            style: context.themeTitleText.copyWith(
                              color: state.isNotAccount != true
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: ButtonWidget.basic(
                    title: "Đăng nhập",
                    colorBackground: isValidate() ? Colors.grey : null,
                    onClickButton: () async {
                      if (isValidate()) return;
                      await _cubit.login(
                        accountController.text,
                        passwordController.text,
                        context,
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  bool isValidate() {
    if (isNullOrEmpty(accountController.text) ||
        isNullOrEmpty(passwordController.text)) {
      return true;
    }
    return false;
  }
}
