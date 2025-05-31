import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';

class ServiceHeader extends StatefulWidget {
  Function? setFavorite;
  bool isFavorite;
  ServiceHeader(this.isFavorite, {Key? key, this.setFavorite})
    : super(key: key);

  @override
  State<ServiceHeader> createState() => _ServiceHeaderState();
}

class _ServiceHeaderState extends State<ServiceHeader> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          left: paddingSize,
          right: paddingSize,
          top: 10,
          bottom: 10,
        ),
        decoration: BoxDecoration(
          // gradient: topGradient
          color: whiteColor,
          boxShadow: shadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UserController.user.value.isCompleted == true
                ? Img(
                  widget.isFavorite ? favoritedIcon : favoriteIcon,
                  width: 15,
                  height: 20,
                  color: itemColor1,
                  onClick: () {
                    setState(() {
                      widget.isFavorite = !widget.isFavorite;
                    });
                    if (widget.setFavorite != null) widget.setFavorite!();
                  },
                )
                : Container(),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 40,
                height: 40,
                child: Img(backIcon, width: 20, height: 20, color: itemColor1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
