import 'package:anbobtak/costanse/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CheckoutScreen extends StatefulWidget {
  final int? id; // Address ID passed from previous screen
  final double? lat;
  final double? long;
  CheckoutScreen({Key? key, this.id, this.lat, this.long}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? paymentMethod = 'visa'; // Default payment method

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
  Widget build(BuildContext context) {
    // Dummy data for address based on ID
    ScreenUtil.init(context, designSize: const Size(360, 852));
    final addressDetails = {
      1: {
        'title': 'Masaken Sheraton - Fairmont ...',
        'details': 'Building 2, tenth floor\nMob: 1104336893'
      },
      2: {
        'title': 'New Cairo - Fifth Settlement',
        'details': 'Villa 4, Ground floor\nMob: 1234567890'
      },
    };

    final selectedAddress = addressDetails[widget.id] ??
        {'title': 'Unknown Address', 'details': 'No details available'};

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map Section
            Container(
              height: 200.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: _buildGoogleMaps(),
                  ),
                  ListTile(
                    title: Text(selectedAddress['title']!),
                    subtitle: Text(selectedAddress['details']!),
                    trailing: TextButton(
                      onPressed: () {
                        // Logic to change address
                      },
                      child: Text('Change'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Payment Method Section
            Text('Pay with',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Column(
              children: [
                RadioListTile(
                  value: 'card',
                  groupValue: paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value as String?;
                    });
                  },
                  title: Row(
                    children: [
                      Icon(Icons.credit_card, color: Colors.blue),
                      SizedBox(width: 10),
                      Text('Card'),
                    ],
                  ),
                ),
               
                RadioListTile(
                  value: 'cash',
                  groupValue: paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value as String?;
                    });
                  },
                  title: Row(
                    children: [
                      Icon(Icons.attach_money, color: Colors.green),
                      SizedBox(width: 10),
                      Text('Cash'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Payment Summary Section
            Text('Payment summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal', style: TextStyle(fontSize: 16)),
                Text('EGP 735.00', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery', style: TextStyle(fontSize: 16)),
                Text('EGP 70.00', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total amount',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('EGP 805.00',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            Spacer(),
            // Place Order Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Logic to place order
                  print('Order placed with payment method: $paymentMethod');
                },
                child: Text('Place Order',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
