import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/main_controller.dart';
import 'package:vodda_old/Logic/Models/answer.dart';
import 'package:vodda_old/Logic/Models/question.dart';
import 'package:vodda_old/UI/Components/Headers/back-header.dart';
import 'package:vodda_old/UI/Components/Items/question-item.dart';

import 'package:vodda_old/UI/Components/General/column-scroll.dart';

class FrequentlyQuestions extends StatelessWidget {
  const FrequentlyQuestions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BackHeader(title: 'سوالات متداول'),
            Expanded(
              child: GetBuilder<MainController>(
                builder: (controller) {
                  return ColumnScroll(
                    children: [
                      for (var x in controller.setting['questions'])
                        QuestionItem(
                          Question(type: 0, title: x['question']),
                          Answer(value: x['answer']),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
