import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mybuttoncomponent extends StatelessWidget{
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final BorderSide? border;
  final Widget? icon;

  const Mybuttoncomponent({
    super.key,
    required this.text,
    required this.onTap,
    required this.backgroundColor,
    this.textColor = Colors.white,
    this.border,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          side: border,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 10),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}