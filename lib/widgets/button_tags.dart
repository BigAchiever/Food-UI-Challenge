import 'package:flutter/material.dart';

import '../models/button_model.dart';

Widget _animationInWidget({
  Widget? child,
  int? duration,
  double? delay,
  bool reverse = false,
}) {
  return TweenAnimationBuilder<double>(
    tween: Tween(begin: reverse ? 0.0 : 1.0, end: reverse ? 1.0 : 0.0),
    duration: Duration(milliseconds: duration!),
    curve: Curves.decelerate,
    child: child,
    builder: (context, value, child) {
      return Transform.translate(
        offset: Offset(0.0, value * delay!),
        child: Opacity(
          opacity: 1.0 - value,
          child: child,
        ),
      );
    },
  );
}

// ignore: must_be_immutable
class ButtonColorChange extends StatefulWidget {
  late bool isScreenPopped;
  ButtonColorChange({Key? key, required this.isScreenPopped}) : super(key: key);

  @override
  State<ButtonColorChange> createState() => _ButtonColorChangeState();
}

class _ButtonColorChangeState extends State<ButtonColorChange> {
  void _toggleButton(int index) {
    setState(() {
      buttons[index].isPressed = !buttons[index].isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          widget.isScreenPopped = true;
        });
        return true;
      },
      child: Wrap(
        spacing: 8.0,
        runSpacing: 2.0,
        children: buttons.asMap().entries.map((entry) {
          final index = entry.key;
          final button = entry.value;
          return _animationInWidget(
            child: ElevatedButton(
              onPressed: () => _toggleButton(index),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                backgroundColor:
                    button.isPressed ? Colors.red : Colors.grey.shade800,
              ),
              child: Text(
                button.text,
              ),
            ),
            duration: 800,
            delay: index * 150.0,
            reverse: widget.isScreenPopped,
          );
        }).toList(),
      ),
    );
  }
}
