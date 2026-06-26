import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../data/models/announcement.dart';

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;

  const AnnouncementCard({super.key, required this.announcement});

  Color _tagColor() {
    switch (announcement.tag.toUpperCase()) {
      case 'EVENT':
        return AppColors.tileGreen;
      case 'ADVISORY':
        return AppColors.tileAmber;
      default:
        return AppColors.tileBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: _tagColor(),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                announcement.tag.toUpperCase(),
                style: AppTextStyles.tinyBold,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(announcement.title, style: AppTextStyles.cardTitle),
            const SizedBox(height: AppSpacing.xs),
            Text(
              announcement.body,
              style: AppTextStyles.caption,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              DateFormatter.toDisplayDate(announcement.createdAt),
              style: AppTextStyles.tiny,
            ),
          ],
        ),
      ),
    );
  }
}
