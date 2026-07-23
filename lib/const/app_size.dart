import 'package:flutter/material.dart';

class AppSize {
  AppSize._();

  // ── Spacing (based on 4px unit) ──
  static const double spacingXs = 4;
  static const double spacingSm = 8;
  static const double spacingMd = 16;
  static const double spacingLg = 24;
  static const double spacingXl = 40;
  static const double gutter = 16;
  static const double marginMobile = 20;
  static const double marginDesktop = 64;

  // ── Border radius ──
  static const double radiusSm = 4;
  static const double radiusMd = 8;
  static const double radiusLg = 12;
  static const double radiusXl = 16;
  static const double radiusFull = 9999;

  // ── Responsive helpers ──

  /// Get screen height
  static double screenHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  /// Get screen width
  static double screenWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  /// Get height as percentage of screen height
  static double heightPercent(BuildContext context, double percent) =>
      screenHeight(context) * percent;

  /// Get width as percentage of screen width
  static double widthPercent(BuildContext context, double percent) =>
      screenWidth(context) * percent;

  /// Check if device is mobile (< 600px)
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 600;

  /// Check if device is tablet (600px – 1024px)
  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 600 &&
      MediaQuery.sizeOf(context).width < 1024;

  /// Check if device is desktop (>= 1024px)
  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1024;
}