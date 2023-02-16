import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/controllers/shop/shop_cubit.dart';
import '../../models/product_model.dart';
import '../widgets/product_item.dart';

class CategoriesDetailsScreen extends StatelessWidget {
  const CategoriesDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        return state is ShopLoadingCategoriesDetailsDataState
            ? const Scaffold(
                body: Center(
                child: CircularProgressIndicator(),
              ))
            : ShopCubit.get(context)
                        .categoryDetailsModel!
                        .data
                        .productData.isEmpty
                ? const Center(
                    child: Text(
                      'Coming Soon',
                      style: TextStyle(fontSize: 50),
                    ),
                  )
                : ConditionalBuilder(
          condition:ShopCubit.get(context).favoritesModel != null &&
              ShopCubit.get(context).favourite.isNotEmpty,
          builder: (context) =>Scaffold(
            appBar: AppBar(),
            body: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 2,
              childAspectRatio: 0.6,
              mainAxisSpacing: 2,
              children: List.generate(
                  ShopCubit.get(context)
                      .categoryDetailsModel!
                      .data
                      .productData
                      .length,
                      (index) => ProductItem(
                    productModel: ShopCubit.get(context)
                        .categoryDetailsModel!
                        .data
                        .productData[index],
                  )),
            ),
          ),
          fallback: (context) =>
              Center(child: CircularProgressIndicator.adaptive()),
        );
      },
    );
  }
}

Widget productItemBuilder(ProductModel model, context) {
  print(model.id);
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    decoration: BoxDecoration(
      color: Color.fromARGB(223, 220, 226, 229),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: [
        Row(
          children: [
            if (model.discount != 0)
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
                  ShopCubit.get(context).changeToFavorite(model.id!);
                },
                icon:  ShopCubit.get(context).favourite[model.id]!
                    ? Icon(
                  Icons.favorite,
                  color: Colors.red,
                )
                    : Icon(
                  Icons.favorite_border,
                ),
            )
          ],
        ),
        Expanded(
            child: Image(
          image: NetworkImage("${model.image}"),
        )),
        Text(model.name, maxLines: 1, overflow: TextOverflow.ellipsis),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'EGP ${model.price}',
                style:  TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
            ),
            if (model.discount != 0)
              Expanded(
                child: Text(
                  'EGP ${model.oldPrice}',
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
  );
}
