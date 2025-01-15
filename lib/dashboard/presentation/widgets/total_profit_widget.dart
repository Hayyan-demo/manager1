import 'package:flutter/material.dart';

class TotalProfitWidget extends StatelessWidget {
  final double maxProfit, height, width, profit;

  const TotalProfitWidget(
      {super.key,
      required this.maxProfit,
      required this.height,
      required this.width,
      required this.profit});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          child: AnimatedContainer(
            curve: Curves.fastOutSlowIn,
            height: (height * profit) / maxProfit,
            width: width - 180,
            duration: const Duration(seconds: 5),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 141, 255, 34),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(right: 80),
          height: height - 50,
          width: width - 180,
          decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Color.fromARGB(255, 33, 243, 243),
                  width: 3,
                ),
                right: BorderSide(
                  color: Color.fromARGB(255, 33, 243, 243),
                  width: 3,
                ),
                bottom: BorderSide(
                  color: Color.fromARGB(255, 33, 243, 243),
                  width: 3,
                ),
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
        ),
        Positioned(
            left: 10,
            top: 5,
            child: Text(
              "Goal: $maxProfit \$",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            )),
        AnimatedPositioned(
            duration: const Duration(seconds: 5),
            right: 10,
            curve: Curves.fastOutSlowIn,
            bottom: (height * profit) / maxProfit,
            child: Text(
              "Current: $profit \$",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ))
      ],
    );
  }
}
