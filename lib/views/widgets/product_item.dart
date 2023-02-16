import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controllers/shop/shop_cubit.dart';
import '../../models/product_model.dart';
import '../screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  final ProductModel productModel;

  const ProductItem({required this.productModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetails(productModel: productModel),
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(223, 220, 226, 229),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                if (productModel.discount != 0)
                  Container(
                      color: Colors.red,
                      child:  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'Discount',
                          style: TextStyle(fontSize: 14.sp, color: Colors.white),
                        ),
                      )),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    ShopCubit.get(context).changeToFavorite(productModel.id!);
                    print(productModel.id);
                  },
                  icon: ShopCubit.get(context).favourite[productModel.id]!
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(Icons.favorite_border),
                )
              ],
            ),
            Expanded(
                child: Image(
              image: NetworkImage("${productModel.image}"),
            )),
            Text(productModel.name,
                maxLines: 1, overflow: TextOverflow.ellipsis),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'EGP ${productModel.price}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                if (productModel.discount != 0)
                  Expanded(
                    child: Text(
                      'EGP ${productModel.oldPrice}',
                      style: const TextStyle(
                        fontSize: 12,
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
  }
}
