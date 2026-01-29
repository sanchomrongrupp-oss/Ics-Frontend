import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _autoBackup = true;
  bool _twoFactorAuth = false;
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'USD (\$)';
  String _selectedDateFormat = 'MM/DD/YYYY';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Account Settings Section
          _buildSectionHeader(theme, 'Account Settings', Icons.account_circle),
          _buildSettingsTile(
            theme,
            title: 'Profile Information',
            subtitle: 'View and edit your profile',
            icon: Icons.person,
            onTap: () => _showProfileDialog(),
          ),
          _buildSettingsTile(
            theme,
            title: 'Change Password',
            subtitle: 'Update your password',
            icon: Icons.lock,
            onTap: () => _showChangePasswordDialog(),
          ),
          _buildSettingsTile(
            theme,
            title: 'Two-Factor Authentication',
            subtitle: _twoFactorAuth ? 'Enabled' : 'Disabled',
            icon: Icons.security,
            onTap: () {},
            trailing: Switch(
              value: _twoFactorAuth,
              onChanged: (value) {
                setState(() {
                  _twoFactorAuth = value;
                });
              },
            ),
          ),
          const SizedBox(height: 24),

          // Display Settings Section
          _buildSectionHeader(theme, 'Display Settings', Icons.palette),
          _buildDropdownSetting(
            theme,
            title: 'Language',
            value: _selectedLanguage,
            items: ['English', 'Spanish', 'French', 'German', 'Chinese'],
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value;
              });
            },
            icon: Icons.language,
          ),
          _buildDropdownSetting(
            theme,
            title: 'Date Format',
            value: _selectedDateFormat,
            items: ['MM/DD/YYYY', 'DD/MM/YYYY', 'YYYY-MM-DD'],
            onChanged: (value) {
              setState(() {
                _selectedDateFormat = value;
              });
            },
            icon: Icons.calendar_today,
          ),
          _buildDropdownSetting(
            theme,
            title: 'Currency',
            value: _selectedCurrency,
            items: ['USD (\$)', 'EUR (€)', 'GBP (£)', 'JPY (¥)', 'INR (₹)'],
            onChanged: (value) {
              setState(() {
                _selectedCurrency = value;
              });
            },
            icon: Icons.attach_money,
          ),
          const SizedBox(height: 24),

          // Notification Settings Section
          _buildSectionHeader(
            theme,
            'Notification Settings',
            Icons.notifications,
          ),
          _buildToggleSetting(
            theme,
            title: 'Enable Notifications',
            subtitle: 'Receive all notifications',
            icon: Icons.notifications_active,
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          if (_notificationsEnabled) ...[
            _buildToggleSetting(
              theme,
              title: 'Email Notifications',
              subtitle: 'Get notified via email',
              icon: Icons.email,
              value: _emailNotifications,
              onChanged: (value) {
                setState(() {
                  _emailNotifications = value;
                });
              },
            ),
            _buildToggleSetting(
              theme,
              title: 'Push Notifications',
              subtitle: 'Get push notifications on your device',
              icon: Icons.mobile_screen_share,
              value: _pushNotifications,
              onChanged: (value) {
                setState(() {
                  _pushNotifications = value;
                });
              },
            ),
          ],
          const SizedBox(height: 24),

          // Data & Privacy Section
          _buildSectionHeader(theme, 'Data & Privacy', Icons.privacy_tip),
          _buildToggleSetting(
            theme,
            title: 'Auto Backup',
            subtitle: 'Automatically backup your data',
            icon: Icons.backup,
            value: _autoBackup,
            onChanged: (value) {
              setState(() {
                _autoBackup = value;
              });
            },
          ),
          _buildSettingsTile(
            theme,
            title: 'Privacy Policy',
            subtitle: 'Read our privacy policy',
            icon: Icons.description,
            onTap: () => _showPrivacyDialog(),
          ),
          _buildSettingsTile(
            theme,
            title: 'Terms of Service',
            subtitle: 'Read our terms',
            icon: Icons.article,
            onTap: () => _showTermsDialog(),
          ),
          _buildSettingsTile(
            theme,
            title: 'Export Data',
            subtitle: 'Download your data',
            icon: Icons.download,
            onTap: () => _showExportDialog(),
          ),
          const SizedBox(height: 24),

          // System Settings Section
          _buildSectionHeader(theme, 'System Settings', Icons.settings),
          _buildSettingsTile(
            theme,
            title: 'App Version',
            subtitle: 'v1.0.0',
            icon: Icons.info,
            onTap: () {},
            trailing: const Icon(Icons.check_circle, color: Colors.green),
          ),
          _buildSettingsTile(
            theme,
            title: 'Check for Updates',
            subtitle: 'Manually check for new updates',
            icon: Icons.system_update,
            onTap: () => _showUpdateDialog(),
          ),
          _buildSettingsTile(
            theme,
            title: 'Clear Cache',
            subtitle: 'Free up storage space',
            icon: Icons.delete_sweep,
            onTap: () => _showClearCacheDialog(),
          ),
          const SizedBox(height: 24),

          // Help & Support Section
          _buildSectionHeader(theme, 'Help & Support', Icons.help),
          _buildSettingsTile(
            theme,
            title: 'FAQ',
            subtitle: 'Frequently asked questions',
            icon: Icons.question_answer,
            onTap: () => _showFAQDialog(),
          ),
          _buildSettingsTile(
            theme,
            title: 'Contact Support',
            subtitle: 'Get help from our support team',
            icon: Icons.support_agent,
            onTap: () => _showSupportDialog(),
          ),
          _buildSettingsTile(
            theme,
            title: 'Report Issue',
            subtitle: 'Report a bug or issue',
            icon: Icons.bug_report,
            onTap: () => _showReportDialog(),
          ),
          const SizedBox(height: 24),

          // Danger Zone Section
          _buildSectionHeader(
            theme,
            'Danger Zone',
            Icons.warning,
            isDanger: true,
          ),
          _buildSettingsTile(
            theme,
            title: 'Delete Account',
            subtitle: 'Permanently delete your account',
            icon: Icons.delete_forever,
            iconColor: Colors.red,
            onTap: () => _showDeleteAccountDialog(),
          ),
          _buildSettingsTile(
            theme,
            title: 'Logout',
            subtitle: 'Sign out from this device',
            icon: Icons.logout,
            iconColor: Colors.orange,
            onTap: () => _showLogoutDialog(),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    ThemeData theme,
    String title,
    IconData icon, {
    bool isDanger = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: isDanger ? Colors.red : theme.colorScheme.primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDanger ? Colors.red : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    ThemeData theme, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    Widget? trailing,
    Color? iconColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Icon(icon, color: iconColor ?? theme.colorScheme.primary),
        title: Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle, style: theme.textTheme.bodySmall),
        trailing: trailing ?? const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Widget _buildToggleSetting(
    ThemeData theme, {
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle, style: theme.textTheme.bodySmall),
        trailing: Switch(value: value, onChanged: onChanged),
      ),
    );
  }

  Widget _buildDropdownSetting(
    ThemeData theme, {
    required String title,
    required String value,
    required List<String> items,
    required Function(String) onChanged,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: theme.colorScheme.primary, size: 24),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: value,
              items: items
                  .map(
                    (item) => DropdownMenuItem(value: item, child: Text(item)),
                  )
                  .toList(),
              onChanged: (selected) {
                if (selected != null) onChanged(selected);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Profile Information'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.phone),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully')),
              );
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password changed successfully')),
              );
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog() {
    _showInformationDialog(
      'Privacy Policy',
      'Our privacy policy details how we collect, use, and protect your data. We are committed to maintaining your privacy and security.',
    );
  }

  void _showTermsDialog() {
    _showInformationDialog(
      'Terms of Service',
      'By using our service, you agree to our terms. This includes our usage policies and your responsibilities as a user.',
    );
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Data'),
        content: const Text(
          'Your data will be exported as a CSV file. This may take a few moments.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data exported successfully')),
              );
              Navigator.pop(context);
            },
            child: const Text('Export'),
          ),
        ],
      ),
    );
  }

  void _showUpdateDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Check for Updates'),
        content: const Text(
          'You are already using the latest version (v1.0.0).',
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('This will free up storage space. Are you sure?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared successfully')),
              );
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showFAQDialog() {
    _showInformationDialog(
      'FAQ',
      'Q: How do I change my password?\nA: Go to Settings > Change Password.\n\nQ: How do I export my data?\nA: Go to Settings > Export Data.\n\nQ: How do I contact support?\nA: Go to Settings > Contact Support.',
    );
  }

  void _showSupportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contact Support'),
        content: const Text(
          'Email: support@example.com\nPhone: +1-234-567-8900\nWebsite: www.example.com/support',
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Issue'),
        content: TextField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Describe the issue...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Issue reported successfully')),
              );
              Navigator.pop(context);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'This action cannot be undone. All your data will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Account deleted')));
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully')),
              );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showInformationDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(child: Text(content)),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
