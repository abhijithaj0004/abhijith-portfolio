import 'package:flutter/material.dart';

/// Animates from 0 up to the numeric part of [value] once it starts
/// running (call via a key change or wrap in a ScrollReveal-triggered
/// widget). Supports trailing non-numeric suffixes like "+" or "%".
class AnimatedCounter extends StatefulWidget {
  final String value; // e.g. "2+", "1000+", "50%"
  final TextStyle? style;
  final Duration duration;
  final bool reduceMotion;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.style,
    this.duration = const Duration(milliseconds: 1400),
    this.reduceMotion = false,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late final int _numericTarget;
  late final String _suffix;

  @override
  void initState() {
    super.initState();
    final match = RegExp(r'^(\d+)(.*)$').firstMatch(widget.value);
    _numericTarget = match != null ? int.parse(match.group(1)!) : 0;
    _suffix = match != null ? match.group(2)! : widget.value;

    _controller = AnimationController(
      vsync: this,
      duration: widget.reduceMotion ? Duration.zero : widget.duration,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        final current = (_numericTarget * _animation.value).round();
        return Text('$current$_suffix', style: widget.style);
      },
    );
  }
}
