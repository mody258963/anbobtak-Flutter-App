import 'package:anbobtak/besnese_logic/email_auth/email_auth_cubit.dart';
import 'package:anbobtak/besnese_logic/get_method%20v1/get_method_cubit.dart';
import 'package:anbobtak/besnese_logic/get_method%20v1/get_method_state.dart';
import 'package:anbobtak/besnese_logic/get_method/get_method_cubit.dart';
import 'package:anbobtak/besnese_logic/get_method/get_method_state.dart';
import 'package:anbobtak/besnese_logic/uploding_data/uploding_data_cubit.dart';
import 'package:anbobtak/besnese_logic/uploding_data/uploding_data_state.dart';
import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/costanse/extensions.dart';
import 'package:anbobtak/costanse/pages.dart';
import 'package:anbobtak/presntation_lyar/screens/checkout/Checkout.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:anbobtak/web_servese/model/address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key, this.lat, this.long});
  final double? lat;
  final double? long;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController otpcontroller = TextEditingController();
  final TextEditingController buidingcontroller = TextEditingController();
  final TextEditingController apartmentcontroller = TextEditingController();
  final TextEditingController floorcontroller = TextEditingController();
  final TextEditingController streetcontroller = TextEditingController();
  final TextEditingController Addcontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  bool? isOffice = false;
  bool isLoading = false;
  Widgets _widgets = Widgets();
  String phone = '';
  String? selectedAddressString; // Store the address string (for display)
  Map<String, dynamic>? selectedAddressMap;
  int? selectedAddressId;
  List<Map<String, dynamic>> addresses = [];

  @override
  void initState() {
    super.initState();
    // Fetch regions' polygons data from the database
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      await BlocProvider.of<GetMethodCubitV2>(context).GetAddress();
      await BlocProvider.of<GetMethodCubit>(context).GetMe();
    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Widget _buildMe() {
    return BlocBuilder<GetMethodCubit, GetMethodState>(
      builder: (context, state) {

        if (state is LodingState) {
            return Center(
            child: CircularProgressIndicator(
              color: MyColors.Secondcolor,
            ),
          );
        }
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

Widget _buildAddress() {
  return BlocBuilder<GetMethodCubitV2, GetMethodStateV1>(
    builder: (context, state) {
      if (state is LodingStateV1) {
        return Center(
          child: CircularProgressIndicator(
            color: MyColors.Secondcolor,
          ),
        );
      } else if (state is GetAddres) {
        final List<Datas> addressList = state.posts;
        addresses.clear(); // Avoid duplicates
        for (var item in addressList) {
          addresses.add({
            'id': item.id,
            'building_number': item.buildingNumber ?? 'N/A',
            'apartment_number': item.apartmentNumber ?? 'N/A',
            'additional_address': item.additionalAddress ?? 'N/A',
            'floor': item.floor ?? 'N/A',
            'lat': item.lat?.toString() ?? '0',
            'long': item.long?.toString() ?? '0',
            'street': item.street ?? 'N/A',
          });
        }
      }
      return Container(); // Return an empty container when data is loaded
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

  Widget _phoneInputField(BuildContext context) {
    final emailAuthCubit = BlocProvider.of<EmailAuthCubit>(context);
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  value.length > 11 ||
                  value.length < 11) {
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
              child: _widgets.AppButton(() {
                emailAuthCubit.sendVerificationCode(phone);
              }, 'Verify', enabled: true),
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
            selectedAddressMap != null ? false : true,
            TextInputType.text,
            selectedAddressMap != null
                ? selectedAddressMap!['building_number']
                : '',
            context),
        SizedBox(height: isOffice == true ? height * 0.01 : height * 0.001),
        if (isOffice == true)
          Row(
            children: [
              Expanded(
                child: _widgets.TextFieldinApp(
                    apartmentcontroller,
                    'Apt. no.',
                    6,
                    'more detals',
                    'alot of detals',
                    2,
                    0.01,
                    0.05,
                    selectedAddressMap != null ? false : true,
                    TextInputType.text,
                    selectedAddressMap != null
                        ? selectedAddressMap!['apartment_number']
                        : '',
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
                    selectedAddressMap != null ? false : true,
                    TextInputType.number,
                    selectedAddressMap != null
                        ? selectedAddressMap!['floor']
                        : '',
                    context),
              ),
            ],
          ),
        SizedBox(height: height * 0.01),
        _widgets.TextFieldinApp(
            streetcontroller,
            'Street',
            6,
            'more detals',
            'alot of detals',
            65,
            0.05,
            0.05,
            selectedAddressMap != null ? false : true,
            TextInputType.text,
            selectedAddressMap != null ? selectedAddressMap!['street'] : '',
            context),
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
            selectedAddressMap != null ? false : true,
            TextInputType.text,
            selectedAddressMap != null
                ? selectedAddressMap!['additional_address']
                : '',
            context),
        SizedBox(height: height * 0.01),
        Padding(
          padding: EdgeInsets.only(right: width * 0.05, left: width * 0.05),
          child: Row(
            children: [Expanded(child: _phoneInputField(context))],
          ),
        ),
        SizedBox(height: height * 0.015),
        Container(
          height: height * 0.07,
          width: width * 0.80,
          child: _widgets.AppButton(() async {
            if (selectedAddressMap != null && phone != '') {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: CheckoutScreen(
                  id: selectedAddressMap!['id'], // Use selected address ID
                  lat: widget.lat,
                  long: widget.long,
                  selectedAddressId: selectedAddressId,
                  street: selectedAddressMap!['street'],
                  building: selectedAddressMap!['building_number'],
                ),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            } else {
              // Trigger the addAddress function for a new address
              await BlocProvider.of<UplodingDataCubit>(context).addAddress(
                buidingcontroller.text,
                apartmentcontroller.text,
                Addcontroller.text,
                floorcontroller.text,
                widget.lat.toString(),
                widget.long.toString(),
                streetcontroller.text,
                phone,
              );

              // Listen to the emitted state
              final state = context.read<UplodingDataCubit>().state;

              if (state is AddressLatUploaded) {
                print('============================$phone');
                // Navigate to CheckoutScreen with the new address ID
                if (phone != '') {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: CheckoutScreen(
                      id: state.address, // Use the newly created address ID
                      lat: widget.lat,
                      long: widget.long,
                      selectedAddressId: state.address,
                      street: streetcontroller.text,
                      building: buidingcontroller.text,
                    ),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                }
              } else if (state is ErrorOccurred) {
                // Show an error if address creation fails
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMsg)),
                );
              }
            }
          }, "Confirm", enabled: true),
        ),
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
     bool isLoading = 
      context.watch<GetMethodCubitV2>().state is LodingStateV1;

    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      home: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          backgroundColor: MyColors.white,
          appBar: AppBar(
            leading: IconButton(
              icon:
                  const Icon(Icons.arrow_back_ios, color: MyColors.Secondcolor),
              onPressed: () {
                if (!isLoading) {
                  BlocProvider.of<GetMethodCubit>(context).GetRegions();
                  Navigator.pop(context, true);
                }
              },
            ),
            backgroundColor: MyColors.white,
            title: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter your address',
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: DropdownButton<String>(
                  value: selectedAddressString,
                  onChanged: (String? newValue) {
                    setState(() {
                      if (newValue == 'clear_selection') {
                        selectedAddressString = null;
                        selectedAddressMap = null;
                        isLoading = false;
                      } else {
                        selectedAddressString = newValue;
                        selectedAddressMap = addresses.firstWhere(
                          (address) =>
                              '${address['street']} ${address['floor']}' ==
                              newValue,
                          orElse: () => {}, // Return empty map if not found
                        );
                        if (selectedAddressMap != null &&
                            selectedAddressMap!.isNotEmpty) {
                          selectedAddressId = selectedAddressMap!['id'];
                          print('Selected Address ID: $selectedAddressId');
                        }
                      }
                      print('New value: $newValue');
                    });
                  },
                  hint: Text(
                    'Select Address',
                    style: TextStyle(color: Colors.black),
                  ),
                  items: [
                    // Clear Selection Option
                    DropdownMenuItem<String>(
                      value: 'clear_selection',
                      child: Text(
                        'Clear Selection',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    // Address Options
                    ...addresses.map<DropdownMenuItem<String>>((address) {
                      return DropdownMenuItem<String>(
                        value: '${address['street']} ${address['floor']}',
                        child: Text(
                          '${address['street'] ?? 'Unknown Street'}, Floor: ${address['floor'] ?? 'N/A'}',
                        ),
                      );
                    }).toList(),
                  ],
                  dropdownColor: Colors.white,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                  underline: SizedBox(),
                ),
              ),
            ],
          ),
          body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: MyColors.Secondcolor,
              ),
            )
          : SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          height: 150.h,
                          width: 320.w,
                          child: Stack(children: [
                            _buildAddress(),
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
                            height: 70.h,
                            width: 320.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.sp),
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
      ),
    );
  }
}
