import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/styles.dart';

class CheckBox extends StatefulWidget {
  String? text;
  bool? value;
  Function? onClick;
  fontTypes? fontType;
  CheckBox(
    this.text, {
    Key? key,
    this.value = false,
    this.onClick,
    this.fontType,
  }) : super(key: key);

  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.value = !widget.value!;
        });
        if (widget.onClick != null) widget.onClick!(widget.value);
      },
      child: Container(
        width: maxItemWidth,
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Checkbox(
              value: widget.value,
              fillColor: MaterialStateProperty.all(appColor),
              activeColor: appColor,
              side: BorderSide(width: 1, color: itemColor4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              onChanged: (flag) {
                setState(() {
                  widget.value = flag!;
                });
                if (widget.onClick != null) widget.onClick!(widget.value);
              },
            ),
            Expanded(
              child: Text(
                '${widget.text ?? ''}',
                style: AppController.fontStyle(
                  widget.fontType ?? fontTypes.heading3,
                  itemColor2,
                ),
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
