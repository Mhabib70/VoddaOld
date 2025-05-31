import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/main-controller.dart';
import 'package:vodda_old/Logic/Models/answer.dart';
import 'package:vodda_old/Logic/Models/question.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Headers/back-header.dart';
import 'package:vodda_old/UI/Components/Items/question-item.dart';

import 'package:vodda_old/UI/Components/General/column-scroll.dart';

class FrequentlyQuestions extends StatelessWidget {
  const FrequentlyQuestions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BackHeader(title: 'سوالات متداول'),
            Expanded(
              child: ColumnScroll(
                children: [
                  for (var x in MainController.setting['questions'])
                    QuestionItem(
                      Question(type: 0, title: x['question']),
                      Answer(value: x['answer']),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
