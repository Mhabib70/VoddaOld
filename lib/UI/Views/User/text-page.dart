import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Models/link-menu.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/my-scroll.dart';
import 'package:vodda_old/UI/Components/Headers/back-header.dart';

class TextPage extends StatelessWidget {
  LinkMenu linkMenu = LinkMenu();
  TextPage(this.linkMenu);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        child: Column(
          children: [
            BackHeader(title: linkMenu.title!),
            Expanded(
              child: MyScroll(
                child: Container(
                  margin: EdgeInsets.all(paddingSize),
                  child: Text(
                    '${linkMenu.description ?? ''}',
                    style: AppController.fontStyle(
                      fontTypes.heading4,
                      itemColor3,
                    ),
                    textAlign: TextAlign.justify,
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
