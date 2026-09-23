import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_theme.dart';
import '../../core/responsive/responsive.dart';
import '../../core/animations/scroll_reveal.dart';
import '../../data/content/portfolio_data.dart';
import '../../data/models/experience_item.dart';
import 'common/section_title.dart';
import 'common/responsive_container.dart';
import 'common/glass_card.dart';

class ExperienceSection extends StatelessWidget {
  final Key sectionKey;
  final bool reduceMotion;
  const ExperienceSection({required this.sectionKey, required this.reduceMotion, super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return AppSection(
      sectionKey: sectionKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            eyebrow: 'Experience',
            title: 'Where I\'ve worked',
          ),
          const SizedBox(height: 40),
          for (int i = 0; i < PortfolioData.experience.length; i++)
            ScrollReveal(
              reduceMotion: reduceMotion,
              delay: Duration(milliseconds: 100 * i),
              child: _TimelineItem(
                item: PortfolioData.experience[i],
                isLast: i == PortfolioData.experience.length - 1,
                isMobile: isMobile,
              ),
            ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatefulWidget {
  final ExperienceItem item;
  final bool isLast;
  final bool isMobile;

  const _TimelineItem({
    required this.item,
    required this.isLast,
    required this.isMobile,
  });

  @override
  State<_TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<_TimelineItem> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 14,
                height: 14,
                margin: const EdgeInsets.only(top: 6),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              if (!widget.isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: context.borderColor,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: GlassCard(
                hoverLift: false,
                onTap: () => setState(() => _expanded = !_expanded),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.item.role,
                                style: AppTypography.h3(context.textPrimary)
                                    .copyWith(fontSize: 18),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${widget.item.company} · ${widget.item.location}',
                                style: AppTypography.body(AppColors.primary),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          _expanded ? Icons.expand_less : Icons.expand_more,
                          color: context.textMuted,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.item.period,
                      style: AppTypography.label(context.textMuted).copyWith(fontSize: 11),
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOut,
                      child: !_expanded
                          ? const SizedBox(width: double.infinity)
                          : Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: widget.item.responsibilities
                                    .map(
                                      (r) => Padding(
                                        padding: const EdgeInsets.only(bottom: 8),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 7),
                                              child: Container(
                                                width: 5,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                  color: context.textMuted,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                r,
                                                style: AppTypography.body(context.textSecondary),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
