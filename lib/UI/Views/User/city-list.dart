import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/main-controller.dart';
import 'package:vodda_old/Logic/Controllers/order-controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Logic/Models/address.dart';
import 'package:vodda_old/Logic/Models/city.dart';
import 'package:vodda_old/Logic/Models/user-city.dart';
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

class CityList extends StatelessWidget {
  const CityList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          BackHeader(title: 'لیست شهر ها'),
          Expanded(
            child: MyScroll(
              child: Container(
                padding: EdgeInsets.only(left: paddingSize, right: paddingSize),
                width: size.width,
                child: Loading(
                  getLoadedComponent:
                      () => Column(
                        children: [
                          Column(
                            children: [
                              for (UserCity userCity
                                  in UserController.userCities.values)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            userCity.city.name ?? '',
                                            style: AppController.fontStyle(
                                              fontTypes.heading3,
                                              itemColor1,
                                            ),
                                            maxLines: null,
                                          ),
                                          Text(
                                            userCity.province.name ?? '',
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
                                        UserController.deleteCity(userCity);
                                      },
                                      child: Icon(
                                        Icons.clear,
                                        size: 25,
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
                                UserCity newUserCity = UserCity();
                                showBottomModal(
                                  Get.context!,
                                  450,
                                  Column(
                                    children: [
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(height: 15),
                                              Text(
                                                'افزودن شهر جدید',
                                                style: AppController.fontStyle(
                                                  fontTypes.heading3,
                                                  itemColor2,
                                                ),
                                              ),
                                              SizedBox(height: 30),

                                              SelectBox(
                                                text: 'انتخاب استان',
                                                onSelect: (value) {
                                                  newUserCity.cityId = null;
                                                  MainController.cities.value =
                                                      [];
                                                  newUserCity.provinceId =
                                                      value;
                                                  MainController.cities.value =
                                                      MainController
                                                          .provinces[value]!
                                                          .cities
                                                          .values
                                                          .toList();
                                                },
                                                options: {
                                                  for (var provinceID
                                                      in MainController
                                                          .provinces
                                                          .keys)
                                                    MainController
                                                        .provinces[provinceID]!
                                                        .name: provinceID,
                                                },
                                                icon: Img(locationIcon),
                                                value: newUserCity.provinceId,
                                              ),
                                              SizedBox(height: 15),
                                              Obx(() {
                                                return SelectBox(
                                                  text: 'انتخاب شهر',
                                                  onSelect: (value) {
                                                    newUserCity.cityId = value;
                                                  },
                                                  options:
                                                      MainController
                                                                      .cities
                                                                      .value
                                                                      .length >
                                                                  0 &&
                                                              newUserCity
                                                                      .provinceId !=
                                                                  null
                                                          ? {
                                                            for (var city
                                                                in MainController
                                                                    .cities
                                                                    .value)
                                                              city.name:
                                                                  city.id,
                                                          }
                                                          : <
                                                            dynamic,
                                                            dynamic
                                                          >{},
                                                  icon: Img(cityIcon),
                                                  value: newUserCity.cityId,
                                                );
                                              }),
                                              SizedBox(height: 30),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          bottom: paddingSize,
                                        ),
                                        child: Btn(
                                          btnType.primary,
                                          text: 'ذخیره تغییرات',
                                          onClick: () {
                                            if (newUserCity.cityId != null &&
                                                newUserCity.provinceId !=
                                                    null) {
                                              Navigator.pop(Get.context!);
                                              newUserCity.setModels();
                                              UserController.addCity(
                                                newUserCity,
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ],
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
                                    'افزودن شهر جدید',
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
