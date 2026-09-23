import 'package:flutter/material.dart';
import 'dart:ui';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_theme.dart';
import '../../core/responsive/responsive.dart';
import '../../core/constants/app_constants.dart';
import '../../main.dart';
import 'common/app_button.dart';

class NavItem {
  final String label;
  final GlobalKey sectionKey;
  const NavItem(this.label, this.sectionKey);
}

class Navbar extends StatefulWidget {
  final List<NavItem> items;
  final VoidCallback onResumeTap;
  final bool scrolled;

  const Navbar({
    super.key,
    required this.items,
    required this.onResumeTap,
    required this.scrolled,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool _menuOpen = false;

  void _scrollTo(GlobalKey key) {
    setState(() => _menuOpen = false);
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = !Responsive.isMobile(context) && !Responsive.isTablet(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRect(
          child: BackdropFilter(
            filter: widget.scrolled
                ? ImageFilter.blur(sigmaX: 12, sigmaY: 12)
                : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.isMobile(context) ? 20 : 60,
                vertical: 18,
              ),
              decoration: BoxDecoration(
                color: widget.scrolled
                    ? context.surfaceColor.withOpacity(0.75)
                    : Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    color: widget.scrolled
                        ? context.borderColor
                        : Colors.transparent,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          gradient: const LinearGradient(
                            colors: [AppColors.primary, AppColors.accent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'AJ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      if (isDesktop) ...[
                        const SizedBox(width: 12),
                        Text(
                          AppConstants.name,
                          style: AppTypography.h3(context.textPrimary)
                              .copyWith(fontSize: 16),
                        ),
                      ],
                    ],
                  ),
                  if (isDesktop)
                    Row(
                      children: [
                        ...widget.items.map(
                          (item) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: _NavLink(
                              label: item.label,
                              onTap: () => _scrollTo(item.sectionKey),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          tooltip: themeController.isDark
                              ? 'Switch to light mode'
                              : 'Switch to dark mode',
                          onPressed: themeController.toggle,
                          icon: Icon(
                            themeController.isDark
                                ? Icons.light_mode_outlined
                                : Icons.dark_mode_outlined,
                            color: context.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        AppButton(
                          label: 'Resume',
                          type: AppButtonStyleType.secondary,
                          onPressed: widget.onResumeTap,
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        IconButton(
                          onPressed: themeController.toggle,
                          icon: Icon(
                            themeController.isDark
                                ? Icons.light_mode_outlined
                                : Icons.dark_mode_outlined,
                            color: context.textSecondary,
                          ),
                        ),
                        IconButton(
                          onPressed: () => setState(() => _menuOpen = !_menuOpen),
                          icon: Icon(
                            _menuOpen ? Icons.close : Icons.menu,
                            color: context.textPrimary,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        if (!isDesktop)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            top: _menuOpen ? 66 : -400,
            left: 0,
            right: 0,
            child: Material(
              color: context.surfaceColor,
              elevation: 8,
              child: Column(
                children: [
                  ...widget.items.map(
                    (item) => ListTile(
                      title: Text(
                        item.label,
                        style: AppTypography.body(context.textPrimary),
                      ),
                      onTap: () => _scrollTo(item.sectionKey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: AppButton(
                      label: 'Resume',
                      type: AppButtonStyleType.secondary,
                      onPressed: widget.onResumeTap,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: AppTypography.body(
            _hovering ? AppColors.primary : context.textSecondary,
          ).copyWith(fontSize: 14, fontWeight: FontWeight.w500),
          child: Text(widget.label),
        ),
      ),
    );
  }
}
