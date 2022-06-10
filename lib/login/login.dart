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
      return LoginButton(
        loginMethod: AuthService().anonymousLogin,
        label: "Sign-in anonymously",
        icon: FontAwesomeIcons.userNinja,
        color: Colors.black54,
      );
    }

    googleLoginButton() {
      return LoginButton(
        loginMethod: AuthService().googleLogin,
        label: "Sign-in with your Google account",
        icon: FontAwesomeIcons.google,
        color: Colors.red,
      );
    }

    emailLoginButton() {
      return LoginButton(
        loginMethod: AuthService().emailPasswordLogin,
        label: "Sign-in with your Djin account",
        icon: FontAwesomeIcons.freeCodeCamp,
        color: Colors.deepPurpleAccent.shade700,
      );
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login'),
      // ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width / 2,
                child: const Image(
                    image: AssetImage('assets/images/blueRed.png'))),
            const SizedBox(height: 60),
            anonLoginButton(),
            googleLoginButton(),
            const SizedBox(height: 60),
            emailLoginButton(),
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
        : circularLoading(80);
  }
}
