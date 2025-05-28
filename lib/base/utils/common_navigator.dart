import 'package:flutter/material.dart';

Future pushPage(BuildContext context, Widget page, {String? name}) {
  return Navigator.of(context).push(
    _pageBuilder(page),
  );
}

Future pushAndRemoveUntil(BuildContext context, Widget page, {String? name}) {
  return Navigator.of(context).pushAndRemoveUntil(
    _pageBuilder(page),
    ModalRoute.withName(name ?? ""),
  );
}

Route _pageBuilder(Widget page) {
  return SlideRightRoute(page: page);
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;

  SlideRightRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          barrierColor: Colors.transparent,
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
