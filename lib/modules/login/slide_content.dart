import 'package:flutter/material.dart';

class SlideContent extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;

  const SlideContent({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  State<SlideContent> createState() => _SlideContentState();
}

class _SlideContentState extends State<SlideContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<double> _scale;

  static const Color deepGray = Color(0xFF1E1E1E);
  static const Color softGray = Color(0xFF9E9E9E);
  static const Color white = Colors.white;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _scale = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isSmall = width < 900;

    return Container(
      // 🌈 GRADIENT BACKGROUND ADDED HERE
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF2A2A2A), // deep gray top
            Color(0xFF1E1E1E), // deeper gray middle
            Color(0xFF0F0F0F), // almost black bottom
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),

      child: LayoutBuilder(
        builder: (context, constraints) {
          final imageHeight = isSmall
              ? constraints.maxHeight * 0.55
              : constraints.maxHeight * 0.65;

          return FadeTransition(
            opacity: _fade,
            child: ScaleTransition(
              scale: _scale,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: imageHeight,
                    child: Image.asset(
                      widget.image,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ---- TITLE (WHITE) ----
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isSmall ? 26 : 34,
                      fontWeight: FontWeight.w700,
                      color: white,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ---- SUBTITLE (SOFT GRAY) ----
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isSmall ? 16 : 20,
                        color: softGray,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
