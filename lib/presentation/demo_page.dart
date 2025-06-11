import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import '../base/utils/common_function.dart';
import '../base/utils/file_utils.dart';
import 'login/login_cubit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  Uint8List? filename = Uint8List(0);

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
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () async {
                          final result = await FileUtils.selectFilePicker();
                          filename = result![0].bytes;
                          setState(() {});
                        },
                        child: Text(
                          'Selected Image',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      Visibility(
                        visible: !isNullOrEmpty(filename),
                        child: Image.memory(
                          filename ?? Uint8List(0),
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () async {
                          DatePicker.showDateTimePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2019, 3, 5),
                              maxTime: DateTime(2025, 6, 7), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            print('confirm $date');
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.vi);
                        },
                        child: Text(
                          'Selected Date Time',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      Visibility(
                        visible: !isNullOrEmpty(filename),
                        child: Image.memory(
                          filename ?? Uint8List(0),
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () async {
                          await showDatePicker(
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
                        },
                        child: Text(
                          'Selected Date',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      Visibility(
                        visible: !isNullOrEmpty(filename),
                        child: Image.memory(
                          filename ?? Uint8List(0),
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Image.network(
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
          ],
        ),
      ),
    );
  }
}
