import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';

import 'dart:math' as math;

import 'package:vodda_old/Logic/Models/order-document.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Views/Order/question-images.dart';

class DocumentItem extends StatefulWidget {
  OrderDocument orderDocument = OrderDocument();

  DocumentItem(this.orderDocument);

  @override
  State<DocumentItem> createState() => _DocumentItemState();
}

class _DocumentItemState extends State<DocumentItem> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: borderSize, color: itemColor2),
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
                          '${widget.orderDocument.description}',
                          style: AppController.fontStyle(
                            fontTypes.text2,
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
                            widget.orderDocument.fileUrls.length != 0
                                ? Wrap(
                                  direction: Axis.horizontal,
                                  spacing: 10,
                                  runSpacing: 5,
                                  children: [
                                    for (
                                      int i = 0;
                                      i < widget.orderDocument.fileUrls.length;
                                      i++
                                    )
                                      InkWell(
                                        onTap: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (builder) => QuestionImages(
                                                    widget
                                                        .orderDocument
                                                        .fileUrls,
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
                                            widget.orderDocument.fileUrls[i],
                                            width: 55,
                                            height: 55,
                                            radius: 5,
                                            isNetwork: true,
                                          ),
                                        ),
                                      ),
                                  ],
                                )
                                : Container(),
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
