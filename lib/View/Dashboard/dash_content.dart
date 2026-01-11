import 'package:flutter/material.dart';
import 'package:ics_frontend/View/Dashboard/alert.dart';
import 'package:ics_frontend/View/Dashboard/chatdiagram.dart';
import 'package:ics_frontend/View/Dashboard/stockstatus.dart';

class DashContent extends StatefulWidget {
  const DashContent({super.key});

  @override
  State<DashContent> createState() => _DashContentState();
}

class _DashContentState extends State<DashContent> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBoxProducts(
                  "Total Products",
                  "150",
                  "icons/product.png",
                  Color.fromARGB(255, 114, 180, 255),
                ),
                CustomBoxProducts(
                  "Total Stock",
                  "124045",
                  "icons/total_product.png",
                  Color.fromARGB(255, 14, 184, 22),
                ),
                CustomBoxProducts(
                  "Low Stock",
                  "10",
                  "icons/low_stock.png",
                  Color.fromARGB(255, 230, 169, 40),
                ),
                CustomBoxProducts(
                  "Out of Stock",
                  "5",
                  "icons/out_of_stock.png",
                  Color.fromARGB(255, 255, 89, 89),
                ),
                TodayStockInOut(
                  "Today's Stock In",
                  "500",
                  "icons/stock_up.png",
                  "Today's Stock Out",
                  "300",
                  "icons/stock_down.png",
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Card(
                    elevation: 4,
                    color: Colors.white,
                    child: SizedBox(height: 400, 
                    child: Chatdiagram(),),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Card(
                    elevation: 4,
                    color: Colors.white,
                    child: SizedBox(
                      height: 400,
                      child: StockStatusChart(),
                    ),
                  )
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Card(
                    elevation: 4,
                    color: Colors.white,
                    child: SizedBox(
                      height: 300,
                      child: Alert(),
                    ),
                  )
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget CustomBoxProducts(
    String title,
    String count,
    String iconPath,
    Color color,
  ) {
    return Card(
      color: color,
      elevation: 2, // Added a little shadow for better look
      child: Container(
        width: 250,
        height: 117,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      count,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                ImageIcon(AssetImage(iconPath), size: 80, color: Colors.black),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Today stock in and out
  Widget TodayStockInOut(
    String titlein,
    String countin,
    String iconPathin,
    String titleout,
    String countout,
    String iconPathout,
  ) {
    return Card(
      elevation: 2,
      child: Container(
        width: 450,
        height: 117,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titlein,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            countin,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 50),
                          ImageIcon(
                            AssetImage(iconPathin),
                            size: 50,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 40),
                SizedBox(
                  height: 97,
                  width: 1,
                  child: Container(color: Colors.grey),
                ),
                SizedBox(width: 40),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titleout,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            countout,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 50),
                          ImageIcon(
                            AssetImage(iconPathout),
                            size: 50,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Widget chat product label
  Widget CustomChatdiagramProductLabel(String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
