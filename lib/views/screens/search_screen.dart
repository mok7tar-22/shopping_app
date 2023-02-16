import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/views/screens/product_details_screen.dart';
import '../../controllers/search/seacrh_cubit.dart';
import '../../controllers/search/seacrh_state.dart';
class SearchScreen extends StatelessWidget {
  const SearchScreen( {super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocBuilder<SearchCubit,SearchStates>(
        buildWhen: (previous, current) => previous!=current,
        builder:(context, state) {
          SearchCubit cubit = SearchCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                toolbarHeight: 60.h,
                title: Padding(
                  padding: const EdgeInsets.all(7),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyText1,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'What are you looking for ?',
                      hintStyle: TextStyle(fontSize: 15.sp),
                      prefixIcon: Icon(Icons.search,color: Colors.blue,),
                    ),
                    onChanged: (value) {
                      cubit.getSearchData(value);
                    },
                  ),
                ),
              ),
              body: state is SearchLoadingState ?
              const Center(child: CircularProgressIndicator()):
              cubit.searchModel != null? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index) =>searchItemBuilder(cubit.searchModel?.data.data[index],context) ,
                separatorBuilder:(context,index) =>Divider(),
                itemCount:cubit.searchModel?.data.data.length ?? 10,
              ) :
              Container()
          );
        },

      ),
    );
  }
  Widget searchItemBuilder(ProductModel? model,context){
    return  InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(productModel:model ),));

      },
      child: Container(
        height: 120.h,
        padding: const EdgeInsets.all(10),
        child: Row(
          children:
          [
            Image(image: NetworkImage(model!.image),width: 100.w,height: 100.h,),
             SizedBox(width: 10.w,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Text(model.name,
                    style:  TextStyle(fontSize: 15.sp,),maxLines: 3,overflow: TextOverflow.ellipsis,),
                  const Spacer(),
                  Text('EGP '+'${model.price}',style:  TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}