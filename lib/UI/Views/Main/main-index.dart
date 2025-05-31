import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/main-controller.dart';
import 'package:vodda_old/Logic/Controllers/notification-controller.dart';
import 'package:vodda_old/Logic/Controllers/order-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Headers/main-header.dart';
import 'package:vodda_old/UI/Components/Lists/drawer-menu.dart';
import 'package:vodda_old/UI/Components/Lists/tab-menu.dart';
import 'package:vodda_old/UI/Views/Main/categories.dart';
import 'package:vodda_old/UI/Views/Main/home.dart';
import 'package:vodda_old/UI/Views/Main/profile.dart';
import 'package:vodda_old/UI/Views/Main/search.dart';
import 'package:vodda_old/UI/Views/Order/my-orders.dart';
import 'package:vodda_old/UI/Views/User/edit-profile.dart';
import 'package:vodda_old/UI/Views/User/favorites-list.dart';
import 'package:vodda_old/UI/Views/User/login.dart';

class MainIndex extends StatefulWidget {
  MainIndex({Key? key}) : super(key: key);

  @override
  State<MainIndex> createState() => _MainIndexState();
}

class _MainIndexState extends State<MainIndex>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    MainController.tabController = new TabController(vsync: this, length: 5);
    MainController.tabController!.addListener(() {
      setState(() {});
      if (MainController.tabController!.index == 3)
        OrderController.getMyOrders(tabIndex: 1, refresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: backgroundColor,
      drawer: DrawerMenu(),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
        child: Container(
          alignment: Alignment.center,
          width: size.width,
          height: size.height,
          child: DefaultTabController(
            length: 5,
            child: Column(
              children: [
                MainHeader(
                  openDrawer: () {
                    scaffoldKey.currentState!.openDrawer();
                  },
                ),
                Expanded(
                  child: TabBarView(
                    controller: MainController.tabController,
                    children: [
                      Home(),
                      Search(),
                      Categories(),
                      MyOrders(),
                      Profile(),
                    ],
                  ),
                ),
                size.width > maxItemWidth ? Container() : TabMenu(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
