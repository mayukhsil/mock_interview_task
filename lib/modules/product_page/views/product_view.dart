import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mock_interview_task/modules/cart_page/providers/cart_provider.dart';
import 'package:mock_interview_task/modules/product_page/widgets/product_app_bar.dart';
import 'package:mock_interview_task/modules/product_page/providers/product_provider.dart';
import 'package:mock_interview_task/styles/app_colors.dart';
import 'package:mock_interview_task/styles/app_text_styles.dart';

class ProductView extends ConsumerWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final state = ref.watch(productStateNotifierProvider);
    final cartChangeProvider = ref.watch(cartChangeNotifierProvider);
    return Scaffold(
      appBar: productAppBar(context,cartChangeProvider.productList.length,false),
      body: state.when(
        initial: () => Container(),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (product) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp,vertical: 20.sp),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount: product.products?.length ?? 0,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.sp,
                      mainAxisSpacing: 10.sp
                    ),
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          height: 200.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: AppColor.appDarkGrey,
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Hero(
                                        tag: '${product.products![index].id}',
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10.sp),
                                          child: SizedBox(
                                              height: 90.h,
                                              width: 90.w,
                                              child: Image.network(
                                                  product.products![index].images![0],fit: BoxFit.contain,)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5.h,),
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth: 250.w,
                                      ),
                                        child: Text(product.products![index].title!,
                                          style: AppTextStyles.s12(
                                              fontType: FontType.SEMI_BOLD),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                    ),
                                    Text('\u0024${product.products![index].price.toString()}',style: AppTextStyles.s10(fontType: FontType.SEMI_BOLD),),
                                  ],
                                ),
                                !cartChangeProvider.productList.contains(product.products![index]) ?
                                _FrostedContainer(
                                    text: 'Add to Cart',
                                    isInCart: false,
                                    onTap: (){
                                      cartChangeProvider.addToCart(product.products![index]);
                                    }):
                                _FrostedContainer(
                                    text: 'Remove from Cart',
                                    isInCart: true,
                                    onTap: (){
                                      cartChangeProvider.removeFromCart(product.products![index]);
                                    })
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                )
              ),
            ],
          ),
        ),
        error: (error) => Container(color: AppColor.appPrimary,
          child: const Center(child: Text('Error')),),
      ),
    );
  }
}

class _FrostedContainer extends StatelessWidget {

  final String text;
  final bool isInCart;
  final Function() onTap;

  const _FrostedContainer({Key? key, required this.text, required this.onTap, required this.isInCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 50.0),
            child: Container(
              width: isInCart?120.w:80.w,
              height: 30.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.sp),
                  color: Colors.grey.shade200.withOpacity(0.2)
              ),
              child: Center(
                child: Text(
                    text,
                    style: AppTextStyles.s12(fontType: FontType.SEMI_BOLD,color: AppColor.appWhite)
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}