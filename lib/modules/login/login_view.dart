import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<LoginController>();

    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Username"),
                onChanged: (v) => c.username.value = v,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
                onChanged: (v) => c.password.value = v,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => c.login(),
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
