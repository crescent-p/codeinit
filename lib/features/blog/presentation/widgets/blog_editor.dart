import 'package:flutter/material.dart';

class BlogTextField extends StatelessWidget {
  final TextEditingController _controller;
  final String hintext;
  const BlogTextField(
      {super.key,
      required TextEditingController controller,
      required this.hintext})
      : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: null,
      controller: _controller,
      decoration: InputDecoration(
        hintText: hintext,
      ),
    );
  }
}
