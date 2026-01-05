import "package:flutter/material.dart";

class CustomLightModeSwitch extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onChanged;

  const CustomLightModeSwitch({
    super.key,
    required this.isDarkMode,
    required this.onChanged,
  });

  @override
  State<CustomLightModeSwitch> createState() => _CustomLightModeSwitchState();
}

class _CustomLightModeSwitchState extends State<CustomLightModeSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLabel('Light', !widget.isDarkMode,),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () => widget.onChanged(!widget.isDarkMode),
          child: Container(
            width: 150,
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            // Use Stack to layer the background icons and the moving thumb
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 2. The Animated Sliding Thumb
                AnimatedAlign(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  alignment: widget.isDarkMode ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      // FIXED: Toggle between two Image assets directly
                      child: widget.isDarkMode
                          ? Image.asset(
                              'icons/moon.png',
                              width: 60,
                              height: 60,
                            )
                          : Image.asset(
                              'icons/sun.png',
                              width: 60,
                              height: 60,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        _buildLabel('Dark', widget.isDarkMode),
      ],
    );
  }

  Widget _buildLabel(String text, bool isActive) {
    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 200),
      style: TextStyle(
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        color: isActive ? Colors.black : Colors.grey,
        fontSize: 17,
        fontFamily: 'sans-serif', // Use your app's font
      ),
      child: Text(text),
    );
  }
}