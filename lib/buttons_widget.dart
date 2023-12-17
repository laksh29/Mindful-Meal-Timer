import 'package:flutter/material.dart';
import 'package:neopop/neopop.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Function()? onClicked;
  final bool secondary;
  const ButtonWidget({
    super.key,
    required this.text,
    this.onClicked,
    this.secondary = false,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      height: 60,
      width: width / 1.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: NeoPopButton(
        onTapUp: onClicked,
        border: secondary
            ? Border.all(
                color: const Color.fromARGB(255, 226, 247, 228),
                width: 3,
              )
            : null,
        color: secondary
            ? Colors.transparent
            : const Color.fromARGB(255, 226, 247, 228),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: secondary ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
