import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Models/provider.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/my-scroll.dart';
import 'package:vodda_old/UI/Components/Headers/back-header.dart';
import 'package:vodda_old/UI/Components/Items/comment-item.dart';

class CommentsList extends StatelessWidget {
  Provider provider = Provider();
  CommentsList(this.provider);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        child: Column(
          children: [
            BackHeader(title: 'نظرات'),
            Expanded(
              child: MyScroll(
                child: Container(
                  margin: EdgeInsets.only(
                    left: paddingSize,
                    right: paddingSize,
                  ),
                  child: Column(
                    children: [
                      for (var comment in provider.comments)
                        CommentItem(comment),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
