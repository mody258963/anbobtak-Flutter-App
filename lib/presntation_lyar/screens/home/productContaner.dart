import 'package:add_to_cart_button/add_to_cart_button.dart';
import 'package:anbobtak/besnese_logic/get_method/get_method_cubit.dart';
import 'package:anbobtak/besnese_logic/get_method/get_method_state.dart';
import 'package:anbobtak/besnese_logic/uploding_data/uploding_data_cubit.dart';
import 'package:anbobtak/costanse/colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductContainer extends StatefulWidget {
  final Function(List<Map<String, dynamic>>)
      onCartUpdate; // Callback to update cart in HomeScreen

  const ProductContainer({super.key, required this.onCartUpdate});

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  List<Map<String, dynamic>> cartItems = [];
  double totalPrice = 0;

  void _CartEditing() {
    for (var item in cartItems) {
      setState(() {
        BlocProvider.of<UplodingDataCubit>(context)
            .addItemInCart(item['quantity'], item['id']);
      });
    }
  }

  // Sort cartItems by id
  void sortCart() {
    cartItems.sort((a, b) {
      // Handle null ids, consider them last
      if (a['id'] == null && b['id'] == null) return 0;
      if (a['id'] == null) return 1;
      if (b['id'] == null) return -1;
      return a['id'].compareTo(b['id']);
    });
  }

  // Sorting products by id
  List<dynamic> _sortProducts(List<dynamic> products) {
    products.sort((a, b) {
      // Handle null ids, consider them last
      if (a.id == null && b.id == null) return 0;
      if (a.id == null) return 1;
      if (b.id == null) return -1;
      return a.id!.compareTo(b.id!);
    });
    return products;
  }

  Widget _buildProductList() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocBuilder<GetMethodCubit, GetMethodState>(
      builder: (context, state) {
        if (state is GetCartsandProducts) {
          final items = _sortProducts(state.products); // Sort products by id
          final cart = _sortProducts(state.cart);

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
                      (width / 0.12) / (height - kToolbarHeight - 50) / 2.1,
                ),
                itemBuilder: (context, index) {
                  final allList = items[index];
                  final allcart = cart[index];

                  return _buildProductItem(allList, allcart);
                },
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildProductItem(product, cartItem) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: CachedNetworkImage(
              imageUrl: '${product.image.toString()}',
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
                    '${product.name.toString()}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.05,
                    ),
                  ),
                  Text(
                    '${product.description.toString()}',
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
                        '${product.price.toString()}',
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
          _buildCounter(product, cartItem),
        ],
      ),
    );
  }

  Widget _buildCounter(product, cartItem) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.14,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: width * 0.1),
          AddToCartCounterButton(
            initNumber: cartItem.quantity,
            minNumber: 0,
            maxNumber: 10,
            increaseCallback: () {
              setState(() {
                _CartEditing();
              });
            },
            decreaseCallback: () {
              setState(() {
                _CartEditing();
              });
              ;
            },
            counterCallback: (int count) {
              bool found = false;

              // Find the cart item matching the product id
              for (var item in cartItems) {
                if (item['id'] == product.id) {
                  item['quantity'] =
                      count; // Update the quantity for this product
                  found = true;
                  break;
                }
              }

              // If the product was not found in the cart, add it
              if (!found) {
                cartItems.add({
                  'id': product.id,
                  'name': product.name,
                  'quantity': count,
                  'price': product.price,
                  'image': product.image
                });
              }

              // Sort cart items by id to maintain order
              sortCart();

              // After updating the cart, notify the parent widget
              widget.onCartUpdate(cartItems);

              print('=============cart==========$cartItems');
              print('=============price==========$totalPrice');
            },
            backgroundColor: Colors.white,
            buttonFillColor: MyColors.Secondcolor,
            buttonIconColor: Colors.white,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildProductList();
  }
}
