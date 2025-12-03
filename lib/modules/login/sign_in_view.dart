// import 'package:flutter/material.dart';
// import '../../core/services/auth_service.dart';
// import 'login_form.dart';
// import 'package:get/get.dart';
// import '../dashboard/dashboard_view.dart';

// class SignInView extends StatelessWidget {
//   const SignInView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           final isSmallScreen = constraints.maxWidth < 900;

//           return isSmallScreen
//               ? _buildMobileLayout()
//               : _buildDesktopLayout();
//         },
//       ),
//     );
//   }

//   Widget _buildMobileLayout() {
//     return Center(
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: SizedBox(
//           width: 380,
//           child: PrettyLoginForm(
//             onSignInTap: _handleLogin,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDesktopLayout() {
//     return Row(
//       children: [
//         Expanded(
//           flex: 2,
//           child: Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("assets/backgrounds/background-1.jpg"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 1,
//           child: Center(
//             child: Container(
//               width: 380,
//               padding: const EdgeInsets.all(32),
//               child: PrettyLoginForm(
//                 onSignInTap: _handleLogin,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   /// Handle login from PrettyLoginForm
//   Future<void> _handleLogin(String username, String password) async {
//     final auth = Get.find<AuthService>();
//     final success = await auth.login(username, password);

//     if (success) {
//       Get.offAll(() => DashboardView());
//     } else {
//       Get.snackbar(
//         "Login failed",
//         "Invalid username or password",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
// }
