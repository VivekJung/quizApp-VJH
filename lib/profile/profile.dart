import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quizapp/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: ElevatedButton.icon(
          onPressed: () async {
            var logOutStatus = await AuthService().signOut();

            if (logOutStatus == null) {
              navigator.pushNamedAndRemoveUntil('/', (route) => false);
            } else {
              log('Error while loging out - UI, $logOutStatus');
            }
            //
          },
          icon: const Icon(
            Icons.logout_rounded,
            color: Colors.white,
            size: 20,
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(24),
            backgroundColor: Colors.deepOrange,
          ),
          label: const Text('Sign Out'),
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final Function() btnFunction;
  final String label;
  final IconData icon;
  final Color bgColor;
  const CustomElevatedButton({
    Key? key,
    required this.btnFunction,
    required this.label,
    required this.icon,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        onPressed: () {},
        // btnFunction,
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(24),
          backgroundColor: bgColor,
        ),
        label: Text(label),
      ),
    );
  }
}
