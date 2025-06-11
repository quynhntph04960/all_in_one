import 'dart:js' as js;

import 'package:all_in_one/base/configs_app/app_preference.dart';
import 'package:all_in_one/base/extension/build_context_ext.dart';
import 'package:all_in_one/base/utils/common_function.dart';
import 'package:all_in_one/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'base/widget/loading_dialog.dart';
import 'di/firebase_options.dart';
import 'domain/entities/user_entities.dart';
import 'presentation/demo_page.dart';
import 'presentation/login/login_page.dart';

void requestPermission() {
  js.context.callMethod('Notification', ['requestPermission']).then((result) {
    if (result == 'granted') {
      print('Thông báo đã được cấp quyền.');
    } else {
      print('Không cấp quyền.');
    }
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseConfigApp.initializeFirebase();

  // requestPermission();

  await AppPreferences.init();
  UserEntities? user = await AppPreferences.getUser();
  print('main ------- ${user?.account}');
  if (isNotNullOrEmpty(user)) {
    accountLogin = user!;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    );
    return MaterialApp(
      locale: Locale("vi"),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // tiếng Anh
        Locale('vi', ''), // tiếng Việt
      ],
      theme: ThemeData(
        primaryColor: Colors.blue,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
          actionsIconTheme: IconThemeData(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          border: border,
          errorBorder: border,
          focusedErrorBorder: border,
          enabledBorder: border,
          disabledBorder: border,
          focusedBorder: border,
          iconColor: Colors.black,
          suffixIconColor: Colors.black,
          prefixIconColor: Colors.black,
          hintStyle: context.themeDefaultText.copyWith(
            color: Colors.black.withOpacity(0.5),
          ),
          labelStyle: context.themeDefaultText,
        ),
        textTheme: TextTheme(
          titleLarge: context.themeHeaderText,
          titleMedium: context.themeTitleText,
          titleSmall: context.themeDefaultText,
          labelMedium: context.themeSubText,
        ),
      ),
      navigatorKey: mainGlobalKey,
      home: const MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    loadingDialog = LoadingDialog(mainGlobalKey.currentContext!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isNotNullOrEmpty(accountLogin.account)) {
      return const DemoPage();
    }
    return const LoginPage();
  }
}
