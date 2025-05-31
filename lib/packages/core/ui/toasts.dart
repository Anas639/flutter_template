import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

/// Shows a sucess toast
///
/// [message] - The message to be displayed
///
/// [description] - An optional description
///
///
/// Returns a [Function] that dismises the toast when called
Function showSuccessToast(
  BuildContext context, {
  required String message,
  String? description,
}) {
  var toast = toastification.show(
    context: context,
    title: Text(
      message,
      maxLines: 3,
    ),
    description: description == null ? null : Text(description),
    type: ToastificationType.success,
    style: ToastificationStyle.minimal,
    autoCloseDuration: const Duration(seconds: 3),
  );
  return () => toastification.dismiss(
        toast,
      );
}

/// Shows an error toast
///
/// [error] - The error message to be displayed
///
/// [description] - An optional description
///
///
/// Returns a [Function] that dismises the toast when called
Function showErrorToast(
  BuildContext context, {
  required String error,
  String? description,
}) {
  var toast = toastification.show(
    context: context,
    title: Text(
      error,
      maxLines: 3,
    ),
    description: description == null ? null : Text(description),
    type: ToastificationType.error,
    style: ToastificationStyle.minimal,
    autoCloseDuration: const Duration(seconds: 3),
  );
  return () => toastification.dismiss(
        toast,
      );
}
