import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:mapir_raster/mapir_raster.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/order_controller.dart';
import 'package:vodda_old/Logic/Controllers/service_controller.dart';
import 'package:vodda_old/Logic/Models/provider.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/column-scroll.dart';
import 'package:vodda_old/UI/Components/Headers/back-header.dart';
import 'package:vodda_old/UI/Components/Inputs/input.dart';
import 'package:vodda_old/UI/Components/Items/provider-item.dart';
import 'package:vodda_old/UI/Components/Lists/empty-list.dart';
import 'package:vodda_old/UI/Components/Popups/loading.dart';
import 'package:vodda_old/UI/Components/Selectors/select-provider.dart';

// ignore: must_be_immutable
class ProvidersList extends StatelessWidget {
  ProvidersList({super.key});

  OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: size.height,
          child: Column(
            children: [
              BackHeader(title: 'انتخاب متخصص', padding: paddingSize),
              GetBuilder<ServiceController>(
                builder:
                    (serviceController) => Expanded(
                      child: Loading(
                        getLoadedComponent: () {
                          return serviceController
                                      .services[orderController
                                          .order
                                          .serviceId]!
                                      .typeTime ==
                                  3
                              ? DefaultTabController(
                                length: 2,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 65,
                                      width: size.width,
                                      child: TabBar(
                                        labelColor: appColor,
                                        unselectedLabelColor: itemColor1,
                                        indicatorColor: appColor,
                                        tabs: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'لیست متخصص ها',
                                                style: AppController.fontStyle(
                                                  fontTypes.heading5,
                                                  itemColor2,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'نمایش در نقشه',
                                                style: AppController.fontStyle(
                                                  fontTypes.heading5,
                                                  itemColor2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: paddingSize,
                                                  right: paddingSize,
                                                  top: paddingSize,
                                                ),
                                                child: Input(
                                                  lable:
                                                      'جستجو در متخصص ها ...',
                                                  initValue:
                                                      OrderController
                                                          .providerText,
                                                  icon1: Icon(
                                                    Icons.search,
                                                    size: 25,
                                                    color: itemColor4,
                                                  ),
                                                  onChange: (text) {
                                                    OrderController
                                                        .providerText = text;
                                                    OrderController.findProvider(
                                                      text,
                                                    );
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: Obx(() {
                                                  return OrderController
                                                                  .seachedProviders
                                                                  .length ==
                                                              0 &&
                                                          OrderController
                                                                  .providerText ==
                                                              ''
                                                      ? OrderController
                                                                  .providers
                                                                  .length ==
                                                              0
                                                          ? EmptyList(
                                                            manualIcon,
                                                          )
                                                          : ColumnScroll(
                                                            children: [
                                                              SizedBox(
                                                                height: 30,
                                                              ),
                                                              for (Provider
                                                                  provider
                                                                  in OrderController
                                                                      .providers
                                                                      .values
                                                                      .where(
                                                                        (
                                                                          element,
                                                                        ) =>
                                                                            element.isMark!,
                                                                      ))
                                                                if (provider
                                                                    .hasUserCity())
                                                                  ProviderItem(
                                                                    provider,
                                                                  ),
                                                              for (Provider
                                                                  provider
                                                                  in OrderController
                                                                      .providers
                                                                      .values
                                                                      .where(
                                                                        (
                                                                          element,
                                                                        ) =>
                                                                            !element.isMark!,
                                                                      ))
                                                                if (provider
                                                                    .hasUserCity())
                                                                  ProviderItem(
                                                                    provider,
                                                                  ),
                                                            ],
                                                          )
                                                      : ColumnScroll(
                                                        children: [
                                                          SizedBox(height: 30),
                                                          for (Provider provider
                                                              in OrderController
                                                                  .seachedProviders
                                                                  .value
                                                                  .where(
                                                                    (element) =>
                                                                        element
                                                                            .isMark!,
                                                                  ))
                                                            if (provider
                                                                .hasUserCity())
                                                              ProviderItem(
                                                                provider,
                                                              ),
                                                          for (Provider provider
                                                              in OrderController
                                                                  .seachedProviders
                                                                  .value
                                                                  .where(
                                                                    (element) =>
                                                                        !element
                                                                            .isMark!,
                                                                  ))
                                                            if (provider
                                                                .hasUserCity())
                                                              ProviderItem(
                                                                provider,
                                                              ),
                                                        ],
                                                      );
                                                }),
                                              ),
                                            ],
                                          ),
                                          SelectProviderAddress(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              : Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: paddingSize,
                                      right: paddingSize,
                                      top: paddingSize,
                                    ),
                                    child: Input(
                                      lable: 'جستجو در متخصص ها ...',
                                      initValue: OrderController.providerText,
                                      icon1: Icon(
                                        Icons.search,
                                        size: 25,
                                        color: itemColor4,
                                      ),
                                      onChange: (text) {
                                        OrderController.providerText = text;
                                        OrderController.findProvider(text);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Obx(() {
                                      return OrderController
                                                      .seachedProviders
                                                      .length ==
                                                  0 &&
                                              OrderController.providerText == ''
                                          ? OrderController.providers.length ==
                                                  0
                                              ? EmptyList(manualIcon)
                                              : ColumnScroll(
                                                children: [
                                                  SizedBox(height: 30),
                                                  for (Provider provider
                                                      in OrderController
                                                          .providers
                                                          .values
                                                          .where(
                                                            (element) =>
                                                                element.isMark!,
                                                          ))
                                                    if (provider.hasUserCity())
                                                      ProviderItem(provider),
                                                  for (Provider provider
                                                      in OrderController
                                                          .providers
                                                          .values
                                                          .where(
                                                            (element) =>
                                                                !element
                                                                    .isMark!,
                                                          ))
                                                    if (provider.hasUserCity())
                                                      ProviderItem(provider),
                                                ],
                                              )
                                          : ColumnScroll(
                                            children: [
                                              SizedBox(height: 30),
                                              for (Provider provider
                                                  in OrderController
                                                      .seachedProviders
                                                      .value
                                                      .where(
                                                        (element) =>
                                                            element.isMark!,
                                                      ))
                                                if (provider.hasUserCity())
                                                  ProviderItem(provider),
                                              for (Provider provider
                                                  in OrderController
                                                      .seachedProviders
                                                      .value
                                                      .where(
                                                        (element) =>
                                                            !element.isMark!,
                                                      ))
                                                if (provider.hasUserCity())
                                                  ProviderItem(provider),
                                            ],
                                          );
                                    }),
                                  ),
                                ],
                              );
                        },
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
