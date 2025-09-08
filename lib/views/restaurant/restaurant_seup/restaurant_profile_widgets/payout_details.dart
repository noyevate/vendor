import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/page_title.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/setup_field.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/payout_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vendor/models/restaurant_account_details.dart';

class PayoutDetails extends StatefulWidget {
  const PayoutDetails({super.key});

  @override
  State<PayoutDetails> createState() => _PayoutDetailsState();
}

class _PayoutDetailsState extends State<PayoutDetails> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PayoutController());
    final box = GetStorage();

    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
            child: Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 60.h,
                  ),
                  const PageTitle(
                    title: "Payout details",
                  ),
                ],
              ),
            ),
          ),
          body: LayoutBuilder(builder: (context, constraints) {
            return Container(
              color: Tcolor.White,
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        ReuseableText(
                          title: "Bank",
                          style: TextStyle(
                            color: Tcolor.TEXT_Label,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
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
                                  text: controller.bank['name']),
                              hintText: "choose a preferred option",
                              onChanged: (value) {
                                controller.bank['name'] = value;
                              },
                              onTap: () {
                                controller.showOrderTypeOptions(context);
                              },
                            ),
                          );
                        }),
                        SizedBox(
                          height: 40.h,
                        ),
                        ReuseableText(
                          title: "Account number",
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
                          sufixIcon: Icon(
                            HeroiconsOutline.chevronDown,
                            size: 28.sp,
                            color: Tcolor.BACKGROUND_Regaular,
                          ),
                          controller: controller.accountNumber,
                          hintText: "Enter account number",
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        ReuseableText(
                          title: "Account name",
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
                          controller: controller.accountName,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        SizedBox(height: 50.h)
                      ],
                    ),
                  )),
                  SizedBox(height: 50.h),
                  CustomButton(
                    title: "Save changes",
                    textColor: Tcolor.Text,
                    btnColor: Tcolor.Primary_New,
                    btnWidth: width,
                    btnHeight: 96.h,
                    raduis: 100.r,
                    fontSize: 32.sp,
                    onTap: controller.accountNumber.text.isNotEmpty &&
                            controller.accountName.text.isNotEmpty &&
                            controller.bank['code']!.isNotEmpty
                        ? () async {
                            var bankCode = controller.bank['code'].toString();
                            var restaurantId = box.read("restaurantId");
                            RestaurantAccountDetails model =
                                RestaurantAccountDetails(
                                    restaurantId: restaurantId,
                                    accountName: controller.accountName.text,
                                    accountNumber: controller.accountNumber.text,
                                    bank: bankCode);
                            String data = restaurantAccountDetailsToJson(model);
                            print("data: ${data}");
                            int? statusCode = await controller.addAccountDetails(data);
                            if (statusCode == 200) {
                              print("Restaurant created successfully.");
                              await Future.delayed(const Duration(seconds: 2));
                            } else {
                              print(
                                  "Failed to create restaurant. Status code: $statusCode");
                            }
                          }
                        : null,
                    showArrow: false,
                  ),
                  SizedBox(height: 30.h)
                ],
              ),
            );
          }),
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
