import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Models/comment.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/Selectors/star-rating.dart';

class CommentItem extends StatelessWidget {
  Comment comment = Comment();
  CommentItem(this.comment, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: borderSize, color: itemColor5),
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Img(userIcon, width: 11, height: 14, color: appColor),
                  SizedBox(width: 5),
                  Text(
                    '${comment.userName}',
                    style: AppController.fontStyle(
                      fontTypes.heading4,
                      itemColor1,
                    ),
                  ),
                ],
              ),
              Text(
                '${comment.date}',
                style: AppController.fontStyle(fontTypes.text1, itemColor4),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            '${comment.description ?? ''}',
            textAlign: TextAlign.right,
            style: AppController.fontStyle(fontTypes.text1, itemColor2),
          ),
          SizedBox(height: 20),
          Container(
            width: 55,
            child: StarRating(
              size: 10,
              editable: false,
              rating: comment.value!.toDouble(),
            ),
          ),
        ],
      ),
    );
  }
}
