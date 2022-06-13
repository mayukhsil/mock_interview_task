import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mock_interview_task/modules/cart_page/views/cart_view.dart';
import 'package:mock_interview_task/styles/app_colors.dart';
import 'package:mock_interview_task/styles/app_text_styles.dart';

AppBar productAppBar(BuildContext context, int cartCount, bool isCartPage){
  return AppBar(
    backgroundColor: AppColor.appPrimary,
    title: isCartPage?
    Text('Cart',style: AppTextStyles.s16(fontType: FontType.MEDIUM)):
    Text('Mock Interview Task',style: AppTextStyles.s16(fontType: FontType.MEDIUM)),
    actions: <Widget>[
      isCartPage?
          Container():
      Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: GestureDetector(
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (_) => const CartView()
                ),
            );
          },
          child: Container(
            color: AppColor.appPrimary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    color: AppColor.appWhite,
                  ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_rounded,color: AppColor.appDarkGrey,size: 16.sp,),
                      Text(cartCount.toString(),
                        style: AppTextStyles.s16(
                            fontType: FontType.MEDIUM,
                            color: AppColor.appDarkGrey),
                      )
                    ],
                  ),
                ),
                )
              ],
            ),
          ),
        ),
      )
    ],
  );
}