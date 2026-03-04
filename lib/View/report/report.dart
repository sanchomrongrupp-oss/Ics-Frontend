import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  String _selectedTimeRange = 'Last 7 Days';
  final List<String> _timeRanges = [
    'Today',
    'Yesterday',
    'Last 7 Days',
    'Last 30 Days',
    'Custom Range',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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

          final padding = isDesktop ? 24.0 : 16.0;
          final spacing = isDesktop ? 20.0 : 16.0;

          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(padding),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(theme, isDesktop, isMobile),
                  SizedBox(height: spacing),
                  _buildSummaryStrip(theme, isMobile, isTablet, spacing),
                  SizedBox(height: spacing * 1.5),
                  _buildFilterBar(theme, isDark, isMobile),
                  SizedBox(height: spacing * 1.5),
                  _buildChartsGrid(theme, isDark, isMobile, isTablet, spacing),
                  SizedBox(height: spacing * 1.5),
                  _buildRecentActivitySection(theme, isMobile),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // --- Header Section ---
  Widget _buildHeader(ThemeData theme, bool isDesktop, bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Analytics & Reports",
              style: TextStyle(
                fontSize: isDesktop ? 28 : 22,
                fontWeight: FontWeight.bold,
                color: theme.textTheme.titleLarge?.color,
              ),
            ),
            Text(
              "Overview of your system performance",
              style: TextStyle(
                fontSize: isDesktop ? 16 : 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        if (!isMobile)
          Row(
            children: [
              _buildActionButton(
                icon: Icons.download_rounded,
                label: "Export PDF",
                onPressed: () {},
                color: Colors.blue,
              ),
              const SizedBox(width: 12),
              _buildActionButton(
                icon: Icons.print_rounded,
                label: "Print",
                onPressed: () {},
                color: Colors.redAccent,
              ),
            ],
          ),
      ],
    );
  }

  // --- Summary Cards ---
  Widget _buildSummaryStrip(
    ThemeData theme,
    bool isMobile,
    bool isTablet,
    double spacing,
  ) {
    final cards = [
      _buildStatCard(
        "Total Revenue",
        "128,430",
        "+12.5%",
        Icons.insights_rounded,
        Colors.blue,
      ),
      _buildStatCard(
        "Net Profit",
        "45,200",
        "+8.2%",
        Icons.account_balance_wallet_rounded,
        Colors.green,
      ),
      _buildStatCard(
        "Total Orders",
        "1,240",
        "-3.1%",
        Icons.shopping_cart_rounded,
        Colors.orange,
      ),
      _buildStatCard(
        "Customers",
        "856",
        "+24%",
        Icons.people_alt_rounded,
        Colors.purple,
      ),
    ];

    if (isMobile) {
      return Column(
        children: cards
            .map(
              (c) => Padding(
                padding: EdgeInsets.only(bottom: spacing),
                child: c,
              ),
            )
            .toList(),
      );
    }

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: cards
          .map((c) => SizedBox(width: isTablet ? 180 : 220, child: c))
          .toList(),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    String growth,
    IconData icon,
    Color color,
  ) {
    final isPositive = growth.startsWith('+');
    return Card(
      elevation: 0,
      color: color.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: color.withOpacity(0.2), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 28),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: (isPositive ? Colors.green : Colors.red).withOpacity(
                      0.15,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    growth,
                    style: TextStyle(
                      color: isPositive ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // --- Filter Bar ---
  Widget _buildFilterBar(ThemeData theme, bool isDark, bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.filter_list_rounded, color: Colors.grey),
          const SizedBox(width: 8),
          const Text(
            "Time Period:",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _timeRanges.map((range) {
                  final isSelected = _selectedTimeRange == range;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(range),
                      selected: isSelected,
                      onSelected: (val) =>
                          setState(() => _selectedTimeRange = range),
                      backgroundColor: Colors.transparent,
                      selectedColor: Colors.blue.withOpacity(0.2),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.blue : Colors.grey,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Charts Grid ---
  Widget _buildChartsGrid(
    ThemeData theme,
    bool isDark,
    bool isMobile,
    bool isTablet,
    double spacing,
  ) {
    if (isMobile) {
      return Column(
        children: [
          _buildChartContainer(
            "Sales Revenue Trend",
            _buildLineChart(isDark),
            350,
          ),
          SizedBox(height: spacing),
          _buildChartContainer(
            "Category Distribution",
            _buildPieChart(isDark),
            350,
          ),
          SizedBox(height: spacing),
          _buildChartContainer("Monthly Growth", _buildBarChart(isDark), 350),
        ],
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildChartContainer(
                "Sales Revenue Trend",
                _buildLineChart(isDark),
                400,
              ),
            ),
            SizedBox(width: spacing),
            Expanded(
              flex: 1,
              child: _buildChartContainer(
                "Category Distribution",
                _buildPieChart(isDark),
                400,
              ),
            ),
          ],
        ),
        SizedBox(height: spacing),
        _buildChartContainer(
          "Monthly Growth Comparison",
          _buildBarChart(isDark),
          400,
        ),
      ],
    );
  }

  Widget _buildChartContainer(String title, Widget chart, double height) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Expanded(child: chart),
        ],
      ),
    );
  }

  // --- FlChart Implementations ---

  Widget _buildLineChart(bool isDark) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) =>
              FlLine(color: Colors.grey.withOpacity(0.1), strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const dates = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                if (value.toInt() >= 0 && value.toInt() < dates.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      dates[value.toInt()],
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 3),
              const FlSpot(1, 1.5),
              const FlSpot(2, 5),
              const FlSpot(3, 3.1),
              const FlSpot(4, 4),
              const FlSpot(5, 3),
              const FlSpot(6, 4),
            ],
            isCurved: true,
            color: Colors.blue,
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(bool isDark) {
    return PieChart(
      PieChartData(
        sectionsSpace: 4,
        centerSpaceRadius: 40,
        sections: [
          PieChartSectionData(
            color: Colors.blue,
            value: 40,
            title: '40%',
            radius: 50,
            titleStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            color: Colors.green,
            value: 30,
            title: '30%',
            radius: 50,
            titleStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            color: Colors.orange,
            value: 15,
            title: '15%',
            radius: 50,
            titleStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            color: Colors.purple,
            value: 15,
            title: '15%',
            radius: 50,
            titleStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(bool isDark) {
    return BarChart(
      BarChartData(
        barGroups: [
          _buildBarGroup(0, 8, 5),
          _buildBarGroup(1, 10, 7),
          _buildBarGroup(2, 14, 10),
          _buildBarGroup(3, 15, 12),
          _buildBarGroup(4, 13, 8),
          _buildBarGroup(5, 18, 15),
        ],
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    labels[value.toInt()],
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                );
              },
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double y1, double y2) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: Colors.blue,
          width: 12,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
        BarChartRodData(
          toY: y2,
          color: Colors.green,
          width: 12,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
      ],
    );
  }

  // --- Recent Activity Section ---
  Widget _buildRecentActivitySection(ThemeData theme, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recent Transactions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(onPressed: () {}, child: const Text("View All")),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.1)),
          ),
          child: DataTable(
            columnSpacing: isMobile ? 20 : null,
            columns: const [
              DataColumn(label: Text("Date")),
              DataColumn(label: Text("Client")),
              DataColumn(label: Text("Status")),
              DataColumn(label: Text("Amount")),
            ],
            rows: [
              _buildDataRow(
                "2024-03-01",
                "Acme Corp",
                "Paid",
                "\$1,200",
                Colors.green,
              ),
              _buildDataRow(
                "2024-03-02",
                "Global Tech",
                "Pending",
                "\$850",
                Colors.orange,
              ),
              _buildDataRow(
                "2024-03-03",
                "Starlight Inc",
                "Paid",
                "\$2,100",
                Colors.green,
              ),
              _buildDataRow(
                "2024-03-04",
                "Omega Solutions",
                "Cancelled",
                "\$120",
                Colors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }

  DataRow _buildDataRow(
    String date,
    String client,
    String status,
    String amount,
    Color statusColor,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(date)),
        DataCell(Text(client)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataCell(
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  // --- Helper: Action Button ---
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
