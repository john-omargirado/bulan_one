import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../shared/widgets/placeholder_image.dart';

/// Municipal identity banner — the "Home of Padaraw" section.
/// Distinct from the hero (greeting) and the festival card (events):
/// this one carries civic identity/branding, similar to a seal of office.
class MunicipalBanner extends StatelessWidget {
  const MunicipalBanner({super.key});

  static const String _bgImageUrl =
      'https://picsum.photos/seed/bulan-palms/600/300';

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 100,
        child: Stack(
          children: [
            PlaceholderImage(
              imageUrl: _bgImageUrl,
              width: double.infinity,
              height: 100,
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.primaryNavy.withValues(alpha: 0.95),
                      AppColors.primaryNavy.withValues(alpha: 0.55),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  // Seal placeholder — swap for the real municipal seal asset.
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.account_balance,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Home of',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        Text(
                          'Padaraw',
                          style: TextStyle(
                            color: AppColors.accentGold,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const Text(
                          'Progressive. Peaceful. Proud.',
                          style: TextStyle(color: Colors.white70, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
