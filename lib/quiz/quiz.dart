import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/quiz/quiz_state.dart';
import 'package:quizapp/services/firestore.dart';
import 'package:quizapp/services/models.dart';
import 'package:quizapp/shared/common_widgets/custom_loading_indicator.dart';
import 'package:quizapp/shared/widgets/progress_bar.dart';

class QuizScreen extends StatelessWidget {
  final String quizId;
  const QuizScreen({Key? key, required this.quizId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => QuizState(),
        child: FutureBuilder<Quiz>(
          future: FirstoreService().getQuiz(quizId),
          builder: (context, snapshot) {
            var state = Provider.of<QuizState>(context);

            if (!snapshot.hasData || snapshot.hasError) {
              return circularLoading(40);
            } else {
              var quizData = snapshot.data!;
              return Scaffold(
                appBar: AppBar(
                  title: AnimatedProgressBar(value: state.progress),
                  leading: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(FontAwesomeIcons.xmark)),
                ),
                body: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  controller: state.controller,
                  //listening to page that we are currently on
                  //state.progress gives percentage on progress.
                  onPageChanged: (int idx) =>
                      state.progress = (idx / (quizData.questions.length + 1)),
                  itemBuilder: (context, idx) {
                    //showing question or if the quiz has ended
                    if (idx == 0) {
                      return StartPage(quiz: quizData);
                    } else if (idx == quizData.questions.length + 1) {
                      return CompletionPage(quiz: quizData);
                    } else {
                      return QuestionPage(
                          question: quizData.questions[idx - 1]);
                    }
                  },
                ),
              );
            }
          },
        ));
  }
}

class StartPage extends StatelessWidget {
  final Quiz quiz;
  const StartPage({Key? key, required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(quiz.title, style: Theme.of(context).textTheme.headline3),
          const Divider(),
          Expanded(child: Text(quiz.description)),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: state.nextPage,
                icon: const Icon(Icons.poll),
                label: const Text('Begin quiz!'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CompletionPage extends StatelessWidget {
  final Quiz quiz;
  const CompletionPage({Key? key, required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'WELL DONE!\nYou have succesfully completed - ${quiz.title} ',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
              height: 200, child: Image.asset('assets/images/blueRed.png')),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              FirstoreService().updateUserReport(quiz);
              Navigator.pushNamedAndRemoveUntil(
                  context, '/topics', (route) => false);
            },
            icon: const Icon(FontAwesomeIcons.check),
            label: const Text('Mark it DONE !'),
          ),
        ],
      ),
    );
  }
}

class QuestionPage extends StatelessWidget {
  final Question question;
  const QuestionPage({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Text(question.text),
        )),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: question.options.map((opt) {
              return Container(
                height: 90,
                margin: const EdgeInsets.only(bottom: 10),
                color: Colors.black26,
                child: InkWell(
                  onTap: () {
                    state.selected = opt;
                    _bottomSheet(context, opt, state);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          state.selected == opt
                              ? FontAwesomeIcons.circleCheck
                              : FontAwesomeIcons.circle,
                          size: 30,
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 16),
                            child: Text(
                              opt.value,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  _bottomSheet(BuildContext context, Option opt, QuizState state) {
    bool isCorrect = opt.correct;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 250,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(isCorrect ? 'Well Played!' : 'WRONG'),
              Text(
                opt.detail,
                style: const TextStyle(fontSize: 18, color: Colors.white54),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: isCorrect ? Colors.green : Colors.red),
                onPressed: () {
                  if (isCorrect) {
                    state.nextPage();
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  isCorrect ? 'Onward' : 'Give it another try',
                  style: const TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
