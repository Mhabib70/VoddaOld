import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Models/answer.dart';
import 'package:vodda_old/Logic/Models/question.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';

class QuestionItem extends StatefulWidget {
  Question question;
  Answer answer;

  QuestionItem(this.question, this.answer);

  @override
  State<QuestionItem> createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxItemWidth,
      margin: EdgeInsets.only(top: paddingSize),
      decoration: BoxDecoration(
        border: Border.all(width: borderSize, color: itemColor5),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                show = !show;
              });
            },
            child: Container(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${widget.question.title}',
                      style: AppController.fontStyle(
                        fontTypes.heading4,
                        itemColor1,
                      ),
                      maxLines: null,
                    ),
                  ),
                  Transform.rotate(
                    angle: show ? 180 * math.pi / 180 : 0,
                    child: Img(
                      downIcon,
                      width: 12,
                      height: 6,
                      color: itemColor1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          show
              ? Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
                    child:
                        widget.question.type == 2
                            ? Wrap(
                              direction: Axis.horizontal,
                              spacing: 10,
                              runSpacing: 5,
                              children: [
                                for (
                                  int i = 0;
                                  i < widget.answer.value.length;
                                  i++
                                )
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder:
                                            (_) => Dialog(
                                              child: Container(
                                                width: 340,
                                                height: 340,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        5.0,
                                                      ),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        5.0,
                                                      ),
                                                  child: Image.memory(
                                                    widget.answer.value[i],
                                                    width: 340,
                                                    height: 340,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                      );
                                    },
                                    child: Container(
                                      width: 55,
                                      height: 55,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          5.0,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          5.0,
                                        ),
                                        child: Image.memory(
                                          widget.answer.value[i],
                                          width: 55,
                                          height: 55,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            )
                            : widget.question.type == 1
                            ? Center(
                              child: Text(
                                '${widget.question.options!.firstWhere((element) => element.id == widget.answer.value).title}',
                                style: AppController.fontStyle(
                                  fontTypes.heading5,
                                  itemColor2,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            )
                            : widget.question.type == 3
                            ? Column(
                              children: [
                                for (int optionId in widget.answer.value)
                                  Center(
                                    child: Text(
                                      '${widget.question.options!.firstWhere((element) => element.id == optionId).title}',
                                      style: AppController.fontStyle(
                                        fontTypes.heading5,
                                        itemColor2,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                              ],
                            )
                            : Center(
                              child: Text(
                                '${widget.answer.value}',
                                style: AppController.fontStyle(
                                  fontTypes.heading5,
                                  itemColor2,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                  ),
                ],
              )
              : Container(),
        ],
      ),
    );
  }
}
