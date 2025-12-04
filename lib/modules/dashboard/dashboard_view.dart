import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/widgets/sidebar.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  bool isDarkMode = true; // default dark theme
  String selectedProfileOption = 'Profile';
  final List<String> profileOptions = ['Profile', 'Settings', 'Logout'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Row(
        children: [
          // Sidebar (fixed width)
          const Sidebar(),

          // Main content
          Expanded(
            child: Column(
              children: [
                // Top bar
                Container(
                  height: 60,
                  color: theme.colorScheme.surface,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      // Dashboard title
                      Expanded(
                        child: Text(
                          'Dashboard',
                          style: theme.textTheme.headlineSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Theme toggle
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isDarkMode = !isDarkMode;
                            Get.changeThemeMode(
                              isDarkMode ? ThemeMode.dark : ThemeMode.light,
                            );
                          });
                        },
                        icon: Icon(
                          isDarkMode ? Icons.dark_mode : Icons.light_mode,
                          color: theme.colorScheme.primary,
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Profile dropdown (auto width)
                      DropdownButton<String>(
                        value: selectedProfileOption,
                        isDense: true,
                        underline: const SizedBox(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            selectedProfileOption = value;
                          });

                          if (value == 'Logout') {
                            // TODO: logout action
                          } else if (value == 'Settings') {
                            // TODO: navigate to settings
                          }
                        },
                        items: profileOptions.map((option) {
                          return DropdownMenuItem(
                            value: option,
                            child: Text(
                              option,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        selectedItemBuilder: (context) {
                          return profileOptions.map((option) {
                            return Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                selectedProfileOption,
                                style: theme.textTheme.bodyMedium,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ],
                  ),
                ),

                // Body content
                Expanded(
                  child: Container(
                    color: theme.colorScheme.background,
                    child: Center(
                      child: Text(
                        'Dashboard Content',
                        style: theme.textTheme.headlineMedium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
