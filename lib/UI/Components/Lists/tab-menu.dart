import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/main-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:get/get.dart';
import 'package:vodda_old/UI/Views/User/login.dart';

class TabMenu extends StatelessWidget {
  TabMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 70,
      width: size.width,
      decoration: BoxDecoration(color: whiteColor, boxShadow: shadow2),
      child: TabBar(
        indicator: CustomTabIndicator(color: appColor2),
        labelColor: appColor2,
        unselectedLabelColor: itemColor4,
        controller: MainController.tabController,
        onTap: (index) {},
        tabs: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Img(
                MainController.tabController!.index == 0
                    ? homeFillIcon
                    : homeBlankIcon,
                color:
                    MainController.tabController!.index == 0
                        ? appColor2
                        : itemColor4,
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  'خانه',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Img(
                MainController.tabController!.index == 1
                    ? searchFillIcon
                    : searchBlankIcon,
                color:
                    MainController.tabController!.index == 1
                        ? appColor2
                        : itemColor4,
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  'جستجو',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Img(
                MainController.tabController!.index == 2
                    ? categoryFillIcon
                    : categoryBlankIcon,
                color:
                    MainController.tabController!.index == 2
                        ? appColor2
                        : itemColor4,
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  'دسته ها',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Img(
                ordersBlankIcon,
                color:
                    MainController.tabController!.index == 3
                        ? appColor2
                        : itemColor4,
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  'درخواستها',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Img(
                MainController.tabController!.index == 4
                    ? userFillIcon
                    : userBlankIcon,
                color:
                    MainController.tabController!.index == 4
                        ? appColor2
                        : itemColor4,
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  'پروفایل',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomTabIndicator extends Decoration {
  final double radius;

  final Color color;

  final double indicatorHeight;

  CustomTabIndicator({
    this.radius = 10,
    this.indicatorHeight = 5,
    this.color = Colors.blue,
  });

  @override
  _CustomPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(this, onChanged, radius, color, indicatorHeight);
  }
}

class _CustomPainter extends BoxPainter {
  final CustomTabIndicator decoration;
  final double radius;
  final Color color;
  final double indicatorHeight;

  _CustomPainter(
    this.decoration,
    VoidCallback? onChanged,
    this.radius,
    this.color,
    this.indicatorHeight,
  ) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    final Paint paint = Paint();
    double xAxisPos = offset.dx + configuration.size!.width / 2;
    double yAxisPos =
        offset.dy + configuration.size!.height - indicatorHeight / 2;
    paint.color = color;

    RRect fullRect = RRect.fromRectAndCorners(
      Rect.fromCenter(
        center: Offset(xAxisPos, yAxisPos),
        width: configuration.size!.width / 3,
        height: indicatorHeight,
      ),
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
    );

    canvas.drawRRect(fullRect, paint);
  }
}
