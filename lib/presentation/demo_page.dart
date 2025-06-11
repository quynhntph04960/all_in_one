import 'dart:typed_data';

import 'package:all_in_one/base/configs_app/app_constant.dart';
import 'package:all_in_one/base/utils/common_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import '../base/utils/common_date_time.dart';
import '../base/utils/common_function.dart';
import '../base/utils/file_utils.dart';
import '../base/widget/button_widget.dart';
import '../base/widget/dropdown_widget.dart';
import '../chat/presentation/list_user/list_user_page.dart';
import 'login/login_cubit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  Uint8List? filename = Uint8List(0);
  String fullDate = "";
  String date = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(resultModel?.data ?? "abcc")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropDownWidget(
                    onTap: () async {
                      final result = await FileUtils.selectFilePicker();
                      filename = result![0].bytes;
                      setState(() {});
                    },
                    labelText: "Selected Image",
                  ),
                ),
                Expanded(
                  child: DropDownWidget(
                    onTap: () async {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2019, 3, 5),
                          maxTime: DateTime(2025, 6, 7), onChanged: (date) {
                        print('change $date');
                      }, onConfirm: (date) {
                        fullDate = dateTimeToString(date);
                        setState(() {});
                        print('confirm $date');
                      }, currentTime: DateTime.now(), locale: LocaleType.vi);
                    },
                    labelText: 'Selected Date Time',
                    value: fullDate,
                  ),
                ),
                Expanded(
                  child: DropDownWidget(
                    onTap: () async {
                      final dateTime = await showDatePicker(
                        locale: Locale("vi"),
                        cancelText: "Hủy",
                        confirmText: "Chọn",
                        helpText: "Chọn ngày",
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2019),
                        lastDate: DateTime(2026),
                      );
                      if (isNullOrEmpty(dateTime)) return;
                      date = dateTimeToString(dateTime!,
                          format: AppConstant.ddMmYyyy);
                      setState(() {});
                    },
                    labelText: 'Selected Date',
                    value: date,
                  ),
                ),
              ],
            ),
            Text("Ảnh File"),
            Visibility(
              visible: !isNullOrEmpty(filename),
              child: Container(
                height: 200,
                child: Image.memory(
                  filename ?? Uint8List(0),
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            Text("Ảnh network"),
            Container(
              height: 200,
              child: Image.network(
                resultModel?.avatar ?? "",
                width: 200,
                height: 200,
                errorBuilder: (_, __, ___) {
                  return Icon(
                    Icons.error_outline_outlined,
                    size: 32,
                    color: Colors.red,
                  );
                },
              ),
            ),
            ButtonWidget.basic(
              title: "Firebase",
              onClickButton: () async {
                pushPage(context, ListUserPage());
              },
            )
          ],
        ),
      ),
    );
  }
}
