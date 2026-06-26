import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/date_formatter.dart';
import '../../data/models/service_request.dart';
import '../../providers/service_request_provider.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Requests')),
      body: Consumer<ServiceRequestProvider>(
        builder: (context, provider, _) {
          if (provider.myRequests.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.assignment_outlined,
                      size: 56,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text('No requests yet', style: AppTextStyles.cardTitle),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Requests you submit for permits, certificates, or '
                      'other services will appear here.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: provider.myRequests.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) =>
                _RequestTile(request: provider.myRequests[index]),
          );
        },
      ),
    );
  }
}

class _RequestTile extends StatelessWidget {
  final ServiceRequest request;
  const _RequestTile({required this.request});

  Color _statusColor() {
    switch (request.status) {
      case RequestStatus.submitted:
        return AppColors.statusSubmitted;
      case RequestStatus.processing:
        return AppColors.statusInProgress;
      case RequestStatus.ready:
      case RequestStatus.completed:
        return AppColors.statusResolved;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(request.serviceName, style: AppTextStyles.cardTitle),
        subtitle: Text(
          DateFormatter.toRelative(request.createdAt),
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
            request.status.label,
            style: AppTextStyles.tinyBold.copyWith(color: _statusColor()),
          ),
        ),
      ),
    );
  }
}
