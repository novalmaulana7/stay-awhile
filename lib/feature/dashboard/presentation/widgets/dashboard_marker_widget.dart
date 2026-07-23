import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';

class DashboardMarkerWidget extends StatelessWidget {
  final String message;
  final String icon;
  final bool isOwn;
  final VoidCallback? onTap;

  const DashboardMarkerWidget({
    super.key,
    required this.message,
    required this.icon,
    this.isOwn = false,
    this.onTap,
  });

  IconData _getIconData() {
    switch (icon) {
      case 'park':
        return Icons.park;
      case 'coffee':
        return Icons.coffee;
      case 'camera':
        return Icons.camera_alt;
      default:
        return Icons.place;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: isOwn ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: isOwn ? AppColors.secondary : AppColors.surfaceContainerHighest,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isOwn ? 16 : 4),
                bottomRight: Radius.circular(isOwn ? 4 : 16),
              ),
              border: isOwn ? null : Border.all(color: AppColors.outlineVariant),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getIconData(),
                  size: 16,
                  color: isOwn ? AppColors.onTertiary : AppColors.onSurfaceVariant,
                ),
                const SizedBox(width: 6),
                Text(
                  message,
                  style: AppTextStyle.labelSm.copyWith(
                    color: isOwn ? AppColors.onTertiary : AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 12,
            height: 12,
            transform: Matrix4.rotationZ(0.785398),
            margin: const EdgeInsets.only(left: 1),
            decoration: BoxDecoration(
              color: isOwn ? AppColors.secondary : AppColors.surfaceContainerHighest,
              border: isOwn ? null : Border.all(color: AppColors.outlineVariant),
            ),
          ),
        ],
      ),
    );
  }
}
