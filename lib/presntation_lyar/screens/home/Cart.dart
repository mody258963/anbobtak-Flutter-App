import 'package:anbobtak/besnese_logic/get_method%20v1/get_method_cubit.dart';
import 'package:anbobtak/besnese_logic/get_method%20v1/get_method_state.dart';
import 'package:anbobtak/besnese_logic/get_method/get_method_cubit.dart';
import 'package:anbobtak/besnese_logic/uploding_data/uploding_data_cubit.dart';
import 'package:anbobtak/besnese_logic/uploding_data/uploding_data_state.dart';
import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/costanse/extensions.dart';
import 'package:anbobtak/costanse/pages.dart';
import 'package:anbobtak/presntation_lyar/screens/mapsScreen.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class CartScreen extends StatefulWidget {
  final int quantity;
  final Function(List<Map<String, dynamic>>) onCartUpdate;
  const CartScreen(
      {super.key, required this.quantity, required this.onCartUpdate});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Widgets _widgets = Widgets();
  int currentQuantity = 0;
  bool carts = false;
  @override
  void initState() {
    super.initState();
   BlocProvider.of<GetMethodCubitV2>(context).GetCart();
    print('Quantity passed to CartScreen: ${widget.quantity}');
  }

  void updateQuantity(int quantity) {
    setState(() {
      currentQuantity = quantity;
    });
  }

  Widget _buildCartList() {
    return BlocBuilder<GetMethodCubitV2, GetMethodStateV1>(
      builder: (context, state) {
        if (state is GetCartsV1) {
          carts = true;
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'EGP ${allcart.price}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            try {
                              final productId = allcart.product.id;

                              // Delete the product from the backend using the Bloc
                              BlocProvider.of<UplodingDataCubit>(context)
                                  .deleteProduct(productId);

                              // Update local cart
                              cart.removeWhere(
                                  (item) => item.product.id == productId);

                              // Map the cart to JSON and ensure type is correct
                              final updatedCart = cart
                                  .map<Map<String, dynamic>>((item) =>
                                      item.toJson() as Map<String, dynamic>)
                                  .toList();

                              // Update parent widget
                              widget.onCartUpdate(updatedCart);
                              if (updatedCart.isEmpty) {
                                context.pop();
                                carts = false;
                              }

                              print(
                                  'Updated Cart after deletion: $updatedCart');
                            } catch (e) {
                              print(
                                  'Error deleting cart item: ${e.toString()}');
                            }
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.only(bottom: 12.sp),
          child: Text('Empty Cart'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UplodingDataCubit, UplodingDataState>(
      listener: (context, state) {
        if (state is ErrorOccurred) {
          showDialog(
              context: context,
              builder: (context) {
                return _widgets.buildCustomDialog(
                    context, 'Check Your Connection', 'Try Again Later');
              });
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
              if (carts && widget.onCartUpdate != null) {
                context.pop();
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: MapScreen(),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return _widgets.buildCustomDialog(
                      context,
                      'Your Cart is Empty',
                      'Please Add Items to Cart',
                    );
                  },
                );
              }
            }, "Pay", enabled: true)
          ],
        ),
      ),
    );
  }
}
