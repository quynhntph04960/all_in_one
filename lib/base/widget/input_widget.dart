import 'package:all_in_one/base/extension/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWidget extends StatefulWidget {
  final TextEditingController? controller;
  final TextFieldIconEnum? typeFieldIcon;
  final String? hintText;
  final String? labelText;
  final String? prefixText;
  final int? maxLines, maxLength, minLines;
  final Widget? suffixIcon, prefixIcon, suffix, prefix;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final InputBorder? border;
  final TextStyle? hintStyle, labelStyle, textStyle, prefixStyle;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged, onFieldSubmitted;
  final GestureTapCallback? onTap;
  final bool? filled, isDense, isRequired;
  final bool autofocus;
  final bool enabled;
  final Color? fillColor;
  final TextAlign textAlign;
  final FocusNode? focusNode;
  final InputDecoration? inputDecoration;

  const InputWidget({
    super.key,
    this.inputDecoration,
    this.autofocus = false,
    this.suffix,
    this.prefix,
    this.focusNode,
    this.isDense,
    this.fillColor,
    this.filled,
    this.onFieldSubmitted,
    this.prefixStyle,
    this.onChanged,
    this.onTap,
    this.inputFormatters,
    this.keyboardType,
    this.contentPadding,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.controller,
    this.hintText,
    this.maxLines,
    this.maxLength,
    this.suffixIcon,
    this.enabled = true,
    this.minLines,
    this.prefixIcon,
    this.labelText,
    this.prefixText,
    this.isRequired,
    this.textInputAction,
    this.textAlign = TextAlign.start,
    this.validator,
    this.border,
    this.typeFieldIcon = TextFieldIconEnum.typeDefault,
  });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool isCheckPassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.labelText != null,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: RichText(
              text: TextSpan(
                text: widget.labelText,
                style: widget.labelStyle ??
                    context.themeConfigs.inputDecorationTheme.labelStyle,
                children: [
                  TextSpan(
                    text: widget.isRequired == true ? "*" : "",
                    style: context.themeConfigs.inputDecorationTheme.labelStyle
                        ?.copyWith(color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
        ),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          style: widget.textStyle,
          keyboardType: widget.keyboardType,
          autofocus: widget.autofocus,
          inputFormatters: widget.inputFormatters,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          focusNode: widget.focusNode,
          onFieldSubmitted: widget.onFieldSubmitted,
          textAlign: widget.textAlign,
          textInputAction: widget.textInputAction,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          obscureText: widget.typeFieldIcon == TextFieldIconEnum.typePassword
              ? isCheckPassword
              : false,
          decoration: widget.inputDecoration ??
              InputDecoration(
                // filled = true để cách vào trong 1 khoảng nhất định
                filled: widget.enabled == false ? true : widget.filled,
                isDense: widget.isDense,
                //filled = true thì fillColor mới có màu
                fillColor: widget.fillColor,
                counterText: "",
                enabled: widget.enabled,
                hoverColor: Colors.blue,
                focusColor: Colors.blue,
                contentPadding: widget.contentPadding,
                hintText: widget.hintText,
                hintStyle: widget.hintStyle,
                isCollapsed: false,
                suffix: widget.suffix,
                prefix: widget.prefix,
                border: widget.border,
                errorBorder: widget.border,
                focusedErrorBorder: widget.border,
                enabledBorder: widget.border,
                disabledBorder: widget.border,
                focusedBorder: widget.border,
                prefixStyle: widget.prefixStyle,
                prefixIcon: widget.prefixIcon,
                prefixText: widget.prefixText,
                suffixIcon:
                    widget.typeFieldIcon == TextFieldIconEnum.typePassword
                        ? GestureDetector(
                            onTap: () {
                              isCheckPassword = !isCheckPassword;
                              setState(() {});
                            },
                            child: Icon(
                              isCheckPassword
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off_sharp,
                              // color: Colors.grey,
                            ),
                          )
                        : widget.suffixIcon,
              ),
        ),
      ],
    );
  }
}

enum TextFieldIconEnum { typePassword, typeDefault }
