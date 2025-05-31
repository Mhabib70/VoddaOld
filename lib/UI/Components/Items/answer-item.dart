import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';

import 'dart:math' as math;

import 'package:vodda_old/Logic/Models/order-question.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Views/Order/question-images.dart';

class answerItem extends StatefulWidget {
  OrderQuestion question = OrderQuestion();

  answerItem(this.question);

  @override
  State<answerItem> createState() => _answerItemState();
}

class _answerItemState extends State<answerItem> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                          '${widget.question.question}',
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
                        padding: EdgeInsets.only(
                          bottom: 15,
                          left: 15,
                          right: 15,
                        ),
                        child:
                            widget.question.typeQuestion == 2
                                ? Wrap(
                                  direction: Axis.horizontal,
                                  spacing: 10,
                                  runSpacing: 5,
                                  children: [
                                    for (
                                      int i = 0;
                                      i < widget.question.res!.length;
                                      i++
                                    )
                                      InkWell(
                                        onTap: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (builder) => QuestionImages(
                                                    widget.question.res,
                                                  ),
                                            ),
                                          );
                                          // await showDialog(
                                          //     context: context,
                                          //     builder: (_) => Dialog(
                                          //         child: Container(
                                          //             width: 340,
                                          //             height: 340,
                                          //             child: Img(
                                          //               widget.question.res![i],
                                          //               width: 340,
                                          //               height: 340,
                                          //               radius: 5,
                                          //               isNetwork: true,
                                          //             )
                                          //         )
                                          //     ));
                                        },
                                        child: Container(
                                          width: 55,
                                          height: 55,
                                          child: Img(
                                            widget.question.res![i],
                                            width: 55,
                                            height: 55,
                                            radius: 5,
                                            isNetwork: true,
                                          ),
                                        ),
                                      ),
                                  ],
                                )
                                : Center(
                                  child: Text(
                                    '${widget.question.res}',
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
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
