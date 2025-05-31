import 'package:flutter/material.dart';

/// An alert dialog with confirmation buttons
///
///
class ConfirmationDialog extends StatelessWidget {
  /// The content of the dialog
  final String message;

  /// The label of the confirmation button
  final String? confirmLabel;

  /// The confirmation callback
  final Function? onConfirm;

  /// The cancelation callback
  final Function? onCancel;

  /// The label of the cancel button
  final String? cancelLabel;

  /// The title of the dialog
  final String? title;

  const ConfirmationDialog({
    super.key,
    required this.message,
    this.title,
    this.onConfirm,
    this.confirmLabel,
    this.onCancel,
    this.cancelLabel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? "Confirmation"),
      content: Text(message),
      actions: [
        ElevatedButton(
          onPressed: () {
            onConfirm?.call();
            Navigator.pop(context);
          },
          child: Text(confirmLabel ?? "Confirm"),
        ),
        TextButton(
          onPressed: () {
            onCancel?.call();
            Navigator.pop(context);
          },
          child: Text(cancelLabel ?? "Cancel"),
        ),
      ],
    );
  }
}
