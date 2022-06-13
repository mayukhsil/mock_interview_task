import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mock_interview_task/modules/cart_page/providers/cart_provider.dart';
import 'package:mock_interview_task/modules/product_page/widgets/product_app_bar.dart';
import 'package:mock_interview_task/styles/app_colors.dart';
import 'package:mock_interview_task/styles/app_text_styles.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartView extends ConsumerWidget{
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartChangeProvider = ref.watch(cartChangeNotifierProvider);
    return Scaffold(
      appBar: productAppBar(context,cartChangeProvider.productList.length,true),
      body: (cartChangeProvider.productList.isEmpty)
        ? Center(
          child: Text('Cart is empty',style: AppTextStyles.s16(fontType: FontType.SEMI_BOLD),),
        ): ListView.builder(
          itemCount: cartChangeProvider.productList.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(cartChangeProvider.productList[index].title ?? ""),
            subtitle: Text('\u0024${cartChangeProvider.productList[index].price.toString()}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: (){
                cartChangeProvider.removeFromCart(cartChangeProvider.productList[index]);
              },
            ),
          );
        },
      ),
      bottomNavigationBar: (cartChangeProvider.productList.isEmpty)?
      Container(
        height: 10.h,
      ):
      Container(
        height: 120.h,
        decoration: const BoxDecoration(
          color: AppColor.appPrimary
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total:',style: AppTextStyles.s16(fontType: FontType.SEMI_BOLD),),
                  Text('\u0024${cartChangeProvider.cartTotal}',style: AppTextStyles.s16(fontType: FontType.SEMI_BOLD),)
              ],
              ),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CartActionButton(
                      text: 'Checkout',
                      onTap: (){
                        cartChangeProvider.checkoutCart();
                        Fluttertoast.showToast(
                            msg: "Order Placed Successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppColor.appDarkGrey,
                            textColor: AppColor.appWhite,
                            fontSize: 16.sp
                        );
                        Navigator.pop(context);
                      }
                  ),
                  _CartActionButton(
                      text: 'Clear Cart',
                      onTap: (){
                        cartChangeProvider.clearCart();
                      }
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CartActionButton extends StatelessWidget {

  final String text;
  final Function() onTap;

  const _CartActionButton({Key? key, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: 120.w,
        decoration: BoxDecoration(
          color: AppColor.appWhite,
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Center(
          child: Text(text,
            style: AppTextStyles.s16(
                fontType: FontType.SEMI_BOLD,
                color: AppColor.appDarkGrey
            ),),
        ),
      ),
    );
  }
}
