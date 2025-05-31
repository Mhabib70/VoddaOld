import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Logic/Models/order.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/General/my-scroll.dart';
import 'package:vodda_old/UI/Components/Items/order-item.dart';
import 'package:vodda_old/UI/Components/Lists/empty-list.dart';

class OrderList extends StatelessWidget {
  List<Order> orders;
  OrderList(this.orders, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return orders.length == 0
        ? EmptyList(transactionIcon)
        : MyScroll(
          child: Column(
            children: [
              SizedBox(height: 30),
              for (var order in orders) OrderItem(order),
            ],
          ),
        );
  }
}
