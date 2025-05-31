import 'package:flutter/material.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CodeInput extends StatelessWidget {
  Function? onComplete;
  Function? onChange;
  int length;
  CodeInput({Key? key, this.onComplete, this.onChange, this.length = 4})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: maxItemWidth,
        child: PinCodeTextField(
          autoFocus: true,
          enableActiveFill: true,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          textStyle: TextStyle(color: appColor),
          appContext: context,
          pastedTextStyle: TextStyle(color: appColor),
          length: length,
          animationType: AnimationType.fade,
          validator: (v) {
            // if (v!.length < 3) {
            // } else {}
          },
          pinTheme: PinTheme(
            inactiveFillColor: Colors.transparent,
            shape: PinCodeFieldShape.underline,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.transparent,
            inactiveColor: itemColor3,
            activeColor: itemColor3,
            selectedColor: appColor,
            selectedFillColor: Colors.transparent,
          ),
          animationDuration: Duration(milliseconds: 300),
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          obscureText: false,
          cursorColor: appColor,
          onCompleted: (value) {
            if (onComplete != null) onComplete!(value);
          },
          onChanged: (value) {
            if (onChange != null) onChange!(value);
          },
          beforeTextPaste: (text) {
            return true;
          },
        ),
      ),
    );
  }
}
