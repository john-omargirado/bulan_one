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
          : GridView.builder(
              padding: const EdgeInsets.all(AppSpacing.lg),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                childAspectRatio: 1.25,
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                return PopularServiceCard(
                  service: service,
                  onTap: () => context.push('/services/${service.id}'),
                );
              },
            ),
    );
  }
}
