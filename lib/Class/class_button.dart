import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget? child; // Made optional if you prefer using label
  final String? label; // Made optional if you prefer using child
  final double? height; // Fixed spelling: hieght -> height
  final double? width; // Fixed spelling: weidht -> width
  final Color? color;
  final Color? textcolor;

  const CustomButton({
    super.key,
    required this.onTap,
    this.child,
    this.label,
    this.height,
    this.width,
    this.color,
    this.textcolor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Use SizedBox to apply your custom width and height
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textcolor,
        ),
        // Use the label if provided, otherwise fallback to the child widget
        child: label != null ? Text(label!) : child,
      ),
    );
  }
}
