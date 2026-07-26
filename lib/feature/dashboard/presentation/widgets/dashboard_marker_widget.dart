import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';

class DashboardMarkerWidget extends StatelessWidget {
  final String message;
  final bool isOwn;
  final double markerLat;
  final double userLat;
  final VoidCallback? onTap;

  const DashboardMarkerWidget({
    super.key,
    required this.message,
    required this.markerLat,
    required this.userLat,
    this.isOwn = false,
    this.onTap,
  });

  bool get _bubbleAbove => markerLat >= userLat;

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isOwn
        ? AppColors.secondary
        : AppColors.surfaceContainerHighest;
    final textColor = isOwn ? AppColors.onTertiary : AppColors.onSurfaceVariant;
    final borderColor = isOwn
        ? null
        : Border.all(color: AppColors.outlineVariant);

    final pointWidget = Container(
      width: 12,
      height: 12,
      transform: Matrix4.rotationZ(0.785398),
      decoration: BoxDecoration(color: bubbleColor, border: borderColor),
    );

    final bubbleWidget = GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(16),
          border: borderColor,
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          message,
          style: AppTextStyle.labelSm.copyWith(color: textColor),
        ),
      ),
    );

    if (_bubbleAbove) {
      // pesan di atas user → bubble naik ke atas
      return Column(
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: [pointWidget, const SizedBox(height: 4), bubbleWidget],
      );
    } else {
      // pesan di bawah user → bubble turun ke bawah
      return Column(
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.up,
        children: [pointWidget, const SizedBox(height: 4), bubbleWidget],
      );
    }
  }
}
