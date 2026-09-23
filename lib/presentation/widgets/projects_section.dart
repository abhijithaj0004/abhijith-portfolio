import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_theme.dart';
import '../../core/responsive/responsive.dart';
import '../../core/animations/scroll_reveal.dart';
import '../../data/content/portfolio_data.dart';
import '../../data/models/project.dart';
import 'common/section_title.dart';
import 'common/responsive_container.dart';
import 'project_detail_modal.dart';

class ProjectsSection extends StatelessWidget {
  final Key sectionKey;
  final bool reduceMotion;
  const ProjectsSection({required this.sectionKey, required this.reduceMotion, super.key});

  void _openProject(BuildContext context, Project project) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (_) => ProjectDetailModal(project: project),
    );
  }

  @override
  Widget build(BuildContext context) {
    final featured = PortfolioData.projects.firstWhere(
      (p) => p.featured,
      orElse: () => PortfolioData.projects.first,
    );
    final rest = PortfolioData.projects.where((p) => p != featured).toList();
    final columns = Responsive.isMobile(context) ? 1 : 2;

    return AppSection(
      sectionKey: sectionKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            eyebrow: 'Featured Projects',
            title: 'What I build',
            subtitle: 'Production apps shipped end-to-end, plus systems work '
                'behind the scenes.',
          ),
          const SizedBox(height: 40),
          ScrollReveal(
            reduceMotion: reduceMotion,
            child: _FeaturedProjectCard(
              project: featured,
              onTap: () => _openProject(context, featured),
            ),
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 20.0;
              final cardWidth = (constraints.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: List.generate(rest.length, (i) {
                  return SizedBox(
                    width: cardWidth,
                    child: ScrollReveal(
                      reduceMotion: reduceMotion,
                      delay: Duration(milliseconds: 80 * i),
                      child: _ProjectCard(
                        project: rest[i],
                        onTap: () => _openProject(context, rest[i]),
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

class _FeaturedProjectCard extends StatefulWidget {
  final Project project;
  final VoidCallback onTap;
  const _FeaturedProjectCard({required this.project, required this.onTap});

  @override
  State<_FeaturedProjectCard> createState() => _FeaturedProjectCardState();
}

class _FeaturedProjectCardState extends State<_FeaturedProjectCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.all(36),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _hovering
                  ? [
                      AppColors.primary.withOpacity(0.16),
                      context.surfaceElevated,
                    ]
                  : [context.surfaceElevated, context.surfaceElevated],
            ),
            border: Border.all(
              color: _hovering ? AppColors.primary.withOpacity(0.5) : context.borderColor,
            ),
            boxShadow: _hovering ? AppShadows.soft(context.isDarkMode) : null,
          ),
          child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.project.category.toUpperCase(),
                      style: AppTypography.label(AppColors.primary),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.project.title,
                      style: AppTypography.h1(context.textPrimary).copyWith(fontSize: 34),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.project.description,
                      style: AppTypography.bodyLarge(context.textSecondary),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: widget.project.highlights
                          .take(4)
                          .map((h) => _pill(context, h))
                          .toList(),
                    ),
                    const SizedBox(height: 24),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      transform: Matrix4.translationValues(_hovering ? 6 : 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'View project details',
                            style: AppTypography.button(AppColors.primary),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.arrow_forward_rounded,
                              size: 16, color: AppColors.primary),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: isMobile ? 0 : 32, height: isMobile ? 24 : 0),
              Expanded(
                flex: 2,
                child: AspectRatio(
                  aspectRatio: 1.1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.accent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.sports_esports_outlined,
                        size: 64, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pill(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.borderColor),
      ),
      child: Text(text, style: AppTypography.body(context.textSecondary).copyWith(fontSize: 12)),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  final VoidCallback onTap;
  const _ProjectCard({required this.project, required this.onTap});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovering = false;

  IconData get _categoryIcon {
    switch (widget.project.category) {
      case 'Dating / Social App':
        return Icons.favorite_border_rounded;
      case 'Novel Reading / Audiobook':
        return Icons.menu_book_outlined;
      case 'Quiz Application':
        return Icons.quiz_outlined;
      default:
        return Icons.apps_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(24),
          transform: Matrix4.translationValues(0, _hovering ? -6 : 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.md),
            color: context.surfaceElevated,
            border: Border.all(
              color: _hovering ? AppColors.primary.withOpacity(0.5) : context.borderColor,
            ),
            boxShadow: _hovering ? AppShadows.soft(context.isDarkMode) : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(_categoryIcon, color: AppColors.primary, size: 20),
                  ),
                  const Spacer(),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: _hovering ? 0.125 : 0,
                    child: Icon(Icons.arrow_outward_rounded, color: context.textMuted),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                widget.project.category.toUpperCase(),
                style: AppTypography.label(context.textMuted).copyWith(fontSize: 10.5),
              ),
              const SizedBox(height: 6),
              Text(
                widget.project.title,
                style: AppTypography.h3(context.textPrimary),
              ),
              const SizedBox(height: 10),
              Text(
                widget.project.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.body(context.textSecondary),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.project.technologies.take(3).map((t) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                    decoration: BoxDecoration(
                      color: context.surfaceColor,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: context.borderColor),
                    ),
                    child: Text(
                      t,
                      style: AppTypography.body(context.textSecondary).copyWith(fontSize: 11.5),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
