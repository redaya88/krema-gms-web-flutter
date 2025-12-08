import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/widgets/sign_in_form.dart';

class PrettyLoginForm extends StatelessWidget {
  const PrettyLoginForm({super.key});

  void showSignInPopup(BuildContext context) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        final width = MediaQuery.of(context).size.width;
        double dialogWidth = width >= 1200
            ? 420
            : width >= 600
                ? 360
                : width * 0.9;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          backgroundColor: theme.colorScheme.surface,
          elevation: 6,
          child: Container(
            width: dialogWidth,
            padding: const EdgeInsets.all(26),
            child: SingleChildScrollView(
              child: SignInForm(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// 🌗 THEME TOGGLE BUTTON
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(
                Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: theme.colorScheme.onSurface,
              ),
              onPressed: () {
                Get.changeThemeMode(
                  Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                );
              },
            ),
          ],
        ),

        const SizedBox(height: 10),

        /// EMAIL FIELD
        TextField(
          style: theme.textTheme.bodyMedium,
          decoration: InputDecoration(
            labelText: "Email / Username",
            labelStyle: theme.textTheme.labelLarge,
            prefixIcon: Icon(
              Icons.person_outline,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            filled: true,
            fillColor: theme.colorScheme.surface,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: theme.colorScheme.outline,
                width: 1.2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 1.5,
              ),
            ),
          ),
        ),

        const SizedBox(height: 15),

        /// PASSWORD FIELD
        TextField(
          obscureText: true,
          style: theme.textTheme.bodyMedium,
          decoration: InputDecoration(
            labelText: "Password",
            labelStyle: theme.textTheme.labelLarge,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            filled: true,
            fillColor: theme.colorScheme.surface,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: theme.colorScheme.outline,
                width: 1.2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 1.5,
              ),
            ),
          ),
        ),

        const SizedBox(height: 25),

        /// SIGN UP BUTTON
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {},
            style: theme.elevatedButtonTheme.style,
            child: Text(
              "SIGN UP",
              style: text.labelLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SizedBox(height: 14),

        /// SIGN IN LINK
        RichText(
          text: TextSpan(
            text: "Already have an Account? ",
            style: text.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            children: [
              TextSpan(
                text: "Sign In",
                style: text.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => showSignInPopup(context),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        /// DIVIDER
        Row(
          children: [
            Expanded(
              child: Divider(color: theme.colorScheme.outline),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("OR"),
            ),
            Expanded(
              child: Divider(color: theme.colorScheme.outline),
            ),
          ],
        ),

        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {},
            style: theme.elevatedButtonTheme.style,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Image.asset(
                    isDark
                        ? 'assets/icons/google-dark.png'
                        : 'assets/icons/google-light.png',
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "Sign in with Google",
                  style: text.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
