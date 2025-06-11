import 'package:all_in_one/base/extension/build_context_ext.dart';
import 'package:flutter/material.dart';

import 'input_widget.dart';

class DropDownWidget extends StatelessWidget {
  final String? hintText, labelText, value;
  final EdgeInsetsGeometry? padding;
  final IconData? suffixIcon;
  final Function()? onTap;
  final bool? isRequired;
  final bool isEnable;
  final TextAlign? textAlign;

  const DropDownWidget({
    super.key,
    this.hintText,
    this.labelText,
    this.value,
    this.suffixIcon,
    this.padding,
    this.onTap,
    this.isRequired,
    this.textAlign,
    this.isEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Visibility(
            visible: labelText != null,
            child: RichText(
              text: TextSpan(
                text: labelText,
                style: context.themeDefaultText,
                children: [
                  TextSpan(
                    text: isRequired == true ? "*" : "",
                    style: context.themeDefaultText.copyWith(color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.only(right: 8, top: 0, bottom: 0),
            // decoration: BoxDecoration(
            //   color: isEnable == false ? Colors.grey : null,
            //   borderRadius: BorderRadius.circular(4),
            //   border: Border.all(color: Colors.grey, width: 0.5),
            // ),
            child: GestureDetector(
              onTap: isEnable == true ? onTap : null,
              child: InputWidget(
                enabled: false,
                fillColor: Colors.transparent,
                controller: TextEditingController(text: value),
                hintText: hintText,
                textStyle:
                    context.themeDefaultText.copyWith(color: Colors.black),
                suffixIcon: Visibility(
                  visible: isEnable,
                  child: Icon(
                    suffixIcon ?? Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
