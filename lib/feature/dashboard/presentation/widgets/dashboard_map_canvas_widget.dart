import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/feature/dashboard/data/models/dashboard_model.dart';
import 'package:stay_awhile_mobile/feature/dashboard/presentation/widgets/dashboard_marker_widget.dart';

class DashboardMapCanvasWidget extends StatelessWidget {
  final List<MapMarker> markers;
  final double centerLat;
  final double centerLng;
  final ValueChanged<MapMarker>? onMarkerTap;

  const DashboardMapCanvasWidget({
    super.key,
    required this.markers,
    required this.centerLat,
    required this.centerLng,
    this.onMarkerTap,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(centerLat, centerLng),
        initialZoom: 15,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.stayawhile.app',
        ),
        MarkerLayer(
          markers: markers
              .map(
                (marker) => Marker(
                  point: LatLng(marker.lat, marker.lng),
                  width: 200,
                  height: 80,
                  child: GestureDetector(
                    onTap: onMarkerTap != null
                        ? () => onMarkerTap!(marker)
                        : null,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: DashboardMarkerWidget(
                        message: marker.message,
                        icon: marker.icon,
                        isOwn: marker.isOwn,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
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
