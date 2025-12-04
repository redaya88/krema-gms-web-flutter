import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  bool isDarkMode = true;
  bool isSidebarExpanded = true;
  String selectedProfileOption = 'Profile';
  int selectedSidebarIndex = 0; // active item index

  final List<String> profileOptions = ['Profile', 'Settings', 'Logout'];

  final List<_SidebarItem> sidebarItems = [
    _SidebarItem(icon: Icons.dashboard, label: 'Dashboard'),
    _SidebarItem(icon: Icons.shopping_cart, label: 'Orders'),
    _SidebarItem(icon: Icons.people, label: 'Users'),
    _SidebarItem(icon: Icons.settings, label: 'Settings'),
    _SidebarItem(icon: Icons.description, label: 'Very Long Menu Item Example'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Scaffold(
      drawer: isMobile
          ? Drawer(
              child: _buildSidebarContent(theme, expanded: true),
            )
          : null,
      body: Row(
        children: [
          // Sidebar for desktop/tablet
          if (!isMobile)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isSidebarExpanded ? 220 : 60,
              color: theme.colorScheme.primaryContainer,
              child: _buildSidebarContent(theme, expanded: isSidebarExpanded),
            ),

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
                      if (isMobile)
                        Builder(
                          builder: (context) => IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          ),
                        ),

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

                      // Profile dropdown
                      DropdownButton<String>(
                        value: selectedProfileOption,
                        isDense: true,
                        underline: const SizedBox(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            selectedProfileOption = value;
                          });
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
                        'Dashboard Content for "${sidebarItems[selectedSidebarIndex].label}"',
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

  // Sidebar content builder
  Widget _buildSidebarContent(ThemeData theme, {required bool expanded}) {
    return Column(
      children: [
        // Always visible toggle button
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              setState(() {
                isSidebarExpanded = !isSidebarExpanded;
              });
            },
            icon: Icon(
              isSidebarExpanded ? Icons.arrow_back : Icons.arrow_forward,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Scrollable sidebar items
        Expanded(
          child: ListView.builder(
            itemCount: sidebarItems.length,
            itemBuilder: (context, index) {
              final item = sidebarItems[index];
              final isActive = selectedSidebarIndex == index;
              return _buildSidebarItem(item, theme, expanded, isActive, index);
            },
          ),
        ),
      ],
    );
  }

  // Sidebar item with hover, tooltip, and active highlight
  Widget _buildSidebarItem(
      _SidebarItem item, ThemeData theme, bool expanded, bool isActive, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: _HoverContainer(
        expanded: expanded,
        label: item.label,
        isActive: isActive,
        onTap: () {
          setState(() {
            selectedSidebarIndex = index;
          });
        },
        child: Row(
          children: [
            Icon(item.icon, color: Colors.white),
            if (expanded) ...[
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.label,
                  style: const TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Hover container widget with active highlight
class _HoverContainer extends StatefulWidget {
  final Widget child;
  final bool expanded;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const _HoverContainer({
    required this.child,
    required this.expanded,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  @override
  State<_HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<_HoverContainer> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    if (widget.isActive) {
      backgroundColor = Colors.white.withOpacity(0.2);
    } else if (isHovered) {
      backgroundColor = Colors.white.withOpacity(0.1);
    } else {
      backgroundColor = Colors.transparent;
    }

    final childWidget = Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: widget.child,
    );

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: widget.expanded
            ? childWidget
            : Tooltip(
                message: widget.label,
                child: childWidget,
              ),
      ),
    );
  }
}

// Sidebar item model
class _SidebarItem {
  final IconData icon;
  final String label;
  _SidebarItem({required this.icon, required this.label});
}
