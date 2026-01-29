import 'package:flutter/material.dart';

class Alert extends StatefulWidget {
  const Alert({super.key});

  @override
  State<Alert> createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet =
            constraints.maxWidth >= 800 && constraints.maxWidth < 1200;
        final isDesktop = constraints.maxWidth >= 1200;

        // Responsive sizing
        final titleSize = isDesktop ? 20.0 : (isTablet ? 18.0 : 16.0);
        final messageSize = isDesktop ? 15.0 : (isTablet ? 14.0 : 13.0);
        final iconSize = isDesktop ? 28.0 : (isTablet ? 24.0 : 20.0);
        final padding = isDesktop ? 16.0 : (isTablet ? 12.0 : 8.0);
        final spacing = isDesktop ? 12.0 : (isTablet ? 10.0 : 8.0);

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF232D37),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Alert",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: titleSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Image.asset(
                      'icons/alert.png',
                      height: iconSize,
                      width: iconSize,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: spacing),
                Divider(
                  color: Colors.white10,
                  thickness: isDesktop ? 1.5 : 1.0,
                ),
                SizedBox(height: spacing),
                Padding(
                  padding: EdgeInsets.all(spacing),
                  child: Column(
                    children: [
                      _Alertmessage(
                        "icons/alert_low_stock.png",
                        "Low Stock: ",
                        "Coca Cola",
                        "5",
                        messageSize,
                        spacing,
                      ),
                      SizedBox(height: spacing * 0.8),
                      _Alertmessage(
                        "icons/alert_out_of_stock.png",
                        "Out of Stock: ",
                        "Monster",
                        "0",
                        messageSize,
                        spacing,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _Alertmessage(
    String iconPath,
    String title,
    String product,
    String qty,
    double fontSize,
    double spacing,
  ) {
    final textStyle = TextStyle(
      fontSize: fontSize,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    );

    return Card(
      elevation: 2,
      color: Colors.black38,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(spacing),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  iconPath,
                  height: fontSize + 6,
                  width: fontSize + 6,
                ),
                SizedBox(width: spacing),
                Text(title, style: textStyle),
                Text(product, style: textStyle),
                Text(": Left $qty", style: textStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
