import 'package:flutter/material.dart';
import 'sidebar_icon.dart';

class SidebarItem extends StatelessWidget {
  final bool expanded;
  final bool active;
  final String title;
  final String iconPath;
  final VoidCallback onTap;

  const SidebarItem({
    super.key,
    required this.expanded,
    required this.active,
    required this.title,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: active
              ? theme.colorScheme.primary.withOpacity(0.12)
              : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SidebarIcon(iconPath: iconPath),
            if (expanded) ...[
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight:
                        active ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
