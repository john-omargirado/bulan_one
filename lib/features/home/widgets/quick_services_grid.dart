import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';

enum _Dest { services, categoryPage, transportMap, comingSoon }

class QuickServicesGrid extends StatelessWidget {
  const QuickServicesGrid({super.key});

  static const _items = [
    (
      Icons.description_outlined,
      'Documents',
      AppColors.tileBlue,
      AppColors.iconBlue,
      _Dest.services,
      '',
    ),
    (
      Icons.apartment,
      'LGU Services',
      AppColors.tileGreen,
      AppColors.iconGreen,
      _Dest.services,
      '',
    ),
    (
      Icons.receipt_long,
      'Pay Bills',
      AppColors.tileAmber,
      AppColors.iconAmber,
      _Dest.comingSoon,
      '',
    ),
    (
      Icons.event_available,
      'Book Appointment',
      AppColors.tilePurple,
      AppColors.iconPurple,
      _Dest.services,
      '',
    ),
    (
      Icons.directions_bus,
      'Trips & Transport',
      AppColors.tileBlue,
      AppColors.iconBlue,
      _Dest.transportMap,
      '',
    ),
    (
      Icons.receipt,
      'Taxes',
      AppColors.tileRed,
      AppColors.iconRed,
      _Dest.comingSoon,
      '',
    ),
    (
      Icons.local_hospital_outlined,
      'Health Services',
      AppColors.tileGreen,
      AppColors.iconGreen,
      _Dest.categoryPage,
      'Health Services',
    ),
    (
      Icons.school_outlined,
      'Scholarship',
      AppColors.tileAmber,
      AppColors.iconAmber,
      _Dest.categoryPage,
      'Education Services',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < _items.length; i += 4) {
      final rowItems = _items.skip(i).take(4).toList();
      rows.add(
        Padding(
          padding: EdgeInsets.only(top: i == 0 ? 0 : AppSpacing.md),
          child: Row(
            children: rowItems
                .map((item) => Expanded(child: _QuickServiceTile(item: item)))
                .toList(),
          ),
        ),
      );
    }
    return Column(children: rows);
  }
}

class _QuickServiceTile extends StatelessWidget {
  final (IconData, String, Color, Color, _Dest, String) item;
  const _QuickServiceTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final (icon, label, bgColor, iconColor, dest, categoryName) = item;
    return GestureDetector(
      onTap: () {
        switch (dest) {
          case _Dest.services:
            context.go('/services');
          case _Dest.categoryPage:
            context.push(
              '/services/category/${Uri.encodeComponent(categoryName)}',
            );
          case _Dest.transportMap:
            context.push('/services/transport');
          case _Dest.comingSoon:
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('$label is coming soon')));
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.tiny.copyWith(
              fontSize: 11,
              color: AppColors.textPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
