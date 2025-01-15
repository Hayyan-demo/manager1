import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double height, width;
  final Widget child;
  final Color? color;
  final Future<void> Function()? onPressed;
  const CustomButton(
      {super.key,
      required this.height,
      required this.width,
      required this.onPressed,
      required this.child,
      this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        onPressed: onPressed == null ? null : () => onPressed!(),
        clipBehavior: Clip.antiAlias,
        style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(
                    color: color ?? Theme.of(context).colorScheme.primary),
              ),
            ),
            backgroundColor:
                WidgetStateProperty.all<Color>(_getWithAlphaColor(context))),
        child: child,
      ),
    );
  }

  Color _getWithAlphaColor(BuildContext context) {
    if (color != null) {
      return color!.withAlpha(250);
    } else {
      return Theme.of(context).colorScheme.primary.withAlpha(150);
    }
  }
}
