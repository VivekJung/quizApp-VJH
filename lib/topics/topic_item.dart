import 'package:flutter/material.dart';
import 'package:quizapp/services/models.dart';
import 'package:quizapp/topics/individual_topic.dart';

class TopicItem extends StatelessWidget {
  final Topic topic;

  const TopicItem({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: topic.img,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    IndividualTopicScreen(topic: topic),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: SizedBox(
                  child: Image.asset(
                    'assets/covers/${topic.img}',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    topic.title,
                    style: const TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
