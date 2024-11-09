import 'dart:async';

import 'package:add_to_cart_button/add_to_cart_button.dart';
import 'package:anbobtak/besnese_logic/get_method/get_method_cubit.dart';
import 'package:anbobtak/besnese_logic/get_method/get_method_state.dart';
import 'package:anbobtak/besnese_logic/uploding_data/uploding_data_cubit.dart';
import 'package:anbobtak/besnese_logic/uploding_data/uploding_data_state.dart';
import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/costanse/pages.dart';
import 'package:anbobtak/presntation_lyar/screens/home/productContaner.dart';
import 'package:anbobtak/presntation_lyar/screens/mapsScreen.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:anbobtak/web_servese/model/product.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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
    BlocProvider.of<GetMethodCubit>(context).GetProductAndCart();
    _loadData();
  }

  List<Map<String, dynamic>> cartItems = [];

  String? _savedValue;

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedValue = prefs.getString('name') ?? 'No name saved';
    });
  }

  Widgets _widgets = Widgets();
  int counter = 0;
  double totalPrice = 0;
  int totalQuantity = 0;
  int initialQuantaty = 0;

  void _calculateTotalQuantity(List<dynamic> items) {
    int newTotalQuantity = 0;

    for (var item in items) {
      newTotalQuantity += item.quantity as int;
    }

    setState(() {
      totalQuantity = newTotalQuantity;
    });
    print('asdasdasdasdasdasd$totalQuantity');
  }

  Widget _buildCartsList() {
    return BlocListener<GetMethodCubit, GetMethodState>(
      listener: (context, state) {
        if (state is GetCartsandProducts) {
          final items = state.cart;

          // Calculate total quantity and update the state
          _calculateTotalQuantity(items);
        }
      },
      child: Container(), // Include a child widget (for example, a list view)
    );
  }


  Widget _CircleWithNumber() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.058, // Diameter of the circle
      height: height * 0.03, // Diameter of the circle
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue, // Background color of the circle
      ),
      child: Center(
        child: Text(
          totalQuantity.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: width * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }



  void showBottomSheet(BuildContext context) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: const Text("This is your cart"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins', // Set the global font here
      ),
      home: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
              width: width * 0.90,
              height: height * 0.07,
              child: _widgets.AppButton(() async {
                for (var item in cartItems) {
                  BlocProvider.of<UplodingDataCubit>(context)
                      .addItemInCart(item['quantity'], item['id']);
                }
                print('=================$cartItems');
                // PersistentNavBarNavigator.pushNewScreen(
                //   context,
                //   screen: MapScreen(),
                //   withNavBar: true, // OPTIONAL VALUE. True by default.
                //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                // );
              }, "Pay")),
        ),
        backgroundColor: MyColors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.05, left: width * 0.8),
              child: Stack(
                children: [
                  _buildCartsList(),
                  _CircleWithNumber(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.shopping_bag_outlined,
                        color: MyColors.Secondcolor,
                        size: width * 0.09,
                      )),
                ],
              ),
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
                                right: width * 0.20, left: width * 0.06),
                            child: _widgets.TitleText(
                                'Hi, ${widget.name != null ? widget.name : _savedValue} ',
                                25),
                          )),
                    ),
                    ProductContainer(),
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
