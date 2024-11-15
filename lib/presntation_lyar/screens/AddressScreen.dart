import 'package:anbobtak/besnese_logic/get_method/get_method_cubit.dart';
import 'package:anbobtak/besnese_logic/get_method/get_method_state.dart';
import 'package:anbobtak/besnese_logic/uploding_data/uploding_data_cubit.dart';
import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final TextEditingController buidingcontroller = TextEditingController();
  final TextEditingController aptcontroller = TextEditingController();
  final TextEditingController floorcontroller = TextEditingController();
  final TextEditingController Streetcontroller = TextEditingController();
  final TextEditingController Addcontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();

  Widgets _widgets = Widgets();
  String phone = '';
  @override
  void initState() {
    super.initState();
    // Fetch regions' polygons data from the database
    BlocProvider.of<GetMethodCubit>(context).GetMe();
  }
Widget _buildMe() {
  return BlocBuilder<GetMethodCubit, GetMethodState>(
    builder: (context, state) {
      if (state is GetMee) {
        final me = state.me;
        if (me.phone != null && me.phone != phone) {
          
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                phone = me.phone!;
              });
            }
          });
          print('========me=${me.name}=======phone=$phone');
        } else if (me.phone == null) {
          print('========No phone found=======');
        }
      }
      return Container();
    },
  );
}



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

 Widget _phoneInputField() {
  return Row(
    children: [
      Expanded(
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty || value.length > 11 || value.length < 11) {
              return 'Invalid phone number';
            }
            return null;
          },
          controller: phonecontroller,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.Secondcolor),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whitefade),
            ),
            prefixText: phone.isNotEmpty ? phone : '+20 ',
            labelText: 'Phone number',
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: MyColors.Secondcolor)),
          ),
        ),
      ),
      if (phone.isEmpty) // Conditional rendering based on phone
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 100.w,
            height: 50.h,
            child: _widgets.AppButton(() {}, 'Verify'),
          ),
        )
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
            buidingcontroller,
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
                    aptcontroller,
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
                    floorcontroller,
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
        _widgets.TextFieldinApp(Streetcontroller, 'Street', 6, 'more detals',
            'alot of detals', 65, 0.05, 0.05, TextInputType.text, context),
        SizedBox(height: height * 0.01),
        _widgets.TextFieldinApp(
            Addcontroller,
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
          child: Row(
            children: [
              Expanded(
                child: _phoneInputField())
            ],
          ),
        ),
        SizedBox(height: height * 0.015),
        Container(
            height: height * 0.07,
            width: width * 0.80,
            child: _widgets.AppButton(() {
              BlocProvider.of<UplodingDataCubit>(context).addAddress(
                  buidingcontroller,
                  aptcontroller,
                  floorcontroller,
                  widget.lat,
                  widget.long,
                  Streetcontroller,
                  phonecontroller);
            }, "Confirm")),
  
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
    ScreenUtil.init(context, designSize: const Size(360, 852));
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
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
                  height: 150,
                  width: 360,
                  child: Stack(children: [
                      _buildMe(),
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
                    height: 80,
                    width: 360,
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
                        Expanded(
                          // Allows the text to wrap within available space
                          child: Text(
                            '${widget.lat} , ${widget.long}',
                            overflow: TextOverflow
                                .ellipsis, // Add ellipsis if text is too long
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _twoButton(),
                _TextField(),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
