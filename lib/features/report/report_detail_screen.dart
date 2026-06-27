import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/date_formatter.dart';
import '../../data/models/report.dart';

class ReportDetailScreen extends StatelessWidget {
  final Report report;

  const ReportDetailScreen({super.key, required this.report});

  Color _statusColor() {
    switch (report.status) {
      case ReportStatus.submitted:
        return AppColors.statusSubmitted;
      case ReportStatus.inProgress:
        return AppColors.statusInProgress;
      case ReportStatus.resolved:
        return AppColors.statusResolved;
    }
  }

  Future<void> _openInMaps() async {
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${report.lat},${report.lng}',
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ReportHeader(report: report),

              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: _statusColor().withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            report.status.label,
                            style: AppTextStyles.tinyBold.copyWith(
                              color: _statusColor(),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          DateFormatter.toDisplayDate(report.createdAt),
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    Text(
                      'Barangay',
                      style: AppTextStyles.sectionTitle.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(report.barangay, style: AppTextStyles.body),
                    const SizedBox(height: AppSpacing.lg),

                    Text(
                      'Description',
                      style: AppTextStyles.sectionTitle.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(report.description, style: AppTextStyles.body),
                    const SizedBox(height: AppSpacing.xl),

                    Text(
                      'Location',
                      style: AppTextStyles.sectionTitle.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        height: 180,
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: LatLng(report.lat, report.lng),
                            initialZoom: 15,
                            interactionOptions: const InteractionOptions(
                              flags:
                                  InteractiveFlag.pinchZoom |
                                  InteractiveFlag.drag,
                            ),
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.bulan_app',
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: LatLng(report.lat, report.lng),
                                  width: 36,
                                  height: 36,
                                  child: const Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 32,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    OutlinedButton.icon(
                      onPressed: _openInMaps,
                      icon: const Icon(Icons.map_outlined),
                      label: Text(
                        '${report.lat.toStringAsFixed(5)}, ${report.lng.toStringAsFixed(5)}',
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xl),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.tileBlue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            size: 18,
                            color: AppColors.primaryNavy,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              'Status updates are reviewed by LGU staff. '
                              'This may take a few days depending on the issue.',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.primaryNavy,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Header for the report detail screen. Shows the citizen's own
/// submitted photo as the hero image when one exists (real content,
/// no SAMPLE badge needed) \u2014 falls back to a generic banner-style
/// header only when no photo was attached to the report.
class _ReportHeader extends StatelessWidget {
  final Report report;
  const _ReportHeader({required this.report});

  @override
  Widget build(BuildContext context) {
    final hasPhoto = report.photoUrl != null;

    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Stack(
        children: [
          if (hasPhoto)
            Image.network(
              report.photoUrl!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              cacheWidth: 800,
              errorBuilder: (_, _, _) => Container(
                height: 200,
                color: AppColors.tileBlue,
                child: const Icon(Icons.image_not_supported_outlined, size: 48),
              ),
            )
          else
            Container(
              width: double.infinity,
              height: 200,
              color: AppColors.primaryNavy,
            ),

          // Gradient so the title stays legible over either a photo
          // or the flat navy fallback.
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.45),
                    Colors.black.withValues(alpha: 0.15),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: 4,
            left: 4,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),

          Positioned(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            bottom: AppSpacing.md,
            child: SafeArea(
              top: false,
              child: Text(
                report.category.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
