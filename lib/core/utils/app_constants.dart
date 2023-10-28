import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../src/presentation/widgets/custom_text.dart';

class AppConstants {
  AppConstants._();

  static showSnackBar({
    required BuildContext context,
    required String message,
    Color? color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          alignment: Alignment.center,
          child: CustomText(
            title: message,
            color: color ?? Colors.red,
          ),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  static AwesomeDialog showAwesomeDialog({
    required BuildContext context,
    required DialogType dialogType,
    required String dialogTitle,
    required String message,
    required Color titleColor,
    Color? textColor,
    String? btnOkText,
    String? btnCancelText,
    VoidCallback? onCancelTap,
    VoidCallback? onOkTap,
    void Function(DismissType)? onDismissCallback,
  }) {
    return AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.bottomSlide,
      title: dialogTitle,
      titleTextStyle: TextStyle(
        color: titleColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      desc: message,
      descTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: textColor,
      ),
      btnOkOnPress: onOkTap,
      onDismissCallback: onDismissCallback,
      btnCancelOnPress: onCancelTap,
      btnOkText: btnOkText,
      btnCancelText: btnCancelText,
    )..show();
  }
}
