import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// import '../../core/widgets/glass_popup.dart';
import '../../core/widgets/sign_in_form.dart';

class PrettyLoginForm extends StatelessWidget {
  const PrettyLoginForm({super.key});

  void showSignInPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        final width = MediaQuery.of(context).size.width;

        double dialogWidth;
        if (width >= 1200) {
          dialogWidth = 420; // Desktop
        } else if (width >= 600) {
          dialogWidth = 360; // Tablet
        } else {
          dialogWidth = width * 0.9; // Mobile
        }

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 3,
          child: Container(
            width: dialogWidth,
            padding: const EdgeInsets.all(24),
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
    const Color lightPink = Color(0xFFF4D7FF);
    const Color darkPurple = Color(0xFF8A00D4);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // EMAIL FIELD
        TextField(
          onChanged: (value) => {},
          decoration: InputDecoration(
            labelText: "Email / Username",
            prefixIcon: const Icon(Icons.person_outline),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        const SizedBox(height: 15),

        // PASSWORD FIELD
        TextField(
          onChanged: (value) => {},
          decoration: InputDecoration(
            labelText: "Password",
            prefixIcon: const Icon(Icons.lock_outline),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
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
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // SIGN IN LINK
        RichText(
          text: TextSpan(
            text: "Already have an Account? ",
            style: TextStyle(color: Colors.grey.shade700),
            children: [
              TextSpan(
                text: "Sign In",
                style: const TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
                mouseCursor: SystemMouseCursors.click,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => showSignInPopup(context),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        // DIVIDER
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

  // SOCIAL ICON
  static Widget _socialIcon(String imagePath) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.deepPurpleAccent,
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
