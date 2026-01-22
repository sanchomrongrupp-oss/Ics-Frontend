import 'package:flutter/material.dart';

// Changed to StatelessWidget since no internal state is being managed
class CustomInputField extends StatelessWidget {
  final bool readOnly;
  final String label;
  final double width;
  final String? hintText; // Added hintText for better UX
  final TextEditingController? controller; // Added controller for data handling

  const CustomInputField({
    super.key,
    required this.label,
    required this.width,
    this.readOnly = false,
    this.hintText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const textStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 6), // Space between label and field
          SizedBox(
            width: width,
            height: 40, // Fixed height for a compact UI
            child: TextField(
              controller: controller,
              // Note: readOnly is true in your snippet. Change to false if users need to type.
              readOnly: readOnly,
              style: textStyle,
              textAlignVertical:
                  TextAlignVertical.center, // Keeps text centered vertically
              decoration: InputDecoration(
                hintText: hintText,
                filled: true,
                fillColor: isDark ? Colors.white10 : Colors.grey[50],
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0, // Adjusted for fixed height
                  horizontal: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: isDark ? Colors.white24 : Colors.grey[300]!,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: isDark ? Colors.white24 : Colors.grey[300]!,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                ),
                hintStyle: textStyle.copyWith(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
