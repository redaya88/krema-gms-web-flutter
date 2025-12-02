import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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

    return LayoutBuilder(
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
                AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TyperAnimatedText(
                      widget.title,
                      textStyle: TextStyle(
                        fontSize: isSmall ? 26 : 34,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF4A155A),
                      ),
                      speed: const Duration(milliseconds: 80),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TyperAnimatedText(
                        widget.subtitle,
                        textStyle: TextStyle(
                          fontSize: isSmall ? 16 : 20,
                          color: Colors.black54,
                        ),
                        speed: const Duration(milliseconds: 50),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
