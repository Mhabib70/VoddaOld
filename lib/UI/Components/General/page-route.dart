import 'package:flutter/cupertino.dart';
import 'package:vodda_old/UI/Views/Main/main-index.dart';

class MainPageRoute extends CupertinoPageRoute {
  MainPageRoute() : super(builder: (BuildContext context) => MainIndex());

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return FadeTransition(opacity: animation, child: MainIndex());
  }
}
