import 'dart:math';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String username;
  final String? imageUrl;
  final double size;
  final double borderWidth;
  final Color borderColor;
  final List<Color>? gradientColors;

  const UserAvatar({
    super.key,
    required this.username,
    this.imageUrl,
    this.size = 40,
    this.borderWidth = 2,
    this.borderColor = Colors.white,
    this.gradientColors,
  });

  /// Generate deterministic color from username
  Color _generateColor(String text) {
    final seed = text.hashCode & 0xFFFFFF;
    final random = Random(seed);
    return Color.fromARGB(
      255,
      150 + random.nextInt(105), // bright color range
      150 + random.nextInt(105),
      150 + random.nextInt(105),
    );
  }

  /// Generate gradient from username
  List<Color> _generateGradient(String text) {
    final base = _generateColor(text);
    return [
      base.withOpacity(0.9),
      base.withOpacity(0.6),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final initials = username.isNotEmpty ? username[0].toUpperCase() : '?';
    final gradient = gradientColors ?? _generateGradient(username);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        // border only — NO SHADOW
        border: Border.all(
          width: borderWidth,
          color: borderColor,
        ),
      ),
      child: ClipOval(
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) {
                  return _fallback(initials);
                },
              )
            : _fallback(initials),
      ),
    );
  }

  /// Fallback to initial hero character
  Widget _fallback(String initial) {
    return Center(
      child: Text(
        initial,
        style: TextStyle(
          fontSize: size * 0.45,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
