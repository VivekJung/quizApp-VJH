import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/services/models.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);

    return Row(
      children: [
        // _progressCount(report, topic),
        // Expanded(child: AnimatedProgressBar)
      ],
    );
  }
}
