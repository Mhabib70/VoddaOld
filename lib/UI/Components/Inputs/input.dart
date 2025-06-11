import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vodda_old/UI/Components/Popups/snackbar.dart';

class Input extends StatelessWidget {
  String? lable, hint;
  Function? onChange;
  bool isNumber, isHalf;
  TextAlign align;
  Widget? icon1, icon2;
  double? width;
  double? height;
  int lines;
  var initValue;
  Input({
    this.lable,
    this.width,
    this.height,
    this.hint,
    this.initValue,
    this.onChange,
    this.isNumber = false,
    this.isHalf = false,
    this.icon1,
    this.icon2,
    this.lines = 1,
    this.align = TextAlign.right,
  });

  @override
  Widget build(BuildContext context) {
    if (WidgetsBinding.instance.window.viewInsets.bottom == 0) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
    var size = MediaQuery.of(context).size;
    return Container(
      height: lines == 1 ? this.height ?? 50 : null,
      width:
          this.isHalf
              ? ((size.width < maxItemWidth ? size.width : maxItemWidth) -
                      (2 * paddingSize)) /
                  2.05
              : this.width ?? maxItemWidth,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: TextFormField(
        initialValue: isNumber ? initValue : '${initValue ?? ''} ',
        textAlign: align,
        minLines: lines,
        maxLines: lines,
        textDirection: isNumber ? TextDirection.ltr : TextDirection.rtl,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: lines > 1 ? 30 : 5),
          prefixIcon: icon1 != null ? icon1 : null,
          suffixIcon: icon2 != null ? icon2 : null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: itemColor5, width: borderSize),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: appColor, width: borderSize),
            borderRadius: BorderRadius.circular(30),
          ),
          // floatingLabelStyle:TextStyle(color: appColor),
          labelStyle: AppController.fontStyle(fontTypes.heading4, itemColor2),
          alignLabelWithHint: true,
          labelText: this.lable ?? '',
          hintText: this.hint ?? '',
          hintStyle: AppController.fontStyle(fontTypes.heading4, itemColor4),
        ),
        keyboardType:
            isNumber
                ? TextInputType.number
                : lines == 1
                ? TextInputType.text
                : TextInputType.multiline,
        textInputAction:
            lines == 1 ? TextInputAction.next : TextInputAction.newline,
        inputFormatters: <TextInputFormatter>[
          isNumber
              ? FilteringTextInputFormatter.digitsOnly
              : TextInputFormatter.withFunction(
                (oldValue, newValue) => newValue,
              ),
        ],
        onChanged: (text) {
          if (onChange != null) this.onChange!(text);
        },
      ),
    );
  }
}
