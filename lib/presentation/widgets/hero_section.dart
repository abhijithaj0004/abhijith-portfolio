import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_theme.dart';
import '../../core/responsive/responsive.dart';
import '../../core/constants/app_constants.dart';
import '../../data/content/portfolio_data.dart';
import 'common/app_button.dart';
import 'common/responsive_container.dart';
import 'common/social_button.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onViewWork;
  final VoidCallback onDownloadResume;
  final VoidCallback onContact;
  final bool reduceMotion;

  const HeroSection({
    super.key,
    required this.onViewWork,
    required this.onDownloadResume,
    required this.onContact,
    required this.reduceMotion,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.reduceMotion
          ? const Duration(milliseconds: 1)
          : const Duration(milliseconds: 700),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);

    final textColumn = FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Column(
          crossAxisAlignment:
              isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: Text(
                'AVAILABLE FOR OPPORTUNITIES',
                style: AppTypography.label(AppColors.primary).copyWith(fontSize: 11),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Hi, I'm ${AppConstants.name}.",
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
              style: (isMobile
                  ? AppTypography.h1(context.textPrimary)
                  : AppTypography.display(context.textPrimary)),
            ),
            const SizedBox(height: 14),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Text(
                AppConstants.tagline,
                textAlign: isMobile ? TextAlign.center : TextAlign.start,
                style: AppTypography.h3(context.textSecondary).copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Text(
                AppConstants.subTagline,
                textAlign: isMobile ? TextAlign.center : TextAlign.start,
                style: AppTypography.bodyLarge(context.textSecondary),
              ),
            ),
            const SizedBox(height: 32),
            Wrap(
              alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
              spacing: 14,
              runSpacing: 14,
              children: [
                AppButton(
                  label: 'View My Work',
                  icon: Icons.arrow_downward_rounded,
                  onPressed: widget.onViewWork,
                ),
                AppButton(
                  label: 'Download Resume',
                  type: AppButtonStyleType.secondary,
                  icon: Icons.download_rounded,
                  onPressed: widget.onDownloadResume,
                ),
                AppButton(
                  label: "Let's Talk",
                  type: AppButtonStyleType.ghost,
                  onPressed: widget.onContact,
                ),
              ],
            ),
            const SizedBox(height: 32),
            Wrap(
              alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
              spacing: 12,
              children: PortfolioData.socialLinks
                  .map((link) => SocialButton(link: link))
                  .toList(),
            ),
          ],
        ),
      ),
    );

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: context.heroGradient,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.only(
        top: isMobile ? 130 : 160,
        bottom: 80,
      ),
      child: ResponsiveContainer(
        child: isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 6, child: textColumn),
                  const SizedBox(width: 40),
                  Expanded(
                    flex: 5,
                    child: _FloatingTechVisual(reduceMotion: widget.reduceMotion),
                  ),
                ],
              )
            : Column(
                children: [
                  textColumn,
                  const SizedBox(height: 56),
                  SizedBox(
                    height: isMobile ? 260 : 320,
                    child: _FloatingTechVisual(reduceMotion: widget.reduceMotion),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Abstract "floating device + tech node" visual — deliberately not a
/// stock illustration. A soft glass card with orbiting technology badges.
class _FloatingTechVisual extends StatefulWidget {
  final bool reduceMotion;
  const _FloatingTechVisual({required this.reduceMotion});

  @override
  State<_FloatingTechVisual> createState() => _FloatingTechVisualState();
}

class _FloatingTechVisualState extends State<_FloatingTechVisual>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const _badges = ['Flutter', 'Dart', 'Firebase', 'REST', 'Socket.io', 'Flame'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    );
    if (!widget.reduceMotion) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final size = constraints.biggest.shortestSide;
            final radius = size * 0.42;

            return Stack(
              alignment: Alignment.center,
              children: [
                // Center glass card
                Container(
                  width: size * 0.5,
                  height: size * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: context.surfaceElevated.withOpacity(0.9),
                    border: Border.all(color: context.borderColor),
                    boxShadow: AppShadows.glow(AppColors.primary),
                  ),
                  child: const Icon(
                    Icons.flutter_dash,
                    size: 56,
                    color: AppColors.primary,
                  ),
                ),
                for (int i = 0; i < _badges.length; i++)
                  _orbitBadge(i, radius),
              ],
            );
          },
        );
      },
    );
  }

  Widget _orbitBadge(int index, double radius) {
    final baseAngle = (2 * math.pi * index) / _badges.length;
    final angle = baseAngle + _controller.value * 2 * math.pi;
    final dx = radius * 0.9 * math.cos(angle);
    final dy = radius * 0.6 * math.sin(angle);

    return Transform.translate(
      offset: Offset(dx, dy),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: context.borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(context.isDarkMode ? 0.3 : 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          _badges[index],
          style: AppTypography.body(context.textSecondary).copyWith(fontSize: 12),
        ),
      ),
    );
  }
}
