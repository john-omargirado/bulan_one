import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'models/destination.dart';
import 'widgets/destination_card.dart';
import 'widgets/dish_card.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explore Bulan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader(title: 'Featured Destinations'),
            const SizedBox(height: 12),
            SizedBox(
              height: 140,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: bulanDestinations.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (context, i) =>
                    DestinationCard(destination: bulanDestinations[i]),
              ),
            ),
            const SizedBox(height: 24),

            _SectionHeader(title: 'Local Food & Delicacies'),
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
