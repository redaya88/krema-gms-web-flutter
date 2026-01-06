import 'package:flutter/material.dart';

class ThemeSegmentedToggle extends StatelessWidget {
  final bool isDark;
  final bool expanded;
  final ValueChanged<bool> onChanged;

  const ThemeSegmentedToggle({
    super.key,
    required this.isDark,
    required this.expanded,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ───── COLLAPSED: ICON ONLY ─────
    if (!expanded) {
      return Tooltip(
        message: isDark ? 'Dark mode' : 'Light mode',
        child: IconButton(
          icon: Icon(
            isDark ? Icons.nightlight_round : Icons.wb_sunny_outlined,
            size: 22,
          ),
          onPressed: () => onChanged(!isDark),
        ),
      );
    }

    // ───── EXPANDED: FULL TOGGLE ─────
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _ToggleItem(
              active: !isDark,
              icon: Icons.wb_sunny_outlined,
              label: 'Light',
              onTap: () => onChanged(false),
            ),
            const SizedBox(width: 4),
            _ToggleItem(
              active: isDark,
              icon: Icons.nightlight_round,
              label: 'Dark',
              onTap: () => onChanged(true),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToggleItem extends StatelessWidget {
  final bool active;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ToggleItem({
    required this.active,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? theme.colorScheme.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.colorScheme.onSurfaceVariant.withOpacity(0.2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max, // ✅ allow shrinking
            children: [
              Icon(icon, size: 18),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis, // ✅ no overflow
                  style: theme.textTheme.bodySmall!.copyWith(
                    fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
