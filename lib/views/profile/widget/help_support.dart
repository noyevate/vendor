import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/page_title.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpSupport extends StatelessWidget {
  const HelpSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: const PageTitle(title: "Help and Support",),
            )
          ],
        ),
      ),
      body: Container(),
    );
  }
}