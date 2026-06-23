import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Placeholder for the Services tab (permits, certificates, bills).
/// These require real LGU backend integration (Tier 2/3) — this stub
/// exists so the navigation flow is demoable while that's pending.
class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Services')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.apartment_outlined,
                size: 56,
                color: AppColors.textSecondary,
              ),
              const SizedBox(height: 16),
              Text(
                'Government services coming soon',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Permit and document requests will appear here once '
                'connected with LGU offices.',
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
