import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_theme.dart';
import '../../core/responsive/responsive.dart';
import '../../core/animations/scroll_reveal.dart';
import '../../data/content/portfolio_data.dart';
import 'common/section_title.dart';
import 'common/responsive_container.dart';

class ArchitectureSection extends StatelessWidget {
  final Key sectionKey;
  final bool reduceMotion;
  const ArchitectureSection({required this.sectionKey, required this.reduceMotion, super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final steps = PortfolioData.architectureFlow;

    return AppSection(
      sectionKey: sectionKey,
      background: context.surfaceColor.withOpacity(context.isDarkMode ? 0.4 : 0.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            eyebrow: 'How I Build',
            title: 'Architecture approach',
            subtitle: 'MVVM, Clean Architecture and a Repository pattern keep '
                'UI, state, and data concerns separate and testable.',
          ),
          const SizedBox(height: 44),
          ScrollReveal(
            reduceMotion: reduceMotion,
            child: isMobile
                ? Column(
                    children: [
                      for (int i = 0; i < steps.length; i++) ...[
                        _StepNode(label: steps[i], index: i),
                        if (i != steps.length - 1)
                          Container(
                            width: 2,
                            height: 28,
                            color: context.borderColor,
                          ),
                      ],
                    ],
                  )
                : Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      for (int i = 0; i < steps.length; i++) ...[
                        _StepNode(label: steps[i], index: i),
                        if (i != steps.length - 1)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(Icons.arrow_forward_rounded,
                                color: context.textMuted, size: 20),
                          ),
                      ],
                    ],
                  ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: ['MVVM', 'Clean Architecture', 'Repository Pattern'].map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                ),
                child: Text(tag, style: AppTypography.body(AppColors.primary).copyWith(fontSize: 13)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _StepNode extends StatefulWidget {
  final String label;
  final int index;
  const _StepNode({required this.label, required this.index});

  @override
  State<_StepNode> createState() => _StepNodeState();
}

class _StepNodeState extends State<_StepNode> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: _hovering ? AppColors.primary.withOpacity(0.12) : context.surfaceElevated,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: _hovering ? AppColors.primary : context.borderColor,
          ),
        ),
        child: Text(
          widget.label,
          textAlign: TextAlign.center,
          style: AppTypography.body(
            _hovering ? AppColors.primary : context.textPrimary,
          ).copyWith(fontWeight: FontWeight.w600, fontSize: 13),
        ),
      ),
    );
  }
}
