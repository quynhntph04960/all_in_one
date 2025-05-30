import 'package:all_in_one/base/extension/build_context_ext.dart';
import 'package:flutter/material.dart';

import 'base/widget/loading_dialog.dart';
import 'di/firebase_options.dart';
import 'presentation/login/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseConfigApp.initializeFirebase();

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
    return const LoginPage();
  }
}
