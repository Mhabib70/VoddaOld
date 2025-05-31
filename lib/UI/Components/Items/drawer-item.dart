import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';

class DrawerItem extends StatefulWidget {
  String text;
  Widget icon;
  Function? onClick;
  DrawerItem(this.text, this.icon, {Key? key, this.onClick}) : super(key: key);

  @override
  _DrawerItemState createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() {
          selected = !selected;
        });
        await Future.delayed(
          Duration(milliseconds: 300),
          () => Navigator.pop(context),
        );
        if (widget.onClick != null) widget.onClick!();
      },
      child: Container(
        height: 40,
        margin: EdgeInsets.only(left: paddingSize, right: paddingSize, top: 10),
        padding: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: selected ? appColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            widget.icon,
            SizedBox(width: 15),
            Text(
              '${widget.text}',
              style:
                  !selected
                      ? AppController.fontStyle(fontTypes.heading4, itemColor3)
                      : AppController.fontStyle(fontTypes.heading4, appColor),
            ),
          ],
        ),
      ),
    );
  }
}
