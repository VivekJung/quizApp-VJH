import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizapp/services/auth_service.dart';
import 'package:quizapp/shared/common_widgets/custom_loading_indicator.dart';
import 'package:quizapp/shared/common_widgets/error_notifier.dart';

class LoginScreen extends StatefulWidget {
  final bool loadStatus;
  const LoginScreen({Key? key, this.loadStatus = false}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    anonLoginButton() {
      return Flexible(
        child: LoginButton(
          loginMethod: AuthService().anonymousLogin,
          label: "Follow in anonymously",
          icon: FontAwesomeIcons.userNinja,
          color: Colors.deepPurple,
        ),
      );
    }

    googleLoginButton() {
      return LoginButton(
        loginMethod: AuthService().googleLogin,
        label: "Follow in with Google account",
        icon: FontAwesomeIcons.google,
        color: Colors.blue,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const FlutterLogo(size: 120),
            const SizedBox(height: 80),
            anonLoginButton(),
            googleLoginButton(),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatefulWidget {
  final Function loginMethod;
  final String label;
  final IconData icon;
  final Color color;

  const LoginButton({
    Key? key,
    required this.loginMethod,
    required this.label,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool isLoading = false;
  bool loadingStatus() {
    setState(() {
      isLoading = !isLoading;
      stat(isLoading);
    });
    return isLoading;
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Container(
            height: 80,
            color: Colors.transparent,
            margin: const EdgeInsets.only(bottom: 10),
            child: ElevatedButton.icon(
              onPressed: () async {
                loadingStatus();
                await widget.loginMethod();
              },
              icon: Icon(
                widget.icon,
                color: Colors.white,
                size: 20,
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(24),
                backgroundColor: widget.color,
              ),
              label: Text(widget.label),
            ),
          )
        : circularLoading(90);
  }
}
