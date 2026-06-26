import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../data/models/report.dart';

class CategoryPicker extends StatelessWidget {
  final ReportCategory? selected;
  final ValueChanged<ReportCategory> onSelect;

  const CategoryPicker({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: ReportCategory.values.map((category) {
        final isSelected = category == selected;
        return ChoiceChip(
          label: Text(category.label),
          selected: isSelected,
          onSelected: (_) => onSelect(category),
          selectedColor: AppColors.primaryNavy,
          labelStyle: AppTextStyles.caption.copyWith(
            color: isSelected ? Colors.white : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
          backgroundColor: AppColors.surface,
        );
      }).toList(),
    );
  }
}
