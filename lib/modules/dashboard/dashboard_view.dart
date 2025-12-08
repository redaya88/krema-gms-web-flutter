import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/theme_service.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  bool isSidebarExpanded = true;
  String selectedProfileOption = 'Profile';
  String? selectedFeature;

  final List<String> profileOptions = ['Profile', 'Settings', 'Logout'];
  final authService = Get.find<AuthService>();

  bool get isMobile => MediaQuery.of(context).size.width < 800;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: isMobile ? Drawer(child: _buildSidebar(expanded: true)) : null,
      body: Row(
        children: [
          // Desktop sidebar
          if (!isMobile)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isSidebarExpanded ? 220 : 60,
              // color: isDark ? theme.colorScheme.primaryContainer : theme.colorScheme.secondaryContainer,
              color: theme.colorScheme.surface,
              child: _buildSidebar(expanded: isSidebarExpanded),
            ),

          // Main content
          Expanded(
            child: Column(
              children: [
                // Top bar
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: theme.colorScheme.surface,
                  child: Row(
                    children: [
                      // Mobile: menu button
                      if (isMobile)
                        IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () =>
                              _scaffoldKey.currentState?.openDrawer(),
                        ),

                      // Desktop: toggle button
                      if (!isMobile)
                        IconButton(
                          icon: Icon(
                            isSidebarExpanded
                                ? Icons.arrow_back_ios
                                : Icons.arrow_forward_ios,
                          ),
                          onPressed: () {
                            setState(() {
                              isSidebarExpanded = !isSidebarExpanded;
                            });
                          },
                        ),

                      const Spacer(),

                      IconButton(
                        icon: Icon(
                          theme.brightness == Brightness.dark
                              ? Icons.light_mode
                              : Icons.dark_mode,
                        ),
                        onPressed: () => Get.find<ThemeService>().toggleTheme(),
                      ),

                      // const Spacer(),

                      // Profile dropdown
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedProfileOption,
                          items: profileOptions
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() => selectedProfileOption = value);
                            if (value == 'Logout') {
                              authService.logout();
                              // Navigate to login if needed
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Main content area
                Expanded(
                  child: Container(
                    color: theme.colorScheme.surface,
                    child: Center(
                      child: Text(
                        'Welcome, ${authService.currentUser.value?.username ?? ''}',
                        style: theme.textTheme.headlineSmall,
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

  Widget _buildSidebar({required bool expanded}) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const SizedBox(height: 20),
        Expanded(
          child: Obx(() {
            final features = authService.features;
            if (features.isEmpty) return const SizedBox();

            return ListView.builder(
              itemCount: features.length,
              itemBuilder: (context, index) {
                final feature = features[index];
                final isActive = selectedFeature == feature.name;
                final isDark = theme.brightness == Brightness.dark;

                return ListTile(
                  leading: Image.asset(
                    isDark ? feature.darkIconPath : feature.lightIconPath,
                    width: 22,
                    height: 22,
                    fit: BoxFit.contain,
                  ),
                  title: expanded
                      ? Text(
                          feature.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: theme.colorScheme.onSurface
                          ),
                        )
                      : null,
                  selected: isActive,
                  onTap: () {
                    setState(() {
                      selectedFeature = feature.name;
                    });
                    // Close drawer on mobile
                    if (isMobile) Navigator.of(context).pop();
                  },
                  horizontalTitleGap: 10,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: expanded ? 16 : 8,
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
