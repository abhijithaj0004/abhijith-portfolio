import 'package:flutter/material.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_theme.dart';
import '../../core/responsive/responsive.dart';
import '../../core/animations/animated_counter.dart';
import '../../core/animations/scroll_reveal.dart';
import '../../data/content/portfolio_data.dart';
import 'common/section_title.dart';
import 'common/responsive_container.dart';
import 'common/glass_card.dart';

class AboutSection extends StatelessWidget {
  final Key sectionKey;
  final bool reduceMotion;
  const AboutSection({required this.sectionKey, required this.reduceMotion, super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return AppSection(
      sectionKey: sectionKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(eyebrow: 'About', title: 'Who I am'),
          const SizedBox(height: 28),
          ScrollReveal(
            reduceMotion: reduceMotion,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Text(
                PortfolioData.aboutSummary,
                style: AppTypography.bodyLarge(context.textSecondary),
              ),
            ),
          ),
          const SizedBox(height: 48),
          ScrollReveal(
            reduceMotion: reduceMotion,
            delay: const Duration(milliseconds: 150),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: PortfolioData.stats.map((stat) {
                return SizedBox(
                  width: isMobile
                      ? (MediaQuery.of(context).size.width - 20 * 2 - 20) / 2
                      : 240,
                  child: GlassCard(
                    hoverLift: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedCounter(
                          value: stat['value']!,
                          reduceMotion: reduceMotion,
                          style: AppTypography.h1(context.textPrimary)
                              .copyWith(fontSize: 34),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          stat['label']!,
                          style: AppTypography.body(context.textSecondary),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
