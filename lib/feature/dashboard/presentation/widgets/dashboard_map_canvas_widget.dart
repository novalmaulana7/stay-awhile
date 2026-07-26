import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/feature/dashboard/data/models/dashboard_model.dart';
import 'package:stay_awhile_mobile/feature/dashboard/presentation/widgets/dashboard_marker_widget.dart';

class DashboardMapCanvasWidget extends StatefulWidget {
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
  State<DashboardMapCanvasWidget> createState() =>
      _DashboardMapCanvasWidgetState();
}

class _DashboardMapCanvasWidgetState extends State<DashboardMapCanvasWidget>
    with SingleTickerProviderStateMixin {
  late final MapController _mapController;
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  static const double _initialZoom = 15;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _zoomIn() {
    final cam = _mapController.camera;
    if (cam.zoom < 18) {
      _mapController.move(cam.center, cam.zoom + 1);
    }
  }

  void _zoomOut() {
    final cam = _mapController.camera;
    if (cam.zoom > 3) {
      _mapController.move(cam.center, cam.zoom - 1);
    }
  }

  void _recenter() {
    _mapController.move(
      LatLng(widget.centerLat, widget.centerLng),
      _initialZoom,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: LatLng(widget.centerLat, widget.centerLng),
            initialZoom: _initialZoom,
            minZoom: 3,
            maxZoom: 18,
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
              markers: widget.markers.map((marker) {
                final bubbleAbove = marker.lat >= widget.centerLat;
                return Marker(
                  point: LatLng(marker.lat, marker.lng),
                  width: 200,
                  height: 80,
                  alignment: bubbleAbove
                      ? Alignment.bottomCenter
                      : Alignment.topCenter,
                  child: GestureDetector(
                    onTap: widget.onMarkerTap != null
                        ? () => widget.onMarkerTap!(marker)
                        : null,
                    child: DashboardMarkerWidget(
                      message: marker.message,
                      isOwn: marker.isOwn,
                      markerLat: marker.lat,
                      userLat: widget.centerLat,
                    ),
                  ),
                );
              }).toList(),
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(widget.centerLat, widget.centerLng),
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  child: AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (_, __) {
                      return CustomPaint(
                        painter: _UserPositionPainter(
                          pulseRadius: _pulseAnimation.value,
                        ),
                        size: const Size(40, 40),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          right: 12,
          bottom: 24,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _MapControlButton(icon: Icons.add, onTap: _zoomIn),
              const SizedBox(height: 4),
              _MapControlButton(icon: Icons.remove, onTap: _zoomOut),
              const SizedBox(height: 4),
              _MapControlButton(icon: Icons.my_location, onTap: _recenter),
            ],
          ),
        ),
      ],
    );
  }
}

class _MapControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MapControlButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, size: 20, color: AppColors.onSurface),
        ),
      ),
    );
  }
}

class _UserPositionPainter extends CustomPainter {
  final double pulseRadius;

  _UserPositionPainter({required this.pulseRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final pulsePaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.15 * pulseRadius)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 16 * pulseRadius, pulsePaint);

    final ringPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, 8, ringPaint);

    final dotPaint = Paint()..color = AppColors.primary;
    canvas.drawCircle(center, 5, dotPaint);

    final innerDotPaint = Paint()..color = AppColors.surface;
    canvas.drawCircle(center, 2.5, innerDotPaint);
  }

  @override
  bool shouldRepaint(covariant _UserPositionPainter oldDelegate) =>
      oldDelegate.pulseRadius != pulseRadius;
}
