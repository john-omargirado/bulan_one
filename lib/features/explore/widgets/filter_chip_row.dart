import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/destination.dart';

class FilterChipRow extends StatelessWidget {
  final ExploreFilter selected;
  final ValueChanged<ExploreFilter> onSelect;

  const FilterChipRow({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  static const _labels = {
    ExploreFilter.all: ('All', Icons.apps),
    ExploreFilter.nature: ('Nature', Icons.park_outlined),
    ExploreFilter.attractions: ('Attractions', Icons.camera_alt_outlined),
    ExploreFilter.culture: ('Culture & Events', Icons.celebration_outlined),
    ExploreFilter.food: ('Food', Icons.restaurant_outlined),
    ExploreFilter.stay: ('Stay', Icons.bed_outlined),
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 84,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: ExploreFilter.values.length,
        separatorBuilder: (_, _) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final filter = ExploreFilter.values[index];
          final (label, icon) = _labels[filter]!;
          final isSelected = filter == selected;

          return SizedBox(
            width: 64, // <-- fixed width fixes the unbounded-text overflow
            child: GestureDetector(
              onTap: () => onSelect(filter),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: isSelected
                        ? AppColors.primaryNavy
                        : AppColors.tileBlue,
                    child: Icon(
                      icon,
                      color: isSelected ? Colors.white : AppColors.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                      color: isSelected
                          ? AppColors.primaryNavy
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
