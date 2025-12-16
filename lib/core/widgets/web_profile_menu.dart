import 'package:flutter/material.dart';
import 'package:krema_gms_web/core/widgets/user_avatar.dart';

class WebProfileMenu extends StatefulWidget {
  final String username;
  final String role;
  final String? imageUrl;
  final Function(String) onSelect;

  const WebProfileMenu({
    super.key,
    required this.username,
    required this.role,
    required this.onSelect,
    this.imageUrl,
  });

  @override
  State<WebProfileMenu> createState() => _WebProfileMenuState();
}

class _WebProfileMenuState extends State<WebProfileMenu> {
  bool isHovered = false;
  bool isMenuOpen = false;
  OverlayEntry? overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void dispose() {
    overlayEntry?.remove();
    super.dispose();
  }

  void toggleMenu() {
    if (isMenuOpen) {
      overlayEntry?.remove();
      isMenuOpen = false;
      setState(() {});
      return;
    }

    overlayEntry = buildOverlayMenu();
    Overlay.of(context).insert(overlayEntry!);
    isMenuOpen = true;
    setState(() {});
  }

  // ------------------- Smooth Animated Dropdown -------------------

  OverlayEntry buildOverlayMenu() {
    final theme = Theme.of(context);

    return OverlayEntry(
      builder: (context) => Positioned(
        width: 260,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: const Offset(-210, 50),
          showWhenUnlinked: false,
          child: Material(
            elevation: 12,
            borderRadius: BorderRadius.circular(16),
            child: SelectionContainer.disabled(
              // ⬅ disables yellow highlight
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // --- Profile header ---
                    Row(
                      children: [
                        UserAvatar(
                          username: widget.username,
                          size: 44,
                          imageUrl: widget.imageUrl,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.username,
                                // style: const TextStyle(
                                //   fontSize: 16,
                                //   fontWeight: FontWeight.bold,
                                // ),
                              ),
                              Text(
                                widget.role,
                                // style: TextStyle(
                                //   fontSize: 13,
                                //   color: theme.textTheme.bodyMedium.color.,
                                // ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    const Divider(),

                    buildMenuItem(Icons.person, "Profile"),
                    buildMenuItem(Icons.settings, "Settings"),
                    buildMenuItem(Icons.logout, "Logout", color: Colors.red),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ------------------- Menu Content -------------------
  Widget buildMenuContent() {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.black.withOpacity(0.08),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- Profile header ---
          Row(
            children: [
              UserAvatar(
                username: widget.username,
                size: 44,
                imageUrl: widget.imageUrl,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.username,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        )),
                    Text(widget.role,
                        style: TextStyle(
                          fontSize: 13,
                          color: theme.colorScheme.onSurface,
                        )),
                  ],
                ),
              )
            ],
          ),

          const SizedBox(height: 12),
          const Divider(),

          buildMenuItem(Icons.person, "Profile"),
          buildMenuItem(Icons.settings, "Settings"),
          buildMenuItem(Icons.logout, "Logout", color: Colors.red),
        ],
      ),
    );
  }

  // ------------------- Menu Item -------------------
  Widget buildMenuItem(IconData icon, String label, {Color? color}) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          widget.onSelect(label);
          toggleMenu();
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Icon(icon, size: 20, color: theme.colorScheme.onSurface),
              const SizedBox(width: 12),
              Text(label,
                  style: TextStyle(
                    // fontSize: 14,
                    color: theme.colorScheme.onSurface,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------- Avatar Hover Trigger -------------------
  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: GestureDetector(
          onTap: toggleMenu,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 180),
            scale: isHovered ? 1.15 : 1.0,
            child: Material(
              type: MaterialType.transparency,
              elevation: 0,
              shadowColor: Colors.transparent,
              child: UserAvatar(
                username: widget.username,
                imageUrl: widget.imageUrl,
                size: 36,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
//      Smooth fade + slide wrapper for the dropdown card
// -------------------------------------------------------------
class _SmoothMenuWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback onClose;

  const _SmoothMenuWrapper({
    required this.child,
    required this.onClose,
  });

  @override
  State<_SmoothMenuWrapper> createState() => _SmoothMenuWrapperState();
}

class _SmoothMenuWrapperState extends State<_SmoothMenuWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacity;
  late Animation<Offset> slide;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 180),
      vsync: this,
    );

    opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
    );

    slide = Tween<Offset>(
      begin: const Offset(0, -0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: SlideTransition(
        position: slide,
        child: widget.child,
      ),
    );
  }
}
