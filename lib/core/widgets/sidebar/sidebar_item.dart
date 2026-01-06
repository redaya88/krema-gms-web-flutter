import 'package:flutter/material.dart';

const double kSidebarIconWidth = 40;
const double kSidebarHorizontalPadding = 12;

class SidebarItem extends StatelessWidget {
  final bool expanded;
  final IconData icon;
  final String title;
  final bool active;
  final VoidCallback onTap;

  const SidebarItem({
    super.key,
    required this.expanded,
    required this.icon,
    required this.title,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final content = Material(
      color: active
          ? theme.colorScheme.primary.withOpacity(0.12)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          height: 44,
          child: Row(
            children: [
              SizedBox(
                width: kSidebarIconWidth,
                child: Icon(icon, size: 22),
              ),
              Expanded(
                child: AnimatedOpacity(
                  opacity: expanded ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight:
                          active ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kSidebarHorizontalPadding,
      ),
      child: expanded
          ? content
          : Tooltip(
              message: title,
              waitDuration: const Duration(milliseconds: 400),
              child: content,
            ),
    );
  }
}
