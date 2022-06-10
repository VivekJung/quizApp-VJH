import 'package:flutter/material.dart';
import 'package:quizapp/services/models.dart';
import 'package:quizapp/shared/widgets/custom_buttom_nav.dart';

class IndividualTopicScreen extends StatelessWidget {
  final Topic topic;
  const IndividualTopicScreen({Key? key, required this.topic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topic.title),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
      body: Container(
        color: Colors.transparent,
        child: ListView(
          children: [
            Hero(
              tag: topic.img,
              child: Image.asset(
                'assets/covers/${topic.img}',
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Text(topic.title),
          ],
        ),
      ),
    );
  }
}
