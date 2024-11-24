import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/costanse/extensions.dart';
import 'package:anbobtak/costanse/pages.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final List<Map<String, String>> items = [
    {'label': 'Subtotal', 'amount': 'EGP 735.00'},
    {'label': 'Delivery', 'amount': 'EGP 70.00'},
    {'label': 'Total amount', 'amount': 'EGP 805.00'},
    // Add more items here
    {'label': 'Discount', 'amount': 'EGP -50.00'},
    {'label': 'Tax', 'amount': 'EGP 50.00'},
  ];
  double progressValue = 0.7;

  Widget _Prices() {
    return Center(
      child: Container(
        width: 350.w,
        padding: EdgeInsets.all(20.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    item['label']!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: item['label'] == 'Total amount'
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                );
              }).toList(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: items.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    item['amount']!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: item['label'] == 'Total amount'
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleMaps() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        height: 150,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(31.7778542, 35.2342953),
            zoom: 14.4746,
          ),
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          rotateGesturesEnabled: false,
          scrollGesturesEnabled: false,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 852));
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.pushNamedAndRemoveUntil(
                nav, (Route<dynamic> route) => false);
          },
        ),
        backgroundColor: MyColors.white,
        title: Text('Order Details'),
      ),
      body: Center(
        child: Container(
          width: 330.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jun 01 . 2:20am',
                    style: TextStyle(fontSize: 16),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    child: Text(
                      'Delivered',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 160.h,
                width: 400.w,
                child: Stack(children: [
                  _buildGoogleMaps(),
                  Center(
                    // This creates the fixed pin in the center of the map view
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Icon(Icons.location_pin,
                          size: 40.0, color: MyColors.Secondcolor),
                    ),
                  ),
                ]),
              ),
              Container(
                width: 400.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_pin),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          '', // Replace this with your actual text
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 15.h, // Height of the progress bar
                    color: Colors.grey[300],
                    width: 400.w, // Adjust the width as needed
                  ),
                  Container(
                    height: 15.h, // Height of the filled progress bar
                    width: 300.w *
                        progressValue, // Adjust the width based on progress
                    color: Colors.red, // Progress bar color
                  ),
                  Positioned(
                    left:
                        290.sp * progressValue - 30, // Adjust based on progress
                    top: -20.sp, // Adjust the vertical position
                    child: Image.asset(
                      'assets/gas.png', // Replace with your image URL
                      width: 60.w,
                      height: 60.h,
                    ),
                  ),
                  // Image overlay positioned above the progress bar
                ],
              ),
              SizedBox(height: 20.h),
              _Prices(),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      'Report',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      'Cancel Order',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
