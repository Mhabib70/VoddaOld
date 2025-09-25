import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/order_controller.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/my-scroll.dart';
import 'package:vodda_old/UI/Components/Inputs/input.dart';
import 'package:vodda_old/UI/Components/Selectors/checkbox.dart';
import 'package:vodda_old/UI/Components/Selectors/file-picker.dart';
import 'package:vodda_old/UI/Components/Selectors/radio-group.dart' as rg;

class QuestionTypes extends StatefulWidget {
  const QuestionTypes({Key? key}) : super(key: key);
  @override
  _QuestionTypesState createState() => _QuestionTypesState();
}

class _QuestionTypesState extends State<QuestionTypes> {
  OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MyScroll(
      child: Container(
        width: size.width,
        padding: EdgeInsets.only(left: paddingSize, right: paddingSize),
        child: Column(
          children: [
            Text(
              '${orderController.questions[orderController.questionIndex].title}',
              style: AppController.fontStyle(fontTypes.heading4, itemColor2),
            ),
            SizedBox(height: 50),
            orderController.questions[orderController.questionIndex].type == 0
                ? Input(
                  lable: 'توضیحات',
                  initValue:
                      orderController
                          .order
                          .answers[orderController.questionIndex]
                          .value,
                  onChange: (text) {
                    orderController
                        .order
                        .answers[orderController.questionIndex]
                        .value = text;
                  },
                  icon1: Container(
                    child: Icon(
                      Icons.edit_outlined,
                      size: 20,
                      color: itemColor4,
                    ),
                    width: 50,
                    height: 250,
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(top: 5),
                  ),
                  lines: 10,
                )
                : orderController
                        .questions[orderController.questionIndex]
                        .type ==
                    1
                ? rg.RadioGroup(
                  orderController
                      .questions[orderController.questionIndex]
                      .options!
                      .indexWhere(
                        (element) =>
                            orderController
                                .order
                                .answers[orderController.questionIndex]
                                .value ==
                            element.id,
                      ),
                  {
                    for (
                      int i = 0;
                      i <
                          orderController
                              .questions[orderController.questionIndex]
                              .options!
                              .length;
                      i++
                    )
                      '${orderController.questions[orderController.questionIndex].options![i].title}':
                          i,
                  },
                  space: 20,
                  onChange: (index) {
                    orderController
                        .order
                        .answers[orderController.questionIndex]
                        .value = orderController
                            .questions[orderController.questionIndex]
                            .options![index]
                            .id;
                    orderController
                        .order
                        .answers[orderController.questionIndex]
                        .price = orderController
                            .questions[orderController.questionIndex]
                            .options![index]
                            .price!;
                    orderController
                        .order
                        .answers[orderController.questionIndex]
                        .time = orderController
                            .questions[orderController.questionIndex]
                            .options![index]
                            .time!;
                    if (orderController
                            .order
                            .answers[orderController.questionIndex]
                            .nextQuestionIndex !=
                        null) {
                      orderController
                          .order
                          .answers[orderController
                              .order
                              .answers[orderController.questionIndex]
                              .nextQuestionIndex!]
                          .preQuestionIndex = null;
                      orderController
                          .order
                          .answers[orderController.questionIndex]
                          .nextQuestionIndex = null;
                    }
                    if (orderController
                                .questions[orderController.questionIndex]
                                .options![index]
                                .targetQuestionId !=
                            null &&
                        orderController
                                .questions[orderController.questionIndex]
                                .options![index]
                                .targetQuestionId !=
                            0) {
                      orderController
                          .order
                          .answers[orderController.questionIndex]
                          .nextQuestionIndex = orderController.questions
                          .indexWhere(
                            (element) =>
                                orderController
                                    .questions[orderController.questionIndex]
                                    .options![index]
                                    .targetQuestionId ==
                                element.id,
                          );
                    }
                  },
                )
                : orderController
                        .questions[orderController.questionIndex]
                        .type ==
                    2
                ? FilePicker(
                  images:
                      orderController
                          .order
                          .answers[orderController.questionIndex]
                          .value,
                  onChange: (images) {
                    orderController
                        .order
                        .answers[orderController.questionIndex]
                        .value = images;
                  },
                )
                : orderController
                        .questions[orderController.questionIndex]
                        .type ==
                    3
                ? Column(
                  children: [
                    for (
                      int i = 0;
                      i <
                          orderController
                              .questions[orderController.questionIndex]
                              .options!
                              .length;
                      i++
                    )
                      CheckBox(
                        '${orderController.questions[orderController.questionIndex].options![i].title}',
                        value: orderController
                            .order
                            .answers[orderController.questionIndex]
                            .value
                            .contains(
                              orderController
                                  .questions[orderController.questionIndex]
                                  .options![i]
                                  .id,
                            ),
                        onClick: (val) {
                          if (val) {
                            orderController
                                .order
                                .answers[orderController.questionIndex]
                                .value
                                .add(
                                  orderController
                                      .questions[orderController.questionIndex]
                                      .options![i]
                                      .id,
                                );
                            orderController
                                .order
                                .answers[orderController.questionIndex]
                                .price += orderController
                                    .questions[orderController.questionIndex]
                                    .options![i]
                                    .price ??
                                0;
                            orderController
                                .order
                                .answers[orderController.questionIndex]
                                .time += orderController
                                    .questions[orderController.questionIndex]
                                    .options![i]
                                    .time ??
                                0;
                          } else {
                            orderController
                                .order
                                .answers[orderController.questionIndex]
                                .value
                                .remove(
                                  orderController
                                      .questions[orderController.questionIndex]
                                      .options![i]
                                      .id,
                                );
                            orderController
                                .order
                                .answers[orderController.questionIndex]
                                .price -= orderController
                                    .questions[orderController.questionIndex]
                                    .options![i]
                                    .price ??
                                0;
                            orderController
                                .order
                                .answers[orderController.questionIndex]
                                .time -= orderController
                                    .questions[orderController.questionIndex]
                                    .options![i]
                                    .time ??
                                0;
                          }
                        },
                      ),
                  ],
                )
                : Container(),
          ],
        ),
      ),
    );
  }
}
