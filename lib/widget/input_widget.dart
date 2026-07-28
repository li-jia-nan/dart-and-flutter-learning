import 'package:flutter/material.dart';

// 登录输入框
class InputWidget extends StatelessWidget {
  final String hint;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;

  const InputWidget(
    this.hint, {
    Key? key,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _input(),
        Divider(height: 1, color: Colors.white, thickness: 0.5),
      ],
    );
  }

  Widget _input() {
    return TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      autofocus: !obscureText,
      cursorColor: Colors.white,
      style: const TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 17, color: Colors.grey),
      ),
    );
  }
}
