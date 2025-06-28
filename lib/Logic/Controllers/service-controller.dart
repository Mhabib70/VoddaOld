import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Logic/Helpers/api-methods.dart';
import 'package:vodda_old/Logic/Models/category.dart';
import 'package:vodda_old/Logic/Models/provider.dart';
import 'package:vodda_old/Logic/Models/service.dart';
import 'package:vodda_old/Logic/Models/tag.dart';
import 'package:vodda_old/Public/api-urls.dart';

class ServiceController extends GetxController {
  static List<Tag> serviceTags = [];
  static List<Tag> providerTags = [];

  static Map<int, Category> categories = <int, Category>{};
  static String categoryText = '';
  static RxList<Category> searchedCategories = <Category>[].obs;

  static Map<int, Service> services = <int, Service>{};
  static String serviceText = '';
  static RxList<Tag> selectedTags = <Tag>[].obs;
  static RxInt selectedCategory = 0.obs;
  static RxList<int> searchedServices = <int>[].obs;

  Future<void> getTagInfo() async {
    var response = await RestApi.get(tagInfoUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        serviceTags = [];
        for (var json in response!.data['data']['slider_tag']) {
          Tag tag = Tag.fromJson(json);
          serviceTags.add(tag);
        }
        providerTags = [];
        for (var json in response.data['data']['tags']) {
          Tag tag = Tag.fromJson(json);
          providerTags.add(tag);
          serviceTags.add(tag);
        }
        serviceTags.sort((a, b) => b.orderIndex!.compareTo(a.orderIndex!));
      },
      printResponse: true,
    );
  }

  static getSliderTags() async {
    var response = await RestApi.get(sliderTagsUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        serviceTags = [];
        for (var json in response!.data['data']) {
          Tag tag = Tag.fromJson(json);
          serviceTags.add(tag);
        }
      },
      printResponse: true,
    );
  }

  static getSearchTags() async {
    var response = await RestApi.get(searchTagsUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        providerTags = [];
        for (var json in response!.data['data']) {
          Tag tag = Tag.fromJson(json);
          providerTags.add(tag);
        }
      },
      printResponse: true,
    );
  }

  static getCategories() async {
    var response = await RestApi.get(categoryListUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        categories = <int, Category>{};
        for (var json in response!.data['data']) {
          Category category = Category.fromJson(json);
          categories[category.id!] = category;
        }
        for (var category in categories.values) {
          if (category.categoryId != null) {
            categories[category.categoryId]!.categories.add(category);
            categories[category.id!]!.parent = categories[category.categoryId];
          }
        }
      },
      printResponse: true,
    );
  }

  static findCategory(String text) {
    searchedCategories.value = [];
    if (text != '')
      for (var category in categories.values) {
        if (category.title!.removeAllWhitespace.contains(
          text.removeAllWhitespace,
        ))
          searchedCategories.value.add(category);
      }
  }

  static getCategoryServices(int categoryId) async {
    if (!categories[categoryId]!.hasSub! &&
        categories[categoryId]!.serviceIds.length == 0) {
      AppController.isLoading.value = true;
      var response = await RestApi.post(
        serviceListUrl,
        body: {'categoryId': categoryId},
      );
      RestApi.responseHandler(
        response: response,
        successCallback: () {
          for (var json in response!.data['data']) {
            Service service = Service.fromJson(json);
            services[service.id!] = service;
            categories[categoryId]!.serviceIds.add(service.id!);
          }
          categories[categoryId]!.serviceIds.sort(
            (a, b) =>
                services[b]!.orderIndex!.compareTo(services[a]!.orderIndex!),
          );
        },
        printResponse: true,
      );
      AppController.isLoading.value = false;
    }
  }

  Future<void> getSearchedServices(String text) async {
    AppController.isLoading.value = true;
    String tags = '';
    for (var tag in selectedTags.value) tags += '${tag.id!},';

    var response = await RestApi.post(
      serviceListUrl,
      body: {
        'categoryId': selectedCategory.value,
        'q': text.endsWith(' ') ? text.substring(0, text.length - 2) : text,
        'tag': tags,
      },
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        searchedServices.value = <int>[];
        for (var json in response!.data['data']) {
          Service service = Service.fromJson(json);
          services[service.id!] = service;
          searchedServices.add(service.id!);
        }
        searchedServices.sort(
          (a, b) =>
              services[b]!.orderIndex!.compareTo(services[a]!.orderIndex!),
        );
      },
      printResponse: true,
    );
    AppController.isLoading.value = false;
  }

  static findService(int serviceID) async {
    var response = await RestApi.post(findServiceUrl, body: {'id': serviceID});
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        Service service = Service.fromJson(response!.data['data']);
        services[serviceID] = service;
        getRelatedServices(serviceID);
      },
    );
  }

  static getRelatedServices(int serviceID) async {
    if (ServiceController.services[serviceID]!.relatedIds.length == 0) {
      AppController.isLoading.value = true;
      var response = await RestApi.post(
        relatedServicesUrl,
        body: {'service_id': serviceID},
      );
      RestApi.responseHandler(
        response: response,
        successCallback: () {
          for (var json in response!.data['data']) {
            Service service = Service.fromJson(json);
            services[service.id!] = service;
            ServiceController.services[serviceID]!.relatedIds.add(service.id!);
          }
          ServiceController.services[serviceID]!.relatedIds.sort(
            (a, b) =>
                services[b]!.orderIndex!.compareTo(services[a]!.orderIndex!),
          );
        },
      );
      AppController.isLoading.value = false;
    }
  }
}
