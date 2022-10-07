import 'package:flutter/material.dart';

const textFieldBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.white,
    width: 1.5,
  ),
);

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.15, vertical: size.height * 0.02),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
