import 'package:flutter/material.dart';

class SidebarIconButton extends StatelessWidget {
  final String icon;
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
            child: Image.asset("assets/icons/menu/menu-bar-collapse-light.png",
                width: 24, height: 24, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
