import 'package:flutter/material.dart';
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
      appBar: AppBar(title: Text(report.category.label)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (report.photoUrl != null)
              Image.network(
                report.photoUrl!,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                cacheWidth: 800,
                errorBuilder: (_, _, _) => Container(
                  height: 220,
                  color: AppColors.tileBlue,
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    size: 48,
                  ),
                ),
              ),

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
    );
  }
}
