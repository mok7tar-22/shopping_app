import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/utils/app_constants.dart';
import 'package:shopping_app/utils/constants_widgets.dart';
import 'package:shopping_app/views/widgets/products.dart';

import '../../controllers/shop/shop_cubit.dart';
import '../../models/home_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {
          if(state is  ShopSuccessChangeFavouriteState){
            if(!state.favouriteModel.status){
             return ConstantsWidgets.getSnackBar(context, state.favouriteModel.message!,Colors.red);
            }
          }
        },
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.homeModel != null,
            builder: (context) => productBuilder(cubit.homeModel, context),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Widget productBuilder(HomeModel? homeModel, context) {
    return SingleChildScrollView(
      //physics: const BouncingScrollPhysics(),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: homeModel!.data!.banners
                  .map((e) => Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image(
                          image: NetworkImage('${e.image}'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                  ))
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                enableInfiniteScroll: true,
                height: 200.h,
                initialPage: 0,
                reverse: false,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1,
              ),
            ),

            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                child:  Text(
                  AppConstants.productScreenTitle,
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                )),


             Products(homeModel: homeModel),
          ],
        ),
      ),
    );
  }
}
