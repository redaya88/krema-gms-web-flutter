import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/login/login_controller.dart';

class SignInForm extends StatelessWidget {
  SignInForm({super.key});

  final controller = Get.put(LoginController());
  final RxBool hidePassword = true.obs;

  @override
  Widget build(BuildContext context) {
    // THEME COLORS
    const Color deepGray = Color(0xFF1F1F1F);      // Dark accents
    const Color borderGray = Color(0xFF3A3A3A);    // Outline
    const Color textColor = Color(0xFF1F1F1F);     // Visible text (deep gray)

    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Sign In",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: deepGray,
                  ),
            ),
          ),
          const SizedBox(height: 24),

          // USERNAME FIELD
          TextField(
            onChanged: (value) => controller.username.value = value,
            style: const TextStyle(color: textColor), // <<< FIXED
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white, // <<< white background
              labelText: "Email / Username",
              labelStyle: const TextStyle(color: borderGray), // <<< visible label
              prefixIcon: Icon(Icons.person_outline, color: borderGray),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: borderGray, width: 1.2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: deepGray, width: 1.5),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // PASSWORD FIELD WITH EYE TOGGLE
          Obx(() {
            return TextField(
              obscureText: hidePassword.value,
              onChanged: (value) => controller.password.value = value,
              style: const TextStyle(color: textColor), // <<< FIXED
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: "Password",
                labelStyle: const TextStyle(color: borderGray),
                prefixIcon: Icon(Icons.lock_outline, color: borderGray),

                // Toggle eye
                suffixIcon: GestureDetector(
                  onTap: () => hidePassword.value = !hidePassword.value,
                  child: Icon(
                    hidePassword.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: borderGray,
                  ),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: borderGray, width: 1.2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: deepGray, width: 1.5),
                ),
              ),
            );
          }),

          const SizedBox(height: 22),

          // LOGIN BUTTON
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () => controller.login(),
              style: ElevatedButton.styleFrom(
                backgroundColor: deepGray,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: controller.isLoading.value
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),

          const SizedBox(height: 14),

          // FORGOT PASSWORD
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Forgot password?",
                style: TextStyle(color: borderGray),
              ),
            ),
          ),
        ],
      );
    });
  }
}
