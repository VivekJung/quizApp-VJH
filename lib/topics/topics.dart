import 'package:flutter/material.dart';
import 'package:quizapp/shared/widgets/custom_buttom_nav.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
