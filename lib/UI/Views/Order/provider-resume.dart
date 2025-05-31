import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Models/provider.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/UI/Components/Headers/back-header.dart';
import 'package:vodda_old/UI/Components/Popups/loading.dart';
// import 'package:vodda_old/UI/Views/Order/video-player.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Logic/Controllers/app-controller.dart';
import '../../../Public/images.dart';
import '../../../Public/styles.dart';
import '../../Components/Buttons/btn.dart';
import '../../Components/General/column-scroll.dart';
import '../../Components/General/img.dart';
import '../../Components/General/myDivider.dart';
import '../../Components/Inputs/input.dart';
import '../../Components/Lists/empty-list.dart';
import '../../Components/Popups/bottom-modal.dart';
import '../../Components/Selectors/file-picker.dart';

class ProviderResume extends StatelessWidget {
  Provider provider;
  ProviderResume(this.provider);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print('size.with>>>${size.width / 3 + 50}');
    return Scaffold(
      // backgroundColor: backgroundColor,
      body: Container(
        alignment: Alignment.center,
        width: size.width,
        height: size.height,
        child: DefaultTabController(
          length: 3,
          child: Container(
            width: maxItemWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BackHeader(title: 'رزومه متخصص', hasLogo: false),
                Container(
                  height: 50,
                  width: maxItemWidth,
                  alignment: Alignment.centerRight,
                  child: TabBar(
                    labelColor: itemColor1,
                    unselectedLabelColor: itemColor3,
                    indicatorWeight: 3,
                    indicatorColor: appColor,
                    onTap: (index) {
                      // OrderController.getMyOrders(tabIndex: index+1,refresh: false);
                    },
                    tabs: [
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          'رزومه',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          'تصاویر',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          'ویدئو',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: MyDivider(padding: paddingSize),
                  width: maxItemWidth,
                ),

                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ColumnScroll(
                        children: [
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  provider.cv ?? '',
                                  textAlign: TextAlign.right,
                                  style: AppController.fontStyle(
                                    fontTypes.text2,
                                    itemColor2,
                                  ),
                                  maxLines: null,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Loading(
                        getLoadedComponent: () {
                          return ColumnScroll(
                            padding: 10,
                            children: [
                              SizedBox(height: 20),
                              Container(
                                width: size.width,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(bottom: 15),
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: [
                                    for (var image in provider.cvFiles.values
                                        .where(
                                          (element) =>
                                              element.isVideo != 1 &&
                                              element.confirmed == 1,
                                        ))
                                      Container(
                                        width: 200,
                                        height: 100,

                                        child: Img(
                                          image.file!,
                                          width: 200,
                                          height: 100,
                                          radius: 5,
                                          isNetwork: true,
                                          onClick: () async {
                                            if (!await launchUrl(
                                              Uri.parse(baseUrl + image.file!),
                                              mode:
                                                  LaunchMode
                                                      .externalApplication,
                                            ))
                                              throw 'Could not launch ${image.file!}';
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],

                            emptyList: EmptyList(
                              infoIcon,
                              text: 'موردی یافت نشد !',
                            ),
                            checkEmptyList:
                                () =>
                                    provider.cvFiles.values
                                        .where(
                                          (element) =>
                                              element.isVideo != 1 &&
                                              element.confirmed == 1,
                                        )
                                        .length ==
                                    0,
                          );
                        },
                      ),

                      Loading(
                        getLoadedComponent: () {
                          return ColumnScroll(
                            padding: 0,
                            getLoadedWidgets:
                                () => Column(
                                  children: [
                                    SizedBox(height: 20),
                                    Container(
                                      width: size.width,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(bottom: 15),
                                      child: Wrap(
                                        direction: Axis.horizontal,

                                        spacing: 5,
                                        runSpacing: 5,
                                        children: [
                                          for (var video in provider
                                              .cvFiles
                                              .values
                                              .where(
                                                (element) =>
                                                    element.isVideo == 1 &&
                                                    element.confirmed == 1,
                                              ))
                                            InkWell(
                                              onTap: () async {
                                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlay()));
                                                if (!await launchUrl(
                                                  Uri.parse(
                                                    baseUrl + video.file!,
                                                  ),
                                                  mode:
                                                      LaunchMode
                                                          .externalApplication,
                                                ))
                                                  throw 'Could not launch ${video.file!}';
                                              },
                                              child: Container(
                                                width: 200,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: itemColor1,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Img(playIcon),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                            emptyList: EmptyList(
                              infoIcon,
                              text: 'موردی یافت نشد !',
                            ),
                            checkEmptyList:
                                () =>
                                    provider.cvFiles.values
                                        .where(
                                          (element) =>
                                              element.isVideo == 1 &&
                                              element.confirmed == 1,
                                        )
                                        .length ==
                                    0,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
