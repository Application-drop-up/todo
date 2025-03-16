import 'package:flutter/material.dart';

class ContentInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;

  const ContentInput({
    Key? key,
    required this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintText: "Enter content",
      ),
    );
  }
}
