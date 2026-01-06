import 'package:flutter/material.dart';

class SidebarIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const SidebarIconButton({
    super.key,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Center(
            child: Icon(icon, size: 22),
          ),
        ),
      ),
    );
  }
}
