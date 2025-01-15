import 'package:flutter/material.dart';
import 'package:order_delivery_manager/core/constants/strings.dart';

void showSnackBar(BuildContext context, Color color, String text,
    [int delay = 3]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: color,
      duration: const Duration(seconds: 3)));
}

void showCustomAboutDialog(BuildContext context, String title, String content,
    {List<Widget>? actions,
    bool barrierDissmisable = true,
    String type = INFO_TYPE}) {
  showDialog(
    barrierDismissible: barrierDissmisable,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: _getTypeColor(type))),
        backgroundColor: Colors.black.withAlpha(200),
        content: Text(
          content,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: actions ??
            [
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.amber,
                  child: const Text(
                    "ok",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
            ],
      );
    },
  );
}

Color _getTypeColor(String type) {
  switch (type) {
    case ERROR_TYPE:
      return Colors.red;
    case SUCCESS_TYPE:
      return Colors.lightGreen;
    default:
      return Colors.blue;
  }
}
