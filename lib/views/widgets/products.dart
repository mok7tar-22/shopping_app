import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/controllers/shop/shop_cubit.dart';
import 'package:shopping_app/models/home_model.dart';
import 'package:shopping_app/views/screens/product_details_screen.dart';
import 'package:shopping_app/views/widgets/product_item.dart';
import '../../models/product_model.dart';

class Products extends StatelessWidget {
  final HomeModel homeModel;

  const Products({required this.homeModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 2,
      children: List.generate(
          homeModel.data!.products.length,
          (index) =>
              ProductItem(productModel:homeModel.data!.products[index])),


    );
  }
}

Widget productItemBuilder(ProductModel model, context) {
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(productModel:model ),));
    },
    child: Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      decoration: BoxDecoration(
        color: Color.fromARGB(223, 220, 226, 229),
        borderRadius: BorderRadius.circular(20),

      ),
      child: Column(
        children: [
          Row(

            children: [
              if(model.discount!=0)
              Container(
                  color: Colors.red,
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'Discount',
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
                    ),
                  )),
            Spacer(),
              IconButton(onPressed: () {
                ShopCubit.get(context).changeToFavorite(model.id!);
                print(model.id);
              }, icon: ShopCubit.get(context).favourite[model.id]! ?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border)   )


            ],),
          Expanded(child:Image(image: NetworkImage("${model.image}"),)),

      Text(model.name,maxLines: 1,overflow: TextOverflow.ellipsis),
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
              if(model.discount!=0)
              Expanded(
                child: Text(
                  'EGP ${model.oldPrice}',
                  style:  TextStyle(
                    fontSize: 12.sp,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),

            ],),


        ],
      ),
    ),
  );
}
