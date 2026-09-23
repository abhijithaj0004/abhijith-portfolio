import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';

class SectionTitle extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String? subtitle;
  final CrossAxisAlignment alignment;

  const SectionTitle({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.alignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          eyebrow.toUpperCase(),
          style: AppTypography.label(AppColors.primary),
        ),
        const SizedBox(height: 10),
        Text(title, style: AppTypography.h1(context.textPrimary)),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Text(
              subtitle!,
              textAlign: alignment == CrossAxisAlignment.center
                  ? TextAlign.center
                  : TextAlign.start,
              style: AppTypography.bodyLarge(context.textSecondary),
            ),
          ),
        ],
      ],
    );
  }
}
