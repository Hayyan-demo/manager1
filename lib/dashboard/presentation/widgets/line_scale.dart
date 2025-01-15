import 'package:flutter/material.dart';

class LineScale extends StatelessWidget {
  final String name;
  final double value;
  final double maxValue;
  final double width;
  final Color color;
  const LineScale(
      {super.key,
      required this.color,
      required this.width,
      required this.name,
      required this.value,
      required this.maxValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 3,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$name Count : $value / $maxValue ',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Stack(
          children: [
            Center(
              child: Container(
                width: width,
                height: 20,
                decoration: BoxDecoration(
                    color: Colors.white.withAlpha(30),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              width: (width * value) / maxValue,
              height: 20,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
            ),
          ],
        ),
      ],
    );
  }
}
