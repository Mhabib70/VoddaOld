import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/order_controller.dart';
import 'package:vodda_old/Logic/Models/order-document.dart';
import 'package:vodda_old/Logic/Models/order.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/General/column-scroll.dart';
import 'package:vodda_old/UI/Components/Headers/back-header.dart';
import 'package:vodda_old/UI/Components/Inputs/input.dart';
import 'package:vodda_old/UI/Components/Items/document-item.dart';
import 'package:vodda_old/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_old/UI/Components/Popups/loading.dart';
import 'package:vodda_old/UI/Components/Selectors/file-picker.dart';

class OrderDocumentList extends StatelessWidget {
  Order order;
  OrderDocumentList(this.order, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BackHeader(title: 'اطلاعات تکمیلی'),
            Expanded(
              child: Loading(
                getLoadedComponent: () {
                  return ColumnScroll(
                    children: [
                      SizedBox(height: paddingSize),
                      if (order.documents != null)
                        for (var doc
                            in order.documents.values.toList().reversed)
                          DocumentItem(doc),
                      SizedBox(height: paddingSize),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton:
          order.state == 0 || order.state == 3
              ? Container()
              : Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  color: appColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: FloatingActionButton(
                  onPressed: () {
                    OrderDocument orderDocument = OrderDocument(
                      orderId: order.id,
                    );
                    showBottomModal(
                      context,
                      700,
                      Padding(
                        padding: const EdgeInsets.only(
                          left: paddingSize,
                          right: paddingSize,
                          bottom: paddingSize,
                        ),
                        child: Column(
                          children: [
                            Input(
                              lable: 'توضیحات',
                              onChange: (text) {
                                orderDocument.description = text;
                              },
                              icon1: Container(
                                child: Icon(
                                  Icons.edit_outlined,
                                  size: 20,
                                  color: itemColor4,
                                ),
                                width: 50,
                                height: 250,
                                alignment: Alignment.topCenter,
                                padding: EdgeInsets.only(top: 5),
                              ),
                              lines: 4,
                            ),
                            SizedBox(height: 20),
                            FilePicker(
                              onChange: (images) {
                                orderDocument.setFiles(images);
                              },
                            ),
                            Spacer(),
                            Btn(
                              btnType.primary,
                              text: 'ارسال',
                              onClick: () {
                                OrderController.addOrderDocument(orderDocument);
                              },
                            ),
                          ],
                        ),
                      ),
                      title: 'افزودن اطلاعات',
                    );
                  },
                  child: Icon(Icons.add, color: whiteColor, size: 30),
                ),
              ),
    );
  }
}
