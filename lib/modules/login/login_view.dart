import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';
import 'login_slider.dart';
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

  final slides = [
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
    final theme = Theme.of(context);
    Get.find<LoginController>();

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 900;

          return isSmallScreen
              ? _buildVerticalLayout()
              : _buildHorizontalLayout();
        },
      ),
    );
  }

  Widget _buildVerticalLayout() {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: LoginSlider(
            slides: slides,
            pageController: _pageController,
            onPageChanged: _onPageChanged,
          ),
        ),
        Expanded(
          child: Center(
            child: Container(
              width: 380,
              padding: const EdgeInsets.all(20),
              child: PrettyLoginForm(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalLayout() {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/backgrounds/background-1.jpg"),
                fit: BoxFit.cover, // makes image fill the whole area
              ),
            ),
            child: LoginSlider(
              slides: slides,
              pageController: _pageController,
              onPageChanged: _onPageChanged,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 18,
                  offset: const Offset(-1, 0), // left shadow
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 380,
                padding: const EdgeInsets.all(20),
                child: PrettyLoginForm(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
