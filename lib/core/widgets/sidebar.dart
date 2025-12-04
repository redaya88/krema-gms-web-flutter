import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool collapsed = false;
  String active = "Dashboard";

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 240),
      width: collapsed ? 80 : 260,
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
          width: 1.2,
        ),
      ),
      child: Column(
        children: [
          // TOP SECTION
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Row(
              children: [
                // Logo text (only when expanded)
                if (!collapsed)
                  Expanded(
                    child: Text(
                      "KREMA GMS",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ),

                // Collapse button (always visible)
                InkWell(
                  onTap: () => setState(() => collapsed = !collapsed),
                  child: Icon(
                    collapsed
                        ? Icons.arrow_forward_ios
                        : Icons.arrow_back_ios_new,
                    color: Colors.white70,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // NAV ITEMS
          _navItem(Icons.dashboard_outlined, "Dashboard"),
          _navItem(Icons.storefront_outlined, "Products"),
          _navItem(Icons.people_alt_outlined, "Users"),
          _navItem(Icons.shopping_bag_outlined, "Orders"),

          const Spacer(),

          _navItem(Icons.logout, "Logout", isDanger: true),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, {bool isDanger = false}) {
    bool isActive = active == label;

    return InkWell(
      onTap: () => setState(() => active = label),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: collapsed ? 0 : 14, // reduce on collapse
          ),
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: isActive && !collapsed
                ? Colors.white.withOpacity(0.10)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment:
                collapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              // ACTIVE BAR (only when expanded)
              if (!collapsed)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 4,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

              if (!collapsed) const SizedBox(width: 14),

              // ICON
              Icon(
                icon,
                color: isDanger
                    ? Colors.redAccent
                    : (isActive ? Colors.white : Colors.white70),
                size: collapsed ? 26 : 22,
              ),

              // TEXT ONLY IF NOT COLLAPSED
              if (!collapsed) ...[
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: isDanger
                          ? Colors.redAccent
                          : (isActive
                              ? Colors.white
                              : Colors.white.withOpacity(0.85)),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
