import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/date_formatter.dart';
import '../../data/models/report.dart';
import '../../providers/report_provider.dart';

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
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.campaign_outlined,
                      size: 56,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No reports yet',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tap "Report Issue" to flag flooding, road damage, '
                      'or other community concerns.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            itemCount: provider.myReports.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
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
        title: Text(
          report.category.label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '${report.barangay} • ${DateFormatter.toRelative(report.createdAt)}',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _statusColor().withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            report.status.label,
            style: TextStyle(
              color: _statusColor(),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
