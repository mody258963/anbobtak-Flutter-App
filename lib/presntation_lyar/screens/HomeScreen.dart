import 'dart:async';

import 'package:add_to_cart_button/add_to_cart_button.dart';
import 'package:anbobtak/besnese_logic/get_method/get_method_cubit.dart';
import 'package:anbobtak/besnese_logic/get_method/get_method_state.dart';
import 'package:anbobtak/besnese_logic/uploding_data/uploding_data_cubit.dart';
import 'package:anbobtak/besnese_logic/uploding_data/uploding_data_state.dart';
import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/costanse/pages.dart';
import 'package:anbobtak/presntation_lyar/screens/mapsScreen.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.name});
  final name;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    super.initState();
    BlocProvider.of<GetMethodCubit>(context).GetProduct();
    BlocProvider.of<UplodingDataCubit>(context).CreateCart();
    _loadData();
  }

  String? _savedValue;

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedValue = prefs.getString('name') ?? 'No name saved';
    });
  }

  Widgets _widgets = Widgets();
  int counter = 0;



  Widget _buildProductList() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<GetMethodCubit, GetMethodState>(
      builder: (context, state) {
        if (state is GetProducts) {
          final items = state.posts;
          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: FadeInUp(
              duration: Duration(milliseconds: 1500),
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: items.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 1.0,
                  childAspectRatio:
                      ((width / 0.12) / (height - kToolbarHeight - 50) / 2.1),
                ),
                itemBuilder: (context, index) {
                  final allList = items[index];

                  print("=====lolo=====${allList.name.toString()}");
                  return _container(allList);
                },
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _container(allList) {
    print(allList);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () async {},
      child: Container(
        margin: EdgeInsets.all(14.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Container(
            height: height * 0.19,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: '${allList.image.toString()}',
                    width: width * 0.235,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: height * 0.15,
                    width: width * 0.70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${allList.name.toString()}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.05,
                          ),
                        ),
                        Text(
                          '${allList.description.toString()}',
                          style: TextStyle(
                            fontSize: width * 0.03,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              'EGP',
                              style: TextStyle(
                                fontSize: width * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '${allList.price.toString()}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 40),
                Container(
                  height: height * 0.14,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: width * 0.1),
                      Row(
                        children: [
                            AddToCartCounterButton(
                    initNumber: 0,
                    minNumber: 0,
                    maxNumber: 10,
                    increaseCallback: () {},
                    decreaseCallback: () {},
                    counterCallback: (int count) {
                      print('Current count: ${allList.id.toString()}');

                    },
                    backgroundColor: Colors.white,
                    buttonFillColor: Colors.black,
                    buttonIconColor: Colors.white,
                  ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
              width: width * 0.90,
              height: height * 0.07,
              child: _widgets.AppButton(()async{   
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: MapScreen(),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );}, "Pay   EGP 100.50") ),
        ),
        backgroundColor: MyColors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:EdgeInsets.only(top :height * 0.05 , left: width * 0.8),
              child: IconButton(onPressed: (){}, icon: Icon(Icons.shopping_bag_outlined,color: MyColors.Secondcolor,size: width * 0.09,)),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: FadeInUp(
                          duration: Duration(milliseconds: 1500),
                          child: Padding(
                            padding: EdgeInsets.only(
                                
                                right: width * 0.20,
                                left: width * 0.06),
                            child: _widgets.TitleText(
                                'Hi, ${widget.name != null ? widget.name : _savedValue} ',
                                30),
                          )),
                    ),
                    _buildProductList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
