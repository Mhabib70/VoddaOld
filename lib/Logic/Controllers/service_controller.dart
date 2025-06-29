import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Helpers/api-methods.dart';
import 'package:vodda_old/Logic/Models/category.dart';
import 'package:vodda_old/Logic/Models/service.dart';
import 'package:vodda_old/Logic/Models/tag.dart';
import 'package:vodda_old/Public/api-urls.dart';

class ServiceController extends GetxController {
  List<Tag> serviceTags = [];
  List<Tag> providerTags = [];

  Map<int, Category> categories = <int, Category>{};
  String categoryText = '';
  RxList<Category> searchedCategories = <Category>[].obs;

  Map<int, Service> services = <int, Service>{};
  String serviceText = '';
  RxList<Tag> selectedTags = <Tag>[].obs;
  RxInt selectedCategory = 0.obs;
  RxList<int> searchedServices = <int>[].obs;

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
        update();
      },
      printResponse: true,
    );
  }

  Future<void> getSliderTags() async {
    var response = await RestApi.get(sliderTagsUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        serviceTags = [];
        for (var json in response!.data['data']) {
          Tag tag = Tag.fromJson(json);
          serviceTags.add(tag);
        }
        update();
      },
      printResponse: true,
    );
  }

  Future<void> getSearchTags() async {
    var response = await RestApi.get(searchTagsUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        providerTags = [];
        for (var json in response!.data['data']) {
          Tag tag = Tag.fromJson(json);
          providerTags.add(tag);
        }
        update();
      },
      printResponse: true,
    );
  }

  Future<void> getCategories() async {
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
        update();
      },
      printResponse: true,
    );
  }

  void findCategory(String text) {
    searchedCategories.value = [];
    if (text != '')
      // ignore: curly_braces_in_flow_control_structures
      for (var category in categories.values) {
        if (category.title!.removeAllWhitespace.contains(
          text.removeAllWhitespace,
        )) {
          searchedCategories.value.add(category);
        }
      }
    update();
  }

  Future<void> getCategoryServices(int categoryId) async {
    if (!categories[categoryId]!.hasSub! &&
        categories[categoryId]!.serviceIds.isEmpty) {
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

          update();
        },
        printResponse: true,
      );
      AppController.isLoading.value = false;
    }
  }

  Future<void> getSearchedServices(String text) async {
    AppController.isLoading.value = true;
    String tags = '';
    for (var tag in selectedTags.value) {
      tags += '${tag.id!},';
    }

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

        update();
      },
      printResponse: true,
    );
    AppController.isLoading.value = false;
  }

  Future<void> findService(int serviceID) async {
    var response = await RestApi.post(findServiceUrl, body: {'id': serviceID});
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        Service service = Service.fromJson(response!.data['data']);
        services[serviceID] = service;
        getRelatedServices(serviceID);
        update();
      },
    );
  }

  Future<void> getRelatedServices(int serviceID) async {
    if (services[serviceID]!.relatedIds.isEmpty) {
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
            services[serviceID]!.relatedIds.add(service.id!);
          }
          services[serviceID]!.relatedIds.sort(
            (a, b) =>
                services[b]!.orderIndex!.compareTo(services[a]!.orderIndex!),
          );
          update();
        },
      );
      AppController.isLoading.value = false;
    }
  }
}
