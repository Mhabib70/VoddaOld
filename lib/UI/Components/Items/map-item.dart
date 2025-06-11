import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
// import 'package:mapir_raster/mapir_raster.dart';

import 'package:flutter/widgets.dart';
// import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Public/api-urls.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:map_launcher/map_launcher.dart' as launcher;

class MapItem extends StatelessWidget {
  double lat, long;
  String title;
  MapItem(this.lat, this.long, this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        InkWell(
          onTap: () async {
            if (kIsWeb) {
              await UserController.getMyLocation();
              launchUrlString(
                'https://www.google.com/maps/dir/${UserController.myPosition.latitude},${UserController.myPosition.latitude}/${lat},${long}',
              );
            } else {
              final availableMaps = await launcher.MapLauncher.installedMaps;
              print(
                availableMaps,
              ); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

              await availableMaps.first.showMarker(
                coords: launcher.Coords(lat, long),
                title: title,
              );
            }
          },
          child: Container(
            height: 150,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                children: [
                  ///TODO: Emrani removed this
                  // MapirMap(
                  //   apiKey: mapApiKey,
                  //   options: MapOptions(center: LatLng(lat, long), zoom: 16.0),
                  //   layers: [
                  //     MarkerLayerOptions(
                  //       markers: [
                  //         Marker(
                  //           width: 30.0,
                  //           height: 40.0,
                  //           point: LatLng(lat, long),
                  //           builder:
                  //               (ctx) => Img(
                  //                 mapIcon,
                  //                 width: 30,
                  //                 height: 40,
                  //                 color: appColor2,
                  //               ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                        color: appColor.withOpacity(0.45),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'مسیریابی',
                          style: AppController.fontStyle(
                            fontTypes.heading4,
                            appColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(color: Colors.transparent),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
