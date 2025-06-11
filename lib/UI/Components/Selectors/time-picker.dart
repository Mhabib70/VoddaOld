import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';

class TimePicker extends StatefulWidget {
  TimeOfDay? initialTime = TimeOfDay.now();
  Function? onSelect;
  TimePicker({this.initialTime, this.onSelect});
  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: widget.initialTime!,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Colors.white,
              hourMinuteColor: MaterialStateColor.resolveWith(
                (states) =>
                    states.contains(MaterialState.selected)
                        ? appColor
                        : Colors.transparent,
              ),
              hourMinuteTextColor: MaterialStateColor.resolveWith(
                (states) =>
                    states.contains(MaterialState.selected)
                        ? Colors.white
                        : itemColor1,
              ),
              dialHandColor: appColor,
              dialBackgroundColor: Colors.white,
              dialTextColor: MaterialStateColor.resolveWith(
                (states) =>
                    states.contains(MaterialState.selected)
                        ? Colors.white
                        : itemColor1,
              ),
              entryModeIconColor: itemColor2,
            ),
            ///TODO: Emrani removed this
            // textTheme: TextTheme(overline: TextStyle(color: itemColor2)),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent,
                ),
                foregroundColor: MaterialStateColor.resolveWith(
                  (states) => itemColor2,
                ),
                overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent,
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null && pickedTime != widget.initialTime) {
      setState(() {
        widget.initialTime = pickedTime;
      });
      if (widget.onSelect != null) {
        widget.onSelect!(widget.initialTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectTime(context);
      },
      child: Container(
        height: 45,
        padding: EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          border: Border.all(color: itemColor5, width: borderSize),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.access_time_outlined, size: 20, color: itemColor4),
                SizedBox(width: 10),
                Text(
                  '${widget.initialTime!.hourOfPeriod > 9 ? widget.initialTime!.hourOfPeriod : '0${widget.initialTime!.hourOfPeriod}'}:${widget.initialTime!.minute > 9 ? widget.initialTime!.minute : '0${widget.initialTime!.minute}'}',
                  style: AppController.fontStyle(
                    fontTypes.heading4,
                    itemColor2,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  '${widget.initialTime!.period.name == 'am' ? 'قبل از ظهر' : 'بعد از ظهر'} ',
                  style: AppController.fontStyle(
                    fontTypes.heading4,
                    itemColor2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
