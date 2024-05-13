import 'package:anbobtak/costanse/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key, this.lat, this.long});
  final double? lat;
  final double? long;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  bool? isOffice = true;

  Widget _TextFeild() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => setState(() => isOffice = false),
              child: Text('House'),
            ),
            ElevatedButton(
              onPressed: () => setState(() => isOffice = true),
              child: Text('Office'),
            ),
          ],
        ),
      ]
    );
    //     Expanded(
    //       child: SingleChildScrollView(
    //         padding: const EdgeInsets.all(16),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             TextFormField(
    //               decoration: InputDecoration(
    //                 labelText: isOffice! ? 'Company Name' : 'Building Name',
    //               ),
    //             ),
    //             TextFormField(
    //               decoration: InputDecoration(
    //                 labelText: 'Apt. No.',
    //               ),
    //             ),
    //             if (isOffice!)
    //               TextFormField(
    //                 decoration: InputDecoration(
    //                   labelText: 'Floor (optional)',
    //                 ),
    //               ),
    //             TextFormField(
    //               decoration: InputDecoration(
    //                 labelText: 'Street',
    //               ),
    //             ),
    //             TextFormField(
    //               decoration: InputDecoration(
    //                 labelText: 'Additional Directions (optional)',
    //               ),
    //             ),
    //             TextFormField(
    //               decoration: InputDecoration(
    //                 labelText: '+20',
    //                 prefixText: 'Phone Number ',
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // );
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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: MyColors.white,
        appBar: AppBar(
          backgroundColor: MyColors.white,
          title: Center(child: Text('Enter your address')),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                height: height * 0.15,
                width: width * 0.90,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: height * 0.08,
                  width: width * 0.90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors.white,
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.location_pin),
                      ),
                      Text('${widget.lat} , ${widget.long}')
                    ],
                  ),

                ),
              ),
              _TextFeild(),
            ],
          ),
        ),
      ),
    );
  }
}
