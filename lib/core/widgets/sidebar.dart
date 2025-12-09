// import 'package:flutter/material.dart';

// class Sidebar extends StatelessWidget {
//   const Sidebar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Container(
//       width: 250, // fixed sidebar width
//       color: theme.colorScheme.surface,
//       child: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           ListTile(
//             leading: const Icon(Icons.dashboard),
//             title: const Text('Dashboard'),
//             onTap: () {},
//           ),
//           ListTile(
//             leading: const Icon(Icons.people),
//             title: const Text('Users'),
//             onTap: () {},
//           ),
//           ListTile(
//             leading: const Icon(Icons.shopping_cart),
//             title: const Text('Orders'),
//             onTap: () {},
//           ),
//           ListTile(
//             leading: const Icon(Icons.settings),
//             title: const Text('Settings'),
//             onTap: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }