import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/launch_utils.dart';
import '../../../data/models/social_link.dart';

class SocialButton extends StatefulWidget {
  final SocialLink link;
  const SocialButton({super.key, required this.link});

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () => LaunchUtils.openUrl(widget.link.url),
        child: Tooltip(
          message: widget.link.label,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _hovering
                  ? AppColors.primary.withOpacity(0.15)
                  : context.surfaceElevated,
              border: Border.all(
                color: _hovering ? AppColors.primary : context.borderColor,
              ),
            ),
            child: Icon(
              widget.link.icon,
              size: 18,
              color: _hovering ? AppColors.primary : context.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
