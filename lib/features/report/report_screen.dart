import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/date_formatter.dart';
import '../../data/models/report.dart';
import '../../providers/report_provider.dart';
import 'report_detail_screen.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Reports')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/report/new'),
        icon: const Icon(Icons.add),
        label: const Text('Report Issue'),
      ),
      body: Consumer<ReportProvider>(
        builder: (context, provider, _) {
          if (provider.myReports.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.campaign_outlined,
                      size: 56,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text('No reports yet', style: AppTextStyles.cardTitle),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Tap "Report Issue" to flag flooding, road damage, '
                      'or other community concerns.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              80,
            ),
            itemCount: provider.myReports.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) =>
                _ReportTile(report: provider.myReports[index]),
          );
        },
      ),
    );
  }
}

class _ReportTile extends StatelessWidget {
  final Report report;

  const _ReportTile({required this.report});

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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ReportDetailScreen(report: report)),
        ),
        title: Text(report.category.label, style: AppTextStyles.cardTitle),
        subtitle: Text(
          '${report.barangay} • ${DateFormatter.toRelative(report.createdAt)}',
          style: AppTextStyles.caption,
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: _statusColor().withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            report.status.label,
            style: AppTextStyles.tinyBold.copyWith(color: _statusColor()),
          ),
        ),
      ),
    );
  }
}
