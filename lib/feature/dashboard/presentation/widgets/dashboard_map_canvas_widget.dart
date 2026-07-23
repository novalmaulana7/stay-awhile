import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/feature/dashboard/data/models/dashboard_model.dart';
import 'package:stay_awhile_mobile/feature/dashboard/presentation/widgets/dashboard_marker_widget.dart';

class DashboardMapCanvasWidget extends StatelessWidget {
  final List<MapMarker> markers;
  final ValueChanged<MapMarker>? onMarkerTap;

  const DashboardMapCanvasWidget({
    super.key,
    required this.markers,
    this.onMarkerTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFFE0DED7),
          ),
          child: CustomPaint(
            painter: _MapTexturePainter(),
            size: Size.infinite,
          ),
        ),
        Positioned.fill(
          child: Opacity(
            opacity: 0.4,
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuCl9U0INpXHom7pl5qZY9odLTolNnlmCDe_MVOZPhRTtD7azqeoirwODHqw6_rcsKC2cs55lFFXL9aODCS5pyV8RWLAxrzOtLF_UUWhloceKGNs-OlQPd5l5yBo6byZ2QA-_YyKGYIegZ1ZbDeeHx8FKkNBVOSWqlcNanH07CVedCBn68f9rvM_hEQDpMP6Z-ntfB8CI1C-eNrjEnWDxTiKBhmuISybgOEavYIgKrL6kL6yzoEs_u6voRu7qfZRHQ8AZVA9C-uZpww',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        for (final marker in markers)
          Positioned(
            top: marker.topPercent,
            left: marker.leftPercent,
            child: DashboardMarkerWidget(
              message: marker.message,
              icon: marker.icon,
              isOwn: marker.isOwn,
              onTap: onMarkerTap != null ? () => onMarkerTap!(marker) : null,
            ),
          ),
        const Center(
          child: _CrosshairWidget(),
        ),
      ],
    );
  }
}

class _CrosshairWidget extends StatelessWidget {
  const _CrosshairWidget();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(96, 96),
      painter: _CrosshairPainter(),
    );
  }
}

class _CrosshairPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final pulsePaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, 48, pulsePaint);

    final linePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset(center.dx - 20, center.dy),
      Offset(center.dx - 4, center.dy),
      linePaint,
    );
    canvas.drawLine(
      Offset(center.dx + 4, center.dy),
      Offset(center.dx + 20, center.dy),
      linePaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - 20),
      Offset(center.dx, center.dy - 4),
      linePaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy + 4),
      Offset(center.dx, center.dy + 20),
      linePaint,
    );

    final dotPaint = Paint()..color = AppColors.primary;
    canvas.drawCircle(center, 4, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MapTexturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.outlineVariant.withValues(alpha: 0.4)
      ..strokeWidth = 0.5;

    const spacing = 24.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 0.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
