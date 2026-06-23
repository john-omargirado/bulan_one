import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_colors.dart';
import '../../data/models/hotline.dart';
import '../../providers/hotline_provider.dart';

class HotlinesScreen extends StatelessWidget {
  const HotlinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency Hotlines')),
      body: Consumer<HotlineProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.hotlines.isEmpty) {
            return const Center(
              child: Text(
                'No hotlines added yet.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: provider.hotlines.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              return _HotlineTile(hotline: provider.hotlines[index]);
            },
          );
        },
      ),
    );
  }
}

class _HotlineTile extends StatelessWidget {
  final Hotline hotline;

  const _HotlineTile({required this.hotline});

  Future<void> _call() async {
    final uri = Uri(scheme: 'tel', path: hotline.number);
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppColors.tileRed,
          child: Icon(Icons.phone, color: Colors.red),
        ),
        title: Text(
          hotline.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(hotline.number),
        trailing: const Icon(Icons.call, color: AppColors.primaryNavy),
        onTap: _call,
      ),
    );
  }
}
