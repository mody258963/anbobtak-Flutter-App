import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/costanse/extensions.dart';
import 'package:anbobtak/costanse/pages.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatefulWidget {
  final dynamic order;
  const OrderDetails({super.key, this.order});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Widgets _widgets = Widgets();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _widgets.PriceRow('Tax', widget.order.tax.toString()),
            _widgets.PriceRow('Fees', widget.order.fees.toString()),
            _widgets.PriceRow(
                'Carrying Service', widget.order.carryingService.toString()),
            _widgets.PriceRow(
                'Delivery Service', widget.order.deliveryService.toString()),
            _widgets.PriceRow('Total', widget.order.total.toString()),
            _widgets.PriceRow(
                'Discount', '${widget.order.discount.toString()}')
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleMaps() {
    double? latitude = double.tryParse(widget.order.address.lat ?? '');
    double? longitude = double.tryParse(widget.order.address.long ?? '');

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        height: 150,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(latitude!, longitude!),
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

  String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return "N/A"; // Handle null case

    // Example: Format to "2024-11-23 01:04"
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    String formattedDateTime = formatDateTime(
        widget.order.createdAt); // e.g., "2024-11-23T01:04:34.000000Z"
    ScreenUtil.init(context, designSize: const Size(360, 852));

    double progressValue = 0.0;

    switch (widget.order.status) {
      case "Pending":
        progressValue = 0.125; // 12.5% of the progress bar
        break;
      case "Placed":
        progressValue = 0.25; // 25% of the progress bar
        break;
      case "Working On":
        progressValue = 0.375; // 37.5% of the progress bar
        break;
      case "Cancelled":
        progressValue = 0.0; // Default position for Cancelled
        break;
      case "Delivering":
        progressValue = 0.5; // 50% of the progress bar
        break;
      case "Failed":
        progressValue = 0.0; // Default position for Failed
        break;
      case "Delivered":
        progressValue = 0.75; // 100% of the progress bar
        break;
      case "Completed":
        progressValue = 1.0; // 75% of the progress bar
        break;
      default:
        progressValue = 0.0; // Default position for unknown statuses
    }

    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
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
                    formattedDateTime,
                    style: TextStyle(fontSize: 16),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    child: Text(
                      '${widget.order.status}',
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
                  // Background progress bar
                  Container(
                    height: 15.h, // Height of the progress bar
                    color: Colors.grey[300],
                    width: 400.w, // Full width of the progress bar
                  ),

                  // Filled progress bar
                  Container(
                    height: 15.h, // Height of the filled progress bar
                    width: 400.w *
                        progressValue, // Adjust the width based on progress
                    color: Colors.red, // Progress bar color
                  ),

                  // Image overlay (indicator)
                  Positioned(
                    left: (400.w * progressValue) -
                        30.w, // Adjust the position based on progress
                    top: -20.h, // Adjust the vertical position
                    child: Image.asset(
                      'assets/gas.png', // Replace with your image URL
                      width: 60.w,
                      height: 60.h,
                    ),
                  ),
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
