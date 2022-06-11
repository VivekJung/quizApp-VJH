import 'package:flutter/material.dart';
import 'package:quizapp/services/models.dart';
import 'package:quizapp/shared/widgets/custom_buttom_nav.dart';
import 'package:quizapp/topics/topic_drawer.dart';

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
      // bottomNavigationBar: const CustomBottomNavBar(),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    topic.title,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  QuizList(topic: topic),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
