import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Sample notification data
  List<NotificationItem> notifications = [
    NotificationItem(
      id: 1,
      title: 'Stock Update',
      message: 'Product ABC has low stock quantity. Current: 5 units',
      type: NotificationType.warning,
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      isRead: false,
      icon: Icons.inventory_2,
    ),
    NotificationItem(
      id: 2,
      title: 'Sale Completed',
      message: 'Order #12345 has been successfully processed',
      type: NotificationType.success,
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      isRead: false,
      icon: Icons.shopping_cart,
    ),
    NotificationItem(
      id: 3,
      title: 'Inventory Alert',
      message: 'Product XYZ is out of stock',
      type: NotificationType.error,
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      isRead: true,
      icon: Icons.error_outline,
    ),
    NotificationItem(
      id: 4,
      title: 'Payment Received',
      message: 'Payment of \$500 received from Customer ABC',
      type: NotificationType.success,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: true,
      icon: Icons.attach_money,
    ),
    NotificationItem(
      id: 5,
      title: 'System Notification',
      message: 'New update available. Please refresh the application',
      type: NotificationType.info,
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      isRead: true,
      icon: Icons.info_outline,
    ),
    NotificationItem(
      id: 6,
      title: 'Adjustment Recorded',
      message: 'Stock adjustment for Product DEF has been recorded',
      type: NotificationType.info,
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      isRead: true,
      icon: Icons.done_all,
    ),
  ];

  void _markAsRead(int id) {
    setState(() {
      final index = notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        notifications[index].isRead = true;
      }
    });
  }

  void _deleteNotification(int id) {
    setState(() {
      notifications.removeWhere((n) => n.id == id);
    });
  }

  void _clearAll() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Notifications'),
        content: const Text(
          'Are you sure you want to delete all notifications?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() => notifications.clear());
              Navigator.pop(context);
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification.isRead = true;
      }
    });
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: isDark ? Colors.white10 : Colors.grey[200]!),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1200;
          final isTablet =
              constraints.maxWidth >= 800 && constraints.maxWidth < 1200;
          final isMobile = constraints.maxWidth < 800;

          // Responsive sizing
          final titleFontSize = isDesktop ? 24.0 : (isTablet ? 20.0 : 18.0);
          final subtitleFontSize = isDesktop ? 16.0 : (isTablet ? 14.0 : 12.0);
          final notificationTitleSize = isDesktop
              ? 16.0
              : (isTablet ? 14.0 : 12.0);
          final notificationMessageSize = isDesktop
              ? 14.0
              : (isTablet ? 12.0 : 11.0);
          final timestampSize = isDesktop ? 13.0 : (isTablet ? 11.0 : 10.0);
          final padding = isDesktop ? 28.0 : (isTablet ? 20.0 : 16.0);
          final spacing = isDesktop ? 16.0 : (isTablet ? 12.0 : 8.0);
          final iconSize = isDesktop ? 28.0 : (isTablet ? 24.0 : 20.0);

          return Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notifications',
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spacing / 2),
                          Text(
                            '${notifications.where((n) => !n.isRead).length} unread notification${notifications.where((n) => !n.isRead).length != 1 ? 's' : ''}',
                            style: TextStyle(
                              fontSize: subtitleFontSize,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isMobile)
                      Row(
                        children: [
                          if (notifications.any((n) => !n.isRead))
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal: spacing,
                                  vertical: spacing / 2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: _markAllAsRead,
                              child: Text(
                                'Mark all as read',
                                style: TextStyle(
                                  fontSize: notificationTitleSize,
                                ),
                              ),
                            ),
                          SizedBox(width: spacing),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[400],
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: spacing,
                                vertical: spacing / 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: _clearAll,
                            child: Text(
                              'Clear all',
                              style: TextStyle(fontSize: notificationTitleSize),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                SizedBox(height: spacing * 1.5),

                // Action buttons for mobile
                if (isMobile)
                  Column(
                    children: [
                      if (notifications.any((n) => !n.isRead))
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: spacing),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: _markAllAsRead,
                            child: Text(
                              'Mark all as read',
                              style: TextStyle(fontSize: notificationTitleSize),
                            ),
                          ),
                        ),
                      SizedBox(height: spacing),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[400],
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: spacing),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: _clearAll,
                          child: Text(
                            'Clear all',
                            style: TextStyle(fontSize: notificationTitleSize),
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: spacing),
                Divider(height: spacing),
                SizedBox(height: spacing),

                // Notifications List
                if (notifications.isEmpty)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: padding),
                      child: Column(
                        children: [
                          Icon(
                            Icons.notifications_none,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: spacing),
                          Text(
                            'No notifications',
                            style: TextStyle(
                              fontSize: notificationTitleSize,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return _buildNotificationTile(
                          notification: notification,
                          iconSize: iconSize,
                          notificationTitleSize: notificationTitleSize,
                          notificationMessageSize: notificationMessageSize,
                          timestampSize: timestampSize,
                          spacing: spacing,
                          isMobile: isMobile,
                          isDark: isDark,
                          onRead: () => _markAsRead(notification.id),
                          onDelete: () => _deleteNotification(notification.id),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationTile({
    required NotificationItem notification,
    required double iconSize,
    required double notificationTitleSize,
    required double notificationMessageSize,
    required double timestampSize,
    required double spacing,
    required bool isMobile,
    required bool isDark,
    required VoidCallback onRead,
    required VoidCallback onDelete,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: spacing),
      decoration: BoxDecoration(
        color: notification.isRead
            ? (isDark ? Colors.grey[900] : Colors.grey[50])
            : (isDark ? Colors.grey[850] : Colors.blue[50]),
        border: Border.all(
          color: notification.isRead
              ? (isDark ? Colors.white10 : Colors.grey[200]!)
              : Colors.blue[200]!,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(spacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(spacing / 2),
                  decoration: BoxDecoration(
                    color: _getNotificationColor(
                      notification.type,
                    ).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    notification.icon,
                    size: iconSize,
                    color: _getNotificationColor(notification.type),
                  ),
                ),
                SizedBox(width: spacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: TextStyle(
                                fontSize: notificationTitleSize,
                                fontWeight: notification.isRead
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: spacing / 2),
                          if (!notification.isRead)
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: spacing / 2),
                      Text(
                        notification.message,
                        style: TextStyle(
                          fontSize: notificationMessageSize,
                          color: Colors.grey[600],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: spacing / 2),
                      Text(
                        _formatTime(notification.timestamp),
                        style: TextStyle(
                          fontSize: timestampSize,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (!isMobile) ...[
              SizedBox(height: spacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!notification.isRead)
                    TextButton(
                      onPressed: onRead,
                      child: Text(
                        'Mark as read',
                        style: TextStyle(
                          fontSize: notificationMessageSize,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  TextButton(
                    onPressed: onDelete,
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: notificationMessageSize,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ] else
              SizedBox(height: spacing / 2),
          ],
        ),
      ),
    );
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return Colors.green;
      case NotificationType.error:
        return Colors.red;
      case NotificationType.warning:
        return Colors.orange;
      case NotificationType.info:
        return Colors.blue;
    }
  }
}

enum NotificationType { success, error, warning, info }

class NotificationItem {
  final int id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  bool isRead;
  final IconData icon;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    required this.isRead,
    required this.icon,
  });
}
