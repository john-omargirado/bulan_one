import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterChipRow(
              selected: _selected,
              onSelect: (f) => setState(() => _selected = f),
            ),
            const SizedBox(height: 12),

            const _SectionHeader(title: 'Featured Destinations'),
            const SizedBox(height: 12),
            if (_filtered.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'No destinations in this category yet.',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              )
            else
              SizedBox(
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filtered.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (context, i) =>
                      DestinationCard(destination: _filtered[i]),
                ),
              ),
            const SizedBox(height: 24),

            const _SectionHeader(title: 'Local Food & Delicacies'),
            const SizedBox(height: 12),
            SizedBox(
              height: 130,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: bulanDishes.length,
                separatorBuilder: (_, _) => const SizedBox(width: 16),
                itemBuilder: (context, i) => DishCard(dish: bulanDishes[i]),
              ),
            ),
            const SizedBox(height: 24),

            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Itineraries & guides coming soon',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
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
    return Text(title, style: Theme.of(context).textTheme.titleMedium);
  }
}
