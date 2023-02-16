import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import '../../controllers/shop/shop_cubit.dart';
import '../../models/product_model.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel productModel;

  const ProductDetails({required this.productModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (productModel.discount != 0)
                  Container(
                      color: Colors.red,
                      child:  Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'Discount',
                          style: TextStyle(fontSize: 14.sp, color: Colors.white),
                        ),
                      )),
                Spacer(),
                IconButton(
                    onPressed: () {
                      ShopCubit.get(context).changeToFavorite(productModel.id!);
                    },
                    icon: ShopCubit.get(context).favourite[productModel.id]!
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(Icons.favorite_border))
              ],
            ),
            Image(
              image: NetworkImage("${productModel.image}"),
            ),
           const Text("Product Name"),
            Text(productModel.name),
             SizedBox(height: 8.h,),
            ReadMoreText(
              productModel.description,
              trimLines: 3,
              textAlign: TextAlign.justify,
              trimMode: TrimMode.Line,
              trimCollapsedText: " Show More ",
              trimExpandedText: " Show Less ",
              style:  TextStyle(fontSize: 18.sp),
              moreStyle:  TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 20.sp),
              lessStyle:  TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 20.sp),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'EGP ${productModel.price}',
                    style:  TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                if (productModel.discount != 0)
                  Expanded(
                    child: Text(
                      'EGP ${productModel.oldPrice}',
                      style:  TextStyle(
                        fontSize: 12.sp,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  },
);
  }
}
