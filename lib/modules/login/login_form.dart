import 'package:flutter/material.dart';

class PrettyLoginForm extends StatelessWidget {
  const PrettyLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    const Color lightPink = Color(0xFFF4D7FF);
    const Color darkPurple = Color(0xFF8A00D4);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // EMAIL FIELD
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: lightPink,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Your email",
              icon: Icon(Icons.person, color: Colors.purple.shade800),
            ),
          ),
        ),

        const SizedBox(height: 15),

        // PASSWORD FIELD
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: lightPink,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Your password",
              icon: Icon(Icons.lock, color: Colors.purple.shade800),
            ),
          ),
        ),

        const SizedBox(height: 25),

        // SIGN UP BUTTON
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: darkPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "SIGN UP",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // SIGN IN TEXT LINK
        RichText(
          text: TextSpan(
            text: "Already have an Account? ",
            style: TextStyle(color: Colors.grey.shade700),
            children: const [
              TextSpan(
                text: "Sign In",
                style: TextStyle(
                  color: darkPurple,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),

        const SizedBox(height: 25),

        // OR DIVIDER
        const Row(
          children: [
            Expanded(child: Divider(thickness: 1, indent: 40, endIndent: 10)),
            Text("OR"),
            Expanded(child: Divider(thickness: 1, indent: 10, endIndent: 40)),
          ],
        ),

        const SizedBox(height: 20),

        // SOCIAL LOGIN ICONS
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialIcon('assets/icons/email-icon.png'),
            const SizedBox(width: 25),
            _socialIcon('assets/icons/google-icon.png'),
          ],
        ),
      ],
    );
  }

  Widget _socialIcon(String imagePath) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.deepPurpleAccent.shade100,
          width: 1,
        ),
      ),
      child: Image.asset(
        imagePath,
        width: 24,
        height: 24,
        fit: BoxFit.contain,
      ),
    );
  }
}
