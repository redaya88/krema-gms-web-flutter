import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
          dialogWidth = 420;
        } else if (width >= 600) {
          dialogWidth = 360;
        } else {
          dialogWidth = width * 0.9;
        }

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          backgroundColor: Colors.white,
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
    const Color deepGray = Color(0xFF2C2C2C);
    const Color fieldBorder = Color(0xFF444444);
    const Color textColor = Color(0xFF1A1A1A);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // EMAIL FIELD
        TextField(
          decoration: InputDecoration(
            labelText: "Email / Username",
            labelStyle: const TextStyle(color: textColor),
            prefixIcon: const Icon(Icons.person_outline, color: fieldBorder),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: fieldBorder, width: 1.2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: deepGray, width: 1.5),
            ),
          ),
        ),

        const SizedBox(height: 15),

        // PASSWORD FIELD
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Password",
            labelStyle: const TextStyle(color: textColor),
            prefixIcon: const Icon(Icons.lock_outline, color: fieldBorder),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: fieldBorder, width: 1.2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: deepGray, width: 1.5),
            ),
          ),
        ),

        const SizedBox(height: 25),

        // SIGN UP BUTTON
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: deepGray,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "SIGN UP",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SizedBox(height: 14),

        // SIGN IN LINK
        RichText(
          text: TextSpan(
            text: "Already have an Account? ",
            style: TextStyle(color: Colors.grey.shade700),
            children: [
              TextSpan(
                text: "Sign In",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
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
            Expanded(child: Divider(color: Colors.grey, thickness: 1)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("OR"),
            ),
            Expanded(child: Divider(color: Colors.grey, thickness: 1)),
          ],
        ),

        const SizedBox(height: 20),

        // SOCIAL LOGIN
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialIcon('assets/icons/email-icon.png'),
            const SizedBox(width: 28),
            _socialIcon('assets/icons/google-icon.png'),
          ],
        ),
      ],
    );
  }

  static Widget _socialIcon(String imagePath) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Color(0xFF666666),
          width: 1.2,
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
