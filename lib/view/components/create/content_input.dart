import 'package:flutter/material.dart';

class ContentInput extends StatelessWidget {
  final TextEditingController controller;

  const ContentInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: '内容',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
