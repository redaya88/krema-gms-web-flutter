import 'package:flutter/material.dart';

class SidebarToggleButton extends StatefulWidget {
  final bool isExpanded;
  final VoidCallback onTap;

  const SidebarToggleButton({
    super.key,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  State<SidebarToggleButton> createState() => _SidebarToggleButtonState();
}

class _SidebarToggleButtonState extends State<SidebarToggleButton> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: hovered ? 1.12 : 1.0,
          duration: const Duration(milliseconds: 160),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF7B2FF7),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.18),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 1), // Center visually
              child: Icon(
                widget.isExpanded
                    ? Icons.chevron_left
                    : Icons.chevron_right,
                size: 22,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
