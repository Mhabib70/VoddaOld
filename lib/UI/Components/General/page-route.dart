import 'package:flutter/cupertino.dart';
import 'package:vodda_old/UI/Views/Main/main-index.dart';

class MainPageRoute extends CupertinoPageRoute {
  MainPageRoute() : super(builder: (BuildContext context) => new MainIndex());

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return new FadeTransition(opacity: animation, child: new MainIndex());
  }
}
