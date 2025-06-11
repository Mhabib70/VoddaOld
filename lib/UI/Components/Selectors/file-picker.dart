import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
// import 'package:isolated_worker/isolated_worker.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
// import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/picker-btn.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:image/image.dart' as IMG;

class FilePicker extends StatefulWidget {
  Function? onChange;
  List? images;
  FilePicker({Key? key, this.onChange, this.images}) : super(key: key);

  @override
  _FilePickerState createState() => _FilePickerState();
}

class _FilePickerState extends State<FilePicker> {
  chooseFile(ImageSource imageSource) async {
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
        maxWidth: 2000,
        maxHeight: 2000,
      );

      if (image != null) {
        Uint8List selectedImage = await image.readAsBytes();
        // IMG.Image img = IMG.decodeImage(selectedImage)!;
        // IMG.Image resized = IMG.copyResize(img, width: 200, height: 200);
        // selectedImage =resized.getBytes();

        setState(() {
          widget.images!.add(selectedImage);
        });
        int index = widget.images!.length - 1;
        // await IsolatedWorker()
        //     .run(UserController.ReduceImageQualityAndSize, selectedImage)
        //     .then((value) {
        //   selectedImage = value;
        // });
        widget.images![index] = selectedImage;
        if (widget.onChange != null) widget.onChange!(widget.images);
      } else {
        print("No file selected");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.images == null) widget.images = [];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DottedBorder(
      ///TODO: Emrani removed this
      // color: itemColor5,
      // strokeWidth: 2,
      // radius: Radius.circular(10),
      // dashPattern: [15, 5],
      child: Container(
        width: size.width,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            widget.images!.length == 0
                ? Row(
                  children: [
                    Img(chooserIcon, width: 40, height: 40),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'انتخاب تصاویر',
                          style: AppController.fontStyle(
                            fontTypes.heading3,
                            itemColor1,
                          ),
                        ),
                        Text(
                          'تصاویر مربوطه را از گالری یا دوربین انتخاب کنید :',
                          style: AppController.fontStyle(
                            fontTypes.text1,
                            itemColor1,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
                : Wrap(
                  direction: Axis.horizontal,
                  spacing: 10,
                  runSpacing: 5,
                  children: [
                    for (int i = 0; i < widget.images!.length; i++)
                      InkWell(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder:
                                (_) => Dialog(
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 340,
                                        height: 340,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            5.0,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            5.0,
                                          ),
                                          child: Image.memory(
                                            widget.images![i],
                                            width: 340,
                                            height: 340,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 20,
                                        left: 20,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            setState(() {
                                              widget.images!.removeAt(i);
                                            });
                                            if (widget.onChange != null)
                                              widget.onChange!(widget.images);
                                          },
                                          child: Container(
                                            width: 45,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: itemColor1.withOpacity(
                                                0.4,
                                              ),
                                            ),
                                            child: Img(
                                              removeIcon,
                                              width: 20,
                                              height: 25,
                                              color: whiteColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          );
                        },
                        child: Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.memory(
                              widget.images![i],
                              width: 55,
                              height: 55,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
            SizedBox(height: 20),
            Row(
              children: [
                PickerBtn(
                  folderIcon,
                  'انتخاب از گالری',
                  onClick: () {
                    chooseFile(ImageSource.gallery);
                  },
                ),
                SizedBox(width: 10),
                PickerBtn(
                  cameraIcon,
                  'بازکردن دوربین',
                  onClick: () {
                    chooseFile(ImageSource.camera);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
