import 'package:flutter/material.dart';

class CounterClock extends StatelessWidget {
  const CounterClock({
    super.key,
    required this.controller,
    required this.counterText,
    required this.animation,
  });

  final AnimationController controller;
  final String counterText;
  final Animation animation;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      CircleAvatar(
        radius: 150,
        backgroundColor: Colors.grey[300],
      ),
      CircleAvatar(
        radius: 130,
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return Text(
                    counterText,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  );
                }),
            const Text(
              "minutes remaining",
              style: TextStyle(
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
      Transform.rotate(
        angle: 3.14 + (3.14 / 2),
        child: ShaderMask(
          shaderCallback: (rect) {
            return SweepGradient(
              startAngle: 0,
              endAngle: 3.14 * 2,
              stops: [animation.value, animation.value],
              center: Alignment.center,
              colors: [
                Colors.green,
                animation.value == 0.0 ? Colors.green : Colors.grey
              ],
            ).createShader(rect);
          },
          child: Center(
            child: Container(
              width: 230,
              height: 230,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/clock_lines.png'),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
