import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:vodda_old/Logic/Controllers/main_controller.dart';
import 'package:vodda_old/Logic/Controllers/service_controller.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/my-scroll.dart';
import 'package:vodda_old/UI/Components/Headers/back-header.dart';
import 'package:vodda_old/UI/Components/Items/category-item.dart';
import 'package:vodda_old/UI/Components/Items/provider-item.dart';
import 'package:vodda_old/UI/Components/Items/service-item.dart';
import 'package:vodda_old/UI/Components/Lists/empty-list.dart';
import 'package:vodda_old/UI/Components/Popups/loading.dart';

// ignore: must_be_immutable
class SubList extends StatelessWidget {
  var model;
  bool isTag = false;
  SubList(this.model, {Key? key, this.isTag = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            BackHeader(title: '${model.title}'),
            Expanded(
              child: MyScroll(
                child: Container(
                  padding: EdgeInsets.only(
                    left: paddingSize,
                    right: paddingSize,
                  ),
                  child: Loading(
                    getLoadedComponent:
                        () =>
                            isTag && model.providerIds.length > 0
                                ? GetBuilder<MainController>(
                                  builder:
                                      (controller) => Column(
                                        children: [
                                          for (var providerId
                                              in model.providerIds)
                                            if (controller
                                                .tagProviders[providerId]!
                                                .hasUserCity())
                                              ProviderItem(
                                                controller
                                                    .tagProviders[providerId]!,
                                                hasSelectBtn: false,
                                              ),
                                        ],
                                      ),
                                )
                                : model.serviceIds.length > 0
                                ? GetBuilder<ServiceController>(
                                  builder:
                                      (serviceController) => Column(
                                        children: [
                                          for (var serviceId
                                              in model.serviceIds)
                                            if (serviceController
                                                .services[serviceId]!
                                                .hasUserCity())
                                              ServiceItem(
                                                serviceController
                                                    .services[serviceId]!,
                                              ),
                                        ],
                                      ),
                                )
                                : model.categories.length > 0
                                ? Column(
                                  children: [
                                    for (var category in model.categories)
                                      CategoryItem(category),
                                  ],
                                )
                                : EmptyList(emptyCategoryIcon),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
