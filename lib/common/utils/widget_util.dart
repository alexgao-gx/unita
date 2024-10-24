import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart' as fc;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/style/colors.dart';

import '../components/basic/custom_weelpicker.dart';
import '../components/basic/time_weelpicker.dart';

class WidgetUtil {
  static void showTimePickerSheet(context,
      {DateTime? initialDate, ValueChanged<DateTime>? onDateSelected}) {
    final hours = List.generate(12, (index) => (index).toString());
    final minutes = List.generate(59, (index) => (index + 1).toString());
    final halfDays = ['AM'.tr, 'PM'.tr];
    final initialTime = initialDate ?? DateTime.now();
    // Calculate the hour index (1-12 format)
    var hour12 = initialTime.hour % 12;
    hour12 = hour12 == 0 ? 12 : hour12; // Convert 0 to 12 for 12 AM/PM
    var initialHourIndex = hours.indexOf(hour12.toString());

    // Calculate the minute index
    var initialMinuteIndex = initialTime.minute - 1;

    // Calculate the AM/PM index
    var initialHalfDayIndex = initialTime.hour >= 12 ? 1 : 0;

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 328.h,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            color: Colors.white,
          ),
          padding: const EdgeInsets.only(left: 14, right: 14),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                ButtonWidget.text(
                  textColor: AppColors.color_C5C5C5,
                  textSize: 14.sp,
                  height: 53.h,
                  textWeight: FontWeight.w400,
                  'Cancel'.tr,
                  onTap: () {
                    Get.back();
                  },
                ),
                ButtonWidget.text(
                  textColor: AppColors.color_65AF7C,
                  textSize: 14.sp,
                  height: 53.h,
                  textWeight: FontWeight.w400,
                  'Save'.tr,
                  onTap: () {
                    int hour = int.parse(hours[initialHourIndex]);
                    int minute = int.parse(minutes[initialMinuteIndex]);
                    String halfDay = halfDays[initialHalfDayIndex];

                    // Convert to 24-hour format
                    if (halfDay == 'PM'.tr && hour != 12) {
                      hour += 12;
                    } else if (halfDay == 'AM'.tr && hour == 12) {
                      hour = 0;
                    }

                    // Create the DateTime object
                    DateTime dateTime = DateTime.now();
                    DateTime resultTime = DateTime(dateTime.year,
                        dateTime.month, dateTime.day, hour, minute);

                    onDateSelected?.call(resultTime);
                    Get.back();
                  },
                ),
              ]),
              const Divider(
                height: 0.5,
                color: AppColors.color_E6DCD6,
              ),
              Expanded(
                child: TimeWheelPicker(
                    list1: hours,
                    split: ':',
                    list2: minutes,
                    list3: halfDays,
                    initialIndex1: initialHourIndex,
                    initialIndex2: initialMinuteIndex,
                    initialIndex3: initialHalfDayIndex,
                    onValueChanged: ({int? index1, int? index2, int? index3}) {
                      // Get the hour, minute, and AM/PM
                      if (index1 != null) {
                        initialHourIndex = index1;
                      }
                      if (index2 != null) {
                        initialMinuteIndex = index2;
                      }
                      if (index3 != null) {
                        initialHalfDayIndex = index3;
                      }
                    }),
              )
            ],
          ),
        );
      },
    );
  }

  static void showDateTimeSheet(context, CupertinoDatePickerMode type,
      {DateTime? initialDate, ValueChanged<DateTime>? onDateSelected}) {
    DateTime _dateTime = DateTime.now();
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 328,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            color: Colors.white,
          ),
          padding: const EdgeInsets.only(left: 14, right: 14, top: 18),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                ButtonWidget.text(
                  textColor: AppColors.color_C5C5C5,
                  textSize: 14.sp,
                  textWeight: FontWeight.w400,
                  'Cancel'.tr,
                  onTap: () {
                    Get.back();
                  },
                ),
                ButtonWidget.text(
                  textColor: AppColors.color_65AF7C,
                  textSize: 14.sp,
                  textWeight: FontWeight.w400,
                  'Save'.tr,
                  onTap: () {
                    onDateSelected?.call(_dateTime);
                    Get.back();
                  },
                ),
              ]),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                height: 0.5,
                color: AppColors.color_E6DCD6,
              ),
              Expanded(
                child: CupertinoDatePicker(
                  backgroundColor:
                      CupertinoColors.systemBackground.resolveFrom(context),
                  mode: type,
                  initialDateTime: initialDate ?? _dateTime,
                  onDateTimeChanged: (time) {
                    _dateTime = time;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showUploadImageOperations(BuildContext context,
      VoidCallback onCameraTap, VoidCallback onGalleryTap) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoTheme(
            data: const CupertinoThemeData(),
            child: CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  child: TextWidget(
                    text: 'Take Photo'.tr,
                    color: AppColors.color_1A342B,
                  ),
                  onPressed: () {
                    Get.back();
                    onCameraTap();
                  },
                ),
                CupertinoActionSheetAction(
                  child: TextWidget(
                      text: 'Choose From Album'.tr,
                      color: AppColors.color_1A342B),
                  onPressed: () {
                    Get.back();
                    onGalleryTap();
                  },
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                child: TextWidget(
                    text: 'Cancel'.tr, color: AppColors.color_1A342B),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          );
        });
  }

  static Future showGallery(
      BuildContext context, List<String> images, int initialPage,
      {bool enableDownload = true, bool enableShare = true}) {
    PageController _controller = PageController(initialPage: initialPage);
    var current = initialPage;

    return showDialog(
        context: context,
        barrierColor: Colors.black,
        useSafeArea: false,
        builder: (context) =>
            StatefulBuilder(builder: (context, setDialogState) {
              Widget child = PhotoViewGallery.builder(
                enableRotation: true,
                onPageChanged: (v) {
                  current = v;
                  setDialogState(() {});
                },
                scrollPhysics: const BouncingScrollPhysics(),
                gaplessPlayback: false,
                builder: (BuildContext context, int index) {
                  var image = images[index];
                  ImageProvider provider;

                  if (!image.toLowerCase().startsWith('http')) {
                    provider =
                        Image.file(File(Uri.parse(image).toFilePath())).image;
                  } else {
                    provider = CachedNetworkImageProvider(image);
                  }
                  return PhotoViewGalleryPageOptions(
                    imageProvider: provider,
                    gestureDetectorBehavior: HitTestBehavior.opaque,
                  );
                },
                itemCount: images.length,
                backgroundDecoration: const BoxDecoration(color: Colors.black),
                pageController: _controller,
              );
              void download() {
                getImageFromCache(
                    images[current],
                    (file) => saveImage(Uri.parse(file.path).pathSegments.last,
                        file.readAsBytesSync()));
              }

              void share() {
                getImageFromCache(images[current], (file) {
                  Share.shareXFiles([XFile(file.path)]);
                });
              }

              return Stack(
                children: [
                  GestureDetector(onLongPress: download, child: child),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.black45,
                              child: CloseButton(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(45),
                                color: Colors.black45,
                              ),
                              child: Text(
                                '${current + 1}/${images.length}',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                            const Spacer(),
                            const SizedBox(
                              width: 10,
                            ),
                            Visibility(
                                visible: enableDownload,
                                child: CircleAvatar(
                                  backgroundColor: Colors.black45,
                                  child: IconButton(
                                    onPressed: download,
                                    tooltip: 'Save to local',
                                    icon: const Icon(
                                      Icons.download_rounded,
                                      color: Colors.white,
                                    ),
                                    color: Colors.white,
                                  ),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Visibility(
                                visible: enableShare,
                                child: CircleAvatar(
                                  backgroundColor: Colors.black45,
                                  child: IconButton(
                                    onPressed: share,
                                    tooltip: 'Share',
                                    icon: const Icon(
                                      Icons.share,
                                      color: Colors.white,
                                    ),
                                    color: Colors.white,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }));
  }

  static void getImageFromCache(String url, Function(File file) onFile) {
    if (!url.toLowerCase().startsWith('http')) {
      //文件
      onFile(File.fromUri(Uri.parse(url)));
    } else {
      fc.DefaultCacheManager().getImageFile(url).listen((event) {
        var f = event as fc.FileInfo;
        onFile(f.file);
      });
    }
  }

  static Future<void> saveImage(String filename, Uint8List imageBytes,
      [Function(String? path)? callback]) async {
    var value = await ImageGallerySaver.saveImage(imageBytes);
    if (value['isSuccess']) {
      String? path;
      if (value['filePath'] != null && value['filePath'].isNotEmpty) {
        path = Uri.parse(value['filePath']).path;
      }
      Loading.toast(
        'Save Success'.tr,
        // Loading.toast(
        //   'Save success${path != null ? '，path: $path' : ''}',
      );
      if (callback != null) {
        callback(path!);
      }
    } else {
      Loading.toast(
        'Save failed：' + (value['errorMessage'] ?? 'Unknown error'),
      );
      if (callback != null) {
        callback(null);
      }
    }
  }
}
