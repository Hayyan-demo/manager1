import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

class ImagePickerWidget extends StatefulWidget {
  final double height, width;
  final Function(Uint8List) onImageSelected;

  const ImagePickerWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.onImageSelected});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  Uint8List? _imageBytes;

  Future<void> _pickImage() async {
    final imageBytes = await ImagePickerWeb.getImageAsBytes();

    if (imageBytes != null) {
      setState(() {
        _imageBytes = imageBytes;
      });

      widget.onImageSelected(imageBytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickImage,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            color: Colors.white.withAlpha(50),
            border: Border.all(color: Colors.white),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            image: _imageBytes == null
                ? null
                : DecorationImage(
                    fit: BoxFit.cover,
                    image: MemoryImage(
                      _imageBytes!,
                    ))),
        child: Center(
          child: _imageBytes != null
              ? const Text("")
              : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    Text(
                      "Add store picture",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
