import 'package:flutter/material.dart';

showLoadingDialog({required BuildContext context}) {
  showDialog(
    context: context,
      barrierDismissible:false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        content: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "images/logo.png",
              width: 80,
              height: 80,
            ),
            const SizedBox(
              height: 100.0,
              width: 100.0,
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    },
  );
}