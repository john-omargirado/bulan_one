import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:osrm/osrm.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import 'models/transport_route.dart';

class TransportScreen extends StatefulWidget {
  const TransportScreen({super.key});

  @override
  State<TransportScreen> createState() => _TransportScreenState();
}

class _TransportScreenState extends State<TransportScreen> {
  TransportRoute? _selected;
  final MapController _mapController = MapController();
  final Osrm _osrm = Osrm();

  List<LatLng> _roadPoints = [];
  bool _isLoadingRoute = false;

  TransportRoute get _route => _selected ?? landRoutes.first;

  @override
  void initState() {
    super.initState();
    _fetchRoute(_route);
  }

  Future<void> _fetchRoute(TransportRoute route) async {
    setState(() => _isLoadingRoute = true);

    try {
      final result = await _osrm.route(
        RouteRequest(
          coordinates: [
            (route.originLng, route.originLat),
            (route.destLng, route.destLat),
          ],
          overview: OsrmOverview.full,
          geometries: OsrmGeometries.geojson,
        ),
      );

      final coords =
          result.routes.first.geometry?.lineString?.coordinates ?? [];
      setState(() {
        _roadPoints = coords.map((c) => LatLng(c.$2, c.$1)).toList();
        _isLoadingRoute = false;
      });
    } catch (_) {
      setState(() {
        _roadPoints = [
          LatLng(route.originLat, route.originLng),
          LatLng(route.destLat, route.destLng),
        ];
        _isLoadingRoute = false;
      });
    }
  }

  void _selectRoute(TransportRoute route) {
    setState(() => _selected = route);
    _fetchRoute(route);
    final center = LatLng(
      (route.originLat + route.destLat) / 2,
      (route.originLng + route.destLng) / 2,
    );
    _mapController.move(center, 8);
  }

  void _zoomIn() {
    final camera = _mapController.camera;
    _mapController.move(camera.center, camera.zoom + 1);
  }

  void _zoomOut() {
    final camera = _mapController.camera;
    _mapController.move(camera.center, camera.zoom - 1);
  }

  @override
  Widget build(BuildContext context) {
    final route = _route;
    final origin = LatLng(route.originLat, route.originLng);
    final dest = LatLng(route.destLat, route.destLng);

    return Scaffold(
      appBar: AppBar(title: const Text('Trips & Transport')),
      body: Column(
        children: [
          SizedBox(
            height: 320,
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: LatLng(
                      (origin.latitude + dest.latitude) / 2,
                      (origin.longitude + dest.longitude) / 2,
                    ),
                    initialZoom: 8,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.bulan_app',
                    ),
                    if (_roadPoints.isNotEmpty)
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: _roadPoints,
                            color: AppColors.primaryNavy,
                            strokeWidth: 4,
                          ),
                        ],
                      ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: origin,
                          width: 36,
                          height: 36,
                          child: const Icon(
                            Icons.location_on,
                            color: AppColors.primaryNavy,
                            size: 32,
                          ),
                        ),
                        Marker(
                          point: dest,
                          width: 36,
                          height: 36,
                          child: const Icon(
                            Icons.location_on,
                            color: AppColors.statusResolved,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (_isLoadingRoute)
                  const Positioned(
                    top: 8,
                    right: 8,
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),

                // Zoom controls, bottom-right.
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Column(
                    children: [
                      _ZoomButton(icon: Icons.add, onTap: _zoomIn),
                      const SizedBox(height: 8),
                      _ZoomButton(icon: Icons.remove, onTap: _zoomOut),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.directions_bus_outlined,
                      size: 18,
                      color: AppColors.primaryNavy,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text('Land Routes', style: AppTextStyles.sectionTitle),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                ...landRoutes.map(
                  (r) => _RouteTile(
                    route: r,
                    isSelected: r.id == route.id,
                    onTap: () => _selectRoute(r),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                Row(
                  children: [
                    const Icon(
                      Icons.directions_boat_outlined,
                      size: 18,
                      color: AppColors.primaryNavy,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text('Water Routes', style: AppTextStyles.sectionTitle),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                ...waterRoutes.map(
                  (r) => _RouteTile(
                    route: r,
                    isSelected: r.id == route.id,
                    onTap: () => _selectRoute(r),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ZoomButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ZoomButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(icon, color: AppColors.primaryNavy, size: 20),
        ),
      ),
    );
  }
}

class _RouteTile extends StatelessWidget {
  final TransportRoute route;
  final bool isSelected;
  final VoidCallback onTap;

  const _RouteTile({
    required this.route,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Material(
        color: isSelected ? AppColors.tileBlue : AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected
                    ? AppColors.primaryNavy.withValues(alpha: 0.3)
                    : Colors.black.withValues(alpha: 0.06),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryNavy
                        : AppColors.tileBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    route.mode == TransportMode.water
                        ? Icons.directions_boat_outlined
                        : Icons.directions_bus_outlined,
                    color: isSelected ? Colors.white : AppColors.primaryNavy,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(route.name, style: AppTextStyles.cardTitle),
                      const SizedBox(height: 2),
                      Text(route.vehicleType, style: AppTextStyles.caption),
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        children: [
                          const Icon(
                            Icons.schedule,
                            size: 12,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(route.hours, style: AppTextStyles.tiny),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(
                            Icons.payments_outlined,
                            size: 12,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(route.fare, style: AppTextStyles.tiny),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(
                      Icons.check_circle,
                      size: 18,
                      color: AppColors.primaryNavy,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
