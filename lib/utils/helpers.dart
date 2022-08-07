import 'package:find_gym/utils/constants.dart';
import 'package:find_gym/utils/localization.dart';
import 'package:get/get.dart';

void alert(String message) => Get.snackbar(appName, message);

void alertWarning(String message) => Get.snackbar(t("WARNING"), message);

void alertError(String message) => Get.snackbar(t("ERROR"), message);
