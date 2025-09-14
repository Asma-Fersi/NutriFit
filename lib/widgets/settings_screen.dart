import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'English';
  String _selectedUnits = 'Metric';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFEBF4FF),
              Color(0xFFFFFFFF),
              Color(0xFFF3E8FF),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildPreferencesSection(),
              const SizedBox(height: 24),
              _buildAccountSection(),
              const SizedBox(height: 24),
              _buildAboutSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6B7280), Color(0xFF374151)],
            ),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.settings,
            color: Colors.white,
            size: 40,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Settings',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Customize your app experience',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF6B7280),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ).animate().fadeIn();
  }

  Widget _buildPreferencesSection() {
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preferences',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSwitchTile(
              'Notifications',
              'Receive workout reminders and tips',
              Icons.notifications,
              _notificationsEnabled,
              (value) => setState(() => _notificationsEnabled = value),
            ),
            const Divider(),
            _buildSwitchTile(
              'Dark Mode',
              'Use dark theme throughout the app',
              Icons.dark_mode,
              _darkModeEnabled,
              (value) => setState(() => _darkModeEnabled = value),
            ),
            const Divider(),
            _buildDropdownTile(
              'Language',
              'Choose your preferred language',
              Icons.language,
              _selectedLanguage,
              ['English', 'Spanish', 'French', 'German'],
              (value) => setState(() => _selectedLanguage = value!),
            ),
            const Divider(),
            _buildDropdownTile(
              'Units',
              'Choose measurement units',
              Icons.straighten,
              _selectedUnits,
              ['Metric', 'Imperial'],
              (value) => setState(() => _selectedUnits = value!),
            ),
          ],
        ),
      ),
    ).animate().slideX(begin: -0.2);
  }

  Widget _buildAccountSection() {
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildActionTile(
              'Export Data',
              'Download your fitness data',
              Icons.download,
              () => _showExportDialog(),
            ),
            const Divider(),
            _buildActionTile(
              'Reset Progress',
              'Clear all progress data',
              Icons.refresh,
              () => _showResetDialog(),
            ),
            const Divider(),
            _buildActionTile(
              'Delete Account',
              'Permanently delete your account',
              Icons.delete_forever,
              () => _showDeleteDialog(),
              isDestructive: true,
            ),
          ],
        ),
      ),
    ).animate().slideX(begin: 0.2);
  }

  Widget _buildAboutSection() {
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildActionTile(
              'Privacy Policy',
              'Read our privacy policy',
              Icons.privacy_tip,
              () => _showPrivacyPolicy(),
            ),
            const Divider(),
            _buildActionTile(
              'Terms of Service',
              'Read our terms of service',
              Icons.description,
              () => _showTermsOfService(),
            ),
            const Divider(),
            _buildActionTile(
              'Contact Support',
              'Get help with the app',
              Icons.support,
              () => _contactSupport(),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info, color: Color(0xFF6B7280)),
              title: const Text('Version'),
              subtitle: const Text('1.0.0'),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    ).animate().slideY(begin: 0.2);
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF6B7280)),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF10B981),
      ),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildDropdownTile(
    String title,
    String subtitle,
    IconData icon,
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF6B7280)),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: DropdownButton<String>(
        value: value,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        underline: const SizedBox(),
      ),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildActionTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : const Color(0xFF6B7280),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : null,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Export Data'),
        content: const Text('Your fitness data will be exported as a JSON file.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data exported successfully!')),
              );
            },
            child: const Text('Export'),
          ),
        ],
      ),
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Reset Progress'),
        content: const Text('This will permanently delete all your progress data. This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Progress reset successfully!')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Account'),
        content: const Text('This will permanently delete your account and all associated data. This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy() {
    // In a real app, this would navigate to a privacy policy screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Privacy Policy would open here')),
    );
  }

  void _showTermsOfService() {
    // In a real app, this would navigate to a terms of service screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Terms of Service would open here')),
    );
  }

  void _contactSupport() {
    // In a real app, this would open email or support chat
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Support contact would open here')),
    );
  }
}