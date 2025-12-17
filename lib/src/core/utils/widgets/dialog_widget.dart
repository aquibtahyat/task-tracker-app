import 'package:flutter/material.dart';

class ShowDialog {
  ShowDialog._({
    required this.context,
    required this.title,
    this.message,
    this.isDismissible = true,
  });

  final BuildContext context;
  final String title;
  final String? message;
  final bool isDismissible;

  static Future<bool?> yesNo(
    BuildContext context,
    String title, {
    String? message,
    String? yesText,
    String? noText,
    VoidCallback? onYes,
    VoidCallback? onNo,
    bool isDismissible = true,
  }) async {
    final dialog = ShowDialog._(
      context: context,
      title: title,
      message: message,
      isDismissible: isDismissible,
    );

    return dialog._showYesNoDialog(
      yesText: yesText,
      noText: noText,
      onYes: onYes,
      onNo: onNo,
    );
  }

  static Future<bool?> confirmation(
    BuildContext context,
    String title, {
    String? message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isDismissible = true,
  }) async {
    final dialog = ShowDialog._(
      context: context,
      title: title,
      message: message,
      isDismissible: isDismissible,
    );

    return dialog._showConfirmationDialog(
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  Future<bool?> _showYesNoDialog({
    String? yesText,
    String? noText,
    VoidCallback? onYes,
    VoidCallback? onNo,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: isDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(20),
          insetPadding: const EdgeInsets.all(12),
          actionsPadding: EdgeInsets.zero,
          title: Text(title, textAlign: TextAlign.center),
          content: _buildContent(),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            TextButton(
              key: const Key('noButton'),
              onPressed: () {
                Navigator.of(context).pop(false);
                onNo?.call();
              },
              child: Text(noText ?? 'No'),
            ),
            TextButton(
              key: const Key('yesButton'),
              onPressed: () {
                Navigator.of(context).pop(true);
                onYes?.call();
              },
              child: Text(yesText ?? 'Yes'),
            ),
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        );
      },
    );
  }

  Future<bool?> _showConfirmationDialog({
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: isDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(20),
          insetPadding: const EdgeInsets.all(12),
          actionsPadding: EdgeInsets.zero,
          title: Text(title, textAlign: TextAlign.center),
          content: _buildContent(),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            TextButton(
              key: const Key('cancelButton'),
              onPressed: () {
                Navigator.of(context).pop(false);
                onCancel?.call();
              },
              child: Text(cancelText ?? 'Cancel'),
            ),
            TextButton(
              key: const Key('confirmButton'),
              onPressed: () {
                Navigator.of(context).pop(true);
                onConfirm?.call();
              },
              child: Text(confirmText ?? 'Ok'),
            ),
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (message != null) ...[
          const SizedBox(height: 12),
          Text(message!, textAlign: TextAlign.start),
        ],
      ],
    );
  }
}
