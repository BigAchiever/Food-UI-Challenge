import 'package:flutter/material.dart';

class AnimatedRow extends StatelessWidget {
  final List<Widget>? children;
  final int? duration;
  final double? delay;
  final bool reverse;

  const AnimatedRow({
    super.key,
    required this.children,
    required this.duration,
    required this.delay,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children!.asMap().entries.map((entry) {
        final index = entry.key;
        final widget = entry.value;
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: reverse ? 0.0 : 1.0, end: reverse ? 1.0 : 0.0),
          duration: Duration(milliseconds: duration!),
          curve: Curves.decelerate,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(
                0.0,
                value * (delay! * index),
              ),
              child: child!,
            );
          },
          child: widget,
        );
      }).toList(),
    );
  }
}
