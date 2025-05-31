import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/order-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Logic/Models/address.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/Buttons/radio-btn.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/General/myDivider.dart';
import 'package:vodda_old/UI/Components/Inputs/input.dart';
import 'package:vodda_old/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_old/UI/Components/Selectors/select-box.dart';
import 'package:vodda_old/UI/Views/User/new-address.dart';

class QuestionAddress extends StatelessWidget {
  QuestionAddress({Key? key}) : super(key: key);
  OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: paddingSize, right: paddingSize),
        width: maxItemWidth,
        child: Column(
          children: [
            Obx(() {
              return Column(
                children: [
                  for (Address address in UserController.addresses.value.values)
                    RadioBtn(
                      orderController.addressId.value,
                      address.id,
                      lable: '${address.title}',
                      description: '${address.fullAddress}',
                      onClick: () {
                        orderController.addressId.value = address.id!;
                        orderController.order.addressId = address.id!;
                      },
                    ),
                  SizedBox(height: 20),
                ],
              );
            }),
            SizedBox(height: 30),
            MyDivider(),
            SizedBox(height: 15),
            Container(
              width: maxItemWidth,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (builder) => NewAddress()),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.add_circle_outline, size: 25, color: itemColor4),
                    SizedBox(width: 10),
                    Text(
                      'افزودن آدرس جدید',
                      style: AppController.fontStyle(
                        fontTypes.heading4,
                        itemColor3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
