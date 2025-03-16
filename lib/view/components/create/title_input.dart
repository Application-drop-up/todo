import 'package:flutter/material.dart';

class TitleInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String title;
  final Function(String)? onChanged;

  const TitleInput({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.title,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
