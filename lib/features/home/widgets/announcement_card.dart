import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../data/models/announcement.dart';
import '../../../shared/widgets/placeholder_image.dart';

/// Styled the same way as FeaturedBannerCard: full-height image on
/// the left, content on the right \u2014 consistent card language
/// across Home's "Discover" and "Stay Informed" sections.
class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;

  const AnnouncementCard({super.key, required this.announcement});

  Color _tagColor() {
    switch (announcement.tag.toUpperCase()) {
      case 'EVENT':
        return AppColors.iconGreen;
      case 'ADVISORY':
        return AppColors.iconAmber;
      default:
        return AppColors.primaryNavy;
    }
  }

  @override
  Widget build(BuildContext context) {
    final thumbnailUrl =
        announcement.imageUrl ??
        'https://picsum.photos/seed/${announcement.id}/300/300';
    final isRealImage = announcement.imageUrl != null;

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(14),
              ),
              child: SizedBox(
                width: 110,
                height: 130,
                child: isRealImage
                    ? Image.network(
                        thumbnailUrl,
                        fit: BoxFit.cover,
                        cacheWidth: 220,
                        errorBuilder: (_, _, _) => Container(
                          color: AppColors.tileBlue,
                          child: const Icon(Icons.image_outlined, size: 24),
                        ),
                      )
                    : PlaceholderImage(
                        imageUrl: thumbnailUrl,
                        width: 110,
                        height: 130,
                      ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: _tagColor().withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        announcement.tag.toUpperCase(),
                        style: AppTextStyles.tinyBold.copyWith(
                          color: _tagColor(),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      announcement.title,
                      style: AppTextStyles.cardTitle.copyWith(fontSize: 15),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      announcement.body,
                      style: AppTextStyles.caption,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 12,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          DateFormatter.toDisplayDate(announcement.createdAt),
                          style: AppTextStyles.tiny,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
