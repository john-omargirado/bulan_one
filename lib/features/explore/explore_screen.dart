import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import 'models/destination.dart';
import 'widgets/destination_card.dart';
import 'widgets/dish_card.dart';
import 'widgets/filter_chip_row.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  ExploreFilter _selected = ExploreFilter.all;

  List<Destination> get _filtered {
    if (_selected == ExploreFilter.all) return bulanDestinations;
    return bulanDestinations.where((d) => d.filter == _selected).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explore Bulan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterChipRow(
              selected: _selected,
              onSelect: (f) => setState(() => _selected = f),
            ),
            const SizedBox(height: AppSpacing.md),

            const _SectionHeader(title: 'Featured Destinations'),
            const SizedBox(height: AppSpacing.md),
            if (_filtered.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                child: Text(
                  'No destinations in this category yet.',
                  style: AppTextStyles.caption,
                ),
              )
            else
              SizedBox(
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filtered.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(width: AppSpacing.md),
                  itemBuilder: (context, i) =>
                      DestinationCard(destination: _filtered[i]),
                ),
              ),
            const SizedBox(height: AppSpacing.xl),

            const _SectionHeader(title: 'Local Food & Delicacies'),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 130,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: bulanDishes.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(width: AppSpacing.lg),
                itemBuilder: (context, i) => DishCard(dish: bulanDishes[i]),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Text(
                  'Itineraries & guides coming soon',
                  style: AppTextStyles.caption,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTextStyles.sectionTitle);
  }
}
