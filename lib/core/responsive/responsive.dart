import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

/// Centralized breakpoints. Reference these instead of hardcoding numbers
/// throughout the widget tree.
class Breakpoints {
  Breakpoints._();
  static const double mobile = 600;
  static const double tablet = 1024;
}

class Responsive {
  Responsive._();

  static DeviceType deviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < Breakpoints.mobile) return DeviceType.mobile;
    if (width < Breakpoints.tablet) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  static bool isMobile(BuildContext context) =>
      deviceType(context) == DeviceType.mobile;

  static bool isTablet(BuildContext context) =>
      deviceType(context) == DeviceType.tablet;

  static bool isDesktop(BuildContext context) =>
      deviceType(context) == DeviceType.desktop;

  /// Content max-width so text/sections don't stretch edge-to-edge on
  /// ultra-wide desktop screens.
  static double contentMaxWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1440) return 1200;
    return width;
  }

  static EdgeInsets pageHorizontalPadding(BuildContext context) {
    switch (deviceType(context)) {
      case DeviceType.mobile:
        return const EdgeInsets.symmetric(horizontal: 20);
      case DeviceType.tablet:
        return const EdgeInsets.symmetric(horizontal: 40);
      case DeviceType.desktop:
        return const EdgeInsets.symmetric(horizontal: 80);
    }
  }
}

/// A builder-style widget that picks one of three layouts by breakpoint,
/// so screens don't need repeated MediaQuery checks.
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context) mobile;
  final Widget Function(BuildContext context)? tablet;
  final Widget Function(BuildContext context) desktop;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final type = Responsive.deviceType(context);
    switch (type) {
      case DeviceType.mobile:
        return mobile(context);
      case DeviceType.tablet:
        return (tablet ?? desktop)(context);
      case DeviceType.desktop:
        return desktop(context);
    }
  }
}
