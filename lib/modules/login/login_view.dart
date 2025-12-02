import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';
import 'login_form.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  final List<Map<String, String>> slides = [
    {
      "image": "assets/images/login-1.png",
      "title": "Manage your operations",
      "subtitle": "Fast, secure and easy to control"
    },
    {
      "image": "assets/images/login-2.png",
      "title": "Smart Inventory",
      "subtitle": "Real-time tracking and management"
    },
    {
      "image": "assets/images/login-3.png",
      "title": "Modern Dashboard",
      "subtitle": "Clear insights for better decisions"
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted || !_pageController.hasClients) return;
      final next = (_currentPage + 1) % slides.length;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      _currentPage = next;
    });
  }

  void _onPageChanged(int index) {
    _currentPage = index;
    _startAutoSlide();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<LoginController>();

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 900;

          return isSmallScreen
              ? _buildVerticalLayout() // mobile/tablet
              : _buildHorizontalLayout(); // desktop
        },
      ),
    );
  }

  // -----------------------------
  // SMALL SCREEN (VERTICAL LAYOUT)
  // -----------------------------
  Widget _buildVerticalLayout() {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: _buildSlider(),
        ),
        Expanded(
          child: Center(
            child: Container(
              width: 380,
              padding: const EdgeInsets.all(20),
              child: const PrettyLoginForm(),
            ),
          ),
        ),
      ],
    );
  }

  // -----------------------------
  // LARGE SCREEN (HORIZONTAL)
  // -----------------------------
  Widget _buildHorizontalLayout() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: const Color.fromARGB(255, 229, 200, 233),
            child: _buildSlider(),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Container(
              width: 380,
              padding: const EdgeInsets.all(20),
              child: const PrettyLoginForm(),
            ),
          ),
        )
      ],
    );
  }

  // -----------------------------
  // SLIDER WITH IMAGE + TEXT
  // -----------------------------
  Widget _buildSlider() {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: _onPageChanged,
      itemCount: slides.length,
      itemBuilder: (_, index) {
        return Center(
          child: SizedBox.expand(
            child: _SlideContent(
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

// -----------------------------
// SLIDE ITEM WIDGET
// -----------------------------
class _SlideContent extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;

  const _SlideContent({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  State<_SlideContent> createState() => _SlideContentState();
}

class _SlideContentState extends State<_SlideContent>
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
            ? constraints.maxHeight * 0.55   // make image bigger on mobile
            : constraints.maxHeight * 0.65;  // even bigger on desktop

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

                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: isSmall ? 26 : 34,  // BIGGER TITLE
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF4A155A),
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 12),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.subtitle,
                    style: TextStyle(
                      fontSize: isSmall ? 16 : 20, // BIGGER SUBTITLE
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
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
