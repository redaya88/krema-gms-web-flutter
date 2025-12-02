import 'package:flutter/material.dart';
import '../../core/widgets/sidebar.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(),
          Expanded(
            child: Center(
              child: Text("Dashboard"),
            ),
          )
        ],
      ),
    );
  }
}
