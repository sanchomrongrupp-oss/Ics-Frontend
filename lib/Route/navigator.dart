import 'package:flutter/material.dart';
import 'package:ics_frontend/View/login.dart';
import 'package:ics_frontend/View/dashboad.dart';
import 'package:ics_frontend/View/Sale/sales.dart';
import 'package:ics_frontend/View/Finances/finances.dart';
import 'package:ics_frontend/View/Setting/setting.dart';
import 'package:ics_frontend/View/Customer/customer.dart';
import 'package:ics_frontend/View/Admin/employeeinformation.dart';
import 'package:ics_frontend/View/Admin/registerusers.dart';
import 'package:ics_frontend/View/Inventory/stockinformation.dart';
import 'package:ics_frontend/View/Inventory/purchaseoders.dart';
import 'package:ics_frontend/View/Inventory/adjustment.dart';
import 'package:ics_frontend/View/Build/office.dart';
import 'package:ics_frontend/View/Notification/notification.dart';

class AppNavigator {
  // Route names (constants)
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String sales = '/sales';
  static const String finances = '/finances';
  static const String setting = '/setting';
  static const String customer = '/customer';
  static const String employee = '/employee';
  static const String registerUsers = '/registerUsers';
  static const String stockInformation = '/stockInformation';
  static const String purchaseOrders = '/purchaseOrders';
  static const String adjustment = '/adjustment';
  static const String office = '/office';
  static const String notification = '/notification';
  static const String messages = '/messages';

  // Generate routes
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: const RouteSettings(name: login),
        );

      case dashboard:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
          settings: const RouteSettings(name: dashboard),
        );

      case sales:
        return MaterialPageRoute(
          builder: (_) => const SalesScreen(),
          settings: const RouteSettings(name: sales),
        );

      case finances:
        return MaterialPageRoute(
          builder: (_) => const FinancesScreen(),
          settings: const RouteSettings(name: finances),
        );

      case setting:
        return MaterialPageRoute(
          builder: (_) => const SettingScreen(),
          settings: const RouteSettings(name: setting),
        );

      case customer:
        return MaterialPageRoute(
          builder: (_) => const CustomerScreen(),
          settings: const RouteSettings(name: customer),
        );

      case employee:
        return MaterialPageRoute(
          builder: (_) => const EmployeeInformationScreen(),
          settings: const RouteSettings(name: employee),
        );

      case registerUsers:
        return MaterialPageRoute(
          builder: (_) => const RegisterUsersScreen(),
          settings: const RouteSettings(name: registerUsers),
        );

      case stockInformation:
        return MaterialPageRoute(
          builder: (_) => const StockInformation(),
          settings: const RouteSettings(name: stockInformation),
        );

      case purchaseOrders:
        return MaterialPageRoute(
          builder: (_) => const PurchaseOders(),
          settings: const RouteSettings(name: purchaseOrders),
        );

      case adjustment:
        return MaterialPageRoute(
          builder: (_) => const Adjustment(),
          settings: const RouteSettings(name: adjustment),
        );

      case office:
        return MaterialPageRoute(
          builder: (_) => const OfficeScreen(),
          settings: const RouteSettings(name: office),
        );

      case notification:
        return MaterialPageRoute(
          builder: (_) => const NotificationScreen(),
          settings: const RouteSettings(name: notification),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: const RouteSettings(name: login),
        );
    }
  }

  // Navigation helper methods
  static Future<void> navigateToLogin(BuildContext context) =>
      Navigator.pushNamed(context, login);

  static Future<void> navigateToDashboard(BuildContext context) =>
      Navigator.pushNamed(context, dashboard);

  static Future<void> navigateToSales(BuildContext context) =>
      Navigator.pushNamed(context, sales);

  static Future<void> navigateToFinances(BuildContext context) =>
      Navigator.pushNamed(context, finances);

  static Future<void> navigateToSetting(BuildContext context) =>
      Navigator.pushNamed(context, setting);

  static Future<void> navigateToCustomer(BuildContext context) =>
      Navigator.pushNamed(context, customer);

  static Future<void> navigateToEmployee(BuildContext context) =>
      Navigator.pushNamed(context, employee);

  static Future<void> navigateToRegisterUsers(BuildContext context) =>
      Navigator.pushNamed(context, registerUsers);

  static Future<void> navigateToStockInformation(BuildContext context) =>
      Navigator.pushNamed(context, stockInformation);

  static Future<void> navigateToPurchaseOrders(BuildContext context) =>
      Navigator.pushNamed(context, purchaseOrders);

  static Future<void> navigateToAdjustment(BuildContext context) =>
      Navigator.pushNamed(context, adjustment);

  static Future<void> navigateToOffice(BuildContext context) =>
      Navigator.pushNamed(context, office);

  static Future<void> navigateToNotification(BuildContext context) =>
      Navigator.pushNamed(context, notification);

  static Future<void> navigateToMessages(BuildContext context) =>
      Navigator.pushNamed(context, messages);

  // Replace current route
  static Future<void> replaceWithDashboard(BuildContext context) =>
      Navigator.pushReplacementNamed(context, dashboard);

  static Future<void> replaceWithLogin(BuildContext context) =>
      Navigator.pushReplacementNamed(context, login);

  // Pop current screen
  static void pop(BuildContext context) => Navigator.pop(context);

  // Pop until specific route
  static void popUntil(BuildContext context, String routeName) =>
      Navigator.popUntil(context, ModalRoute.withName(routeName));
}
