import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key, this.lat, this.long});
  final double? lat;
  final double? long;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  bool? isOffice = false;
  final TextEditingController otpcontroller = TextEditingController();
  Widgets _widgets = Widgets();

  Widget _twoButton() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isOffice == false ? MyColors.Secondcolor : MyColors.white,
          ),
          onPressed: () => setState(() => isOffice = false),
          child: Text(
            'House',
            style: TextStyle(
                color: isOffice == false ? MyColors.white : MyColors.black),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(right: width * 0.33),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isOffice == false ? MyColors.white : MyColors.Secondcolor,
              ),
              onPressed: () => setState(() => isOffice = true),
              child: Text(
                'Apartment',
                style: TextStyle(
                    color: isOffice == false ? MyColors.black : MyColors.white),
              ),
            )),
      ],
    );
  }

  Widget _TextField() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(height: height * 0.01),
        _widgets.TextFieldinApp(
            TextEditingController(),
            'Building name',
            6,
            'more detals',
            'alot of detals',
            65,
            0.05,
            0.05,
            TextInputType.text,
            context),
        SizedBox(height: isOffice == true ? height * 0.01 : height * 0.001),
        if (isOffice == true)
          Row(
            children: [
              Expanded(
                child: _widgets.TextFieldinApp(
                    TextEditingController(),
                    'Apt. no.',
                    6,
                    'more detals',
                    'alot of detals',
                    2,
                    0.01,
                    0.05,
                    TextInputType.text,
                    context),
              ),
              Expanded(
                child: _widgets.TextFieldinApp(
                    TextEditingController(),
                    'Floor',
                    0,
                    'more detals',
                    'alot of detals',
                    3,
                    0.05,
                    0.01,
                    TextInputType.number,
                    context),
              ),
            ],
          ),
        SizedBox(height: height * 0.01),
        _widgets.TextFieldinApp(
            TextEditingController(),
            'Street',
            6,
            'more detals',
            'alot of detals',
            65,
            0.05,
            0.05,
            TextInputType.text,
            context),
        SizedBox(height: height * 0.01),
        _widgets.TextFieldinApp(
            TextEditingController(),
            'Additional directions (optional)',
            6,
            'more detals',
            'alot of detals',
            65,
            0.05,
            0.05,
            TextInputType.text,
            context),
        SizedBox(height: height * 0.01),
        Padding(
          padding: EdgeInsets.only(right: width * 0.05, left: width * 0.05),
          child: TextFormField(
            validator: (value) {
              if (value!.length > 8) {
                return 'min';
              }
              if (value.length < 1) {
                return 'max';
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color:
                        MyColors.Secondcolor), // Change the color when focused
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyColors.whitefade),
              ),
              prefixText: '+20 ',
              labelText: 'Phone number',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: MyColors.Secondcolor)),
            ),
          ),
        ),
        SizedBox(height: height * 0.015),
        Container(
            height: height * 0.07,
            width: width * 0.80,
            child: _widgets.AppButton(() {}, "Confirm"))
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
        body: SingleChildScrollView(
          child: Center(
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
                    _twoButton(),
                _TextField()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
