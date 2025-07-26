import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studly/app/features/settings/presentation/providers/settings_provider.dart';
import 'package:studly/app/shared/widgets/bottom_navigation.dart'; // Your custom navigation bar

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // State to control visibility of the editors
  bool _isEditingUsername = false;
  bool _isEditingPassword = false;

  // Controllers and FocusNodes for the text fields
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final FocusNode _usernameFocusNode;
  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up controllers and focus nodes to prevent memory leaks
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  /// Toggles the username editor visibility
  void _toggleUsernameEditor(String currentUsername) {
    setState(() {
      _isEditingPassword = false; // Close other editor
      _isEditingUsername = !_isEditingUsername;
      if (_isEditingUsername) {
        _usernameController.text = currentUsername;
        // Request focus when the editor opens
        _usernameFocusNode.requestFocus();
      }
    });
  }

  /// Toggles the password editor visibility
  void _togglePasswordEditor() {
    setState(() {
      _isEditingUsername = false; // Close other editor
      _isEditingPassword = !_isEditingPassword;
      if (_isEditingPassword) {
        _passwordController.clear();
        _passwordFocusNode.requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      bottomNavigationBar: const BottomNavigation(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // -- ACCOUNT SECTION --
          _buildSectionHeader(context, 'Account'),
          Card(
            clipBehavior: Clip.antiAlias, // Ensures the divider doesn't overflow
            child: Column(
              children: [
                // --- USERNAME ---
                _buildUsernameTile(context, settingsProvider.username),
                _buildInlineEditor(
                  context: context,
                  isVisible: _isEditingUsername,
                  controller: _usernameController,
                  focusNode: _usernameFocusNode,
                  labelText: 'New Username',
                  onCancel: () => _toggleUsernameEditor(''),
                  onSave: () {
                    context.read<SettingsProvider>().username = _usernameController.text;
                    _toggleUsernameEditor('');
                  },
                ),
                const Divider(height: 0),
                // --- PASSWORD ---
                _buildPasswordTile(context),
                _buildInlineEditor(
                  context: context,
                  isVisible: _isEditingPassword,
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  labelText: 'New Password',
                  obscureText: true,
                  onCancel: _togglePasswordEditor,
                  onSave: () {
                    context.read<SettingsProvider>().password = _passwordController.text;
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Password updated successfully!')));
                    _togglePasswordEditor();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // -- APPEARANCE SECTION --
          _buildSectionHeader(context, 'Appearance'),
          Card(
            child: _buildThemeTile(
              context,
              currentMode: settingsProvider.themeMode,
              onTap: () => _showThemeDialog(context),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
      ),
    );
  }

  Widget _buildUsernameTile(BuildContext context, String username) {
    return ListTile(
      leading: const Icon(Icons.person_outline),
      title: const Text('Username'),
      subtitle: Text(username),
      trailing: Icon(_isEditingUsername ? Icons.expand_less : Icons.expand_more, size: 20),
      onTap: () => _toggleUsernameEditor(username),
    );
  }

  Widget _buildPasswordTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.lock_outline),
      title: const Text('Change Password'),
      trailing: Icon(_isEditingPassword ? Icons.expand_less : Icons.expand_more, size: 20),
      onTap: _togglePasswordEditor,
    );
  }

  /// A reusable inline editor widget with smooth animation.
  Widget _buildInlineEditor({
    required BuildContext context,
    required bool isVisible,
    required TextEditingController controller,
    required FocusNode focusNode,
    required String labelText,
    required VoidCallback onCancel,
    required VoidCallback onSave,
    bool obscureText = false,
  }) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child:
          isVisible
              ? Container(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Column(
                  children: [
                    TextField(
                      controller: controller,
                      focusNode: focusNode,
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        labelText: labelText,
                        isDense: true,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: onCancel, child: const Text('Cancel')),
                        const SizedBox(width: 8),
                        FilledButton(onPressed: onSave, child: const Text('Save')),
                      ],
                    ),
                  ],
                ),
              )
              : const SizedBox.shrink(), // Appears when hidden
    );
  }

  Widget _buildThemeTile(BuildContext context, {required ThemeMode currentMode, required VoidCallback onTap}) {
    String themeText;
    switch (currentMode) {
      case ThemeMode.light:
        themeText = 'Light';
        break;
      case ThemeMode.dark:
        themeText = 'Dark';
        break;
      default:
        themeText = 'System Default';
        break;
    }
    return ListTile(
      leading: const Icon(Icons.brightness_6_outlined),
      title: const Text('Theme'),
      subtitle: Text(themeText),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _showThemeDialog(BuildContext context) {
    // This function remains the same, using a dialog.
    // Note: Corrected the call to the provider.
    final provider = context.read<SettingsProvider>();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Choose Theme'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<ThemeMode>(
                  title: const Text('Light'),
                  value: ThemeMode.light,
                  groupValue: provider.themeMode,
                  onChanged: (value) {
                    provider.themeModeName = value!.name;
                    Navigator.pop(context);
                  },
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Dark'),
                  value: ThemeMode.dark,
                  groupValue: provider.themeMode,
                  onChanged: (value) {
                    provider.themeModeName = value!.name;
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
    );
  }
}
