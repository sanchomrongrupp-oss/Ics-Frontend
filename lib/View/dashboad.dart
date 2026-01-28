import 'package:flutter/material.dart';
import 'package:ics_frontend/View/Build/office.dart';
import 'package:ics_frontend/View/Customer/customer.dart';
import 'package:ics_frontend/View/Dashboard/dash_content.dart';
import 'package:ics_frontend/View/Inventory/adjustment.dart';
import 'package:ics_frontend/View/Inventory/purchaseoders.dart';
import 'package:ics_frontend/View/Inventory/stockinformation.dart';
import 'package:ics_frontend/View/login.dart';

// Note: Ensure your assets are defined in pubspec.yaml
// and your imports for DashContent and CustomLightModeSwitch are correct.

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isDark = false;
  bool _isInventoryExpanded = false; // Tracks Inventory ExpansionTile
  String _currentTitle = "Inventory";

  late Widget _currentContent;
  @override
  void initState() {
    super.initState();
    // Set default content to Dashboard
    _currentContent = const DashContent();
  }

  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF2F2F7),
      cardColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0A84FF),
        brightness: Brightness.light,
      ),
    );

    final darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      cardColor: const Color(0xFF1C1C1E),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF0A84FF),
        surface: Color(0xFF1C1C1E),
        onSurface: Colors.white,
      ),
    );
    // 1. Define Themes for Light and Dark modes

    final theme = _isDark ? darkTheme : lightTheme;

    return Theme(
      data: theme,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Row(
            children: [
              // --- SIDEBAR ---
              _buildSidebar(theme),

              // --- MAIN CONTENT ---
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    right: 16.0,
                    bottom: 16.0,
                  ),
                  child: Column(
                    children: [
                      _buildTopHeader(theme),
                      SizedBox(height: 16),
                      _currentContent,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widget: Sidebar ---
  Widget _buildSidebar(ThemeData theme) {
    return Container(
      width: 280,
      margin: const EdgeInsets.all(12),
      child: Card(
        elevation: 0,
        color: theme.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              "Inventory",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            const Text(
              "Control System",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 40),

            // Sidebar Navigation Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  _navTile(
                    iconPath: 'icons/dashboard.png',
                    title: 'Dashboard',
                    isActive: _currentContent is DashContent,
                    onTap: () {
                      setState(() {
                        _currentContent = const DashContent();
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  _navExpansionTile(
                    iconPath: 'icons/inventorys.png',
                    title: _currentTitle,
                    isDark: _isDark,
                    isExpanded: _isInventoryExpanded,
                    onExpansionChanged: (Expanded) {
                      setState(() {
                        _isInventoryExpanded = Expanded;
                      });
                    },
                    children: [
                      _subTile(
                        title: "Stock Info",
                        onTap: () {
                          setState(() {
                            _currentTitle = "Stock Info"; // ✅ show subTile name
                            _currentContent = const StockInformation();
                            _isInventoryExpanded =
                                false; // ✅ collapse after tap
                          });
                        },
                      ),
                      _subTile(
                        title: "Purchase Orders",
                        onTap: () {
                          setState(() {
                            _currentTitle =
                                "Purchase Orders"; // ✅ show subTile name
                            _currentContent = const PurchaseOders();
                            _isInventoryExpanded =
                                false; // ✅ collapse after tap
                          });
                        },
                      ),
                      _subTile(
                        title: "Adjustment",
                        onTap: () {
                          setState(() {
                            _currentTitle = "Adjustment";
                            _currentContent = const Adjustment();
                            _isInventoryExpanded =
                                false; // ✅ collapse after tap
                          });
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  _navTile(
                    iconPath: 'icons/office.png',
                    title: 'Office',
                    onTap: () {
                      setState(() {
                        _currentContent = const OfficeScreen();
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  _navTile(
                    iconPath: 'icons/towuser.png',
                    title: 'Customers',
                    onTap: () {
                      setState(() {
                        _currentContent = const CustomerScreen();
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  _navTile(
                    iconPath: 'icons/towuser.png',
                    title: 'Employees',
                    onTap: () {},
                  ),
                  SizedBox(height: 10),
                  _navTile(
                    iconPath: 'icons/finances.png',
                    title: 'Finances',
                    onTap: () {},
                  ),
                  SizedBox(height: 10),
                  _navTile(
                    iconPath: 'icons/sale.png',
                    title: 'Sale',
                    onTap: () {},
                  ),
                  SizedBox(height: 10),
                  _navTile(
                    iconPath: 'icons/settings.png',
                    title: 'Settings',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            // Theme Switcher at bottom
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ListTile(
                title: Text(
                  _isDark ? "Dark Mode" : "Light Mode",
                  style: const TextStyle(fontSize: 14),
                ),
                trailing: Switch(
                  value: _isDark,
                  onChanged: (val) => setState(() => _isDark = val),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widget: Top Header Bar ---
  Widget _buildTopHeader(ThemeData theme) {
    return Card(
      elevation: 0,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            // User Profile
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: const CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white,
                child: Image(image: AssetImage('icons/dog.png')),
              ),
            ),
            const SizedBox(width: 45),

            // Action Icons (Responsive spacing)
            _headerIconButton(
              onTap: () {},
              assetPath: 'icons/bell.png',
              hasBadge: true,
            ),
            const SizedBox(width: 30),
            _headerIconButton(
              onTap: () {},
              assetPath: 'icons/message.png',
              hasBadge: true,
            ),
            const SizedBox(width: 30),
            _headerIconButton(onTap: () {}, assetPath: 'icons/calendar.png'),

            const Spacer(), // Pushes search bar to the right
            // Search Bar
            Expanded(
              flex: 2,
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: _isDark ? Colors.black26 : Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: const TextStyle(fontSize: 14),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(
                        4.0,
                      ), // Adjust padding to "shrink" the icon
                      child: _headerIconButton(
                        onTap: () {},
                        assetPath: 'icons/search.png',
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 30),
            _headerIconButton(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              assetPath: 'icons/logout.png',
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper: Nav Tiles ---
  Widget _navTile({
    required VoidCallback onTap,
    required String iconPath,
    required String title,
    bool isActive = false,
  }) {
    Color? iconColor;
    if (isActive) {
      iconColor = Colors.blue;
    } else {
      iconColor = _isDark ? Colors.white : Colors.black87;
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        // Highlight background if active
        color: isActive ? Colors.blue.withOpacity(0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: onTap,
        // Check if icon is IconData (Icons.home) or a Widget (Image.asset)
        leading: Image.asset(
          iconPath,
          width: 22,
          height: 22,
          color: iconColor, // This makes the image white in dark mode
          colorBlendMode: BlendMode.srcIn,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive ? Colors.blue : null,
          ),
        ),
        dense: true,
        horizontalTitleGap: 12, // Brings the text closer to the icon
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // --- Helper: Header Buttons ---
  Widget _headerIconButton({
    required VoidCallback onTap,
    required String assetPath,
    bool hasBadge = false,
    Color? color,
  }) {
    final Color finalColor = color ?? (_isDark ? Colors.white : Colors.black87);
    return Stack(
      clipBehavior: Clip
          .none, // Allows the badge to sit slightly outside the button bounds
      children: [
        IconButton(
          onPressed: onTap,
          // Check if input is IconData (e.g. Icons.home) or a Widget (e.g. Image.asset)
          icon: Image.asset(
            assetPath,
            width: 24,
            height: 24,
            color: finalColor, // Apply white/black filter
            colorBlendMode: BlendMode.srcIn,
          ),
          visualDensity: VisualDensity.compact,
        ),
        if (hasBadge)
          Positioned(
            right: 4, // Adjusted for better visual alignment
            top: 4,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                // Added a small white border to make the badge pop against icons
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              constraints: const BoxConstraints(minWidth: 10, minHeight: 10),
            ),
          ),
      ],
    );
  }

  Widget _navExpansionTile({
    required String iconPath,
    required String title,
    required List<Widget> children,
    bool isDark = false,
    required bool isExpanded,
    required ValueChanged<bool> onExpansionChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Theme(
        // This removes the default borders and adds the grey background on expansion
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          backgroundColor: isDark
              ? Colors.white10
              : Colors.grey[200], // Grey background when open
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          leading: Image.asset(
            iconPath,
            width: 22,
            height: 22,
            color: isDark ? Colors.white : Colors.black87,
            colorBlendMode: BlendMode.srcIn,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          children: children,
          initiallyExpanded: isExpanded,
          onExpansionChanged: onExpansionChanged,
        ),
      ),
    );
  }

  Widget _subTile({required String title, required VoidCallback onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.only(
        left: 54,
      ), // Indent to align with parent text
      title: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          color: _isDark ? Colors.white70 : Colors.black54,
        ),
      ),
      dense: true,
      onTap: onTap,
    );
  }
}
