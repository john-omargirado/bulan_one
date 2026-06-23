import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

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
        title: const Text(
          'Emergency Hotline',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: const Text('Tap to call our 24/7 hotlines'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
