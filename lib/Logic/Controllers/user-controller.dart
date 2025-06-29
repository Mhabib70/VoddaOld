import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:isolated_worker/isolated_worker.dart';
import 'package:vodda_old/Logic/Models/wallet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/main_controller.dart';
import 'package:vodda_old/Logic/Controllers/notification-controller.dart';
import 'package:vodda_old/Logic/Controllers/order_controller.dart';
import 'package:vodda_old/Logic/Controllers/service_controller.dart';
import 'package:vodda_old/Logic/Helpers/api-methods.dart';
import 'package:vodda_old/Logic/Helpers/token-methods.dart';
import 'package:vodda_old/Logic/Models/address.dart';
import 'package:vodda_old/Logic/Models/city.dart';
import 'package:vodda_old/Logic/Models/notification.dart';
import 'package:vodda_old/Logic/Models/order.dart';
import 'package:vodda_old/Logic/Models/payment.dart';
import 'package:vodda_old/Logic/Models/rate.dart';
import 'package:vodda_old/Logic/Models/service.dart';
import 'package:vodda_old/Logic/Models/user-city.dart';
import 'package:vodda_old/Logic/Models/user.dart';
import 'package:vodda_old/Public/api-urls.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/Inputs/input.dart';
import 'package:vodda_old/UI/Components/Popups/alert-dialog.dart';
import 'package:vodda_old/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_old/UI/Components/Popups/snackbar.dart';
import 'package:vodda_old/UI/Components/Selectors/select-box.dart';
import 'package:vodda_old/UI/Components/Selectors/star-rating.dart';
import 'package:vodda_old/UI/Views/User/edit-profile.dart';
import 'package:vodda_old/UI/Views/User/verify.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:vodda_old/laravel_echo/laravel_echo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:image/image.dart' as IMG;
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserController extends GetxController {
  static Rx<User> user = User().obs;
  static String mobile = '';
  static String verifyCode = '';
  static RxInt timer = 0.obs;
  static RxList<int> myFavorites = <int>[].obs;
  static RxMap<int, Payment> myPayments = <int, Payment>{}.obs;
  static RxMap<int, Wallet> myWallets = <int, Wallet>{}.obs;
  static LatLng myPosition = LatLng(35.7324556, 51.4229012);

  static RxMap<int, Address> addresses = <int, Address>{}.obs;
  static RxMap<int, UserCity> userCities = <int, UserCity>{}.obs;

  Future<void> getUserInfo() async {
    if (await Token.getToken() != null) {
      var response = await RestApi.get(userInfoUrl);
      RestApi.responseHandler(
        response: response,
        successCallback: () {
          user.value = User.fromJson(response!.data['data']['user']);
          Token.setNotifToken(user.value.notificationToken!);
          Get.put(NotificationController());
          userCities.value = <int, UserCity>{};
          for (var json in response.data['data']['cities']) {
            UserCity userCity = UserCity.fromJson(json);
            userCities[userCity.provinceId!] = userCity;
          }
          addresses.value = <int, Address>{};
          for (var json in response.data['data']['addressess']) {
            Address address = Address.fromJson(json);
            addresses[address.id!] = address;
          }
          myFavorites.value = <int>[];
          for (var json in response.data['data']['favorites']) {
            Service service = Service.fromJson(json['service']);
            Get.find<ServiceController>().services[service.id!] = service;
            myFavorites.add(service.id!);
          }
          myFavorites.sort(
            (a, b) => Get.find<ServiceController>().services[b]!.orderIndex!
                .compareTo(
                  Get.find<ServiceController>().services[a]!.orderIndex!,
                ),
          );
        },
        printResponse: false,
      );
    }
  }

  static getUser() async {
    if (await Token.getToken() != null) {
      var response = await RestApi.get(getUserUrl);
      RestApi.responseHandler(
        response: response,
        successCallback: () async {
          user.value = User.fromJson(response!.data['data']);
          Token.setNotifToken(user.value.notificationToken!);
          Get.put(NotificationController());
          // if(user.value.address!=null)
          //   AppController.cities.value=AppController.provinces[user.value.address.provinceId]!.cities;
        },
        popupMessage: false,
      );
    }
  }

  static login() async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      loginUrl,
      body: {'mobile': int.parse(mobile)},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        timer.value = 59;
        const oneSec = Duration(seconds: 1);
        new Timer.periodic(oneSec, (Timer t) {
          if (timer.value == 0) {
            t.cancel();
          } else {
            timer.value--;
          }
        });
        Navigator.pushReplacement(
          Get.context!,
          MaterialPageRoute(builder: (builder) => Verify()),
        );
      },
    );
    AppController.isLoading.value = false;
  }

  static logout() async {
    var response = await RestApi.post(logoutUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        Token.removeToken();
        user.value = User();
      },
    );
  }

  static verify() async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      verifyUrl,
      body: {'mobile': int.parse(mobile), 'verify_code': verifyCode},
    );
    RestApi.responseHandler(
      response: response,
      printResponse: true,
      successCallback: () async {
        user.value = User.fromJson(response!.data['data']['user']);
        await Token.setToken(response.data['data']['token']);
        getFavorites();
        getAddresses();
        getUserCities();
        getUser();
        // if(user.value.address.provinceId!=null)
        //   AppController.cities.value=AppController.provinces[user.value.address.provinceId]!.cities.values.toList();
        if (!user.value.isCompleted!) {
          Navigator.pushReplacement(
            Get.context!,
            MaterialPageRoute(builder: (builder) => EditProfile()),
          );
        } else
          Navigator.pop(Get.context!);
      },
    );
    AppController.isLoading.value = false;
  }

  static editUser() async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(updateUserUrl, body: user.toJson());
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        user.value = User.fromJson(response!.data['data']);
        // getAddresses();
        if (user.value.address.provinceId != null) {
          Get.find<MainController>().cities.value =
              Get.find<MainController>()
                  .provinces[user.value.address.provinceId]!
                  .cities
                  .values
                  .toList();
        }
        if (user.value.isCompleted == true) Navigator.pop(Get.context!);
      },
    );
    AppController.isLoading.value = false;
  }

  static chooseProfile(ImageSource imageSource) async {
    var accepted = false;
    if (!kIsWeb) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;

      if (androidInfo.version.sdkInt <= 32 &&
          await Permission.storage.request().isGranted) {
        accepted = true;
      } else if (await Permission.photos.request().isGranted) {
        accepted = true;
      }
    }
    if (kIsWeb || accepted) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(
        source: imageSource,
        maxWidth: 1000,
        maxHeight: 1000,
      );
      if (image != null) {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          compressFormat: ImageCompressFormat.jpg,

          ///TODO: Emrani removed this
          // cropStyle: CropStyle.circle,
          compressQuality: 100,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'بریدن',

              toolbarColor: appColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
              hideBottomControls: true,
            ),
            WebUiSettings(
              context: Get.context!,

              ///TODO: Emrani removed this
              // presentStyle: CropperPresentStyle.page,
              // boundary: CroppieBoundary(
              //   width:
              //       maxItemWidth >
              //               MediaQuery.of(Get.context!).size.width.toInt()
              //           ? MediaQuery.of(Get.context!).size.width.toInt() -
              //               paddingSize.toInt()
              //           : maxItemWidth.toInt(),
              //   height:
              //       maxItemWidth >
              //               MediaQuery.of(Get.context!).size.width.toInt()
              //           ? MediaQuery.of(Get.context!).size.width.toInt() -
              //               paddingSize.toInt()
              //           : maxItemWidth.toInt(),
              // ),
              // viewPort: CroppieViewPort(
              //   width:
              //       maxItemWidth >
              //               MediaQuery.of(Get.context!).size.width.toInt()
              //           ? MediaQuery.of(Get.context!).size.width.toInt() -
              //               paddingSize.toInt()
              //           : maxItemWidth.toInt(),
              //   height:
              //       maxItemWidth >
              //               MediaQuery.of(Get.context!).size.width.toInt()
              //           ? MediaQuery.of(Get.context!).size.width.toInt() -
              //               paddingSize.toInt()
              //           : maxItemWidth.toInt(),
              //   type: 'circle',
              // ),
              // enableExif: true,
              // enableZoom: true,
              // mouseWheelZoom: true,
              // enableOrientation: true,
              // enableResize: true,
              // enforceBoundary: true,
              // showZoomer: false,
            ),
          ],
        );
        if (croppedFile != null) {
          AppController.isLoading.value = true;
          Uint8List selectedImage = await croppedFile.readAsBytes();

          // await IsolatedWorker()
          //     .run(ReduceImageQualityAndSize, selectedImage)
          //     .then((value) {
          //   selectedImage = value;
          // });

          var response = await RestApi.post(
            avatarUrl,
            body: {'file': base64.encode(selectedImage)},
          );
          RestApi.responseHandler(
            response: response,
            successCallback: () {
              user.value = User.fromJson(response!.data['data']);
            },
          );
          AppController.isLoading.value = false;
        }
      } else {
        print("No file selected");
      }
    }
  }

  static Future<Uint8List> ReduceImageQualityAndSize(Uint8List image) async {
    int maxInBytes = 500000;
    Uint8List resizedData = Uint8List.fromList(image);

    IMG.Image? img = await IMG.decodeImage(image);
    int size = await image.lengthInBytes;
    int quality = 100;

    print("size max: " + maxInBytes.toString());
    print("size before: " + size.toString() + " bytes");

    while (size > maxInBytes && quality > 10) {
      // reduce image size about 10% of image, until the size is less than the maximum limit
      quality = (quality - (quality * 0.1)).toInt();
      int width = img!.width - (img.width * 0.1).toInt();
      IMG.Image resized = await IMG.copyResize(img, width: width);
      resizedData = await Uint8List.fromList(
        IMG.encodeJpg(resized, quality: quality),
      );
      size = await resizedData.lengthInBytes;
      img = resized;
    }

    print("size after: " + size.toString() + " bytes");

    return resizedData;
  }

  static getFavorites() async {
    if (user.value.id != null) {
      var response = await RestApi.get(favoriteListUrl);
      RestApi.responseHandler(
        response: response,
        successCallback: () {
          myFavorites.value = <int>[];
          for (var json in response!.data['data']) {
            Service service = Service.fromJson(json['service']);
            Get.find<ServiceController>().services[service.id!] = service;
            myFavorites.add(service.id!);
          }
          myFavorites.sort(
            (a, b) => Get.find<ServiceController>().services[b]!.orderIndex!
                .compareTo(
                  Get.find<ServiceController>().services[a]!.orderIndex!,
                ),
          );
        },
      );
    }
  }

  static addFavorites(Service service) async {
    var response = await RestApi.post(
      addFavoriteUrl,
      body: {'service_id': service.id},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        Get.find<ServiceController>().services[service.id]!.isFavorite = true;
        myFavorites.add(service.id!);
      },
    );
  }

  static deleteFavorites(Service service) async {
    var response = await RestApi.post(
      deleteFavoriteUrl,
      body: {'service_id': service.id},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        Get.find<ServiceController>().services[service.id]!.isFavorite = false;
        myFavorites.remove(service.id);
      },
    );
  }

  static getUserCities() async {
    if (user.value.id != null) {
      var response = await RestApi.get(getUserCityUrl);
      RestApi.responseHandler(
        response: response,
        successCallback: () {
          userCities.value = <int, UserCity>{};
          for (var json in response!.data['data']) {
            UserCity userCity = UserCity.fromJson(json);
            userCities[userCity.provinceId!] = userCity;
          }
        },
        printResponse: true,
      );
    }
  }

  static addCity(UserCity userCity) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(addUserCityUrl, body: userCity.toJson());
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        userCities[userCity.provinceId!] = userCity;
      },
    );
    AppController.isLoading.value = false;
  }

  static deleteCity(UserCity userCity) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      deleteUserCityUrl,
      body: userCity.toJson(),
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        userCities.remove(userCity.provinceId);
      },
    );

    AppController.isLoading.value = false;
  }

  static getAddresses() async {
    if (user.value.id != null) {
      var response = await RestApi.get(addressListUrl);
      RestApi.responseHandler(
        response: response,
        successCallback: () {
          addresses.value = <int, Address>{};
          for (var json in response!.data['data']) {
            Address address = Address.fromJson(json);
            addresses[address.id!] = address;
          }
        },
      );
    }
  }

  static addAddress(Address newAddress) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(addAddressUrl, body: newAddress.toJson());
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        addresses.value = <int, Address>{};
        for (var json in response!.data['data']) {
          Address address = Address.fromJson(json);
          addresses[address.id!] = address;
        }
        Navigator.pop(Get.context!);
      },
    );
    AppController.isLoading.value = false;
  }

  static deleteAddress(int addressId) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      deleteAddressUrl,
      body: {'address_id': addressId},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        addresses.remove(addressId);
      },
    );

    AppController.isLoading.value = false;
  }

  static findAddress() async {
    AppController.isLoading.value = true;
    Address newAddress = Address(
      lat: myPosition.latitude,
      long: myPosition.longitude,
    );
    var response = await RestApi.post(
      findAddressUrl,
      body: {'lat': myPosition.latitude, 'long': myPosition.longitude},
    );
    await RestApi.responseHandler(
      response: response,
      successCallback: () {
        newAddress.provinceId = response!.data['data']['province'];
        Get.find<MainController>().cities.value =
            Get.find<MainController>()
                .provinces[newAddress.provinceId]!
                .cities
                .values
                .toList();
        newAddress.cityId = response.data['data']['city'];
        newAddress.place = response.data['data']['address'];
      },
      printResponse: true,
    );
    showBottomModal(
      Get.context!,
      500,
      Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 15),
                  Text(
                    'افزودن آدرس جدید',
                    style: AppController.fontStyle(
                      fontTypes.heading3,
                      itemColor2,
                    ),
                  ),
                  SizedBox(height: 30),
                  Input(
                    lable: 'عنوان',
                    initValue: newAddress.title,
                    icon1: Icon(
                      Icons.edit_outlined,
                      size: 20,
                      color: itemColor4,
                    ),
                    onChange: (text) {
                      newAddress.title = text;
                    },
                  ),
                  SizedBox(height: 15),
                  SelectBox(
                    text: 'انتخاب استان',
                    onSelect: (value) {
                      newAddress.cityId = null;
                      Get.find<MainController>().cities.value = [];
                      newAddress.provinceId = value;
                      Get.find<MainController>().cities.value =
                          Get.find<MainController>()
                              .provinces[value]!
                              .cities
                              .values
                              .toList();
                    },
                    options: {
                      for (var provinceID
                          in Get.find<MainController>().provinces.keys)
                        Get.find<MainController>().provinces[provinceID]!.name:
                            provinceID,
                    },
                    icon: Img(locationIcon),
                    value: newAddress.provinceId,
                  ),
                  SizedBox(height: 15),
                  Obx(() {
                    return SelectBox(
                      text: 'انتخاب شهر',
                      onSelect: (value) {
                        newAddress.cityId = value;
                      },
                      options:
                          Get.find<MainController>().cities.value.isNotEmpty &&
                                  newAddress.provinceId != null
                              ? {
                                for (var city
                                    in Get.find<MainController>().cities.value)
                                  city.name: city.id,
                              }
                              : <dynamic, dynamic>{},
                      icon: Img(cityIcon),
                      value: newAddress.cityId,
                    );
                  }),
                  SizedBox(height: 15),
                  Input(
                    lable: 'خیابان / کوچه / پلاک ...',
                    initValue: newAddress.place,
                    icon1: Container(
                      width: 50,
                      height: 250,
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(top: 5),
                      child: Icon(
                        Icons.my_location,
                        size: 20,
                        color: itemColor4,
                      ),
                    ),
                    lines: 10,
                    onChange: (text) {
                      newAddress.place = text;
                    },
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: paddingSize),
            child: Btn(
              btnType.primary,
              text: 'ذخیره تغییرات',
              onClick: () {
                Navigator.pop(Get.context!);
                addAddress(newAddress);
              },
            ),
          ),
        ],
      ),
    );

    AppController.isLoading.value = false;
  }

  Future<bool> getMyLocation() async {
    print('start determine');
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
      return false;
    }
    print('end determine');
    try {
      Position myLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      myPosition = LatLng(myLocation.latitude, myLocation.longitude);
    } catch (e) {}

    return true;
  }

  static getPayList(bool hasLoading) async {
    if (hasLoading) AppController.isLoading.value = true;
    var response = await RestApi.get(paymentListUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        myPayments.value = <int, Payment>{};
        for (var json in response!.data['data']) {
          Payment payment = Payment.fromJson(json);
          myPayments[payment.id!] = payment;
        }
        getUser();
      },
    );
    if (hasLoading) AppController.isLoading.value = false;
  }

  static getWalletList(bool hasLoading) async {
    if (hasLoading) AppController.isLoading.value = true;
    var response = await RestApi.get(walletListUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        myWallets.value = <int, Wallet>{};
        for (var json in response!.data['data']) {
          Wallet wallet = Wallet.fromJson(json);
          myWallets[wallet.id!] = wallet;
        }
        getUser();
      },
    );
    if (hasLoading) AppController.isLoading.value = false;
  }

  static addToWallet(amount) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      walletIncreaseUrl,
      body: {'amount': amount},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        launchUrlString(
          baseUrl + response!.data['data']['pay_link'],
          mode: LaunchMode.externalApplication,
        );
      },
    );
    AppController.isLoading.value = false;
  }
}
