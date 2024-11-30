import 'dart:async';

import 'package:add_to_cart_button/add_to_cart_button.dart';
import 'package:anbobtak/besnese_logic/get_method/get_method_cubit.dart';
import 'package:anbobtak/besnese_logic/get_method/get_method_state.dart';
import 'package:anbobtak/besnese_logic/get_method%20v1/get_method_cubit.dart'
    as cart;
import 'package:anbobtak/besnese_logic/get_method%20v1/get_method_state.dart';
import 'package:anbobtak/besnese_logic/uploding_data/uploding_data_cubit.dart';
import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/main.dart';
import 'package:anbobtak/presntation_lyar/screens/home/Cart.dart';
import 'package:anbobtak/presntation_lyar/screens/home/productContaner.dart';
import 'package:anbobtak/presntation_lyar/screens/mapsScreen.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:anbobtak/web_servese/model/product.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final Function(List<Map<String, dynamic>>) onCartUpdate;
  const HomeScreen({super.key, this.name, required this.onCartUpdate});
  final String? name;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> cartItems = [];
  String? _savedValue;
  int totalQuantity = 0;
  Widgets _widgets = Widgets();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<cart.GetMethodCubitV2>(context).GetCart();
    _loadData();
  }

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedValue = prefs.getString('name') ?? 'No name saved';
    });
  }

  void _calculateTotalQuantity() {
    int total = 0;
    for (var item in cartItems) {
      total += item['quantity'] as int; // If quantity is null, use 0
    }
    setState(() {
      totalQuantity = total; // Update the total quantity
    });
  }

  void _updateCart(List<Map<String, dynamic>> updatedCart) {
    setState(() {
      cartItems = updatedCart;
    });
    widget.onCartUpdate(cartItems); // Pass updated cart back to the parent
  }

  Widget _buildCartsList() {
    return BlocListener<cart.GetMethodCubitV2, GetMethodStateV1>(
      listener: (context, state) {
        if (state is GetCartsV1) {
          int totalQuantity = 0; // Variable to hold the total quantity
          setState(() {
            cartItems = state.posts
                .map((item) => {
                      'id': item.product.id,
                      'name': item.product.name,
                      'quantity': item.quantity ?? 0,
                      'price': item.product.price,
                      'image': item.product.image,
                    })
                .toList();
          });

          // Update the total quantity
          setState(() {
            this.totalQuantity = totalQuantity;
          });
          _calculateTotalQuantity();
        }
        widget.onCartUpdate(cartItems);
      },
      child: Container(), // Include a child widget (for example, a list view)
    );
  }

  Future<dynamic> _buttomSheetCart() {
    return showMaterialModalBottomSheet(
        context: context,
        builder: (context) =>
            CartScreen(quantity: totalQuantity, onCartUpdate: _updateCart));
  }

  Widget _CircleWithNumber() {
    return Container(
      width: 14.w, // Diameter of the circle
      height: 14.h, // Diameter of the circle
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color.fromARGB(
            255, 155, 48, 42), // Background color of the circle
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, designSize: const Size(360, 852));

    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Scaffold(
        
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
              width: width * 0.90,
              height: height * 0.07,
              child: _widgets.AppButton(() async {
                if (cartItems.isNotEmpty) {
                  for (var item in cartItems) {
                    BlocProvider.of<UplodingDataCubit>(context)
                        .addItemInCart(item['quantity'], item['id']);
                  }
                }
                _buttomSheetCart();
              }, "Pay", enabled: true)),
        ),
        backgroundColor: MyColors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 40.sp, left: 300.sp),
                child: Stack(
                  children: [
                    _buildCartsList(),
                    if (cartItems.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(left: 1.sp, top: 5.sp),
                        child: _CircleWithNumber(),
                      ),
                    IconButton(
                        onPressed: () {
                          if (cartItems.isNotEmpty) {
                            for (var item in cartItems) {
                              BlocProvider.of<UplodingDataCubit>(context)
                                  .addItemInCart(item['quantity'], item['id']);
                            }
                          }
                          _buttomSheetCart();
                        },
                        icon: Icon(
                          Icons.shopping_bag_outlined,
                          color: MyColors.Secondcolor,
                          size: width * 0.09,
                        )),
                  ],
                )),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Show user name or fallback if it's null
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.29, left: width * 0.06),
                      child: FadeInUp(
                        duration: Duration(milliseconds: 1500),
                        child: Text(
                          'Hi, ${widget.name ?? _savedValue ?? "Guest"}',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    // Pass the cart update function to ProductContainer
                    ProductContainer(onCartUpdate: _updateCart),
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
