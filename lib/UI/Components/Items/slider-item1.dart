import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Logic/Models/service.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Views/Order/service-index.dart';

class SliderItem1 extends StatelessWidget {
  Service service = Service();
  double width;
  SliderItem1(this.service, {Key? key, this.width = maxItemWidth})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ServiceController.getRelatedServices(service.id!);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (builder) => ServiceIndex(service)),
        );
      },
      child: Container(
        height: 80,
        width: width,
        margin: EdgeInsets.only(left: paddingSize, right: paddingSize, top: 20),
        decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: shadow2,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Row(
            children: [
              service.images.length > 0
                  ? Img(
                    service.images[0],
                    width: 130,
                    height: 80,
                    isNetwork: true,
                  )
                  : Container(width: 55, height: 55),

              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${service.title ?? ''}',
                            style: AppController.fontStyle(
                              fontTypes.regular14,
                              itemColor1,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                    // Text(
                    //     '${service.description??''}',
                    //     style: AppController.fontStyle(fontTypes.text1, itemColor4),
                    //     overflow: TextOverflow
                    //         .ellipsis),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
