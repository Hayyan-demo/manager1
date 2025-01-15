import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final String? Function(String?)? validator;
  final Icon prefixIcon;
  final bool obscured;
  const CustomTextFormField(
      {required this.textEditingController,
      required this.hintText,
      required this.validator,
      required this.prefixIcon,
      this.obscured = false,
      super.key});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: const TextStyle(color: Colors.white, fontSize: 18),
        cursorColor: Colors.amber,
        autocorrect: false,
        controller: widget.textEditingController,
        validator: widget.validator,
        obscureText: widget.obscured,
        decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide:
                    BorderSide(color: Colors.white, style: BorderStyle.solid)),
            fillColor: Colors.grey.shade900.withAlpha(50),
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                  color: Colors.black.withAlpha(100),
                ),
                borderRadius: BorderRadius.circular(13)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                  color: Colors.white.withAlpha(180),
                ),
                borderRadius: BorderRadius.circular(13)),
            label: Text(
              widget.hintText,
              style:
                  TextStyle(color: Colors.white.withAlpha(150), fontSize: 15),
            ),
            labelStyle: Theme.of(context).textTheme.labelSmall,
            prefixIcon: widget.prefixIcon));
  }
}
