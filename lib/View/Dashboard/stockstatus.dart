import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StockStatusChart extends StatelessWidget {
  const StockStatusChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet =
            constraints.maxWidth >= 600 && constraints.maxWidth < 1000;
        final isDesktop = constraints.maxWidth >= 1000;
        final isMobile = constraints.maxWidth < 600;

        // Responsive sizing for desktop, tablet, and mobile
        final titleFontSize = isDesktop ? 24.0 : (isTablet ? 20.0 : 18.0);
        final labelFontSize = isDesktop ? 14.0 : (isTablet ? 13.0 : 12.0);
        final percentageFontSize = isDesktop ? 14.0 : (isTablet ? 13.0 : 12.0);
        final chartHeight = isDesktop ? 280.0 : (isTablet ? 220.0 : 180.0);
        final chartRadius = isDesktop ? 130.0 : (isTablet ? 110.0 : 85.0);
        final padding = isDesktop ? 20.0 : (isTablet ? 16.0 : 12.0);
        final spacing = isDesktop ? 16.0 : (isTablet ? 12.0 : 10.0);
        final colorBoxSize = isDesktop ? 16.0 : (isTablet ? 14.0 : 12.0);

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF232D37),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Stock Status",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spacing),
                isMobile
                    ? Column(
                        children: [
                          SizedBox(
                            height: chartHeight,
                            child: PieChart(
                              PieChartData(
                                sectionsSpace: 2,
                                centerSpaceRadius: 0,
                                sections: [
                                  _section(
                                    60,
                                    const Color(0xFF0A84FF),
                                    "60%",
                                    chartRadius,
                                    14.0,
                                  ),
                                  _section(
                                    25,
                                    const Color(0xFFFF9F0A),
                                    "25%",
                                    chartRadius,
                                    14.0,
                                  ),
                                  _section(
                                    10,
                                    const Color(0xFFFF453A),
                                    "10%",
                                    chartRadius,
                                    14.0,
                                  ),
                                  _section(
                                    5,
                                    const Color(0xFF32D74B),
                                    "5%",
                                    chartRadius,
                                    14.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: spacing),
                          Column(
                            children: [
                              _legendItem(
                                const Color(0xFF32D74B),
                                "Active",
                                "5%",
                                labelFontSize,
                                percentageFontSize,
                                colorBoxSize,
                              ),
                              Divider(color: Colors.white10, height: 8),
                              _legendItem(
                                const Color(0xFF0A84FF),
                                "Normal",
                                "60%",
                                labelFontSize,
                                percentageFontSize,
                                colorBoxSize,
                              ),
                              Divider(color: Colors.white10, height: 8),
                              _legendItem(
                                const Color(0xFFFF9F0A),
                                "Low Stock",
                                "25%",
                                labelFontSize,
                                percentageFontSize,
                                colorBoxSize,
                              ),
                              Divider(color: Colors.white10, height: 8),
                              _legendItem(
                                const Color(0xFFFF453A),
                                "Out of Stock",
                                "10%",
                                labelFontSize,
                                percentageFontSize,
                                colorBoxSize,
                              ),
                            ],
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: chartHeight,
                              child: PieChart(
                                PieChartData(
                                  sectionsSpace: 2,
                                  centerSpaceRadius: 0,
                                  sections: [
                                    _section(
                                      60,
                                      const Color(0xFF0A84FF),
                                      "60%",
                                      chartRadius,
                                      14.0,
                                    ),
                                    _section(
                                      25,
                                      const Color(0xFFFF9F0A),
                                      "25%",
                                      chartRadius,
                                      14.0,
                                    ),
                                    _section(
                                      10,
                                      const Color(0xFFFF453A),
                                      "10%",
                                      chartRadius,
                                      14.0,
                                    ),
                                    _section(
                                      5,
                                      const Color(0xFF32D74B),
                                      "5%",
                                      chartRadius,
                                      14.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spacing),
                          Expanded(
                            child: Column(
                              children: [
                                _legendItem(
                                  const Color(0xFF32D74B),
                                  "Active",
                                  "5%",
                                  labelFontSize,
                                  percentageFontSize,
                                  colorBoxSize,
                                ),
                                Divider(color: Colors.white10, height: 8),
                                _legendItem(
                                  const Color(0xFF0A84FF),
                                  "Normal",
                                  "60%",
                                  labelFontSize,
                                  percentageFontSize,
                                  colorBoxSize,
                                ),
                                Divider(color: Colors.white10, height: 8),
                                _legendItem(
                                  const Color(0xFFFF9F0A),
                                  "Low Stock",
                                  "25%",
                                  labelFontSize,
                                  percentageFontSize,
                                  colorBoxSize,
                                ),
                                Divider(color: Colors.white10, height: 8),
                                _legendItem(
                                  const Color(0xFFFF453A),
                                  "Out of Stock",
                                  "10%",
                                  labelFontSize,
                                  percentageFontSize,
                                  colorBoxSize,
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
      },
    );
  }

  // Helper to create pie slices
  PieChartSectionData _section(
    double value,
    Color color,
    String title,
    double radius,
    double fontSize,
  ) {
    return PieChartSectionData(
      color: color,
      value: value,
      title: title,
      radius: radius,
      titleStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  // Helper to create legend rows
  Widget _legendItem(
    Color color,
    String label,
    String percentage,
    double labelFontSize,
    double percentageFontSize,
    double colorBoxSize,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: colorBoxSize,
            height: colorBoxSize,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: Colors.white70, fontSize: labelFontSize),
            ),
          ),
          Text(
            percentage,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: percentageFontSize,
            ),
          ),
        ],
      ),
    );
  }
}
