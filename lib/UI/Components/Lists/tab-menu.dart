import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/main_controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:get/get.dart';

class TabMenu extends StatelessWidget {
  const TabMenu({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 70,
      width: size.width,
      decoration: BoxDecoration(color: whiteColor, boxShadow: shadow2),
      child: GetBuilder<MainController>(
        builder:
            (controller) => TabBar(
              indicator: CustomTabIndicator(color: appColor2),
              labelColor: appColor2,
              unselectedLabelColor: itemColor4,
              controller: controller.tabController,
              onTap: (index) {},
              tabs: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Img(
                      controller.tabController!.index == 0
                          ? homeFillIcon
                          : homeBlankIcon,
                      color:
                          controller.tabController!.index == 0
                              ? appColor2
                              : itemColor4,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        'خانه',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Img(
                      controller.tabController!.index == 1
                          ? searchFillIcon
                          : searchBlankIcon,
                      color:
                          controller.tabController!.index == 1
                              ? appColor2
                              : itemColor4,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        'جستجو',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Img(
                      controller.tabController!.index == 2
                          ? categoryFillIcon
                          : categoryBlankIcon,
                      color:
                          controller.tabController!.index == 2
                              ? appColor2
                              : itemColor4,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        'دسته ها',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
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
                          controller.tabController!.index == 3
                              ? appColor2
                              : itemColor4,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        'درخواستها',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,

                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Img(
                      controller.tabController!.index == 4
                          ? userFillIcon
                          : userBlankIcon,
                      color:
                          controller.tabController!.index == 4
                              ? appColor2
                              : itemColor4,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        'پروفایل',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
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

class CustomTabIndicator extends Decoration {
  final double radius;

  final Color color;

  final double indicatorHeight;

  const CustomTabIndicator({
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
