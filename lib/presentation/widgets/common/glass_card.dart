import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';

/// A soft, bordered card used throughout the site (skills, highlights,
/// project cards, timeline items). "Glass" styling is intentionally
/// restrained — a subtle surface tint + border, not heavy blur, per the
/// "glassmorphism used sparingly" design direction.
class GlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final bool hoverLift;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.onTap,
    this.hoverLift = true,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final content = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      padding: widget.padding,
      transform: Matrix4.translationValues(
        0,
        widget.hoverLift && _hovering ? -4 : 0,
        0,
      ),
      decoration: BoxDecoration(
        color: context.surfaceElevated,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: _hovering
              ? context.textMuted.withOpacity(0.4)
              : context.borderColor,
        ),
        boxShadow: _hovering
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(context.isDarkMode ? 0.3 : 0.06),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ]
            : null,
      ),
      child: widget.child,
    );

    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: widget.onTap != null
          ? GestureDetector(onTap: widget.onTap, child: content)
          : content,
    );
  }
}
