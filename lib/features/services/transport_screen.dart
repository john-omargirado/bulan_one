import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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

  TransportRoute get _route => _selected ?? landRoutes.first;

  void _selectRoute(TransportRoute route) {
    setState(() => _selected = route);
    final center = LatLng(
      (route.originLat + route.destLat) / 2,
      (route.originLng + route.destLng) / 2,
    );
    _mapController.move(center, 8);
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
            height: 220,
            child: FlutterMap(
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
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.bulan_app',
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: [origin, dest],
                      color: AppColors.primaryNavy,
                      strokeWidth: 3,
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
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                Text('Land Routes', style: AppTextStyles.sectionTitle),
                const SizedBox(height: AppSpacing.sm),
                ...landRoutes.map(
                  (r) => _RouteTile(
                    route: r,
                    isSelected: r.id == route.id,
                    onTap: () => _selectRoute(r),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                Text('Water Routes', style: AppTextStyles.sectionTitle),
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
    return Card(
      color: isSelected ? AppColors.tileBlue : AppColors.surface,
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          route.mode == TransportMode.water
              ? Icons.directions_boat_outlined
              : Icons.directions_bus_outlined,
          color: AppColors.primaryNavy,
        ),
        title: Text(route.name, style: AppTextStyles.cardTitle),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(route.vehicleType, style: AppTextStyles.caption),
            const SizedBox(height: 2),
            Row(
              children: [
                const Icon(
                  Icons.schedule,
                  size: 12,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Expanded(child: Text(route.hours, style: AppTextStyles.tiny)),
              ],
            ),
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
    );
  }
}
