import 'package:get/get.dart';

void showCustumeSnackBar(String message,
    {bool isError = true, String title = "Error"}) {
  Get.snackbar(title, message);
}
