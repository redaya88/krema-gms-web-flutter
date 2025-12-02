import 'package:flutter/material.dart';
import 'slide_content.dart';

class LoginSlider extends StatelessWidget {
  final List<Map<String, String>> slides;
  final PageController pageController;
  final Function(int) onPageChanged;

  const LoginSlider({
    super.key,
    required this.slides,
    required this.pageController,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      onPageChanged: onPageChanged,
      itemCount: slides.length,
      itemBuilder: (_, index) {
        return Center(
          child: SizedBox.expand(
            child: SlideContent(
              key: ValueKey(index),
              image: slides[index]["image"]!,
              title: slides[index]["title"]!,
              subtitle: slides[index]["subtitle"]!,
            ),
          ),
        );
      },
    );
  }
}
