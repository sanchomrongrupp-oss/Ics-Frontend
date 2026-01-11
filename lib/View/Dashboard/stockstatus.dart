import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StockStatusChart extends StatelessWidget {
  const StockStatusChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF232D37), // Dark background from image
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Stock Status",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                // --- THE PIE CHART ---
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 250,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 0, // 0 makes it a Pie, not a Donut
                        sections: [
                          _section(60, const Color(0xFF0A84FF), "60%"),
                          _section(25, const Color(0xFFFF9F0A), "25%"),
                          _section(10, const Color(0xFFFF453A), "10%"),
                          // Small green sliver seen in the top left of your image
                          _section(5, const Color(0xFF32D74B), "5%"), 
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                // --- THE LEGEND ---
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      _legendItem(const Color(0xFF32D74B), "Active", "5%"),
                      const Divider(color: Colors.white10),
                      _legendItem(const Color(0xFF0A84FF), "Normal", "60%"),
                      const Divider(color: Colors.white10),
                      _legendItem(const Color(0xFFFF9F0A), "Low Stock", "25%"),
                      const Divider(color: Colors.white10),
                      _legendItem(const Color(0xFFFF453A), "Out of Stock", "10%"),
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

  // Helper to create pie slices
  PieChartSectionData _section(double value, Color color, String title) {
    return PieChartSectionData(
      color: color,
      value: value,
      title: title,
      radius: 120,
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  // Helper to create legend rows
  Widget _legendItem(Color color, String label, String percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
          Text(
            percentage,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}