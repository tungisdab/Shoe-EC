import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Notice extends StatefulWidget {
  const Notice({super.key});

  @override
  State<Notice> createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w),
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
        height: 300.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(3, 5),
            ),
          ],
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SizedBox(
                height: 30.h,
                child: Image.asset('assets/icons/common/previous.png'),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  height: 30.h,
                  child: Image.asset(
                    "assets/icons/nav/shopping.png",
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                SizedBox(
                  height: 30.h,
                  child: Image.asset(
                    "assets/icons/common/lo.png",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ])));
  }
}
