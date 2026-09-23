import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_theme.dart';
import '../../core/responsive/responsive.dart';
import '../../core/utils/launch_utils.dart';
import '../../data/models/project.dart';
import 'common/app_button.dart';

class ProjectDetailModal extends StatelessWidget {
  final Project project;
  const ProjectDetailModal({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 60,
        vertical: 40,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720, maxHeight: 640),
        child: Container(
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: context.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(28, 24, 20, 20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.accent],
                  ),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.category.toUpperCase(),
                            style: AppTypography.label(Colors.white.withOpacity(0.85)),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            project.title,
                            style: AppTypography.h1(Colors.white).copyWith(fontSize: 28),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _row('Company', project.company, context),
                      if (project.role != null) _row('Role', project.role!, context),
                      if (project.architecture != null)
                        _row('Architecture', project.architecture!, context),
                      const SizedBox(height: 16),
                      Text('Description', style: AppTypography.h3(context.textPrimary).copyWith(fontSize: 15)),
                      const SizedBox(height: 6),
                      Text(project.description, style: AppTypography.body(context.textSecondary)),
                      if (project.contributions.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        Text('Contributions',
                            style: AppTypography.h3(context.textPrimary).copyWith(fontSize: 15)),
                        const SizedBox(height: 8),
                        ...project.contributions.map(
                          (c) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.check_circle_outline,
                                    size: 16, color: AppColors.accent),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(c,
                                      style: AppTypography.body(context.textSecondary)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      if (project.impact != null) ...[
                        const SizedBox(height: 20),
                        Text('Impact',
                            style: AppTypography.h3(context.textPrimary).copyWith(fontSize: 15)),
                        const SizedBox(height: 6),
                        Text(project.impact!, style: AppTypography.body(context.textSecondary)),
                      ],
                      const SizedBox(height: 20),
                      Text('Technologies',
                          style: AppTypography.h3(context.textPrimary).copyWith(fontSize: 15)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: project.technologies.map((t) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: context.surfaceElevated,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: context.borderColor),
                            ),
                            child: Text(t,
                                style: AppTypography.body(context.textSecondary)
                                    .copyWith(fontSize: 12)),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          if (project.playStoreUrl != null)
                            AppButton(
                              label: 'Play Store',
                              icon: Icons.shop_outlined,
                              onPressed: () => LaunchUtils.openUrl(project.playStoreUrl!),
                            ),
                          if (project.githubUrl != null)
                            AppButton(
                              label: 'GitHub',
                              type: AppButtonStyleType.secondary,
                              icon: Icons.code,
                              onPressed: () => LaunchUtils.openUrl(project.githubUrl!),
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
      ),
    );
  }

  Widget _row(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(label, style: AppTypography.label(context.textMuted).copyWith(fontSize: 11)),
          ),
          Expanded(
            child: Text(value, style: AppTypography.body(context.textPrimary)),
          ),
        ],
      ),
    );
  }
}
