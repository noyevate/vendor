import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/page_title.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/setup_field.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/operating_hours_controller.dart';
import 'package:vendor/enty_point.dart';
import 'package:vendor/models/add_time_model.dart';
import 'package:vendor/models/fetch_user_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor/models/loging_response_model.dart';

class OperatingHours extends StatefulWidget {
  const OperatingHours({super.key, this.restaurant});
  final LoginResponseModel? restaurant;

  @override
  State<OperatingHours> createState() => _OperatingHoursState();
}

class _OperatingHoursState extends State<OperatingHours> {
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var restaurantId = box.read("restaurantId");

    restaurantId ??= widget.restaurant!.id;

    final OperatingHoursController controller =
        Get.put(OperatingHoursController());

    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
            child: Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: Column(
                children: [
                  SizedBox(height: 60.h),
                  const PageTitle(title: "Operating hours"),
                ],
              ),
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                color: Tcolor.White,
                height: constraints.maxHeight,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 50.h),
                            ReuseableText(
                              title: "Order type",
                              style: TextStyle(
                                color: Tcolor.TEXT_Label,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Obx(() {
                              return GestureDetector(
                                child: SetupField(
                                  sufixIcon: GestureDetector(
                                    onTap: () {
                                      controller.showOrderTypeOptions(context);
                                    },
                                    child: Icon(
                                      HeroiconsOutline.chevronDown,
                                      size: 28.sp,
                                      color: Tcolor.TEXT_Label,
                                    ),
                                  ),
                                  controller: TextEditingController(
                                      text: controller.orderType.value),
                                  hintText: "choose a preferred option",
                                  onChanged: (value) {
                                    controller.orderType.value = value;
                                    controller.validateForm();
                                  },
                                  onTap: () {
                                    controller.showOrderTypeOptions(context);
                                  },
                                ),
                              );
                            }),
                            SizedBox(height: 40.h),
                            Obx(() {
                              if (controller.orderType.value == "Pre-order") {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReuseableText(
                                      title: "Order cut-off time",
                                      style: TextStyle(
                                        color: Tcolor.TEXT_Label,
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    SetupField(
                                      sufixIcon: Icon(
                                        HeroiconsOutline.chevronDown,
                                        size: 28.sp,
                                        color: Tcolor.TEXT_Label,
                                      ),
                                      onTap: () {
                                        controller.showTimePickerSheet(context,
                                            (selectedTime) {
                                          controller.orderCutOff.value =
                                              selectedTime;
                                          controller.validateForm();
                                        });
                                      },
                                      controller: TextEditingController(
                                          text: controller.orderCutOff.value),
                                      onChanged: (value) {
                                        controller.orderCutOff.value = value;
                                        controller.validateForm();
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    ReuseableText(
                                      title:
                                          "This is the time you no longer receive orders for the day",
                                      style: TextStyle(
                                        color: Tcolor.TEXT_Label,
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 40.h),
                                  ],
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),
                            SizedBox(height: 10.h),
                            Obx(() {
                              if (controller.orderType.value == "Pre-order") {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReuseableText(
                                      title: "Menu ready time",
                                      style: TextStyle(
                                        color: Tcolor.TEXT_Label,
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    SetupField(
                                      sufixIcon: Icon(
                                        HeroiconsOutline.chevronDown,
                                        size: 28.sp,
                                        color: Tcolor.TEXT_Label,
                                      ),
                                      onTap: () {
                                        controller.showTimePickerSheet(context,
                                            (selectedTime) {
                                          controller.menuReadyTime.value =
                                              selectedTime;
                                          controller.validateForm();
                                        });
                                      },
                                      controller: TextEditingController(
                                          text: controller.menuReadyTime.value),
                                      // hintText: "e.g restaurant@example.com",
                                      onChanged: (value) {
                                        controller.menuReadyTime.value = value;
                                        controller.validateForm();
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    ReuseableText(
                                      title:
                                          "This is the time when the first order is ready for delivery",
                                      style: TextStyle(
                                        color: Tcolor.TEXT_Label,
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 40.h),
                                  ],
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),
                            ReuseableText(
                              title: "Day",
                              style: TextStyle(
                                color: Tcolor.TEXT_Label,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SetupField(
                              contentPadding:
                                  EdgeInsets.only(left: 10.w, bottom: 50.h),
                              controller:
                                  TextEditingController(text: controller.day.value),
                              onChanged: (value) {
                                controller.day.value = value;
                                controller.validateForm();
                              },
                            ),
                            SizedBox(height: 40.h),
                            Obx(() {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ReuseableText(
                                        title: "Open",
                                        style: TextStyle(
                                          color: Tcolor.TEXT_Label,
                                          fontSize: 28.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SetupField(
                                        width: 300.w,
                                        contentPadding: EdgeInsets.only(
                                            left: 10.w, bottom: 50.h),
                                        onTap: () {
                                          controller.showTimePickerSheet(context,
                                              (selectedTime) {
                                            controller.open.value = selectedTime;
                                            controller.validateForm();
                                          });
                                        },
                                        controller: TextEditingController(
                                            text: controller.open.value),
                                        hintText: "9am",
                                        onChanged: (value) {
                                          controller.open.value = value;
                                          controller.validateForm();
                                        },
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ReuseableText(
                                        title: "Close",
                                        style: TextStyle(
                                          color: Tcolor.TEXT_Label,
                                          fontSize: 28.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SetupField(
                                        width: 300.w,
                                        contentPadding: EdgeInsets.only(
                                            left: 10.w, bottom: 50.h),
                                        onTap: () {
                                          controller.showTimePickerSheet(context,
                                              (selectedTime) {
                                            controller.close.value = selectedTime;
                                            controller.validateForm();
                                          });
                                        },
                                        controller: TextEditingController(
                                            text: controller.close.value),
                                        hintText: "9pm",
                                        onChanged: (value) {
                                          controller.close.value = value;
                                          controller.validateForm();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                            SizedBox(height: 200.h),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 30.w, right: 30.w, bottom: 20.h),
                      child: GestureDetector(
                        onTap: () async {
                          print(restaurantId);
                          var orderType1 = controller.orderType.value;
                          var day1 = controller.day.value;
                          var open1 = controller.open.value;
                          var close1 = controller.close.value;
                          var menuReadyTime1 = controller.menuReadyTime.value;
                          var orderCutOffTime1 = controller.orderCutOff.value;
        
                          if (controller.orderType.value == "Pre-order") {
                            if (day1.isNotEmpty &&
                                open1.isNotEmpty &&
                                close1.isNotEmpty &&
                                menuReadyTime1.isNotEmpty &&
                                orderCutOffTime1.isNotEmpty) {
                              final AddTimeModel model = AddTimeModel(
                                  orderType: orderType1,
                                  day: day1,
                                  open: open1,
                                  close: close1,
                                  menuReadyTime: menuReadyTime1,
                                  orderCutOffTime: orderCutOffTime1);
                              String data = addTimeModelToJson(model);
                              print(model);
                              int? statusCode = await controller.addOperaingHours(
                                  restaurantId, data);
        
                              print("data: $data");
                              if (statusCode == 200) {
                                print("200");
                                Get.close(1);
        
                                Get.back();
                              } else {}
                            } else {
                              Get.snackbar(
                                "",
                                "",
                                duration: const Duration(seconds: 3),
                                backgroundColor: Tcolor.BACKGROUND_Regaular,
                                titleText: ReuseableText(
                                  title: "Success",
                                  style: TextStyle(
                                      fontSize: 28.sp,
                                      color: Tcolor.Text,
                                      fontWeight: FontWeight.w600),
                                ),
                                messageText: ReuseableText(
                                  title: "complet the neccessary fields",
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Tcolor.ERROR_Light_2,
                                      fontWeight: FontWeight.w600),
                                ),
                              );
                            }
                          } else if (controller.orderType.value ==
                              "Instant delivery") {
                            menuReadyTime1 = "";
                            orderCutOffTime1 = "";
                            if (day1.isNotEmpty &&
                                open1.isNotEmpty &&
                                close1.isNotEmpty) {
                              final AddTimeModel model = AddTimeModel(
                                  orderType: orderType1,
                                  day: day1,
                                  open: open1,
                                  close: close1);
                              String data = addTimeModelToJson(model);
                              int? statusCode = await controller.addOperaingHours(
                                  restaurantId, data);
                              if (statusCode == 200) {
                                print("Instant 200");
                                try {
                                  Get.back();
                                } catch (e) {
                                  print("Error closing: $e");
                                }
                              } else {}
                            } else {
                              Get.snackbar(
                                "",
                                "",
                                duration: const Duration(seconds: 3),
                                backgroundColor: Tcolor.BACKGROUND_Regaular,
                                titleText: ReuseableText(
                                  title: "Success",
                                  style: TextStyle(
                                      fontSize: 28.sp,
                                      color: Tcolor.Text,
                                      fontWeight: FontWeight.w600),
                                ),
                                messageText: ReuseableText(
                                  title: "complete the neccessary fields",
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Tcolor.ERROR_Light_2,
                                      fontWeight: FontWeight.w600),
                                ),
                              );
                            }
                          }
                        },
                        child: CustomButton(
                          title: "Save changes",
                          textColor: Tcolor.Text,
                          btnColor: Tcolor.PRIMARY_Button_color_2,
                          btnWidth: width,
                          btnHeight: 96.h,
                          raduis: 100.r,
                          fontSize: 32.sp,
                          showArrow: false,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Obx(() {
          if (controller.isLoading) {
            return Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5), // Dim background
                child: Center(
                  child: LottieBuilder.asset(
                    'assets/animation/loading_state.json', // Replace with your Lottie file path
                    width: 200.w,
                    height: 200.h,
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
