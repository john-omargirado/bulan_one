import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class EmergencyHotlineCard extends StatelessWidget {
  final VoidCallback onTap;

  const EmergencyHotlineCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: const CircleAvatar(
          backgroundColor: AppColors.tileRed,
          child: Icon(Icons.call, color: Colors.red),
        ),
        title: const Text('Emergency Hotline', style: AppTextStyles.cardTitle),
        subtitle: const Text(
          'Tap to call our 24/7 hotlines',
          style: AppTextStyles.caption,
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
