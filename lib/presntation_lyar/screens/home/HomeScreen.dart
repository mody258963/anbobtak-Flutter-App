import 'dart:async';

import 'package:add_to_cart_button/add_to_cart_button.dart';
import 'package:anbobtak/besnese_logic/get_method/get_method_cubit.dart';
import 'package:anbobtak/besnese_logic/get_method/get_method_state.dart';
import 'package:anbobtak/besnese_logic/uploding_data/uploding_data_cubit.dart';
import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/presntation_lyar/screens/home/Cart.dart';
import 'package:anbobtak/presntation_lyar/screens/home/productContaner.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:anbobtak/web_servese/model/product.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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
    BlocProvider.of<GetMethodCubit>(context).GetProductAndCart();
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
    return BlocListener<GetMethodCubit, GetMethodState>(
      listener: (context, state) {
        if (state is GetCartsandProducts) {
          final items = state.cart;

          int totalQuantity = 0; // Variable to hold the total quantity

          // Iterate through each cart item and calculate total quantity
          for (var item in items) {
            totalQuantity += item.quantity
                as int; // Assuming quantity is a field in each cart item
          }

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
        context: context, builder: (context) => CartScreen());
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                padding:
                    EdgeInsets.only(top: height * 0.05, left: width * 0.85),
                child: Stack(
                  children: [
                    _buildCartsList(),
                    IconButton(
                        onPressed: () {
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
