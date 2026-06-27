import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import 'models/service_item.dart';
import 'widgets/popular_service_card.dart';
import 'widgets/category_tile.dart';

import '../../shared/widgets/page_hero_banner.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ServiceItem> get _filteredServices {
    if (_query.trim().isEmpty) return popularServices;
    final q = _query.toLowerCase();
    return popularServices
        .where((s) => s.name.toLowerCase().contains(q))
        .toList();
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
              const PageHeroBanner(
                title: 'Services',
                subtitle:
                    'Access government services quickly and conveniently.',
                imageSeed: 'bulan-services-hero',
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _searchController,
                      onChanged: (value) => setState(() => _query = value),
                      style: AppTextStyles.body,
                      decoration: InputDecoration(
                        hintText: 'Search services...',
                        hintStyle: AppTextStyles.caption,
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: AppColors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // My Requests shortcut \u2014 relocated here since the
                    // AppBar (and its old actions icon) is gone now that
                    // PageHeroBanner replaces it.
                    InkWell(
                      onTap: () => context.push('/services/my-requests'),
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.xs,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.assignment_outlined,
                              size: 18,
                              color: AppColors.primaryNavy,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              'My Requests',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.primaryNavy,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              size: 16,
                              color: AppColors.primaryNavy,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    Text('Popular Services', style: AppTextStyles.sectionTitle),
                    const SizedBox(height: AppSpacing.md),

                    if (_filteredServices.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.lg,
                        ),
                        child: Text(
                          'No matching services.',
                          style: AppTextStyles.caption,
                        ),
                      )
                    else
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: AppSpacing.md,
                              crossAxisSpacing: AppSpacing.md,
                              childAspectRatio: 1.1,
                            ),
                        itemCount: _filteredServices.length,
                        itemBuilder: (context, index) {
                          final service = _filteredServices[index];
                          return PopularServiceCard(
                            service: service,
                            onTap: () =>
                                context.push('/services/${service.id}'),
                          );
                        },
                      ),

                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      'Services by Category',
                      style: AppTextStyles.sectionTitle,
                    ),
                    const SizedBox(height: AppSpacing.md),

                    ...serviceCategories.map(
                      (category) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: CategoryTile(
                          category: category,
                          onTap: () {
                            if (_query.isNotEmpty) {
                              _searchController.clear();
                              setState(() => _query = '');
                            }

                            if (category.name == 'Transport & Travel') {
                              context.push('/services/transport');
                            } else {
                              context.push(
                                '/services/category/${Uri.encodeComponent(category.name)}',
                              );
                            }
                          },
                        ),
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
