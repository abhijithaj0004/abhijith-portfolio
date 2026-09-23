import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_theme.dart';
import '../../core/responsive/responsive.dart';
import '../../core/animations/scroll_reveal.dart';
import '../../data/content/portfolio_data.dart';
import '../../data/models/skill.dart';
import 'common/section_title.dart';
import 'common/responsive_container.dart';
import 'common/glass_card.dart';

class SkillsSection extends StatelessWidget {
  final Key sectionKey;
  final bool reduceMotion;
  const SkillsSection({required this.sectionKey, required this.reduceMotion, super.key});

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.isMobile(context)
        ? 1
        : Responsive.isTablet(context)
            ? 2
            : 4;

    return AppSection(
      sectionKey: sectionKey,
      background: context.surfaceColor.withOpacity(context.isDarkMode ? 0.4 : 0.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            eyebrow: 'Tech Stack',
            title: 'Tools I build with',
            subtitle:
                'The languages, architecture patterns and services behind every app I ship.',
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              final gap = 20.0;
              final cardWidth = (constraints.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: List.generate(PortfolioData.skillCategories.length, (i) {
                  final category = PortfolioData.skillCategories[i];
                  return SizedBox(
                    width: cardWidth,
                    child: ScrollReveal(
                      reduceMotion: reduceMotion,
                      delay: Duration(milliseconds: 60 * (i % columns)),
                      child: _SkillCard(category: category),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  final SkillCategory category;
  const _SkillCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(category.icon, size: 18, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  category.title,
                  style: AppTypography.h3(context.textPrimary).copyWith(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: category.skills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: context.surfaceColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: context.borderColor),
                ),
                child: Text(
                  skill,
                  style: AppTypography.body(context.textSecondary).copyWith(fontSize: 12.5),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
