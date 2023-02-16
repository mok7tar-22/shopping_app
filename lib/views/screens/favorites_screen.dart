import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/controllers/shop/shop_cubit.dart';
import 'package:shopping_app/models/favourite_model.dart';
import 'package:shopping_app/views/widgets/progress_indicator_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).favoritesModel != null &&
              ShopCubit.get(context).favourite.isNotEmpty,
          builder: (context) =>
              ShopCubit.get(context).favoritesModel!.data!.data.isEmpty
                  ? const Center(
                      child: Text("Add Favourites Products"),
                    )
                  : ListView.builder(
                      itemCount: ShopCubit.get(context)
                          .favoritesModel!
                          .data!
                          .data
                          .length,
                      itemBuilder: (context, index) {
                        return FavouriteItem(
                          favoriteProduct: ShopCubit.get(context)
                              .favoritesModel!
                              .data!
                              .data[index]
                              .product!,
                        );
                      },
                    ),
          fallback: (context) =>const ProgressIndicatorWidget(),
        );
      },
    );
  }
}

class FavouriteItem extends StatelessWidget {
  final FavoriteProduct favoriteProduct;

  const FavouriteItem({
    required this.favoriteProduct,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      child: Row(
        children: [
          Expanded(
              child: Image(
            image: NetworkImage(favoriteProduct.image!),
          )),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (favoriteProduct.discount != 0)
                      Container(
                          color: Colors.red,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              'Discount',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          )),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context)
                            .changeToFavorite(favoriteProduct.id!);
                      },
                      icon:
                          ShopCubit.get(context).favourite[favoriteProduct.id]!
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                ),
                    )
                  ],
                ),
                 SizedBox(
                  height: 8.h,
                ),
                Text(favoriteProduct.name!,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                 SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'EGP ${favoriteProduct.price}',
                        style:  TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                    //if(model.discount!=0)
                    Expanded(
                      child: Text(
                        'EGP ${favoriteProduct.oldPrice}',
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
          )
        ],
      ),
    );
  }
}
