import 'package:flutter/cupertino.dart';
import 'package:quizapp/services/models.dart';

class QuizState with ChangeNotifier {
  double _porgress = 0;
  Option? _selected;

  final PageController controller = PageController();

  double get progress => _porgress;
  Option? get selected => _selected;

  set progress(double newValue) {
    _porgress = newValue;
    //provided by mixin ChangeNotifier.. notifyListeners
    notifyListeners();
  }

  set selected(Option? newValue) {
    _selected = newValue;
    notifyListeners();
  }

  //next page animation
  void nextPage() async {
    await controller.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }
}
