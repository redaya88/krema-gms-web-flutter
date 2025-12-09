import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/widgets/sign_up_form.dart';
import 'login_controller.dart';

class PrettyLoginForm extends StatelessWidget {
  PrettyLoginForm({super.key});

  final controller = Get.put(LoginController());

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
    final isDark = theme.brightness == Brightness.dark;

    return Obx(() {
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
            onChanged: (value) => controller.username.value = value,
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
            onChanged: (value) => controller.password.value = value,
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

          /// SIGN IN BUTTON
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed:
                  controller.isLoading.value ? null : () => controller.login(),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: controller.isLoading.value
                  ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: theme.colorScheme.onPrimary,
                      ),
                    )
                  : Text(
                      "Sign In",
                      style: theme.textTheme.labelLarge?.copyWith(
                        // color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),

          const SizedBox(height: 14),

          /// SIGN UP LINK
          RichText(
            text: TextSpan(
              style: theme.textTheme.bodyMedium,
              text: "Don't have an account? ",
              children: [
                TextSpan(
                  text: "Register",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    // color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
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
                    "Sign In with Google",
                    style: theme.textTheme.labelLarge?.copyWith(
                      // color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
