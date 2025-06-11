import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/main-controller.dart';
import 'package:vodda_old/Logic/Controllers/order-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Logic/Models/link-menu.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn-with-icon.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/General/my-scroll.dart';
import 'package:vodda_old/UI/Components/General/myDivider.dart';
import 'package:vodda_old/UI/Components/Items/drawer-item.dart';
import 'package:vodda_old/UI/Components/Items/icon-item.dart';
import 'package:vodda_old/UI/Components/Items/menu-item.dart';
import 'package:vodda_old/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_old/UI/Components/Popups/loading.dart';
import 'package:vodda_old/UI/Views/Order/my-orders.dart';
import 'package:vodda_old/UI/Views/Question/frequently-questions.dart';
import 'package:vodda_old/UI/Views/User/address-list.dart';
import 'package:vodda_old/UI/Views/User/city-list.dart';
import 'package:vodda_old/UI/Views/User/edit-profile.dart';
import 'package:vodda_old/UI/Views/User/favorites-list.dart';
import 'package:vodda_old/UI/Views/User/login.dart';
import 'package:vodda_old/UI/Views/User/payments.dart';
import 'package:vodda_old/UI/Views/User/text-page.dart';
import 'package:vodda_old/UI/Views/User/wallet-list.dart';
import 'package:vodda_old/UI/Views/User/wallet.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: Obx(() {
        return UserController.user.value.id != null
            ? MyScroll(
              child: Container(
                padding: EdgeInsets.only(left: paddingSize, right: paddingSize),
                child: Column(
                  children: [
                    Container(
                      width: maxItemWidth,
                      padding: EdgeInsets.only(bottom: 30, top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              InkWell(
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
                                                MainAxisAlignment.spaceBetween,
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
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: appColor.withOpacity(0.2),
                                  ),
                                  child: Loading(
                                    getLoadedComponent:
                                        () =>
                                            UserController.user.value.avatar !=
                                                    null
                                                ? Img(
                                                  UserController
                                                      .user
                                                      .value
                                                      .avatar!,
                                                  width: 80,
                                                  height: 80,
                                                  radius: 100,
                                                  isNetwork: true,
                                                )
                                                : Img(
                                                  userIcon,
                                                  color: appColor,
                                                  width: 30,
                                                  height: 40,
                                                ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 25),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${UserController.user.value.fname ?? ''} ${UserController.user.value.lname ?? ''}',
                                    style: AppController.fontStyle(
                                      fontTypes.heading3,
                                      itemColor1,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  // Text('${UserController.user.value.mobile??''}',style: AppController.fontStyle(fontTypes.heading5, itemColor4),textDirection: TextDirection.ltr,),
                                  Row(
                                    children: [
                                      Img(diamondIcon, color: appColor),
                                      SizedBox(width: 5),
                                      Text(
                                        '${UserController.user.value.score} امتیاز',
                                        style: AppController.fontStyle(
                                          fontTypes.heading4,
                                          appColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'کد معرف: ${UserController.user.value.code}',
                                    style: AppController.fontStyle(
                                      fontTypes.heading5,
                                      itemColor4,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Btn(btnType.mini,width: 130,height:30 ,text: 'ویرایش پروفایل',onClick: (){
                          //   Navigator.push(context, MaterialPageRoute(builder: (builder)=>EditProfile()));
                          // },)
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      width: maxItemWidth,
                      height: 120,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        boxShadow: shadow,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconItem(
                            payIcon,
                            'تعداد سفارشات:',
                            '${UserController.user.value.orderCount ?? ''}',
                          ),
                          IconItem(
                            progressIcon,
                            'در حال انجام :',
                            '${UserController.user.value.orderProgressCount ?? ''}',
                          ),
                          IconItem(
                            doneIcon,
                            'انجام شده :',
                            '${UserController.user.value.orderDoneCount ?? ""}',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ListMenuItem(
                      editProfileIcon,
                      'ویرایش مشخصات حساب کاربری',
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => EditProfile(),
                          ),
                        );
                      },
                    ),
                    MyDivider(),
                    ListMenuItem(
                      heartIcon,
                      'لیست علاقه مندی ها',
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => FavoritesList(),
                          ),
                        );
                      },
                    ),
                    MyDivider(),
                    ListMenuItem(
                      locationIcon,
                      'لیست آدرس های من',
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => AddressList(),
                          ),
                        );
                      },
                    ),
                    MyDivider(),
                    ListMenuItem(
                      locationIcon,
                      'لیست شهر های من',
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (builder) => CityList()),
                        );
                      },
                    ),
                    MyDivider(),
                    // ListMenuItem(cityIcon,'لیست شهرهای من',onClick: (){
                    //   Navigator.push(context, MaterialPageRoute(builder: (builder)=>CityList()));
                    // },),
                    // ListMenuItem(wrenchIcon,'لیست سفارشات من',onClick: (){
                    //   OrderController.getMyOrders(tabIndex: 1,refresh: true);
                    //   Navigator.push(context, MaterialPageRoute(builder: (builder)=>MyOrders()));
                    // },),
                    // MyDivider(),
                    // ListMenuItem(transactionIcon,'پرداخت ها و تراکنش ها',onClick: (){
                    //   UserController.getPayList(true);
                    //   Navigator.push(context, MaterialPageRoute(builder: (builder)=>Wallet()));
                    // },),
                    ListMenuItem(
                      walletIcon,
                      'کیف پول',
                      onClick: () {
                        UserController.getWalletList(true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (builder) => WalletList()),
                        );
                      },
                    ),
                    MyDivider(),
                    ListMenuItem(
                      transactionIcon,
                      'پرداخت ها و تراکنش ها',
                      onClick: () {
                        UserController.getPayList(true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (builder) => Payments()),
                        );
                      },
                    ),
                    MyDivider(),
                    for (LinkMenu link in MainController.sidebarLinks)
                      Column(
                        children: [
                          ListMenuItem(
                            link.icon!,
                            link.title ?? '',
                            isNetwork: true,
                            onClick: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => TextPage(link),
                                ),
                              );
                            },
                          ),
                          MyDivider(),
                        ],
                      ),
                    ListMenuItem(
                      callDrawerIcon,
                      'تماس با پشتیبانی',
                      onClick: () {
                        launchUrlString(
                          "tel:${MainController.setting['help_number']}",
                        );
                      },
                    ),
                    MyDivider(),
                    // ListMenuItem(smsIcon, 'چت با پشتیبانی',onClick: (){
                    //   launchUrlString("https://goftino.com/c/Vpq2bC");}
                    //
                    //   ),MyDivider(),
                    ListMenuItem(
                      questionIcon,
                      'سوالات متداول',
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => FrequentlyQuestions(),
                          ),
                        );
                      },
                    ),
                    MyDivider(),
                    ListMenuItem(
                      shareIcon,
                      'دعوت از دوستان',
                      onClick: () {
                        Share.share(baseUrl, subject: appTitle);
                      },
                    ),
                    MyDivider(),
                    ListMenuItem(
                      logoutDrawerIcon,
                      'خروج از حساب کاربری',
                      onClick: () {
                        UserController.logout();
                      },
                    ),
                    MyDivider(),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            )
            : Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Img(userIcon, width: 113, height: 145, color: appColor),
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: maxItemWidth,
                    child: Text(
                      'ورود به حساب کاربری',
                      style: AppController.fontStyle(
                        fontTypes.bold24,
                        itemColor1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 300,
                    child: Text(
                      ' جهت دسترسی به این قسمت لازم است ثبت نام کنید یا وارد حساب کاربری شوید :',
                      textAlign: TextAlign.center,
                      style: AppController.fontStyle(
                        fontTypes.light14,
                        itemColor2,
                      ),
                      maxLines: null,
                    ),
                  ),
                  SizedBox(height: 55),
                  Btn(
                    btnType.primary,
                    text: 'ثبت نام / ورود',
                    width: 200,
                    fontType: fontTypes.bold18,
                    onClick: () {
                      Get.to(Login());
                    },
                  ),
                ],
              ),
            );
      }),
    );
  }
}
