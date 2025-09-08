// ignore_for_file: body_might_complete_normally_nullable, prefer_final_fields, unused_local_variable

import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/payout_controller.dart';
import 'package:vendor/controller/restaurant_setup_controller.dart';
import 'package:vendor/enty_point.dart';
import 'package:vendor/models/api_error.dart';
import 'package:vendor/models/loging_response_model.dart';
import 'package:vendor/others/waiting_page.dart';
import 'package:vendor/views/auth/login/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

import 'package:vendor/views/auth/widget/welcome_page.dart';
import 'package:vendor/views/restaurant/restaurant_seup/restaurant_profile_widgets/restaurant_details.dart';

class LoginController extends GetxController {
  final box = GetStorage();
  final controller = Get.put(RestaurantSetupController());
  final accountcontroller = Get.put(PayoutController());

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set setLoading(bool newValue) {
    _isLoading.value = newValue;
  }

  Future<void> login(String data) async {
    box.erase();
    // Retrieve user data from storage

    setLoading = true;
    Uri url = Uri.parse("$appBaseUrl/vendor");
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(url, headers: headers, body: data);
      print(response.body);
      if (response.statusCode == 201) {
        LoginResponseModel responseData =
            loginResponseModelFromJson(response.body);

        String userData = jsonEncode(responseData);

        box.write("token", responseData.userToken);
        box.write("userID", responseData.id);
        box.write("email", responseData.email);
        box.write("phone", responseData.phone);
        box.write("firstName", responseData.firstName);
        box.write("lastName", responseData.lastName);
        box.write("restaurantId", responseData.restaurant?.id);
        box.write("code", responseData.restaurant?.code);
        setLoading = false;
        if ( responseData.restaurant != null && responseData.restaurant!.accountNumber.isNotEmpty &&
            responseData.restaurant!.accountName.isNotEmpty) {
          accountcontroller.isAccountDetails.value = true;
        }
        

        if (responseData.restaurant != null) {
          switch (responseData.restaurant?.verification) {
            case null:
            
              controller.isRestaurant.value = true;
          //     if (responseData.restaurant!.accountNumber.isNotEmpty &&
          //   responseData.restaurant!.accountName.isNotEmpty) {
          // accountcontroller.isAccountDetails.value = true;
        // }
              Get.offAll(() => WelcomePage(),
                  transition: Transition.leftToRight,
                  duration: const Duration(milliseconds: 700));
              break;
            case "Pending":
              controller.isRestaurant.value = true;
        //       if (responseData.restaurant!.accountNumber.isNotEmpty &&
        //     responseData.restaurant!.accountName.isNotEmpty) {
        //   accountcontroller.isAccountDetails.value = true;
        // }
              Get.offAll(
                  () => MainScreen(
                        loginModel: responseData,
                      ),
                  transition: Transition.leftToRight,
                  duration: const Duration(milliseconds: 700));
              break;

            case "Verified":
              controller.isRestaurant.value = true;
        //       if (responseData.restaurant!.accountNumber.isNotEmpty &&
        //     responseData.restaurant!.accountName.isNotEmpty) {
        //   accountcontroller.isAccountDetails.value = true;
        // }
              Get.offAll(
                  () => MainScreen(
                        loginModel: responseData,
                      ),
                  transition: Transition.leftToRight,
                  duration: const Duration(milliseconds: 700));
            default:
              break;
          }
        } else {
          print("somethin");
          Get.offAll(
            () => const MainScreen(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 700),
          );
        }

        // Get.offAll(
        //   () => const MainScreen(),
        //   transition: Transition.fadeIn,
        //   duration: const Duration(milliseconds: 700),
        // );
        Get.snackbar(
          'Success',
          'Logged in Successfully.',
          margin: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 10), // Smaller margin
          padding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 5), // Compact padding
          borderRadius: 8, // Rounded corners for a sleeker look
          // backgroundColor: Colors.black
          // .withOpacity(0.7), // Transparent background
          colorText: Tcolor.PRIMARY_S4,
          barBlur: 10, // Adds a blur effect
          duration: const Duration(seconds: 20), // Reduce display time
        );
      } else {
        var error = apiErrorFromJson(response.body);
        Get.defaultDialog(
          backgroundColor: Tcolor.White,
          title: "Verification Failed",
          titleStyle: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
              color: Tcolor.TEXT_Placeholder),
          middleText: error.message,
          middleTextStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: Tcolor.TEXT_Label),
          textConfirm: "OK",
          onConfirm: () {
            Get.back();
          },
          barrierDismissible: false,
          confirmTextColor: Tcolor.Text,
          buttonColor: Tcolor.TEXT_Label,
        );
        setLoading = false;
      }
    } catch (e) {
      debugPrint(e.toString());
      setLoading = false;
    }
  }

  void logout() {
    box.erase();
    Get.offAll(() => const LoginPage());
  }

  LoginResponseModel? getUserInfo() {
    String? userId = box.read('userId');
    String? data;
    if (userId != null) {
      data = box.read(userId);
      print(" this is the data id: ${data}");
    }

    if (data != null) {
      return loginResponseModelFromJson(data);
    }
    return null;
  }
}
