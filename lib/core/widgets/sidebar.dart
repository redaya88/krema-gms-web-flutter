import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DrawerHeader(child: Text("Krema GMS Web")),

          ListTile(
            title: const Text("Dashboard"),
            onTap: () => Get.toNamed(AppRoutes.DASHBOARD),
          ),

          ExpansionTile(
            title: const Text("User Management"),
            children: [
              ListTile(
                title: const Text("Users"),
                onTap: () => Get.toNamed(AppRoutes.USERS),
              ),
              ListTile(
                title: const Text("Roles"),
                onTap: () => Get.toNamed(AppRoutes.ROLES),
              ),
              ListTile(
                title: const Text("Features"),
                onTap: () => Get.toNamed(AppRoutes.FEATURES),
              ),
            ],
          )
        ],
      ),
    );
  }
}
