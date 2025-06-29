import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/main_controller.dart';
import 'package:vodda_old/Logic/Controllers/order_controller.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/Headers/main-header.dart';
import 'package:vodda_old/UI/Components/Lists/drawer-menu.dart';
import 'package:vodda_old/UI/Components/Lists/tab-menu.dart';
import 'package:vodda_old/UI/Components/Popups/alert-dialog.dart';
import 'package:vodda_old/UI/Views/Main/categories.dart';
import 'package:vodda_old/UI/Views/Main/home.dart';
import 'package:vodda_old/UI/Views/Main/profile.dart';
import 'package:vodda_old/UI/Views/Main/search.dart';
import 'package:vodda_old/UI/Views/Order/my-orders.dart';

class MainIndex extends StatefulWidget {
  MainIndex({Key? key}) : super(key: key);

  @override
  State<MainIndex> createState() => _MainIndexState();
}

class _MainIndexState extends State<MainIndex>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Get.find<MainController>().tabController = TabController(
      vsync: this,
      length: 5,
    );
    Get.find<MainController>().tabController!.addListener(() {
      setState(() {});
      if (Get.find<MainController>().tabController!.index == 3) {
        OrderController.getMyOrders(tabIndex: 1, refresh: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        showAlertDialog(
          context,
          title: 'خروج از برنامه',
          child: Column(
            children: [
              Text(
                'آیا قصد خروج از برنامه را دارید؟',
                style: AppController.fontStyle(fontTypes.heading5, itemColor1),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Btn(
                    btnType.primary,
                    text: 'بله',
                    width: 80,
                    height: 40,
                    onClick: () async {
                      SystemNavigator.pop();
                    },
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 80,
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(
                        'خیر',
                        style: AppController.fontStyle(
                          fontTypes.heading5,
                          itemColor1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  // Btn(btnType.secondary,text: 'خیر',width: 80,height: 40,onClick: (){
                  //   Navigator.pop(context);
                  // },),
                ],
              ),
            ],
          ),
        );
        return true;
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: backgroundColor,
        drawer: DrawerMenu(),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(
            parent: NeverScrollableScrollPhysics(),
          ),
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
                    child: GetBuilder<MainController>(
                      builder:
                          (controller) => TabBarView(
                            controller: controller.tabController,
                            children: [
                              Home(),
                              Search(),
                              Categories(),
                              MyOrders(),
                              Profile(),
                            ],
                          ),
                    ),
                  ),
                  size.width > maxItemWidth ? Container() : TabMenu(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
