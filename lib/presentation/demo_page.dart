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
      appBar: AppBar(title: Text("demo")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            DropDownWidget(
              onTap: () async {
                final result = await FileUtils.selectFilePicker();
                filename = result![0].bytes;
                setState(() {});
              },
              labelText: "Selected Image",
            ),
            Row(
              children: [
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
                height: 100,
                child: Image.memory(
                  filename ?? Uint8List(0),
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            Text("Ảnh network"),
            Container(
              height: 100,
              child: Image.network(
                resultModel?.avatar ?? "",
                width: 100,
                height: 100,
                errorBuilder: (_, __, ___) {
                  return Icon(
                    Icons.error_outline_outlined,
                    size: 32,
                    color: Colors.red,
                  );
                },
              ),
            ),
            Text("Ảnh svg"),
            // Container(
            //   height: 100,
            //   child: SvgPicture.asset(
            //     "assets/svg/native.svg",
            //     semanticsLabel: 'Dart Logo',
            //   ),
            // ),
            Text("Ảnh assets1"),
            Container(
              color: Colors.red,
              width: 100,
              height: 100,
              alignment: Alignment.center,
              child: Image.asset(
                "anh/voucher_coupon.png",
                errorBuilder: (_, __, ___) {
                  return Container(
                    color: Colors.orange,
                    width: 90,
                    height: 90,
                  );
                },
              ),
            ),
            ButtonWidget.basic(
              title: "Firebase",
              onClickButton: () async {
                Navigator.pushNamed(context, '/user');
                return;
                pushPage(context, UserListPage());
              },
            ),
            ButtonWidget.basic(
              title: "Move Page",
              onClickButton: () async {
                Navigator.pushNamed(context, '/movePage');
                return;
                pushPage(context, UserListPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
