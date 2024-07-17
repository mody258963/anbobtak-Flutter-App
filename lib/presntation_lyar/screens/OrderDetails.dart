import 'package:anbobtak/costanse/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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


  Widget _Prices() {
   return Container(
      padding: EdgeInsets.all(16.0),
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
                    fontWeight: item['label'] == 'Total amount' ? FontWeight.bold : FontWeight.normal,
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
                    fontWeight: item['label'] == 'Total amount' ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: MyColors.white,
        title: Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Delivered',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: height * 0.15,
              width: width * 0.99,
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
            SizedBox(height: height * 0.01),
            Container(
              width: width * 0.99,
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
              children: [
                Container(
                  height: 10,
                  color: Colors.grey[300],
                ),
                Container(
                  height: 10,
                  width: 150, // Adjust this to match the progress
                  color: Colors.red,
                ),
                Positioned(
                  left: 140, // Adjust this to match the progress
                  top: -10,
                  child: Image.network(
                    'https://via.placeholder.com/30',
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            _Prices(),
            SizedBox(height: 20),
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
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
    );
  }
}
