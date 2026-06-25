import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person_outline,
                size: 56,
                color: AppColors.textSecondary,
              ),
              const SizedBox(height: 16),
              Text(
                'No account needed',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.call_outlined,
                    color: AppColors.primaryNavy,
                  ),
                  title: const Text('Emergency Hotlines'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/hotlines'),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'This app works without sign-up. Account features '
                'may be added later.',
                style: TextStyle(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
