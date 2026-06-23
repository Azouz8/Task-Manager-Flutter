import 'package:flutter/material.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Image.asset(
        "assets/appbar_icon.png",
      ),
      titleSpacing: 0,
      title: Text(
        "Master Ledger",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
      ),
    );
  }
}
