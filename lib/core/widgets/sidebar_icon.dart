import 'package:flutter/material.dart';
import 'sidebar_constants.dart';

class SidebarIcon extends StatelessWidget {
  final String iconPath;
  final VoidCallback? onTap;

  const SidebarIcon({
    super.key,
    required this.iconPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SidebarConstants.iconSize,
      height: SidebarConstants.iconSize,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Center(
          child: Image.asset(
            iconPath,
            width: SidebarConstants.iconInnerSize,
            height: SidebarConstants.iconInnerSize,
          ),
        ),
      ),
    );
  }
}
