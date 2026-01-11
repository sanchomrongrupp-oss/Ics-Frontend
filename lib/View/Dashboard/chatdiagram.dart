import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// Helper class for colors if you don't have one
class AppColors {
  static const Color contentColorGreen = Color(0xFF2BF324);
  static const Color contentColorRed = Color(0xFFE57373);
  static const Color contentColorOrange = Color(0xFFFFB74D);
}

// Extension to handle the averaging of colors
extension ColorExtension on Color {
  Color avg(Color other) => Color.lerp(this, other, 0.5)!;
}

class Chatdiagram extends StatefulWidget {
  Chatdiagram({super.key});

  final Color leftBarColor = AppColors.contentColorGreen;
  final Color rightBarColor = AppColors.contentColorRed;
  final Color avgColor = AppColors.contentColorGreen.avg(AppColors.contentColorRed);

  @override
  State<StatefulWidget> createState() => ChatdiagramState();
}

class ChatdiagramState extends State<Chatdiagram> {
  final double width = 7;
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    // Initialize data
    rawBarGroups = [
      makeGroupData(0, 5, 12),
      makeGroupData(1, 16, 12),
      makeGroupData(2, 18, 5),
      makeGroupData(3, 20, 16),
      makeGroupData(4, 17, 6),
      makeGroupData(5, 19, 1.5),
      makeGroupData(6, 10, 1.5),
    ];
    showingBarGroups = List.of(rawBarGroups);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                makeTransactionsIcon(),
                const SizedBox(width: 38),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Stock In Vs Stock Out',
                      style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Monthly Overview',
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        IconButton(onPressed: (){}, icon: Icon(Icons.arrow_drop_down))
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 38),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: 20,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (group) => Colors.blueGrey,
                      getTooltipItem: (a, b, c, d) => null, // Keeps tooltips hidden as per your original code
                    ),
                    touchCallback: (FlTouchEvent event, response) {
                      if (response == null || response.spot == null) {
                        setState(() {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                        });
                        return;
                      }

                      touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                      setState(() {
                        if (!event.isInterestedForInteractions) {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                          return;
                        }

                        // Create a fresh list to avoid mutating the original data
                        showingBarGroups = List.of(rawBarGroups);
                        if (touchedGroupIndex != -1) {
                          var sum = 0.0;
                          for (final rod in showingBarGroups[touchedGroupIndex].barRods) {
                            sum += rod.toY;
                          }
                          final avg = sum / showingBarGroups[touchedGroupIndex].barRods.length;

                          showingBarGroups[touchedGroupIndex] = showingBarGroups[touchedGroupIndex].copyWith(
                            barRods: showingBarGroups[touchedGroupIndex].barRods.map((rod) {
                              return rod.copyWith(toY: avg, color: widget.avgColor);
                            }).toList(),
                          );
                        }
                      });
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 35, // Increased slightly to fit '10K'
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: showingBarGroups,
                  gridData: const FlGridData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 12);
    String text = '';
    if (value == 0) text = '1K';
    else if (value == 10) text = '5K';
    else if (value == 19) text = '10K';
    else return Container();

    return SideTitleWidget(meta: meta, space: 0, child: Text(text, style: style));
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];
    if (value.toInt() >= titles.length) return Container();
    
    return SideTitleWidget(
      meta: meta,
      space: 16,
      child: Text(
        titles[value.toInt()],
        style: const TextStyle(color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(toY: y1, color: widget.leftBarColor, width: width),
        BarChartRodData(toY: y2, color: widget.rightBarColor, width: width),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    const double barWidth = 4.5;
    const double barSpace = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _iconBar(10, 0.4, barWidth),
        const SizedBox(width: barSpace),
        _iconBar(28, 0.8, barWidth),
        const SizedBox(width: barSpace),
        _iconBar(42, 1.0, barWidth),
        const SizedBox(width: barSpace),
        _iconBar(28, 0.8, barWidth),
        const SizedBox(width: barSpace),
        _iconBar(10, 0.4, barWidth),
      ],
    );
  }

  Widget _iconBar(double height, double opacity, double width) {
    return Container(
      width: width,
      height: height,
      color: Colors.black.withOpacity(opacity), // Changed to black for visibility on white background
    );
  }
}