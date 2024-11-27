import 'package:anbobtak/besnese_logic/get_method%20v1/get_method_cubit.dart'
    as cart;
import 'package:anbobtak/besnese_logic/get_method%20v1/get_method_cubit.dart';
import 'package:anbobtak/besnese_logic/get_method%20v1/get_method_state.dart';
import 'package:anbobtak/besnese_logic/get_method/get_method_cubit.dart';
import 'package:anbobtak/besnese_logic/uploding_data/uploding_data_cubit.dart';
import 'package:anbobtak/besnese_logic/uploding_data/uploding_data_state.dart';
import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/costanse/extensions.dart';
import 'package:anbobtak/presntation_lyar/screens/MyorderScreen.dart';
import 'package:anbobtak/presntation_lyar/screens/checkout/Paymob.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class CheckoutScreen extends StatefulWidget {
  final int? id; // Address ID passed from previous screen
  final double? lat;
  final double? long;
  int? selectedAddressId;
  final String? street;
  final String? building;

  CheckoutScreen(
      {Key? key,
      this.id,
      this.lat,
      this.long,
      this.selectedAddressId,
      this.street,
      this.building})
      : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? paymentMethod = 'card'; // Default payment method
  int? fees;
  int? delivery;
  int? carry;
  int? tax;
  int? total;
  Widgets _widgets = Widgets();

  void initState() {
    super.initState();
    // Fetch regions' polygons data from the database
    BlocProvider.of<GetMethodCubitV2>(context).GetPrice();
  }

  Widget _buildPriceList() {
    return BlocBuilder<cart.GetMethodCubitV2, GetMethodStateV1>(
      builder: (context, state) {
        if (state is GetPriceV1) {
          final price = state.posts;

          if (mounted) {
            carry = price.carryingService ?? 0;
            delivery = price.deliveryService ?? 0;
            fees = price.fees ?? 0;
            tax = price.tax ?? 0;
            total = price.total ?? 0;
          }
          print('========Updated Price=========${price.toString()}');

          return _buildPriceDetails();
        }
        // else if (state is GetMethodLoadingV1) {
        //   return const Center(
        //     child: CircularProgressIndicator(),
        //   );
        // } else if (state is GetMethodErrorV1) {
        //   return Center(
        //     child: Text(
        //       'Failed to load prices. Please try again.',
        //       style: TextStyle(color: Colors.red, fontSize: 16),
        //     ),
        //   );
        // }
        return const SizedBox(); // Placeholder when no relevant state is active
      },
    );
  }

  Widget buildPriceRow({
    required String label,
    num? value,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value != null
              ? '${value!.toStringAsFixed(2)} EGP'
              : 'N/A', // Handle null value
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildPriceRow(label: "Carrying Service:", value: carry ?? 0),
        buildPriceRow(label: "Delivery Service:", value: delivery ?? 0),
        buildPriceRow(label: "Fees:", value: fees ?? 0),
        buildPriceRow(label: "Tax:", value: tax ?? 0),
        Divider(color: Colors.grey),
        buildPriceRow(label: "Total:", value: total ?? 0, isBold: true),
      ],
    );
  }

  Widget _buildGoogleMaps() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.lat!, widget.long!),
          zoom: 14.4746,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        rotateGesturesEnabled: false,
        scrollGesturesEnabled: false,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
      ),
    );
  }

Widget _paymentButton() {
  return BlocListener<UplodingDataCubit, UplodingDataState>(
    listener: (context, state) {
      if (state is PayOrder) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymobWebView(iframeUrl: state.paymentUrl),
          ),
        );
      } else if (state is CashOnDelivery) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Order placed successfully with Cash on Delivery!'),
          ),
        );
      } else if (state is OrderAlreadyCreated) {
      showDialog(
          context: context,
          builder: (context) => _widgets.buildCustomDialog(
            context,
            state.errorMsg,
            'Order Made Before',
          ),
        );

        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: MyOrderScreen(),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      } else if (state is ErrorOccurred) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorMsg),
          ),
        );
      }
    },
    child:   SizedBox(
        width: double.infinity,
        height: 50.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () async {
            print('==========address id========${widget.id}');
            print('==========payment method========$paymentMethod');

            // Trigger the OrderMake function
            await context
                .read<UplodingDataCubit>()
                .OrderMake(widget.id, paymentMethod);
          },
          child: Text(
            'Place Order',
            style: TextStyle(fontSize: 18.sp, color: Colors.white),
          ),
        ),
      ),

  );
}

 

  @override
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 852));
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context), // Navigate back
        ),
        title: Text('Checkout', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16.sp, right: 16.sp, top: 6.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map Section
            Container(
              height: 180.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black26, // Black border color
                  width: 1, // Border width
                ),
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
              child: Column(
                children: [
                  Expanded(
                    child: _buildGoogleMaps(),
                  ),
                  ListTile(
                    title: Text(widget.street!),
                    subtitle: Text(widget.building!),
                    trailing: TextButton(
                      onPressed: () {
                        BlocProvider.of<GetMethodCubitV2>(context).GetAddress();
                        BlocProvider.of<GetMethodCubit>(context).GetMe();
                        context.pop();
                      },
                      child: Text('Change',
                          style: TextStyle(color: MyColors.Secondcolor)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14),
            // Payment Method Section
            Text('Pay with',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.h),
            Column(
              children: [
                Container(
                  height: 56.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black26, // Black border color
                      width: 1.w, // Border width
                    ),
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  child: RadioListTile(
                    selectedTileColor: MyColors.Secondcolor,
                    activeColor: MyColors.Secondcolor,
                    value: 'card',
                    groupValue: paymentMethod,
                    onChanged: (value) {
                      setState(() {
                        paymentMethod = value as String?;
                      });
                    },
                    title: Row(
                      children: [
                        Icon(Icons.credit_card,
                            color: Colors.blue), // Credit card icon
                        SizedBox(width: 10.w), // Space between icon and text
                        Text('Card'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                Container(
                  height: 56.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black26, // Black border color
                      width: 1.w, // Border width
                    ),
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  child: RadioListTile(
                    activeColor: MyColors.Secondcolor,
                    value: 'cash_On_delivery',
                    groupValue: paymentMethod,
                    onChanged: (value) {
                      setState(() {
                        paymentMethod = value as String?;
                      });
                    },
                    title: Row(
                      children: [
                        Icon(Icons.attach_money,
                            color: Colors.green), // Money icon
                        SizedBox(width: 10.w), // Space between icon and text
                        Text('Cash'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            // Payment Summary Section
            Text('Payment summary',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 9.h),

            // Place Order Button
            _buildPriceList(),
            SizedBox(height: 50.h),
            _paymentButton(),
          ],
        ),
      ),
    );
  }
}
