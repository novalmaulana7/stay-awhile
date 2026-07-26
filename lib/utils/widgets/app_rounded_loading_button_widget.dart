import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';

/// Reusable animated loading button matching the Stay Awhile design system.
///
/// On press the button shrinks into a circle with a loading spinner,
/// then bounces into a success or error icon before resetting.
///
/// Use the [controller] to drive the animation externally, or simply
/// provide an [onPressed] callback that returns `true`/`false`.
///
/// ```dart
/// final controller = AppRoundedLoadingButtonController();
///
/// AppRoundedLoadingButtonWidget(
///   label: 'Sign In',
///   controller: controller,
///   onPressed: () async {
///     final ok = await login();
///     return ok;
///   },
/// )
/// ```
class AppRoundedLoadingButtonController {
  VoidCallback? _startListener;
  VoidCallback? _stopListener;
  VoidCallback? _successListener;
  VoidCallback? _errorListener;
  VoidCallback? _resetListener;

  void _addListeners({
    required VoidCallback startListener,
    required VoidCallback stopListener,
    required VoidCallback successListener,
    required VoidCallback errorListener,
    required VoidCallback resetListener,
  }) {
    _startListener = startListener;
    _stopListener = stopListener;
    _successListener = successListener;
    _errorListener = errorListener;
    _resetListener = resetListener;
  }

  void start() => _startListener?.call();
  void stop() => _stopListener?.call();
  void success() => _successListener?.call();
  void error() => _errorListener?.call();
  void reset() => _resetListener?.call();
}

class AppRoundedLoadingButtonWidget extends StatefulWidget {
  final String label;
  final Future<bool> Function()? onPressed;
  final AppRoundedLoadingButtonController? controller;
  final bool isEnabled;
  final Color? color;
  final Color? textColor;
  final Color? successColor;
  final Color? errorColor;
  final double height;
  final double width;
  final double loaderSize;
  final double loaderStrokeWidth;
  final double borderRadius;
  final TextStyle? textStyle;
  final Duration duration;
  final Duration completionDuration;
  final Duration resetDuration;
  final bool resetAfterDuration;
  final Curve curve;
  final Curve completionCurve;
  final IconData successIcon;
  final IconData failedIcon;
  final double elevation;

  const AppRoundedLoadingButtonWidget({
    super.key,
    required this.label,
    this.onPressed,
    this.controller,
    this.isEnabled = true,
    this.color,
    this.textColor,
    this.successColor,
    this.errorColor,
    this.height = 56,
    this.width = 300,
    this.loaderSize = 24,
    this.loaderStrokeWidth = 2,
    this.borderRadius = 9999,
    this.textStyle,
    this.duration = const Duration(milliseconds: 500),
    this.completionDuration = const Duration(milliseconds: 1000),
    this.resetDuration = const Duration(seconds: 15),
    this.resetAfterDuration = false,
    this.curve = Curves.easeInOutCirc,
    this.completionCurve = Curves.elasticOut,
    this.successIcon = Icons.check,
    this.failedIcon = Icons.close,
    this.elevation = 8,
  });

  @override
  State<AppRoundedLoadingButtonWidget> createState() =>
      _AppRoundedLoadingButtonWidgetState();
}

enum _ButtonState { idle, loading, success, error }

class _AppRoundedLoadingButtonWidgetState
    extends State<AppRoundedLoadingButtonWidget>
    with TickerProviderStateMixin {
  late AnimationController _buttonController;
  late AnimationController _borderController;
  late AnimationController _completionController;

  late Animation<double> _squeezeAnimation;
  late Animation<double> _bounceAnimation;
  Animation<BorderRadius?>? _borderAnimation;

  _ButtonState _state = _ButtonState.idle;
  Timer? _resetTimer;

  Color get _btnColor => widget.color ?? AppColors.primaryContainer;
  Color get _txtColor => widget.textColor ?? AppColors.onPrimaryContainer;
  Color get _sucColor => widget.successColor ?? AppColors.secondary;
  Color get _errColor => widget.errorColor ?? AppColors.error;

  Duration get _borderDuration =>
      Duration(milliseconds: (widget.duration.inMilliseconds / 2).round());

  @override
  void initState() {
    super.initState();

    _buttonController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _borderController = AnimationController(
      duration: _borderDuration,
      vsync: this,
    );

    _completionController = AnimationController(
      duration: widget.completionDuration,
      vsync: this,
    );

    _squeezeAnimation = Tween<double>(
      begin: widget.width,
      end: widget.height,
    ).animate(CurvedAnimation(parent: _buttonController, curve: widget.curve));

    _bounceAnimation = Tween<double>(begin: 0, end: widget.height).animate(
      CurvedAnimation(
        parent: _completionController,
        curve: widget.completionCurve,
      ),
    );

    _borderAnimation =
        BorderRadiusTween(
              begin: BorderRadius.circular(widget.borderRadius),
              end: BorderRadius.circular(widget.height),
            ).animate(
              CurvedAnimation(
                parent: _borderController,
                curve: Curves.easeInOut,
              ),
            );

    _squeezeAnimation.addListener(() => setState(() {}));
    _borderAnimation!.addListener(() => setState(() {}));
    _bounceAnimation.addListener(() => setState(() {}));

    _squeezeAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed && widget.onPressed != null) {
        _executeCallback();
      }
    });

    widget.controller?._addListeners(
      startListener: _start,
      stopListener: _stop,
      successListener: _success,
      errorListener: _error,
      resetListener: _reset,
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    _borderController.dispose();
    _completionController.dispose();
    _resetTimer?.cancel();
    super.dispose();
  }

  void _start() {
    if (!mounted || _state != _ButtonState.idle) return;
    setState(() => _state = _ButtonState.loading);
    _borderController.forward();
    _buttonController.forward();
    if (widget.resetAfterDuration) _reset();
  }

  void _stop() {
    if (!mounted) return;
    setState(() => _state = _ButtonState.idle);
    _buttonController.reverse();
    _borderController.reverse();
  }

  void _success() {
    if (!mounted) return;
    setState(() => _state = _ButtonState.success);
    _completionController.forward();
    _scheduleReset();
  }

  void _error() {
    if (!mounted) return;
    setState(() => _state = _ButtonState.error);
    _completionController.forward();
    _scheduleReset();
  }

  void _reset() async {
    if (widget.resetAfterDuration) {
      await Future.delayed(widget.resetDuration);
    }
    if (!mounted) return;
    setState(() => _state = _ButtonState.idle);
    _buttonController.reverse();
    _borderController.reverse();
    _completionController.reset();
  }

  void _scheduleReset() {
    _resetTimer?.cancel();
    _resetTimer = Timer(widget.resetDuration, _reset);
  }

  Future<void> _executeCallback() async {
    if (widget.onPressed == null) return;
    try {
      final success = await widget.onPressed!();
      if (!mounted) return;
      if (success) {
        _success();
      } else {
        _error();
      }
    } catch (_) {
      if (!mounted) return;
      _error();
    }
  }

  void _btnPressed() {
    if (!widget.isEnabled || _state != _ButtonState.idle) return;
    _start();
  }

  @override
  Widget build(BuildContext context) {
    final disabled = !widget.isEnabled;

    if (_state == _ButtonState.success) {
      return SizedBox(
        height: widget.height,
        width: widget.height,
        child: Center(
          child: Container(
            width: _bounceAnimation.value,
            height: _bounceAnimation.value,
            decoration: BoxDecoration(color: _sucColor, shape: BoxShape.circle),
            child: _bounceAnimation.value > 20
                ? Icon(widget.successIcon, color: Colors.white)
                : null,
          ),
        ),
      );
    }

    if (_state == _ButtonState.error) {
      return SizedBox(
        height: widget.height,
        width: widget.height,
        child: Center(
          child: Container(
            width: _bounceAnimation.value,
            height: _bounceAnimation.value,
            decoration: BoxDecoration(color: _errColor, shape: BoxShape.circle),
            child: _bounceAnimation.value > 20
                ? Icon(widget.failedIcon, color: Colors.white)
                : null,
          ),
        ),
      );
    }

    final loader = SizedBox(
      height: widget.loaderSize,
      width: widget.loaderSize,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(_txtColor),
        strokeWidth: widget.loaderStrokeWidth,
      ),
    );

    final child = AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: _state == _ButtonState.loading
          ? loader
          : Text(
              widget.label,
              key: const ValueKey('label'),
              style:
                  widget.textStyle ??
                  AppTextStyle.headlineMd.copyWith(color: _txtColor),
            ),
    );

    return SizedBox(
      height: widget.height,
      child: ElevatedButton(
        onPressed: (disabled || _state != _ButtonState.idle)
            ? null
            : _btnPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(_squeezeAnimation.value, widget.height),
          backgroundColor: _btnColor,
          disabledBackgroundColor: _btnColor.withValues(alpha: 0.4),
          foregroundColor: _txtColor,
          elevation: disabled ? 0 : widget.elevation,
          shadowColor: _btnColor.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(borderRadius: _borderAnimation!.value!),
          padding: EdgeInsets.zero,
        ),
        child: child,
      ),
    );
  }
}
