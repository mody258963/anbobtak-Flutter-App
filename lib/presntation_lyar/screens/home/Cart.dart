

import 'package:anbobtak/besnese_logic/get_method%20v1/get_method_cubit.dart';
import 'package:anbobtak/besnese_logic/get_method%20v1/get_method_state.dart';
import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/presntation_lyar/screens/mapsScreen.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class CartScreen extends StatefulWidget {
final int quantity;
  const CartScreen({super.key,  required this.quantity });
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Widgets _widgets = Widgets();

  @override
  void initState() {
    super.initState();
      BlocProvider.of<GetMethodCubitV2>(context).GetCart();
print('Quantity passed to CartScreen: ${widget.quantity}'); 
  }

  // Method to build the cart list and update the quantity
  Widget _buildCartList() {
    return BlocBuilder<GetMethodCubitV2, GetMethodStateV1>(
      builder: (context, state) {
        if (state is GetCartsV1) {
          final cart = state.posts;
          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: cart.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                childAspectRatio: 5,
              ),
              itemBuilder: (context, index) {
                final allcart = cart[index];

                return ListTile(
                  leading: Icon(
                    Icons.shopping_cart,
                    color: MyColors.Secondcolor,
                  ),
                  title: Text(
                    allcart.product.name,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Quantity: ${allcart.quantity}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                  trailing: Text(
                    'EGP ${allcart.price}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetMethodCubitV2, GetMethodStateV1>(
      listener: (context, state) {
        if (state is GetCartsV1) {
          // Once the cart is fetched, you may perform any other action
          // For now, we will simply ensure that cart data is loaded when entering the screen
        }
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCartList(),
            _widgets.AppButton(() {
                  PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: MapScreen(),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
            }, "Pay")
          ],
        ),
      ),
    );
  }
}
