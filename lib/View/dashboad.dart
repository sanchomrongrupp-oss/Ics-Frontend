import 'package:flutter/material.dart';
import 'package:ics_frontend/Route/navigator.dart';
import 'package:ics_frontend/View/Admin/employeeinformation.dart';
import 'package:ics_frontend/View/Build/office.dart';
import 'package:ics_frontend/View/Customer/customer.dart';
import 'package:ics_frontend/View/Dashboard/dash_content.dart';
import 'package:ics_frontend/View/Finances/finances.dart';
import 'package:ics_frontend/View/Inventory/adjustment.dart';
import 'package:ics_frontend/View/Inventory/purchaseoders.dart';
import 'package:ics_frontend/View/Inventory/stockinformation.dart';
import 'package:ics_frontend/View/Notification/notification.dart';
import 'package:ics_frontend/View/Profile/profile.dart';
import 'package:ics_frontend/View/Sale/sales.dart';
import 'package:ics_frontend/View/Setting/setting.dart';

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
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 800;
              final isTablet =
                  constraints.maxWidth >= 800 && constraints.maxWidth < 1200;
              final isDesktop = constraints.maxWidth >= 1200;

              return isMobile
                  ? Column(
                      children: [
                        // --- MOBILE: TOP HEADER ---
                        _buildTopHeader(theme, isMobile: true),
                        // --- MOBILE: SIDEBAR AS DRAWER ---
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 12.0,
                            ),
                            child: _currentContent,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        // --- DESKTOP/TABLET: SIDEBAR ---
                        _buildSidebar(
                          theme,
                          isTablet: isTablet,
                          isDesktop: isDesktop,
                        ),

                        // --- DESKTOP/TABLET: MAIN CONTENT ---
                        Expanded(
                          child: Column(
                            children: [
                              _buildTopHeader(theme, isMobile: false),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(
                                    isDesktop ? 20.0 : 16.0,
                                  ),
                                  child: _currentContent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  // --- Widget: Sidebar ---
  Widget _buildSidebar(
    ThemeData theme, {
    bool isTablet = false,
    bool isDesktop = false,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final sidebarWidth = isDesktop ? 280.0 : (isTablet ? 220.0 : 280.0);
        final fontSize = isDesktop ? 28.0 : (isTablet ? 22.0 : 28.0);
        final subtitleSize = isDesktop ? 14.0 : (isTablet ? 11.0 : 14.0);
        final cardMargin = isDesktop ? 16.0 : 12.0;
        final listPadding = isDesktop ? 20.0 : 12.0;
        final itemHeight = isDesktop ? 12.0 : 10.0;
        final paddingBottom = isDesktop ? 24.0 : 20.0;

        return Container(
          width: sidebarWidth,
          margin: EdgeInsets.all(cardMargin),
          child: Card(
            elevation: 0,
            color: theme.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                SizedBox(height: isDesktop ? 24 : 20),
                Text(
                  "Inventory",
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
                Text(
                  "Control System",
                  style: TextStyle(
                    fontSize: subtitleSize,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: isDesktop ? 32 : 30),

                // Sidebar Navigation Items
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: listPadding),
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
                      SizedBox(height: itemHeight),
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
                                _currentTitle = "Stock Info";
                                _currentContent = const StockInformation();
                                _isInventoryExpanded = false;
                              });
                            },
                          ),
                          _subTile(
                            title: "Purchase Orders",
                            onTap: () {
                              setState(() {
                                _currentTitle = "Purchase Orders";
                                _currentContent = const PurchaseOders();
                                _isInventoryExpanded = false;
                              });
                            },
                          ),
                          _subTile(
                            title: "Adjustment",
                            onTap: () {
                              setState(() {
                                _currentTitle = "Adjustment";
                                _currentContent = const Adjustment();
                                _isInventoryExpanded = false;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: itemHeight),
                      _navTile(
                        iconPath: 'icons/office.png',
                        title: 'Office',
                        onTap: () {
                          setState(() {
                            _currentContent = const OfficeScreen();
                          });
                        },
                      ),
                      SizedBox(height: itemHeight),
                      _navTile(
                        iconPath: 'icons/towuser.png',
                        title: 'Customers',
                        onTap: () {
                          setState(() {
                            _currentContent = const CustomerScreen();
                          });
                        },
                      ),
                      SizedBox(height: itemHeight),
                      _navTile(
                        iconPath: 'icons/towuser.png',
                        title: 'Employees',
                        onTap: () {
                          setState(() {
                            _currentContent = const EmployeeInformationScreen();
                          });
                        },
                      ),
                      SizedBox(height: itemHeight),
                      _navTile(
                        iconPath: 'icons/finances.png',
                        title: 'Finances',
                        onTap: () {
                          setState(() {
                            _currentContent = const FinancesScreen();
                          });
                        },
                      ),
                      SizedBox(height: itemHeight),
                      _navTile(
                        iconPath: 'icons/sale.png',
                        title: 'Sale',
                        onTap: () {
                          setState(() {
                            _currentContent = const SalesScreen();
                          });
                        },
                      ),
                      SizedBox(height: itemHeight),
                      _navTile(
                        iconPath: 'icons/settings.png',
                        title: 'Settings',
                        onTap: () {
                          setState(() {
                            _currentContent = const SettingScreen();
                          });
                        },
                      ),
                    ],
                  ),
                ),

                // Theme Switcher at bottom
                Padding(
                  padding: EdgeInsets.only(bottom: paddingBottom),
                  child: ListTile(
                    title: Text(
                      _isDark ? "Dark Mode" : "Light Mode",
                      style: TextStyle(fontSize: isDesktop ? 15 : 14),
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
      },
    );
  }

  // --- Widget: Top Header Bar ---
  Widget _buildTopHeader(ThemeData theme, {required bool isMobile}) {
    return Card(
      elevation: 0,
      color: theme.cardColor,
      margin: EdgeInsets.all(isMobile ? 8 : 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 12 : 20,
          vertical: isMobile ? 8 : 12,
        ),
        child: Row(
          children: [
            // User Profile
            InkWell(
              onTap: () {
                // Navigate to your profile screen
                setState(() {
                  _currentContent = const DesktopProfileScreen();
                });
              },
              borderRadius: BorderRadius.circular(
                100,
              ), // Ensures the ripple effect is circular
              child: Container(
                padding: const EdgeInsets.all(
                  2,
                ), // Space between border and avatar
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: isMobile ? 18 : 22,
                  backgroundColor: Colors.white,
                  // Using ClipOval to ensure the image fits perfectly inside the avatar
                  child: ClipOval(
                    child: Image.asset(
                      'icons/dog.png',
                      fit: BoxFit.cover,
                      width: isMobile ? 36 : 44,
                      height: isMobile ? 36 : 44,
                      // Error handling in case the asset is missing
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.person),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: isMobile ? 12 : 45),

            // Action Icons (Responsive spacing)
            if (!isMobile) ...[
              _headerIconButton(
                onTap: () {
                  setState(() {
                    _currentContent = const NotificationScreen();
                  });
                },
                assetPath: 'icons/bell.png',
                hasBadge: true,
              ),
              SizedBox(width: isMobile ? 15 : 30),
            ],

            const Spacer(),
            _headerIconButton(
              onTap: () {
                AppNavigator.replaceWithLogin(context);
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
          initiallyExpanded: isExpanded,
          onExpansionChanged: onExpansionChanged,
          children: children,
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
