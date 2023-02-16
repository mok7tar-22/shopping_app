import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/data/local/preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../controllers/boarding/boarding_cubit.dart';
import '../../data/local/boarding_data.dart';
import '../widgets/boarding_item.dart';
import 'authentication/login_screen.dart';

class BoardingScreen extends StatelessWidget {
  const BoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BoardingCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  Preferences.saveData(key: 'ShowOnBoard', value: false).then((value){
                    if(value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                    }

                  });

                },
                child: Text("Skip"))
          ],
        ),
        body: BlocBuilder<BoardingCubit, BoardingState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: PageView.builder(
                      itemCount: boarding.length,
                      controller: BoardingCubit.get(context).boardController,
                      onPageChanged: (index) {

                          BoardingCubit.get(context).changeScreen(
                              index, context);

                      },
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BoardingItem(boardingModel: boarding[index]);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmoothPageIndicator(
                        controller: BoardingCubit.get(context).boardController,
                        effect: const ExpandingDotsEffect(
                            expansionFactor: 4,
                            dotHeight: 10,
                            dotWidth: 10,
                            spacing: 10),
                        count: 3,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          if (BoardingCubit.get(context).isLast) {
                            Preferences.saveData(key: 'ShowOnBoard', value: false).then((value){
                              if(value) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                    ));
                              }

                            });
                          } else {
                            BoardingCubit.get(context).boardController.nextPage(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                );
                          }
                        },
                        child: Icon(Icons.arrow_forward_ios_sharp),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
