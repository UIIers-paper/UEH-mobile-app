import 'package:flutter/material.dart';


class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final Color color;

  const SocialLoginButton({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Login with ${icon.toString()}");
      },
      child: Container(
        width: 110,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: Icon(icon, color: color),
          onPressed: () {
            print("Login with ${icon.toString()}");
          },
          iconSize: 35,
        ),
      ),
    );
  }
}