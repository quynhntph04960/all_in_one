import 'package:all_in_one/base/configs_app/app_colors.dart';
import 'package:all_in_one/base/extension/build_context_ext.dart';
import 'package:flutter/material.dart';

import '../utils/common_function.dart';

class ButtonWidget extends StatefulWidget {
  final Widget? subWidget;
  final EdgeInsetsGeometry? padding, margin;
  final double? width, height;
  final Function()? onClickButton;
  final AlignmentGeometry? alignment;
  final Decoration? decoration;

  const ButtonWidget({
    super.key,
    required this.onClickButton,
    this.width,
    this.height,
    this.margin,
    this.decoration,
    this.subWidget,
    this.alignment,
    this.padding,
  });

  // factory ButtonWidget.custom({
  //   final Widget? subWidget,
  //   final EdgeInsetsGeometry? padding,
  //   final EdgeInsetsGeometry? margin,
  //   final double? width,
  //   final double? height,
  //   final Function()? onClickButton,
  //   final AlignmentGeometry? alignment,
  //   final Decoration? decoration,
  // }) {
  //   return ButtonWidget(
  //     onClickButton: onClickButton,
  //     width: width,
  //     height: height,
  //     margin: margin,
  //     decoration: decoration,
  //     subWidget: subWidget,
  //     alignment: alignment,
  //     padding: padding,
  //   );
  // }

  factory ButtonWidget.basic({
    final Widget? subWidget,
    final EdgeInsetsGeometry? padding,
    final EdgeInsetsGeometry? margin,
    final double? width,
    final double? height,
    required final Function()? onClickButton,
    final AlignmentGeometry? alignment,
    final Decoration? decoration,
    final Color? colorBackground,
    required final String title,
  }) {
    return ButtonWidget(
      onClickButton: onClickButton,
      width: width,
      height: height,
      margin: margin,
      decoration: decoration ??
          BoxDecoration(
            color: colorBackground ?? appColors.colorFF6105,
            borderRadius: BorderRadius.circular(10),
          ),
      subWidget: Text(
        title,
        style: mainGlobalKey.currentContext!.themeTitleText.copyWith(
          color: Colors.white,
        ),
      ),
      alignment: alignment,
      padding: padding ??
          const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 40,
          ),
    );
  }

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool isClick = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!isClick || isNullOrEmpty(widget.onClickButton)) return;

        setState(() {
          isClick = false;
        });

        try {
          await widget.onClickButton?.call();
        } finally {
          // Sau khi hoàn tất hành động, bật lại để có thể nhấn tiếp
          setState(() {
            isClick = true;
          });
        }
      },

      // Màu của hiệu ứng khi được nhấn
      splashColor: Colors.blue.withOpacity(0.5),
      // Đặt highlightColor thành màu trong suốt
      highlightColor: Colors.grey.withOpacity(0.5),
      hoverColor: Colors.grey.withOpacity(0.5),
      overlayColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.grey.withOpacity(0.5);
        }
        // Thực hiện mặc định cho các trạng thái khác
        return Colors.transparent;
      }),
      child: Container(
        alignment: widget.alignment,
        padding: widget.padding,
        margin: widget.margin,
        width: widget.width,
        height: widget.height,
        decoration: widget.decoration,
        child: widget.subWidget,
      ),
    );
  }
}
