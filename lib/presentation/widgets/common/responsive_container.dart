import 'package:flutter/material.dart';
import '../../../core/responsive/responsive.dart';

/// Wraps section content with consistent horizontal padding and a
/// max-width cap so layouts don't stretch edge-to-edge on ultra-wide
/// desktop screens.
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth = 1200,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Responsive.pageHorizontalPadding(context),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }
}

/// A section wrapper: consistent vertical rhythm + optional background
/// color, built on top of [ResponsiveContainer].
class AppSection extends StatelessWidget {
  final Widget child;
  final Color? background;
  final Key? sectionKey;

  const AppSection({
    super.key,
    this.sectionKey,
    required this.child,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      width: double.infinity,
      color: background,
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: ResponsiveContainer(child: child),
    );
  }
}
