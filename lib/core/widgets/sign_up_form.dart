import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/login/login_controller.dart';

class SignInForm extends StatelessWidget {
  SignInForm({super.key});

  final controller = Get.put(LoginController());
  final RxBool hidePassword = true.obs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TITLE
          Center(
            child: Text(
              "Sign In",
              style: theme.textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: 24),

          // USERNAME FIELD
          TextField(
            onChanged: (value) => controller.username.value = value,
            style: theme.textTheme.bodyMedium,
            decoration: InputDecoration(
              labelText: "Email / Username",
              labelStyle: theme.textTheme.labelLarge,
              prefixIcon: Icon(
                Icons.person_outline,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
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

          const SizedBox(height: 16),

          // PASSWORD FIELD WITH EYE TOGGLE
          TextField(
            obscureText: hidePassword.value,
            onChanged: (value) => controller.password.value = value,
            style: theme.textTheme.bodyMedium,
            decoration: InputDecoration(
              labelText: "Password",
              labelStyle: theme.textTheme.labelLarge,
              prefixIcon: Icon(
                Icons.lock_outline,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
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
              suffixIcon: GestureDetector(
                onTap: () => hidePassword.value = !hidePassword.value,
                child: Icon(
                  hidePassword.value ? Icons.visibility_off : Icons.visibility,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // RE ENTER PASSWORD FIELD WITH EYE TOGGLE
          TextField(
            obscureText: hidePassword.value,
            onChanged: (value) => controller.password.value = value,
            style: theme.textTheme.bodyMedium,
            decoration: InputDecoration(
              labelText: "Re-type Password",
              labelStyle: theme.textTheme.labelLarge,
              prefixIcon: Icon(
                Icons.lock_outline,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
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
              suffixIcon: GestureDetector(
                onTap: () => hidePassword.value = !hidePassword.value,
                child: Icon(
                  hidePassword.value ? Icons.visibility_off : Icons.visibility,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ),
          ),

          const SizedBox(height: 22),

          // SIGNUP BUTTON
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
                      "Sign Up",
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),

          const SizedBox(height: 14),

          // FORGOT PASSWORD
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Forgot password?",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
