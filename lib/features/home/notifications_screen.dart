import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/date_formatter.dart';
import '../../providers/notification_provider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    // Mark seen on open, not on dispose — matches how read receipts
    // behave in most apps (opening the list is the "read" action).
    context.read<NotificationProvider>().markAllSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, _) {
          if (provider.notifications.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.notifications_none,
                      size: 56,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'No notifications yet',
                      style: AppTextStyles.cardTitle,
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: provider.notifications.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final n = provider.notifications[index];
              return Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.notifications_outlined,
                    color: AppColors.primaryNavy,
                  ),
                  title: Text(n.title, style: AppTextStyles.cardTitle),
                  subtitle: Text(n.body, style: AppTextStyles.caption),
                  trailing: Text(
                    DateFormatter.toRelative(n.createdAt),
                    style: AppTextStyles.tiny,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
