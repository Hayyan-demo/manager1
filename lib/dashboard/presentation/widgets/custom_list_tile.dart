import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String text;
  final Color textColor, backgroundColor, iconColor;
  final double? radius;
  final IconData icon;
  final bool isSelected;
  final Function() onPressed;
  const CustomListTile(
      {super.key,
      required this.backgroundColor,
      required this.text,
      required this.textColor,
      required this.iconColor,
      required this.icon,
      required this.isSelected,
      required this.onPressed,
      this.radius});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 20))),
      trailing: Icon(
        icon,
        color: iconColor,
      ),
      onTap: () => onPressed(),
      tileColor: isSelected ? backgroundColor : Colors.transparent,
    );
  }
}
