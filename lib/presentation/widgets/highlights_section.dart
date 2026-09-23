import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_theme.dart';
import '../../core/responsive/responsive.dart';
import '../../core/animations/scroll_reveal.dart';
import '../../data/content/portfolio_data.dart';
import 'common/section_title.dart';
import 'common/responsive_container.dart';
import 'common/glass_card.dart';

const List<IconData> _highlightIcons = [
  Icons.sports_esports_outlined,
  Icons.podcasts_outlined,
  Icons.api_outlined,
  Icons.speed_outlined,
  Icons.graphic_eq_outlined,
  Icons.devices_outlined,
  Icons.translate_outlined,
  Icons.rocket_launch_outlined,
];

class HighlightsSection extends StatelessWidget {
  final Key sectionKey;
  final bool reduceMotion;
  const HighlightsSection({required this.sectionKey, required this.reduceMotion, super.key});

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.isMobile(context)
        ? 1
        : Responsive.isTablet(context)
            ? 2
            : 4;

    return AppSection(
      sectionKey: sectionKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(eyebrow: 'Engineering Highlights', title: "Things I've built"),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 20.0;
              final cardWidth = (constraints.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: List.generate(PortfolioData.highlights.length, (i) {
                  final item = PortfolioData.highlights[i];
                  return SizedBox(
                    width: cardWidth,
                    child: ScrollReveal(
                      reduceMotion: reduceMotion,
                      delay: Duration(milliseconds: 50 * (i % columns)),
                      child: GlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.accent.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                _highlightIcons[i % _highlightIcons.length],
                                color: AppColors.accent,
                                size: 19,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              item['title']!,
                              style: AppTypography.h3(context.textPrimary).copyWith(fontSize: 15.5),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item['description']!,
                              style: AppTypography.body(context.textSecondary),
                            ),
                          ],
                        ),
                      ),
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
