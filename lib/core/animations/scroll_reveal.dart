import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Fades + slides a child into view once, the first time its widget key
/// enters the viewport. Uses a simple post-frame position check rather than
/// an extra package dependency, so it stays dependency-light.
///
/// Respects `prefers-reduced-motion` via [reduceMotion] — pass the app-wide
/// flag down from main.dart / a ThemeController.
class ScrollReveal extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final bool reduceMotion;
  final Offset offset;

  const ScrollReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.reduceMotion = false,
    this.offset = const Offset(0, 24),
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.reduceMotion
          ? const Duration(milliseconds: 1)
          : const Duration(milliseconds: 600),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: Offset(widget.offset.dx / 100, widget.offset.dy / 100),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    if (widget.reduceMotion) {
      _controller.value = 1;
      _revealed = true;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => _maybeReveal());
    }
  }

  void _maybeReveal() {
    if (_revealed || !mounted) return;
    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.attached) {
      SchedulerBinding.instance.addPostFrameCallback((_) => _maybeReveal());
      return;
    }
    final position = renderObject.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.of(context).size.height;
    if (position.dy < screenHeight * 0.92) {
      _revealed = true;
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    } else {
      // Not visible yet — check again on next frame (covers initial load
      // and slow scroll). This is intentionally lightweight rather than a
      // full scroll-position listener.
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 120), () {
          if (mounted) _maybeReveal();
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}
