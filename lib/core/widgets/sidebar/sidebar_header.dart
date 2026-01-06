import 'package:flutter/material.dart';

class SidebarHeader extends StatelessWidget {
  final bool expanded;
  final VoidCallback onToggle;

  const SidebarHeader({
    super.key,
    required this.expanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 16,
      ),
      child: Row(
        children: [
          // 🔒 ICON COLUMN
          SizedBox(
            width: 40,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                expanded ? Icons.menu_open : Icons.menu,
                size: 22,
              ),
              onPressed: onToggle,
            ),
          ),

          // TEXT AREA
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 👈 FIX
    mainAxisAlignment: MainAxisAlignment.center,  // optional (vertical centering)
              children: [
                AnimatedOpacity(
                  opacity: expanded ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    'OMS',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: expanded ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    'Optical Management System',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                        // fontWeight: FontWeight.bold,
                        height: 1.2,
                        fontSize: 12),
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
