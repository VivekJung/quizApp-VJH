import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quizapp/login/login.dart';
import 'package:quizapp/services/auth_service.dart';
import 'package:quizapp/shared/common_widgets/custom_loading_indicator.dart';
import 'package:quizapp/shared/common_widgets/error_notifier.dart';
import 'package:quizapp/topics/topics.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (conext, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return circularLoading(60);
        } else if (snapshot.hasError) {
          return errorMessage("");
        } else if (snapshot.hasData) {
          return const TopicsScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
