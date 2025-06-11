library;

import 'package:flutter/material.dart';
import 'package:logger/web.dart';


class Constants {
  // sized box
  static SizedBox height5(Size size) {
    return SizedBox(height: size.height * 0.005);
  }

  static SizedBox height10(Size size) {
    return SizedBox(height: size.height * 0.011);
  }

  static SizedBox height20(Size size) {
    return SizedBox(height: size.height * 0.022);
  }

  static SizedBox widtht5(Size size) {
    return SizedBox(width: size.width * 0.012);
  }

  static SizedBox widtht10(Size size) {
    return SizedBox(width: size.width * 0.023);
  }

  static SizedBox widtht20(Size size) {
    return SizedBox(width: size.width * 0.033);
  }

  // colors
  static const whiteColor = Colors.white;
  static const blackColor = Colors.black;
  static const tileColor = Color.fromARGB(255, 185, 223, 252);
  static const greyColor = Colors.grey;
  static const redColor = Colors.red;
  static const themeBlue = Color.fromARGB(255, 1, 91, 164);
  static const themeOrange = Color(0xffF36629);
  static const themeGreen = Color(0xff0E6B39);

  // text theme
  static TextStyle appBarTitleStyle(Size size) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: size.height * 0.023,
    );
  }

  static TextStyle headingStyle(Size size) {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: size.height * 0.018,
      color: Colors.black,
    );
  }

  static TextStyle mainHeadingStyle(Size size) {
    return TextStyle(
      fontSize: size.height * 0.02,
      fontWeight: FontWeight.w500,
      color: Constants.blackColor,
    );
  }

  static TextStyle subtitleStyle(Size size) {
    return TextStyle(
      fontSize: size.height * 0.014,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle normalStyle(Size size) {
    return TextStyle(
      fontSize: size.height * 0.0158,
    );
  }

  static TextStyle normalTitleStyle(Size size) {
    return TextStyle(
      fontSize: size.height * 0.0158,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle largeStyle(Size size) {
    return TextStyle(
      fontSize: size.height * 0.02,
      color: Constants.blackColor,
    );
  }

  static TextStyle buttonStyle(Size size) {
    return TextStyle(
      fontSize: size.height * 0.022,
      fontWeight: FontWeight.w500,
    );
  }

  // Logger
  static final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
  );

  // snackbar
  static showSnackbar(context, String text) {
    final snackbar = SnackBar(
      content: Text(text),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  // Alert Box
  static Future<Object?> showAlertBox({
    required BuildContext context,
    required String title,
    required String message,
    required AlertType type,
    VoidCallback? onOkPressed,
  }) {
    Size size = MediaQuery.of(context).size;

    Color getColor() {
      switch (type) {
        case AlertType.success:
          return Colors.green;
        case AlertType.failure:
          return Colors.red;
        case AlertType.pending:
          return Colors.orange;
      }
    }

    Color getTitleColor() {
      switch (type) {
        case AlertType.success:
          return Colors.green.shade700;
        case AlertType.failure:
          return Colors.red.shade700;
        case AlertType.pending:
          return Colors.orange.shade700;
      }
    }

    IconData getIcon() {
      switch (type) {
        case AlertType.success:
          return Icons.check_circle_outline;
        case AlertType.failure:
          return Icons.close;
        case AlertType.pending:
          return Icons.pending_outlined;
      }
    }

    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
          ),
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding: EdgeInsets.zero,
            content: Container(
              width: size.width * 0.8,
              padding: EdgeInsets.all(size.height * 0.025),
              decoration: BoxDecoration(
                color: Constants.whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(size.height * 0.015),
                    decoration: BoxDecoration(
                      color: getColor().withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      getIcon(),
                      color: getColor(),
                      size: size.height * 0.06,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: size.height * 0.025,
                      fontWeight: FontWeight.bold,
                      color: getTitleColor(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: size.height * 0.015),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: size.height * 0.023,
                      color: Constants.blackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: size.height * 0.025),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (onOkPressed != null) onOkPressed();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: getColor(),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.1,
                          vertical: size.height * 0.015),
                    ),
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontSize: size.height * 0.018,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Circular Indicator
  static showCircularProgress() {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.orange,
        strokeWidth: 5,
      ),
    );
  }
}

enum AlertType { success, failure, pending }
