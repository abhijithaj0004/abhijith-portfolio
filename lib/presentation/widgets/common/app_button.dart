import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';

enum AppButtonStyleType { primary, secondary, ghost }

class AppButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonStyleType type;
  final IconData? icon;
  final bool loading;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = AppButtonStyleType.primary,
    this.icon,
    this.loading = false,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    Color background;
    Color foreground;
    Border? border;

    switch (widget.type) {
      case AppButtonStyleType.primary:
        background = _hovering ? AppColors.primaryLight : AppColors.primary;
        foreground = Colors.white;
        border = null;
        break;
      case AppButtonStyleType.secondary:
        background = Colors.transparent;
        foreground = context.textPrimary;
        border = Border.all(
          color: _hovering ? AppColors.primary : context.borderColor,
          width: 1.4,
        );
        break;
      case AppButtonStyleType.ghost:
        background =
            _hovering ? context.surfaceElevated : Colors.transparent;
        foreground = context.textSecondary;
        border = null;
        break;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.loading ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          transform: Matrix4.translationValues(0, _hovering ? -2 : 0, 0),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(999),
            border: border,
            boxShadow: widget.type == AppButtonStyleType.primary && _hovering
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.loading) ...[
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(foreground),
                  ),
                ),
                const SizedBox(width: 10),
              ] else if (widget.icon != null) ...[
                Icon(widget.icon, size: 18, color: foreground),
                const SizedBox(width: 8),
              ],
              Text(widget.label, style: AppTypography.button(foreground)),
            ],
          ),
        ),
      ),
    );
  }
}
