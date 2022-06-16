import 'package:flutter_easyloading/flutter_easyloading.dart';

class ToastUtil {
  static info(String msg) {
    EasyLoading.showToast(msg);
  }

  static error(String msg) {
    EasyLoading.showError(
      msg,
    );
  }
}
