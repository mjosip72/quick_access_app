
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {

  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const spacing = SizedBox(width: 8);
    return Container(
      height: 32,
      color: Colors.green.shade800,
      child: Row(
        children: [

          Expanded(child: MoveWindow()),

          WindowButtonWidget(
            color: Colors.green,
            onPressed: () => appWindow.minimize(),
          ),spacing,

          WindowButtonWidget(
            color: Colors.yellow,
            onPressed: () => appWindow.maximizeOrRestore(),
          ),spacing,

          WindowButtonWidget(
            color: Colors.red,
            onPressed: () => appWindow.close(),
          ),spacing,

        ],
      ),
    );
  }

}

class WindowButtonWidget extends StatelessWidget {

  final Color color;
  final void Function() onPressed;

  const WindowButtonWidget({Key? key, required this.color, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 16,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: color,
          foregroundColor: Colors.transparent,
        ),
        onPressed: onPressed,
        child: null,
      ),
    );
  }

}
