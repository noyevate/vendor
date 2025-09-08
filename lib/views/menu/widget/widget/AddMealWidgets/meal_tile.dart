import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custim_checkbox.dart';
import 'package:vendor/common/format_price.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/restaurant_menu_controller.dart';
import 'package:vendor/models/filter_by_restaurant_category_model.dart';
import 'package:vendor/views/menu/widget/widget/AddMealWidgets/edit_menu_category.dart';
import 'package:vendor/views/menu/widget/widget/create_new_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class MealTile extends HookWidget {
  const MealTile({super.key, required this.food, this.refetch});
  final RestaurantCategoryModel food;
  final Function()? refetch;

  @override
  Widget build(BuildContext context) {
    final checkedItems = useState<List<bool>>(
        List.generate(food.items.length, (index) => false));

    final controller = Get.put(RestaurantMenuController());

    final box = GetStorage();
    final restaurantId = box.read("restaurantId");

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: Tcolor.White,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReuseableText(
                  title: food.restaurantCategory,
                  style: TextStyle(
                    fontSize: 28.sp,
                    color: Tcolor.Text,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print(food.restaurantCategory);
                        controller.updateFoodAvailability(
                            restaurantId,
                            food.restaurantCategory,
                            refetch!);
                      },
                      child: ReuseableText(
                        title: "Out of stock",
                        style: TextStyle(
                          fontSize: 28.sp,
                          color: food.restaurantCategoryAvailable
                              ? Tcolor.BORDER_Light
                              : Tcolor.ERROR_Reg,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 30.w),
                    Container(
                      color: Tcolor.BORDER_Light,
                      height: 28.h,
                      width: 2.w,
                    ),
                    SizedBox(width: 30.w),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet<String>(
                          context: context,
                          isScrollControlled: true,
                          isDismissible: false,
                          builder: (context) {
                            return SizedBox(
                                height: 1150.h,
                                width: width,
                                child: EditMenuCategory(currentCategory: food.restaurantCategory, refetch: refetch,));
                          },
                        );
                      },
                      child: ReuseableText(
                        title: "Edit",
                        style: TextStyle(
                          fontSize: 28.sp,
                          color: Tcolor.PRIMARY_S4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: List.generate(food.items.length, (index) {
                Item foodItem = food.items[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 30.h, bottom: 40.h),
                          child: CustomCircularCheckbox(
                            value: checkedItems.value[index],
                            onChanged: (bool? value) {
                              checkedItems.value =
                                  List<bool>.from(checkedItems.value)
                                    ..[index] = value ?? false;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          height: 40.h,
                          width: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              foodItem.imageUrl[0],
                              // width: 170.w,
                              // height: 170.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReuseableText(
                              title: foodItem.title,
                              style: TextStyle(
                                fontSize: 28.sp,
                                color: Tcolor.Text,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "₦",
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    color: Tcolor.TEXT_Placeholder,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                ReuseableText(
                                  title: formatPrice(foodItem.price),
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Tcolor.TEXT_Placeholder,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: foodItem.isAvailable
                                        ? Tcolor.SUCCESS_Reg
                                        : Tcolor.ERROR_Reg,
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.w, right: 10.w),
                                      child: ReuseableText(
                                        title: foodItem.isAvailable
                                            ? "In-stock"
                                            : "Out of stock",
                                        style: TextStyle(
                                          fontSize: 28.sp,
                                          color: Tcolor.White,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        HeroiconsOutline.pencil,
                        color: Tcolor.PRIMARY_S4,
                        size: 32.sp,
                      ),
                    ),
                  ],
                );
              }),
            )
          ],
        ));
  }
}
