import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/order_controller.dart';
import 'package:vodda_old/Logic/Controllers/service_controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Logic/Models/address.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/Buttons/radio-btn.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/General/my-scroll.dart';
import 'package:vodda_old/UI/Components/General/myDivider.dart';
import 'package:vodda_old/UI/Components/Headers/back-header.dart';
import 'package:vodda_old/UI/Components/Inputs/input.dart';
import 'package:vodda_old/UI/Components/Items/category-item.dart';
import 'package:vodda_old/UI/Components/Items/service-item.dart';
import 'package:vodda_old/UI/Components/Lists/empty-list.dart';
import 'package:vodda_old/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_old/UI/Components/Popups/loading.dart';
import 'package:vodda_old/UI/Components/Selectors/select-box.dart';
import 'package:vodda_old/UI/Views/User/new-address.dart';

class AddressList extends StatelessWidget {
  const AddressList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          BackHeader(title: 'لیست آدرس ها'),
          Expanded(
            child: MyScroll(
              child: Container(
                padding: EdgeInsets.only(left: paddingSize, right: paddingSize),
                width: size.width,
                child: Obx(
                  () => Column(
                    children: [
                      Column(
                        children: [
                          for (Address address
                              in UserController.addresses.value.values)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        address.title ?? '',
                                        style: AppController.fontStyle(
                                          fontTypes.heading3,
                                          itemColor1,
                                        ),
                                        maxLines: null,
                                      ),
                                      Text(
                                        address.fullAddress!,
                                        style: AppController.fontStyle(
                                          fontTypes.heading5,
                                          itemColor4,
                                        ),
                                        maxLines: null,
                                      ),
                                    ],
                                  ),
                                ),

                                InkWell(
                                  onTap: () {
                                    UserController.deleteAddress(address.id!);
                                  },
                                  child: Icon(
                                    Icons.clear,
                                    size: 20,
                                    color: itemColor4,
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(height: 20),
                        ],
                      ),
                      SizedBox(height: 30),
                      MyDivider(),
                      SizedBox(height: 15),
                      Container(
                        width: maxItemWidth,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => NewAddress(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                size: 25,
                                color: itemColor4,
                              ),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
