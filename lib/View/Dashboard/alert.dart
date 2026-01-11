import 'package:flutter/material.dart';

class Alert extends StatefulWidget {
  const Alert({super.key});

  @override
  State<Alert> createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF232D37), // Dark background from image
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("Alert",
                  style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                ),
                Spacer(),
                Image.asset('icons/alert.png',height: 24,width: 24,color: Colors.white,)
              ],
            ),
            Divider(color: Colors.white10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _Alertmessage("icons/alert_low_stock.png", "Low Stock: ","Coca Cola","5"),
                  
                  _Alertmessage("icons/alert_out_of_stock.png", "Out of Stock: ","Monster","0"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  
  Widget _Alertmessage(String iconPath, String title, String product, String qty){
    
    const textStyle = TextStyle(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.w500, // Added for better readability
  );

    return Card(
      elevation: 2,
      color: Colors.black38,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(iconPath,height: 20,width: 20,),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  title,
                  style: textStyle
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  product,
                  style: textStyle
                ),
                Text(
                  ": Left $qty",
                  style: textStyle
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}