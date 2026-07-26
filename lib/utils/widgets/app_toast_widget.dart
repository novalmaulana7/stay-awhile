import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:toastification/toastification.dart';

/// Reusable toast notification widget using the [toastification] package.
///
/// All methods are static so they can be called from anywhere with a
/// [BuildContext], without needing to instantiate this class.
///
/// Requires `ToastificationWrapper` to be an ancestor of [MaterialApp]
/// (already configured in `main.dart`).
///
/// ### Commands
/// ```dart
/// // Show an error toast
/// AppToast.showError(context, title: 'Oops', message: 'Try again.');
///
/// // Show a success toast
/// AppToast.showSuccess(context, title: 'Done', message: 'Saved!');
/// ```
class AppToast {
  AppToast._();

  static const Duration _defaultDuration = Duration(seconds: 4);
  static const Alignment _defaultAlignment = Alignment.bottomCenter;

  /// Shows an error toast with [flatColored] style.
  ///
  /// - [title]   – Bold heading (e.g. "Login Failed").
  /// - [message] – Body text explaining the error.
  /// - [duration] – Auto-close delay, defaults to 4 seconds.
  static void showError(
    BuildContext context, {
    required String title,
    required String message,
    Duration duration = _defaultDuration,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      title: Text(title),
      description: Text(message),
      autoCloseDuration: duration,
      alignment: _defaultAlignment,
      primaryColor: AppColors.error,
      backgroundColor: AppColors.errorContainer,
      foregroundColor: AppColors.onErrorContainer,
      borderRadius: BorderRadius.circular(12),
    );
  }

  /// Shows a success toast with [flatColored] style.
  ///
  /// - [title]   – Bold heading (e.g. "Welcome!").
  /// - [message] – Body text describing the success.
  /// - [duration] – Auto-close delay, defaults to 4 seconds.
  static void showSuccess(
    BuildContext context, {
    required String title,
    required String message,
    Duration duration = _defaultDuration,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      title: Text(title),
      description: Text(message),
      autoCloseDuration: duration,
      alignment: _defaultAlignment,
      primaryColor: AppColors.secondary,
      backgroundColor: AppColors.secondaryContainer,
      foregroundColor: AppColors.onSecondaryContainer,
      borderRadius: BorderRadius.circular(12),
    );
  }
}
