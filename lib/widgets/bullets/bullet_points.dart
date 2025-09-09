import 'package:flutter/material.dart';

class BulletPoint extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColor;
  final Color? bulletColor;
  final String bulletSymbol;

  const BulletPoint({
    super.key,
    required this.text,
    this.fontSize,
    this.textColor,
    this.bulletColor,
    this.bulletSymbol = "•",
    EdgeInsetsGeometry? padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$bulletSymbol  ",
            style: TextStyle(
              fontSize: (fontSize ?? 16) + 4, // Larger bullet
              color: bulletColor ?? Colors.black87,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize ?? 16,
                color: textColor ?? Colors.black87,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
