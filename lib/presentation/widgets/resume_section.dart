import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_theme.dart';
import '../../core/responsive/responsive.dart';
import '../../core/utils/launch_utils.dart';
import '../../core/constants/app_constants.dart';
import 'common/responsive_container.dart';
import 'common/app_button.dart';

class ResumeSection extends StatelessWidget {
  final Key sectionKey;
  const ResumeSection({required this.sectionKey, super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return AppSection(
      sectionKey: sectionKey,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 56, horizontal: isMobile ? 24 : 56),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withOpacity(0.14),
              context.surfaceElevated,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: context.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Want the complete picture?',
              textAlign: TextAlign.center,
              style: AppTypography.h1(context.textPrimary).copyWith(fontSize: isMobile ? 26 : 32),
            ),
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Text(
                'Download my resume for my complete experience, projects and technical background.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyLarge(context.textSecondary),
              ),
            ),
            const SizedBox(height: 28),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 14,
              runSpacing: 14,
              children: [
                AppButton(
                  label: 'Download Resume',
                  icon: Icons.download_rounded,
                  onPressed: () => LaunchUtils.openUrl(AppConstants.resumeAssetPath),
                ),
                AppButton(
                  label: 'View Resume',
                  type: AppButtonStyleType.secondary,
                  icon: Icons.open_in_new_rounded,
                  onPressed: () => LaunchUtils.openUrl(AppConstants.resumeAssetPath),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
