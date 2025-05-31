import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';

typedef void RatingChangeCallback(double rating);

class StarRating extends StatefulWidget {
  final int starCount;
  double rating;
  double? size;
  final RatingChangeCallback? onRatingChanged;
  final Color? color;
  bool editable;
  StarRating({
    this.starCount = 5,
    this.rating = 0.0,
    this.onRatingChanged,
    this.color,
    this.size = 40,
    this.editable = true,
  });

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  Widget buildStar(BuildContext context, int index) {
    Widget icon;
    if (index >= widget.rating) {
      icon = Img(
        star2Icon,
        color: appColor2,
        width: widget.size,
        height: widget.size,
      );
    }
    // else if (index > widget.rating - 1 && index < widget.rating) {
    //   icon = new Icon(
    //     Icons.star_half,
    //     size: this.widget.size,
    //     color: widget.color ?? primaryColor,
    //   );
    // }
    else {
      icon = Img(
        star1Icon,
        color: appColor2,
        width: widget.size,
        height: widget.size,
      );
    }
    return new InkWell(
      onTap:
          !widget.editable
              ? null
              : () {
                setState(() {
                  widget.rating = index + 1;
                });
                if (widget.onRatingChanged != null)
                  widget.onRatingChanged!(index + 1.0);
              },
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textDirection: TextDirection.ltr,
        children: new List.generate(
          widget.starCount,
          (index) => buildStar(context, index),
        ),
      ),
    );
  }
}
