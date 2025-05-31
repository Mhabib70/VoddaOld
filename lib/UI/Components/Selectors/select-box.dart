import 'package:vodda_old/Public/styles.dart';
import 'package:flutter/material.dart';

class SelectBox extends StatefulWidget {
  Map<dynamic, dynamic> options;
  Function? onSelect;
  String text;
  Widget? icon;
  var value;
  SelectBox({
    this.options = const <dynamic, dynamic>{},
    this.onSelect,
    this.text = '',
    this.icon,
    this.value,
  });
  @override
  _SelectBoxState createState() => _SelectBoxState();
}

class _SelectBoxState extends State<SelectBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: maxItemWidth,
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        border: Border.all(color: itemColor5, width: borderSize),
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: widget.value,
          isExpanded: true,
          focusColor: Colors.transparent,
          isDense: true,
          icon: Icon(
            Icons.keyboard_arrow_down_sharp,
            size: 20,
            color: itemColor4,
          ),
          hint: Row(
            children: [
              widget.icon != null ? widget.icon! : Container(),
              SizedBox(width: 10),
              Text(
                '${widget.text}',
                style: TextStyle(
                  color: itemColor2,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          items: [
            for (var key in widget.options.keys)
              DropdownMenuItem(
                value: widget.options[key],
                child: Text(
                  '${key}',
                  style: TextStyle(
                    color: itemColor2,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
          onChanged: (val) {
            setState(() {
              this.widget.value = val;
            });
            if (widget.onSelect != null) widget.onSelect!(widget.value);
          },
        ),
      ),
    );
  }
}
