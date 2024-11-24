import 'package:anbobtak/besnese_logic/get_method%20v1/get_method_cubit.dart'
    as cart;
import 'package:anbobtak/besnese_logic/get_method%20v1/get_method_cubit.dart';
import 'package:anbobtak/besnese_logic/get_method%20v1/get_method_state.dart';
import 'package:anbobtak/besnese_logic/get_method/get_method_cubit.dart';
import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/costanse/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  String? paymentMethod = 'visa'; // Default payment method
  int? fees;
  int? delivery;
  int? carry;
  int? tax;
  int? total;

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
          WidgetsBinding.instance.addPersistentFrameCallback((_) {
            if (mounted) {
              setState(() {
                carry = price.carryingService!;
                delivery = price.deliveryService!;
                fees = price.fees!;
                tax = price.tax!;
                total = price.total!;
                print('========price===========$price');
              });
            }
          });
        }
        return Container();
      },
      // Include a child widget (for example, a list view)
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
        padding:  EdgeInsets.only(left: 16.sp , right: 16.sp,top: 6.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPriceList(),
            // Map Section
            Container(
              height: 180.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black26, // Black border color
                  width: 1, // Border width
                ),
                borderRadius:
                    BorderRadius.circular(12), // Rounded corners
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
                        BlocProvider.of<GetMethodCubitV2>(context)
                            .GetAddress();
                        BlocProvider.of<GetMethodCubit>(context)
                            .GetMe();
                        context.pop();
                      },
                      child: Text('Change', style: TextStyle(color: MyColors.Secondcolor)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14),
            // Payment Method Section
            Text('Pay with',
                style: TextStyle(
                    fontSize: 18.sp, fontWeight: FontWeight.bold)),
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
                    borderRadius:
                        BorderRadius.circular(12), // Rounded corners
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
                        SizedBox(
                            width: 10.w), // Space between icon and text
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
                    borderRadius:
                        BorderRadius.circular(12), // Rounded corners
                  ),
                  child: RadioListTile(
                    activeColor: MyColors.Secondcolor,
                    value: 'cash',
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
                        SizedBox(
                            width: 10.w), // Space between icon and text
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
                style: TextStyle(
                    fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 9.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery Fees', style: TextStyle(fontSize: 16.sp)),
                Text(delivery.toString() ?? '',
                    style: TextStyle(fontSize: 16.sp)),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Carrying Service',
                    style: TextStyle(fontSize: 16.sp)),
                Text(carry.toString() ?? '',
                    style: TextStyle(fontSize: 16.sp)),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Fees', style: TextStyle(fontSize: 16.sp)),
                Text(fees.toString() ?? '',
                    style: TextStyle(fontSize: 16.sp)),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tax', style: TextStyle(fontSize: 16.sp)),
                Text(tax.toString() ?? '',
                    style: TextStyle(fontSize: 16.sp)),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total amount',
                    style: TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.bold)),
                Text(total.toString() ?? '',
                    style: TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 14.h),
            // Place Order Button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
      
                  
                },
                child: Text('Place Order',
                    style:
                        TextStyle(fontSize: 18.sp, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
