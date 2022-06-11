import 'package:flutter/material.dart';
import 'package:quizapp/services/firestore.dart';
import 'package:quizapp/services/models.dart';
import 'package:quizapp/shared/common_widgets/custom_loading_indicator.dart';
import 'package:quizapp/shared/common_widgets/error_notifier.dart';
import 'package:quizapp/shared/widgets/custom_buttom_nav.dart';
import 'package:quizapp/topics/topic_drawer.dart';
import 'package:quizapp/topics/topic_item.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
        future: FirstoreService().getTopics(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return circularLoading(40);
          } else if (snapshot.hasError) {
            return errorMessage(snapshot.error.toString());
          } else if (snapshot.hasData) {
            var topics = snapshot.data!;
            return buildPageContents(topics);
          } else {
            return errorMessage(
                'No topics in Firestore. Please check database');
          }
        }));
  }

  Scaffold buildPageContents(List<Topic> topics) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Topics'),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
      drawer: TopicDrawer(topics: topics),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20.0),
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        children: topics.map((topic) => TopicItem(topic: topic)).toList(),
      ),
    );
  }
}
