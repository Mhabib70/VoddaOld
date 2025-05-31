import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/order-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/column-scroll.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/General/myDivider.dart';
import 'package:vodda_old/UI/Components/Headers/back-header.dart';
import 'package:vodda_old/UI/Components/Items/order-item.dart';
import 'package:vodda_old/UI/Components/Lists/empty-list.dart';
import 'package:vodda_old/UI/Components/Lists/order-list.dart';
import 'package:vodda_old/UI/Components/Popups/loading.dart';
import 'package:vodda_old/UI/Views/Order/order-index.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return
    // Scaffold(
    //   backgroundColor: backgroundColor,
    //   body:
    Container(
      alignment: Alignment.center,
      // width: size.width,
      // height: size.height,
      child: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            // BackHeader(title: 'لیست سفارشات'),
            Container(
              height: 50,
              width: maxItemWidth,
              alignment: Alignment.centerRight,
              child: TabBar(
                labelColor: itemColor1,
                unselectedLabelColor: itemColor3,
                indicatorWeight: 3,
                indicatorColor: appColor,
                onTap: (index) {
                  OrderController.getMyOrders(
                    tabIndex: index + 1,
                    refresh: false,
                  );
                },
                tabs: [
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      'در حال انتظار',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      'در حال انجام',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      'انجام شده',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      ' لغو شده',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: MyDivider(padding: paddingSize),
              width: maxItemWidth,
            ),
            Obx(() {
              var orders = OrderController.myOrders.value;
              return Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    ColumnScroll(
                      loadingTag: 'orderTab1',
                      getLoadedWidgets:
                          () => Column(
                            children: [
                              for (var order
                                  in OrderController.myOrders.value.values
                                      .where((order) => order.state == 1)
                                      .toList())
                                OrderItem(order),
                            ],
                          ),
                      onEndScroll: () {
                        OrderController.getMyOrders(
                          tabIndex: 1,
                          refresh: false,
                        );
                      },
                      emptyList: EmptyList(transactionIcon),
                      checkEmptyList:
                          () =>
                              OrderController.myOrders.value.values
                                  .where((order) => order.state == 1)
                                  .toList()
                                  .length ==
                              0,
                    ),
                    ColumnScroll(
                      loadingTag: 'orderTab2',
                      getLoadedWidgets:
                          () => Column(
                            children: [
                              for (var order
                                  in OrderController.myOrders.value.values
                                      .where((order) => order.state == 2)
                                      .toList())
                                OrderItem(order),
                            ],
                          ),
                      onEndScroll: () {
                        OrderController.getMyOrders(
                          tabIndex: 2,
                          refresh: false,
                        );
                      },
                      emptyList: EmptyList(transactionIcon),
                      checkEmptyList:
                          () =>
                              OrderController.myOrders.value.values
                                  .where((order) => order.state == 2)
                                  .toList()
                                  .length ==
                              0,
                    ),
                    ColumnScroll(
                      loadingTag: 'orderTab3',
                      getLoadedWidgets:
                          () => Column(
                            children: [
                              for (var order
                                  in OrderController.myOrders.value.values
                                      .where((order) => order.state == 3)
                                      .toList())
                                OrderItem(order),
                            ],
                          ),
                      onEndScroll: () {
                        OrderController.getMyOrders(
                          tabIndex: 3,
                          refresh: false,
                        );
                      },
                      emptyList: EmptyList(transactionIcon),
                      checkEmptyList:
                          () =>
                              OrderController.myOrders.value.values
                                  .where((order) => order.state == 3)
                                  .toList()
                                  .length ==
                              0,
                    ),
                    ColumnScroll(
                      loadingTag: 'orderTab4',
                      getLoadedWidgets:
                          () => Column(
                            children: [
                              for (var order
                                  in OrderController.myOrders.value.values
                                      .where(
                                        (order) =>
                                            order.state == 0 ||
                                            order.state == 4,
                                      )
                                      .toList())
                                OrderItem(order),
                            ],
                          ),
                      onEndScroll: () {
                        OrderController.getMyOrders(
                          tabIndex: 4,
                          refresh: false,
                        );
                      },
                      emptyList: EmptyList(transactionIcon),
                      checkEmptyList:
                          () =>
                              OrderController.myOrders.value.values
                                  .where(
                                    (order) =>
                                        order.state == 0 || order.state == 4,
                                  )
                                  .toList()
                                  .length ==
                              0,
                    ),
                    // OrderList(OrderController.myOrders.value.values.where((order) => order.state==1).toList()),
                    // OrderList(OrderController.myOrders.value.values.where((order) => order.state==2).toList()),
                    // OrderList(OrderController.myOrders.value.values.where((order) => order.state==3).toList()),
                    // OrderList(OrderController.myOrders.value.values.where((order) => order.state==0 || order.state==4).toList()),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    )
    // )
    ;
  }
}
