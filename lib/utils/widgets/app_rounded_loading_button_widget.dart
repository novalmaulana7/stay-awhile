import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';

/// Reusable rounded loading button matching the Stay Awhile design system.
///
/// Shows a loading spinner on press, then success/error icon before resetting.
/// The caller provides an [onPressed] callback that returns `true` for
/// success or `false` for error.
///
/// ```dart
/// AppRoundedLoadingButtonWidget(
///   label: 'Sign In',
///   onPressed: () async {
///     final ok = await login();
///     return ok;
///   },
/// )
/// ```
class AppRoundedLoadingButtonWidget extends StatefulWidget {
  final String label;
  final Future<bool> Function() onPressed;
  final bool isEnabled;
  final Color? color;
  final Color? textColor;
  final Color? successColor;
  final Color? errorColor;
  final double? height;
  final double? borderRadius;
  final TextStyle? textStyle;
  final Duration? resetDuration;

  const AppRoundedLoadingButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
    this.isEnabled = true,
    this.color,
    this.textColor,
    this.successColor,
    this.errorColor,
    this.height,
    this.borderRadius,
    this.textStyle,
    this.resetDuration,
  });

  @override
  State<AppRoundedLoadingButtonWidget> createState() =>
      _AppRoundedLoadingButtonWidgetState();
}

enum _ButtonState { idle, loading, success, error }

class _AppRoundedLoadingButtonWidgetState
    extends State<AppRoundedLoadingButtonWidget>
    with SingleTickerProviderStateMixin {
  _ButtonState _state = _ButtonState.idle;
  Timer? _resetTimer;

  @override
  void dispose() {
    _resetTimer?.cancel();
    super.dispose();
  }

  void _reset() {
    if (mounted) {
      setState(() => _state = _ButtonState.idle);
    }
  }

  Future<void> _handlePressed() async {
    if (_state != _ButtonState.idle) return;

    setState(() => _state = _ButtonState.loading);

    try {
      final success = await widget.onPressed();
      if (!mounted) return;
      setState(() {
        _state = success ? _ButtonState.success : _ButtonState.error;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _state = _ButtonState.error);
    }

    _resetTimer?.cancel();
    _resetTimer = Timer(
      widget.resetDuration ?? const Duration(seconds: 3),
      _reset,
    );
  }

  @override
  Widget build(BuildContext context) {
    final btnColor = widget.color ?? AppColors.primaryContainer;
    final txtColor = widget.textColor ?? AppColors.onPrimaryContainer;
    final sucColor = widget.successColor ?? AppColors.secondary;
    final errColor = widget.errorColor ?? AppColors.error;
    final h = widget.height ?? 56;
    final br = widget.borderRadius ?? 9999;
    final disabled = !widget.isEnabled;

    return SizedBox(
      height: h,
      width: double.infinity,
      child: Material(
        color: switch (_state) {
          _ButtonState.idle => disabled
              ? btnColor.withValues(alpha: 0.4)
              : btnColor,
          _ButtonState.loading => btnColor,
          _ButtonState.success => sucColor,
          _ButtonState.error => errColor,
        },
        elevation: disabled ? 0 : 8,
        shadowColor: btnColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(br),
        child: InkWell(
          onTap: (_state == _ButtonState.idle && !disabled)
              ? _handlePressed
              : null,
          borderRadius: BorderRadius.circular(br),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: switch (_state) {
              _ButtonState.loading => SizedBox(
                key: const ValueKey('loading'),
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(txtColor),
                ),
              ),
              _ButtonState.success => Icon(
                Icons.check_rounded,
                key: const ValueKey('success'),
                color: Colors.white,
                size: 24,
              ),
              _ButtonState.error => Icon(
                Icons.close_rounded,
                key: const ValueKey('error'),
                color: Colors.white,
                size: 24,
              ),
              _ButtonState.idle => Text(
                widget.label,
                key: const ValueKey('idle'),
                style:
                    widget.textStyle ??
                    AppTextStyle.headlineMd.copyWith(color: txtColor),
              ),
            },
          ),
        ),
      ),
    );
  }
}
