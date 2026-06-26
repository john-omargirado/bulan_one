import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import 'models/service_item.dart';
import 'widgets/popular_service_card.dart';
import 'widgets/category_tile.dart';

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
      appBar: AppBar(
        title: const Text('Services'),
        actions: [
          IconButton(
            icon: const Icon(Icons.assignment_outlined),
            tooltip: 'My Requests',
            onPressed: () => context.push('/services/my-requests'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
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
          const SizedBox(height: AppSpacing.xl),

          Text('Popular Services', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),

          if (_filteredServices.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              child: Text(
                'No matching services.',
                style: AppTextStyles.caption,
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                  onTap: () => context.push('/services/${service.id}'),
                );
              },
            ),

          const SizedBox(height: AppSpacing.xl),
          Text('Services by Category', style: AppTextStyles.sectionTitle),
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
                  context.push(
                    '/services/category/${Uri.encodeComponent(category.name)}',
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
