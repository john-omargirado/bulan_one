import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import 'models/service_item.dart';
import 'widgets/popular_service_card.dart';

class CategoryServicesScreen extends StatelessWidget {
  final String categoryName;

  const CategoryServicesScreen({super.key, required this.categoryName});

  List<ServiceItem> get _services =>
      popularServices.where((s) => s.category == categoryName).toList();

  @override
  Widget build(BuildContext context) {
    final services = _services;

    return Scaffold(
      appBar: AppBar(title: Text(categoryName)),
      body: services.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.inbox_outlined,
                      size: 48,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'No services listed in this category yet.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: _ServiceGrid(
                services: services,
                onTapService: (service) =>
                    context.push('/services/${service.id}'),
              ),
            ),
    );
  }
}

class _ServiceGrid extends StatelessWidget {
  final List<ServiceItem> services;
  final void Function(ServiceItem) onTapService;

  const _ServiceGrid({required this.services, required this.onTapService});

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < services.length; i += 2) {
      final hasSecond = i + 1 < services.length;
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PopularServiceCard(
                  service: services[i],
                  onTap: () => onTapService(services[i]),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: hasSecond
                    ? PopularServiceCard(
                        service: services[i + 1],
                        onTap: () => onTapService(services[i + 1]),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      );
    }
    return Column(children: rows);
  }
}
