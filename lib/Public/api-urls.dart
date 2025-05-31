import 'package:vodda_old/Public/config.dart';

const String baseApiUrl = baseUrl + '/api/v1';

const String findAddressUrl = baseApiUrl + '/findAddress';

const String mainSliderUrl = baseApiUrl + '/getSlider';
const String provincesUrl = baseApiUrl + '/address/provinces';
const String citiesUrl = baseApiUrl + '/address/cities';
const String sliderTagsUrl = baseApiUrl + '/tag/listWithService';
const String searchTagsUrl = baseApiUrl + '/tag/list';
const String settingUrl = baseApiUrl + '/setting/getInfo';
const String mainInfoUrl = baseApiUrl + '/setting/getMainInfo';
const String tagInfoUrl = baseApiUrl + '/tag/info';
const String linksUrl = baseApiUrl + '/setting/getLinks';

const String loginUrl = baseApiUrl + '/user/login';
const String logoutUrl = baseApiUrl + '/user/logout';
const String userInfoUrl = baseApiUrl + '/user/getInfo';
const String getUserUrl = baseApiUrl + '/user/getUser';
const String verifyUrl = baseApiUrl + '/user/verify';
const String updateUserUrl = baseApiUrl + '/user/update';
const String favoriteListUrl = baseApiUrl + '/user/getListFavorite';
const String addFavoriteUrl = baseApiUrl + '/user/addFavorite';
const String deleteFavoriteUrl = baseApiUrl + '/user/deleteFavorite';
const String addressListUrl = baseApiUrl + '/user/addresses';
const String addAddressUrl = baseApiUrl + '/address/add';
const String deleteAddressUrl = baseApiUrl + '/user/deleteAddress';
const String getUserCityUrl = baseApiUrl + '/userCities';
const String addUserCityUrl = baseApiUrl + '/userCity/add';
const String deleteUserCityUrl = baseApiUrl + '/userCity/delete';
const String avatarUrl = baseApiUrl + '/user/updateAvatar';

const String categoryListUrl = baseApiUrl + '/category/list';
const String serviceListUrl = baseApiUrl + '/service/list';
const String findServiceUrl = baseApiUrl + '/service/find';
const String relatedServicesUrl = baseApiUrl + '/service/related';
const String serviceProviderListUrl = baseApiUrl + '/service/getProviders';
const String orderProviderListUrl = baseApiUrl + '/order/getProviders';
const String acceptProviderUrl = baseApiUrl + '/order/acceptProvider';
const String getCvFilesUrl = baseApiUrl + '/provider/getCvFiles';
const String setMarkProviderUrl = baseApiUrl + '/provider/setMark';
const String reserveProviderUrl = baseApiUrl + '/order/getReservation';
const String giftCodeUrl = baseApiUrl + '/order/checkGiftCode';

const String questionUrl = baseApiUrl + '/question/getQuestions';
const String dateUrl = baseApiUrl + '/order/getDate';
// const String timeUrl=baseApiUrl+'/order/getTime';
const String createOrderUrl = baseApiUrl + '/order/store';
const String getOrderUrl = baseApiUrl + '/order/get';
const String orderListUrl = baseApiUrl + '/order/myOrders';
const String confirmOrderUrl = baseApiUrl + '/order/confirm';
const String setRateUrl = baseApiUrl + '/order/setRate';
const String cancelOrderRequestUrl = baseApiUrl + '/order/cancelRequest';
const String cancelOrderRegisterUrl = baseApiUrl + '/order/cancelRegister';
const String additionOrderUrl = baseApiUrl + '/order/addition';
const String callProviderUrl = baseApiUrl + '/order/call';
const String meetProviderUrl = baseApiUrl + '/order/meet';
const String callPrivateUrl = baseApiUrl + '/order/callPrivate';
const String getOrderDocuemntsUrl = baseApiUrl + '/order/getDocuments';
const String storeOrderDocuemntUrl = baseApiUrl + '/order/storeDocument';
const String storeDocuemntFileUrl = baseApiUrl + '/order/storeDocumentFile';
const String exportOrderUrl = baseApiUrl + '/order/exportUrl';

const String payOrderUrl = baseApiUrl + '/payment/order';
const String paymentListUrl = baseApiUrl + '/payment/list';
const String walletListUrl = baseApiUrl + '/wallet/list';
const String walletIncreaseUrl = baseApiUrl + '/wallet/increase';
const String walletDecreaseUrl = baseApiUrl + '/wallet/decrease';

const String mapApiKey =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjQzYmZhMjc4MzE3ZGNmODFhZDUzZjNmMjQ2MGVhNWFhMzJmMWQ3YzgxNTZkOGM3NmM5OGU4NzE1ZDE4YTRjODM2MTJiOWFkMzAwZmVlZTM3In0.eyJhdWQiOiIxOTA1NiIsImp0aSI6IjQzYmZhMjc4MzE3ZGNmODFhZDUzZjNmMjQ2MGVhNWFhMzJmMWQ3YzgxNTZkOGM3NmM5OGU4NzE1ZDE4YTRjODM2MTJiOWFkMzAwZmVlZTM3IiwiaWF0IjoxNjYwMjMyNjQzLCJuYmYiOjE2NjAyMzI2NDMsImV4cCI6MTY2MjgyNDY0Mywic3ViIjoiIiwic2NvcGVzIjpbImJhc2ljIl19.Y0kU-dMjtNJs2cpscoHjwGRoeDhCA4y1SfMchiGL9Nxlx4g9HdukvMBoCB00hkGY5UU1Qfaw9iOHQAgqbWD5qCvqelDSs4xDnnLlyCicDsuqpof2eej2l6twSTdDVaFtCOQiG_LcjusPFZIQP7QNuXI5um-2sYLMvPMmKcuzG6EO2GfVM9vtlftRtmTZ2nvKh3GgRKjqOb8lFKAIw3jKSe9qKj2tPActUAraCHpFWYqhb9bKyR-ODAbo2e2AscZKCcxB97-vj9my8w8eeVh_BQ3i34ijiTzpvPDrLaeGfruphSlusKLzG-7nJKpxRTTPXOJaTcpJaFlQ2l2JsTHqpQ';
