import 'package:flutter/material.dart';

extension SnackBarExtension on BuildContext {
  void showSnackBar(String message, {Duration? duration}) {
    if (message.trim().isEmpty) return;

    ScaffoldMessenger.of(this)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Row(children: [Expanded(child: Text(message))]),
          duration: duration ?? const Duration(seconds: 4),
        ),
      );
  }
}
