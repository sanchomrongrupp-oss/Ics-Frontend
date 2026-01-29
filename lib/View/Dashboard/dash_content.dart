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
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 800;
          final isTablet =
              constraints.maxWidth >= 800 && constraints.maxWidth < 1200;
          final isDesktop = constraints.maxWidth >= 1200;

          // Responsive sizing
          final padding = isDesktop ? 16.0 : (isTablet ? 12.0 : 8.0);
          final spacing = isDesktop ? 16.0 : (isTablet ? 12.0 : 8.0);
          final titleFontSize = isDesktop ? 22.0 : (isTablet ? 20.0 : 18.0);
          final countFontSize = isDesktop ? 36.0 : (isTablet ? 32.0 : 28.0);
          final cardHeight = isDesktop ? 140.0 : (isTablet ? 120.0 : 100.0);
          final chartHeight = isDesktop ? 450.0 : (isTablet ? 380.0 : 320.0);
          final alertHeight = isDesktop ? 360.0 : (isTablet ? 300.0 : 250.0);

          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(padding),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Cards Row
                  isMobile
                      ? Column(
                          children: [
                            _buildStatCard(
                              "Total Products",
                              "150",
                              "icons/product.png",
                              Color.fromARGB(255, 114, 180, 255),
                              titleFontSize,
                              countFontSize,
                              cardHeight,
                              spacing,
                            ),
                            SizedBox(height: spacing),
                            _buildStatCard(
                              "Total Stock",
                              "124045",
                              "icons/total_product.png",
                              Color.fromARGB(255, 14, 184, 22),
                              titleFontSize,
                              countFontSize,
                              cardHeight,
                              spacing,
                            ),
                            SizedBox(height: spacing),
                            _buildStatCard(
                              "Low Stock",
                              "10",
                              "icons/low_stock.png",
                              Color.fromARGB(255, 230, 169, 40),
                              titleFontSize,
                              countFontSize,
                              cardHeight,
                              spacing,
                            ),
                            SizedBox(height: spacing),
                            _buildStatCard(
                              "Out of Stock",
                              "5",
                              "icons/out_of_stock.png",
                              Color.fromARGB(255, 255, 89, 89),
                              titleFontSize,
                              countFontSize,
                              cardHeight,
                              spacing,
                            ),
                            SizedBox(height: spacing),
                            _buildTodayStockInOut(
                              "Today's Stock In",
                              "500",
                              "icons/stock_up.png",
                              "Today's Stock Out",
                              "300",
                              "icons/stock_down.png",
                              titleFontSize,
                              countFontSize,
                              cardHeight,
                              spacing,
                            ),
                          ],
                        )
                      : Wrap(
                          spacing: spacing,
                          runSpacing: spacing,
                          children: [
                            _buildStatCard(
                              "Total Products",
                              "150",
                              "icons/product.png",
                              Color.fromARGB(255, 114, 180, 255),
                              titleFontSize,
                              countFontSize,
                              cardHeight,
                              spacing,
                            ),
                            _buildStatCard(
                              "Total Stock",
                              "124045",
                              "icons/total_product.png",
                              Color.fromARGB(255, 14, 184, 22),
                              titleFontSize,
                              countFontSize,
                              cardHeight,
                              spacing,
                            ),
                            _buildStatCard(
                              "Low Stock",
                              "10",
                              "icons/low_stock.png",
                              Color.fromARGB(255, 230, 169, 40),
                              titleFontSize,
                              countFontSize,
                              cardHeight,
                              spacing,
                            ),
                            _buildStatCard(
                              "Out of Stock",
                              "5",
                              "icons/out_of_stock.png",
                              Color.fromARGB(255, 255, 89, 89),
                              titleFontSize,
                              countFontSize,
                              cardHeight,
                              spacing,
                            ),
                            _buildTodayStockInOut(
                              "Today's Stock In",
                              "500",
                              "icons/stock_up.png",
                              "Today's Stock Out",
                              "300",
                              "icons/stock_down.png",
                              titleFontSize,
                              countFontSize,
                              cardHeight,
                              spacing,
                            ),
                          ],
                        ),
                  SizedBox(height: spacing * 1.5),

                  // Charts Row
                  isMobile
                      ? Column(
                          children: [
                            Card(
                              elevation: 4,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: SizedBox(
                                height: chartHeight,
                                child: Chatdiagram(),
                              ),
                            ),
                            SizedBox(height: spacing),
                            Card(
                              elevation: 4,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: SizedBox(
                                height: chartHeight,
                                child: StockStatusChart(),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Card(
                                elevation: 4,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: SizedBox(
                                  height: chartHeight,
                                  child: Chatdiagram(),
                                ),
                              ),
                            ),
                            SizedBox(width: spacing),
                            Expanded(
                              flex: 1,
                              child: Card(
                                elevation: 4,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: SizedBox(
                                  height: chartHeight,
                                  child: StockStatusChart(),
                                ),
                              ),
                            ),
                          ],
                        ),
                  SizedBox(height: spacing * 1.5),

                  // Alert Section
                  Card(
                    elevation: 4,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SizedBox(height: alertHeight, child: const Alert()),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String count,
    String iconPath,
    Color color,
    double titleFontSize,
    double countFontSize,
    double cardHeight,
    double spacing,
  ) {
    return SizedBox(
      width: 220,
      height: cardHeight,
      child: Card(
        color: color,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(spacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    count,
                    style: TextStyle(
                      fontSize: countFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ImageIcon(
                    AssetImage(iconPath),
                    size: countFontSize,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTodayStockInOut(
    String titlein,
    String countin,
    String iconPathin,
    String titleout,
    String countout,
    String iconPathout,
    double titleFontSize,
    double countFontSize,
    double cardHeight,
    double spacing,
  ) {
    return SizedBox(
      width: 580,
      height: cardHeight,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(spacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      titlein,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          countin,
                          style: TextStyle(
                            fontSize: countFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: spacing),
                        ImageIcon(
                          AssetImage(iconPathin),
                          size: countFontSize - 8,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: spacing),
                child: SizedBox(
                  height: cardHeight - spacing * 2,
                  width: 1,
                  child: Container(color: Colors.grey),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      titleout,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          countout,
                          style: TextStyle(
                            fontSize: countFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: spacing),
                        ImageIcon(
                          AssetImage(iconPathout),
                          size: countFontSize - 8,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
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
