// import 'dart:nativewrappers/_internal/vm/lib/async_patch.dart';

import 'dart:async';

import 'package:flutter/foundation.dart' as web;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/service_controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Logic/Helpers/api-methods.dart';
import 'package:vodda_old/Logic/Models/advertise.dart';
import 'package:vodda_old/Logic/Models/category.dart';
import 'package:vodda_old/Logic/Models/city.dart';
import 'package:vodda_old/Logic/Models/link-menu.dart';
import 'package:vodda_old/Logic/Models/provider.dart';
import 'package:vodda_old/Logic/Models/province.dart';
import 'package:vodda_old/Logic/Models/service.dart';
import 'package:vodda_old/Logic/Models/app-version.dart';
import 'package:vodda_old/Public/api-urls.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/General/page-route.dart';
import 'package:vodda_old/UI/Components/Popups/alert-dialog.dart';
import 'package:vodda_old/UI/Views/Main/sub-list.dart';
import 'package:vodda_old/UI/Views/Order/service-index.dart';
import 'package:vodda_old/UI/Views/User/login.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MainController extends GetxController {
  Map<String, dynamic> setting = <String, dynamic>{};
  List<LinkMenu> sidebarLinks = [];
  List<Advertise> ads = [];
  List<String> mainSlider = [];
  Map<int, Province> provinces = <int, Province>{};
  RxList<City> cities = <City>[].obs;

  TabController? tabController;

  Map<int, Provider> tagProviders = <int, Provider>{};

  AppVersion? newVersion;

  Future<void> getInitData() async {
    AppController.isLoading.value = true;

    getMainInfo();
    Get.find<UserController>().getUserInfo();
    // UserController.getUserInfo();
    Get.find<ServiceController>().getTagInfo();
    // await ServiceController.getTagInfo();

    Get.find<UserController>().getMyLocation();

    Get.find<ServiceController>().getSearchedServices('');
    Timer(Duration(seconds: 3), () {
      firstPageRoute();
    });

    if (newVersion != null && !web.kIsWeb) {
      showAlertDialog(
        Get.context!,
        title: ' بروزرسانی ${newVersion!.required ? 'الزامی' : ''}',
        child: Column(
          children: [
            Text(
              '${newVersion!.text}',
              style: AppController.fontStyle(fontTypes.heading5, itemColor1),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Btn(
                  btnType.primary,
                  text: 'دانلود',
                  width: 80,
                  height: 40,
                  onClick: () async {
                    await launchUrlString(
                      newVersion!.link!,
                      mode: LaunchMode.externalApplication,
                    );
                    Navigator.pop(Get.context!);
                  },
                ),
                Btn(
                  btnType.secondary,
                  text: 'بستن',
                  width: 80,
                  height: 40,
                  onClick: () {
                    Navigator.pop(Get.context!);
                  },
                ),
              ],
            ),
          ],
        ),
        onClose: () {
          if (newVersion!.required) SystemNavigator.pop();
        },
      );
    }
    AppController.isLoading.value = false;
  }

  Future<void> getMainInfo() async {
    var response = await RestApi.get(mainInfoUrl);

    RestApi.responseHandler(
      response: response,
      successCallback: () async {
        for (var json in response!.data['data']['versions']) {
          if (json['name'] == 'service') {
            PackageInfo packageInfo = await PackageInfo.fromPlatform();
            String currentVersion = packageInfo.version;
            String lastVersion = json['version'];
            print('curretVersion>>> $currentVersion');
            print('lastVersion>>> $lastVersion');
            if (currentVersion != lastVersion) {
              newVersion = AppVersion.fromJson(json);
            }
          }
        }
        provinces = <int, Province>{};
        for (var provinceJson in response.data['data']['provinces']) {
          Province province = Province.fromJson(provinceJson);
          provinces[province.id!] = province;
        }
        setting = response.data['data']['setting'];
        print('asdadaf>>>${setting['socials']}');
        mainSlider = [];
        print('aaaa>>>${response.data['data']['slider']}');
        if (response.data['data']['slider'] != null)
          for (var json in response.data['data']['slider']['images']) {
            mainSlider.add(web.kIsWeb ? json['file_pwa'] : json['file']);
          }
        print('bbb>>>${mainSlider}');
        sidebarLinks = [];
        for (var json in response.data['data']['links']) {
          LinkMenu link = LinkMenu.fromJson(json);
          sidebarLinks.add(link);
        }
        ads = [];
        for (var json in response.data['data']['ads']) {
          Advertise ad = Advertise.fromJson(json);
          ads.add(ad);
        }

        Get.find<ServiceController>().categories = <int, Category>{};
        for (var json in response.data['data']['categories']) {
          Category category = Category.fromJson(json);
          Get.find<ServiceController>().categories[category.id!] = category;
        }
        for (var category in Get.find<ServiceController>().categories.values) {
          if (category.categoryId != null) {
            Get.find<ServiceController>()
                .categories[category.categoryId]!
                .categories
                .add(category);
            Get.find<ServiceController>().categories[category.id!]!.parent =
                Get.find<ServiceController>().categories[category.categoryId];
          }
        }
        update();
      },
      printResponse: false,
    );
  }

  Future<void> firstPageRoute() async {
    if (RestApi.isConnected) {
      Navigator.of(Get.context!).pushReplacement(MainPageRoute());
      Map<String, dynamic> params = Uri.base.queryParametersAll;
      if (params.containsKey('login')) {
        Navigator.of(
          Get.context!,
        ).push(MaterialPageRoute(builder: (builder) => Login()));
      }
      if (params.containsKey('category')) {
        Category? category =
            Get.find<ServiceController>().categories[int.parse(
              params['category'][0],
            )];
        if (category != null) {
          Get.find<ServiceController>().getCategoryServices(category.id!);
          Navigator.of(
            Get.context!,
          ).push(MaterialPageRoute(builder: (builder) => SubList(category)));
        }
      }
      if (params.containsKey('service')) {
        await Get.find<ServiceController>().findService(
          int.parse(params['service'][0]),
        );
        Service? service =
            Get.find<ServiceController>().services[int.parse(
              params['service'][0],
            )];
        if (service != null)
          Navigator.of(Get.context!).push(
            MaterialPageRoute(builder: (builder) => ServiceIndex(service)),
          );
      }
    }
  }

  Future<void> getAppSetting() async {
    var response = await RestApi.get(settingUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        // title=response!.data['data']['name'];
        // logo=response.data['data']['logo'];
        // primaryColor=Color(int.parse('0xff${response.data['data']['theme_color'].replaceAll('#', '')}'));
        setting = response!.data['data'];
        update();
      },
      printResponse: true,
    );
  }

  Future<void> getMainSlider() async {
    var response = await RestApi.get(mainSliderUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        mainSlider = [];
        for (var json in response!.data['data']['images']) {
          mainSlider.add(web.kIsWeb ? json['file_pwa'] : json['file']);
        }
        update();
      },
    );
  }

  Future<void> getSidebarLinks() async {
    var response = await RestApi.get(linksUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        sidebarLinks = [];
        for (var json in response!.data['data']) {
          LinkMenu link = LinkMenu.fromJson(json);
          sidebarLinks.add(link);
        }
      },
    );
  }

  Future<void> getProvinces() async {
    var response = await RestApi.get(provincesUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        provinces = <int, Province>{};
        for (var provinceJson in response!.data['data']) {
          Province province = Province.fromJson(provinceJson);
          provinces[province.id!] = province;
        }
        update();
      },

      printResponse: true,
    );
  }
}
