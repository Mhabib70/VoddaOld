import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/order-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn-with-icon.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/General/my-scroll.dart';
import 'package:vodda_old/UI/Components/Headers/back-header.dart';
import 'package:vodda_old/UI/Components/Headers/main-header.dart';
import 'package:vodda_old/UI/Components/Inputs/input.dart';
import 'package:vodda_old/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_old/UI/Components/Popups/loading.dart';
import 'package:vodda_old/UI/Components/Selectors/radio-group.dart';
import 'package:vodda_old/UI/Components/Selectors/select-box.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
        child: Container(
          alignment: Alignment.center,
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Column(
                children: [
                  BackHeader(title: 'اطلاعات کاربر'),
                  Expanded(
                    child: MyScroll(
                      child: Container(
                        width: size.width,
                        padding: EdgeInsets.only(
                          left: paddingSize,
                          right: paddingSize,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            Container(
                              height: 150,
                              width: 150,
                              child: Loading(
                                getLoadedComponent:
                                    () => InkWell(
                                      onTap: () {
                                        showBottomModal(
                                          context,
                                          340,
                                          Column(
                                            children: [
                                              SizedBox(height: 50),
                                              Container(
                                                width: maxItemWidth,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    BtnIcon(
                                                      icon: Img(
                                                        folderIcon,
                                                        width: 30,
                                                        height: 30,
                                                        color: appColor,
                                                      ),
                                                      text: 'انتخاب از گالری',
                                                      onclick: () {
                                                        Navigator.pop(context);
                                                        UserController.chooseProfile(
                                                          ImageSource.gallery,
                                                        );
                                                      },
                                                    ),
                                                    BtnIcon(
                                                      icon: Img(
                                                        cameraIcon,
                                                        width: 30,
                                                        height: 30,
                                                        color: appColor,
                                                      ),
                                                      text: 'بازکردن دوربین',
                                                      onclick: () {
                                                        Navigator.pop(context);
                                                        UserController.chooseProfile(
                                                          ImageSource.camera,
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child:
                                          UserController.user.value.avatar !=
                                                  null
                                              ? Img(
                                                UserController
                                                    .user
                                                    .value
                                                    .avatar!,
                                                width: 150,
                                                height: 150,
                                                isNetwork: true,
                                                radius: 150,
                                              )
                                              : Stack(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            150,
                                                          ),
                                                      color: appColor
                                                          .withOpacity(0.2),
                                                    ),
                                                    child: Img(
                                                      userIcon,
                                                      color: appColor,
                                                      width: 60,
                                                      height: 75,
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 0,
                                                    right: 0,
                                                    child: Container(
                                                      width: 45,
                                                      height: 45,
                                                      decoration: BoxDecoration(
                                                        color: appColor,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              50,
                                                            ),
                                                      ),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: whiteColor,
                                                        size: 30,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                    ),
                              ),
                            ),
                            SizedBox(height: 50),
                            // Container(
                            //   width: maxItemWidth,
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            Input(
                              lable: 'نام',
                              // isHalf: true,
                              icon1: Icon(
                                Icons.edit_outlined,
                                size: 20,
                                color: itemColor4,
                              ),
                              initValue: UserController.user.value.fname,
                              onChange: (text) {
                                UserController.user.value.fname = text;
                              },
                            ),
                            SizedBox(height: 20),
                            Input(
                              lable: 'نام خانوادگی',
                              // isHalf: true,
                              icon1: Icon(
                                Icons.edit_outlined,
                                size: 20,
                                color: itemColor4,
                              ),
                              initValue: UserController.user.value.lname,
                              onChange: (text) {
                                UserController.user.value.lname = text;
                              },
                            ),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(height: 20),
                            UserController.user.value.isCompleted == true
                                ? Container()
                                : Input(
                                  lable: 'کد معرف',
                                  initValue:
                                      UserController.user.value.inviteCode,
                                  icon1: Icon(
                                    Icons.edit_outlined,
                                    size: 20,
                                    color: itemColor4,
                                  ),
                                  onChange: (text) {
                                    UserController.user.value.inviteCode = text;
                                  },
                                ),
                            SizedBox(height: 20),

                            // Container(
                            //     width: maxItemWidth,
                            //     alignment: Alignment.centerRight,
                            //     child: Text('آدرس محل سکونت (جهت دریافت خدمات) :',style: AppController.fontStyle(fontType.heading5, itemColor2),)),
                            // SizedBox(height: 15,),
                            // SelectBox(text: 'انتخاب استان',onSelect: (value){
                            //   UserController.user.value.address.provinceId=value;
                            //   AppController.cities.value=AppController.provinces[value]!.cities;
                            // },options: {
                            //   for(var provinceID in AppController.provinces.keys)
                            //     AppController.provinces[provinceID]!.name:provinceID
                            // },icon: Img(locationIcon),value: UserController.user.value.address.provinceId,),
                            // SizedBox(height: 15,),
                            // Obx(
                            //         () {
                            // return SelectBox(text: 'انتخاب شهر',onSelect: (value){
                            //         UserController.user.value.address.cityId=value;
                            //       },options:AppController.cities.value.length>0  &&  UserController.user.value.address.provinceId!=null?{
                            //         for(var city in AppController.cities.value)
                            //           city.name:city.id
                            //       }:<dynamic,dynamic>{},icon: Img(cityIcon),value: UserController.user.value.address.cityId,);
                            //     }
                            // ),
                            // SizedBox(height: 15,),
                            // Input(lable: 'خیابان / کوچه / پلاک ...',initValue:UserController.user.value.address.place,icon1:Icon(Icons.my_location,size: 20,color: itemColor4),onChange: (text){
                            //   UserController.user.value.address.place=text;
                            // },),
                            // SizedBox(height: 30,),
                            Container(
                              width: maxItemWidth,
                              alignment: Alignment.centerRight,
                              child: Text(
                                'جنسیت :',
                                style: AppController.fontStyle(
                                  fontTypes.heading5,
                                  itemColor2,
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            RadioGroup(
                              UserController.user.value.sex,
                              {'آقا': 1, 'خانم': 0},
                              onChange: (value) {
                                UserController.user.value.sex = value;
                              },
                            ),
                            SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: paddingSize,
                      right: paddingSize,
                    ),
                    child: Btn(
                      btnType.primary,
                      text: 'ذخیره تغییرات',
                      onClick: () {
                        UserController.editUser();
                      },
                    ),
                  ),
                  SizedBox(height: paddingSize),
                ],
              ),
              Loading(),
            ],
          ),
        ),
      ),
    );
  }
}
