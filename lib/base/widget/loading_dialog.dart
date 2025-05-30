import 'package:flutter/material.dart';
import 'package:synchronized/synchronized.dart';

LoadingDialog? loadingDialog;

void showLoading() {
  loadingDialog?.show();
}

void hideLoading() {
  loadingDialog?.hide();
}

class LoadingDialog {
  final _lock = Lock();
  bool _isShowing = false;
  double progress = 0.0; // Biến trạng thái cho tiến trình

  int totalLoading = 0;

  late BuildContext context;
  late BuildContext dialogContext; // Save the context of the dialog

  LoadingDialog(this.context);

  Future show({bool isShowImmediate = false}) async {
    await _lock.synchronized(() async {
      totalLoading++;
      if (isShowImmediate) {
        if (!_isShowing) {
          _showLoading();
          _isShowing = true;
        }
      } else if (totalLoading == 1 && !_isShowing) {
        if (context.mounted) {
          Future.delayed(Duration.zero, () {
            if (totalLoading > 0 && !_isShowing) {
              _showLoading();
              _isShowing = true;
            }
          });
        }
      }
    });
  }

  Future hide() async {
    await _lock.synchronized(() async {
      if (totalLoading == 0) return;
      totalLoading--;
      if (totalLoading == 0 && _isShowing) {
        _hideLoading();
        _isShowing = false;
      }
    });
  }

  void clear() {
    while (totalLoading > 0) {
      hide();
    }
  }

  // Cập nhật tiến trình từ bên ngoài
  void updateProgress(double newProgress) {
    progress = newProgress;
    if (_isShowing) {
      // Cập nhật UI của hộp thoại với tiến trình mới
      (dialogContext as Element).markNeedsBuild();
    }
  }

  Future<void> _showLoading() async {
    if (!context.mounted) {
      return;
    }
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        dialogContext = context;
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Container(
                  // width: 88,
                  // height: 88,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Visibility(
                      //   visible: !kIsWeb,
                      //   replacement: const CircularProgressIndicator(),
                      //   child: Lottie.asset(
                      //     'assets/json_image/loading.json',
                      //     width: 100,
                      //     height: 100,
                      //   ),
                      // ),
                      // Text(
                      //   '${(progress * 100).toStringAsFixed(1)}%',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //   ),
                      // ),
                      const Text(
                        'Đang tải',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(500),
                          value: progress * 100,
                          minHeight: 9,
                          backgroundColor: Colors.white, // Màu nền progress
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.blue,
                          ), // Màu progress
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) {
      totalLoading = 0;
      _isShowing = false;
    });
  }

  void _hideLoading() {
    Navigator.of(context, rootNavigator: true).pop(); //close the dialog
  }
}
