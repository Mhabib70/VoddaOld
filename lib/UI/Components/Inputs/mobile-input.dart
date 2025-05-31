import 'package:flutter/cupertino.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MobileInput extends StatelessWidget {
  Function? onChange, onTap;
  var initValue;
  MobileInput({this.initValue, this.onChange, this.onTap});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 60,
      width: maxItemWidth,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(color: itemColor3, width: borderSize),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: '${initValue ?? ''}',
              textDirection: TextDirection.ltr,
              decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintStyle: TextStyle(
                  color: itemColor4,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                hintText: '_ _ _  _ _ _  _ _ _ _',
                hintTextDirection: TextDirection.ltr,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (text) {
                if (onChange != null) this.onChange!(text);
              },
              onTap: () {
                if (onTap != null) this.onTap!();
              },
            ),
          ),
          Container(
            width: borderSize,
            margin: EdgeInsets.all(10),
            color: itemColor3,
          ),
          Container(
            width: 50,
            child: Text(
              '98+',
              style: AppController.fontStyle(fontTypes.bold18, itemColor2),
            ),
          ),
        ],
      ),
    );
  }
}
