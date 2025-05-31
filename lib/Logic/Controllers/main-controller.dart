import 'package:flutter/foundation.dart' as web;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Logic/Helpers/api-methods.dart';
import 'package:vodda_old/Logic/Helpers/token-methods.dart';
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
  static Map<String, dynamic> setting = <String, dynamic>{};
  static List<LinkMenu> sidebarLinks = [];
  static List<Advertise> ads = [];
  static List<String> mainSlider = [];
  static Map<int, Province> provinces = <int, Province>{};
  static RxList<City> cities = <City>[].obs;

  static TabController? tabController;

  static Map<int, Provider> tagProviders = <int, Provider>{};

  static AppVersion? newVersion;

  static getInitData() async {
    AppController.isLoading.value = true;

    // bool flagVideo=false;
    // bool flagApi=false;
    // Future.delayed(Duration(seconds: web.kIsWeb?1:12),(){
    // flagVideo=true;
    //   if(flagApi)
    //     firstPageRoute();
    // });
    await getMainInfo();
    await UserController.getUserInfo();
    await ServiceController.getTagInfo();
    // await getProvinces();
    // await getAppSetting();
    // await getMainSlider();
    // getSidebarLinks();
    // await UserController.getUser();
    // await UserController.getUserCities();//must be before all service apis
    // // await ServiceController.getCategories();//must be before favorites and tags
    // UserController.getAddresses();
    UserController.getMyLocation();
    // UserController.getFavorites();
    // await ServiceController.getSliderTags();
    // ServiceController.getSearchTags();
    await ServiceController.getSearchedServices(
      '',
    ); //must be at last because of loading

    // flagApi=true;
    // if(flagVideo)
    firstPageRoute();

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

  static getMainInfo() async {
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
        mainSlider = [];
        if (response.data['data']['slider'] != null)
          for (var json in response.data['data']['slider']['images']) {
            mainSlider.add(web.kIsWeb ? json['file_pwa'] : json['file']);
          }
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

        ServiceController.categories = <int, Category>{};
        for (var json in response.data['data']['categories']) {
          Category category = Category.fromJson(json);
          ServiceController.categories[category.id!] = category;
        }
        for (var category in ServiceController.categories.values) {
          if (category.categoryId != null) {
            ServiceController.categories[category.categoryId]!.categories.add(
              category,
            );
            ServiceController.categories[category.id!]!.parent =
                ServiceController.categories[category.categoryId];
          }
        }
      },
      printResponse: false,
    );
  }

  static firstPageRoute() async {
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
            ServiceController.categories[int.parse(params['category'][0])];
        if (category != null) {
          ServiceController.getCategoryServices(category.id!);
          Navigator.of(
            Get.context!,
          ).push(MaterialPageRoute(builder: (builder) => SubList(category)));
        }
      }
      if (params.containsKey('service')) {
        await ServiceController.findService(int.parse(params['service'][0]));
        Service? service =
            ServiceController.services[int.parse(params['service'][0])];
        if (service != null)
          Navigator.of(Get.context!).push(
            MaterialPageRoute(builder: (builder) => ServiceIndex(service)),
          );
      }
    }
  }

  static getAppSetting() async {
    var response = await RestApi.get(settingUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        // title=response!.data['data']['name'];
        // logo=response.data['data']['logo'];
        // primaryColor=Color(int.parse('0xff${response.data['data']['theme_color'].replaceAll('#', '')}'));
        setting = response!.data['data'];
      },
      printResponse: true,
    );
  }

  static getMainSlider() async {
    var response = await RestApi.get(mainSliderUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        mainSlider = [];
        for (var json in response!.data['data']['images']) {
          mainSlider.add(web.kIsWeb ? json['file_pwa'] : json['file']);
        }
      },
    );
  }

  static getSidebarLinks() async {
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

  static getProvinces() async {
    var response = await RestApi.get(provincesUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        provinces = <int, Province>{};
        for (var provinceJson in response!.data['data']) {
          Province province = Province.fromJson(provinceJson);
          provinces[province.id!] = province;
        }
      },
      printResponse: true,
    );
  }
}
