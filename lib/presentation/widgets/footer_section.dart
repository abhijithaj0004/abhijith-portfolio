import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_theme.dart';
import '../../core/responsive/responsive.dart';
import '../../data/content/portfolio_data.dart';
import 'common/responsive_container.dart';
import 'common/social_button.dart';

class FooterSection extends StatefulWidget {
  final VoidCallback onBackToTop;
  const FooterSection({super.key, required this.onBackToTop});

  @override
  State<FooterSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      color: context.surfaceColor,
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: ResponsiveContainer(
        child: Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment:
                  isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                Text('© 2026 Abhijith AJ',
                    style: AppTypography.body(context.textSecondary)),
                const SizedBox(height: 2),
                Text('Built with Flutter.',
                    style: AppTypography.body(context.textMuted).copyWith(fontSize: 12)),
              ],
            ),
            SizedBox(height: isMobile ? 20 : 0),
            Wrap(
              spacing: 10,
              children: PortfolioData.socialLinks
                  .map((link) => SocialButton(link: link))
                  .toList(),
            ),
            SizedBox(height: isMobile ? 20 : 0),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => _hovering = true),
              onExit: (_) => setState(() => _hovering = false),
              child: GestureDetector(
                onTap: widget.onBackToTop,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.all(10),
                  transform: Matrix4.translationValues(0, _hovering ? -3 : 0, 0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withOpacity(0.12),
                  ),
                  child: const Icon(Icons.arrow_upward_rounded,
                      size: 18, color: AppColors.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
