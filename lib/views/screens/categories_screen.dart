import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/controllers/shop/shop_cubit.dart';
import 'package:shopping_app/models/categories_model.dart';
import 'package:shopping_app/views/screens/Categories_details.dart';
import 'package:shopping_app/views/widgets/progress_indicator_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).categoriesModel != null,
            builder: (context) {
              return ListView.builder(
                itemCount:
                    ShopCubit.get(context).categoriesModel!.data.data.length,
                itemBuilder: (context, index) {
                  return CategoryItem(
                      dataModel: ShopCubit.get(context)
                          .categoriesModel!
                          .data
                          .data[index]);
                },
              );
            },
            fallback: (context) => const ProgressIndicatorWidget());
      },
    );
  }
}

class CategoryItem extends StatelessWidget {
  final DataModel dataModel;

  const CategoryItem({
    required this.dataModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ShopCubit.get(context).getCategoriesDetailsData(dataModel.id);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoriesDetailsScreen(),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.white70,
          child: Row(
            children: [
              Image(
                image: NetworkImage(dataModel.image!),
                fit: BoxFit.cover,
                width: 90.w,
                height: 90.h,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                dataModel.name!,
                style: TextStyle(fontSize: 18.sp),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios_sharp)
            ],
          ),
        ),
      ),
    );
  }
}
