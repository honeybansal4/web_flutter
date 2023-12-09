import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

class CommonSnackBar {
  static getSuccessSnackBar(BuildContext context, String message) {
    // Get.snackbar(
    //   "",
    //   "",
    //   maxWidth: width / 2,
    //   duration: Duration(seconds: 2),
    //   messageText: Text(message,
    //       overflow: TextOverflow.ellipsis,
    //       style: const TextStyle(
    //         color: Colors.white,
    //         fontSize: 14,
    //       )),
    //   snackPosition: SnackPosition.BOTTOM,
    //   backgroundColor: color,
    //   borderRadius: 20,
    //   margin: const EdgeInsets.all(0),
    //   colorText: Colors.white,
    //   isDismissible: true,
    //   dismissDirection: DismissDirection.horizontal,
    // );
    AnimatedSnackBar.rectangle(
      'Successfully',
      '$message',
      duration: Duration(seconds: 2),
      desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      type: AnimatedSnackBarType.success,
      brightness: Brightness.dark,
    ).show(
      context,
    );
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     width: width / 2,
    //     backgroundColor: color,
    //     duration: Duration(milliseconds: 600),
    //     behavior: SnackBarBehavior.floating,
    //     content: Text(
    //       message,
    //       style: const TextStyle(color: Colors.white),
    //     ),
    //   ),
    // );
  }

  static getFailedSnackBar(BuildContext context, String message) {
    AnimatedSnackBar.rectangle(
      'Failed',
      '$message',
      duration: Duration(seconds: 2),
      desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      type: AnimatedSnackBarType.error,
      brightness: Brightness.dark,
    ).show(
      context,
    );
  }

  static getWarningSnackBar(BuildContext context, String message) {
    AnimatedSnackBar.rectangle(
      'Warning',
      '$message',
      duration: Duration(seconds: 2),
      desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      type: AnimatedSnackBarType.warning,
      brightness: Brightness.dark,
    ).show(
      context,
    );
  }
}
