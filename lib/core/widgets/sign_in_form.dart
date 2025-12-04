import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/login/login_controller.dart';

class SignInForm extends StatelessWidget {
  SignInForm({super.key});

  final controller = Get.put(LoginController()); // use your existing controller

  @override
  Widget build(BuildContext context) {
    const Color darkPurple = Color(0xFF8A00D4);

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
                  ),
            ),
          ),
          const SizedBox(height: 24),

          // USERNAME FIELD
          TextField(
            onChanged: (value) => controller.username.value = value,
            decoration: InputDecoration(
              labelText: "Email / Username",
              prefixIcon: const Icon(Icons.person_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // PASSWORD FIELD
          TextField(
            obscureText: true,
            onChanged: (value) => controller.password.value = value,
            decoration: InputDecoration(
              labelText: "Password",
              prefixIcon: const Icon(Icons.lock_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 22),

          // LOGIN BUTTON
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () {
                      controller.login();
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: darkPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: controller.isLoading.value
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
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
              child: const Text("Forgot password?"),
            ),
          ),
        ],
      );
    });
  }
}
