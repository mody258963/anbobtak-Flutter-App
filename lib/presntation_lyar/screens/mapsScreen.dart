import 'dart:async';
import 'package:anbobtak/besnese_logic/get_method/get_method_cubit.dart';
import 'package:anbobtak/besnese_logic/get_method/get_method_state.dart';
import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/costanse/extensions.dart';
import 'package:anbobtak/presntation_lyar/screens/AddressScreen.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:anbobtak/web_servese/model/regions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as map_tool;
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _currentMapPosition = LatLng(29.945433862143442, 31.503439692154068);
  double longitude = 0.0;
  double latitude = 0.0;
  final Completer<GoogleMapController> _controller = Completer();
  Set<Polygon> _polygons = {};
  Widgets _widgets = Widgets();

  bool isInSelectedArea = true;
  bool isLoading = true; // State to track loading status

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetMethodCubit>(context).GetRegions();
  }

  void _onCameraIdle() {
    final lat = _currentMapPosition.latitude;
    final long = _currentMapPosition.longitude;

    print('Updated Camera Position - Latitude: $lat, Longitude: $long');
    checkUpdataLocation(_currentMapPosition);
  }

  void checkUpdataLocation(LatLng pointLatLng) {
    List<map_tool.LatLng> convertedPolygonPoints = _polygons.expand((polygon) {
      return polygon.points.map((point) {
        return map_tool.LatLng(point.latitude, point.longitude);
      });
    }).toList();

    setState(() {
      isInSelectedArea = map_tool.PolygonUtil.containsLocation(
        map_tool.LatLng(pointLatLng.latitude, pointLatLng.longitude),
        convertedPolygonPoints,
        false,
      );
      print('==========================================$isInSelectedArea');
    });
  }

  void _loadPolygonsFromDatabase(List<Region> regions) {
    Set<Polygon> polygons = {};

    for (var region in regions) {
      List<LatLng> points = [];

      for (var point in region.polygons) {
        try {
          double latitude = double.parse(point.lat.toString().trim());
          double longitude = double.parse(point.lang.toString().trim());
          points.add(LatLng(latitude, longitude));
        } catch (e) {
          print("Error parsing coordinates for region ${region.name}: $e");
        }
      }

      if (points.isNotEmpty) {
        polygons.add(
          Polygon(
            polygonId: PolygonId(region.id.toString()),
            points: points,
            fillColor: MyColors.skyblue.withOpacity(0.2),
            strokeColor: MyColors.Secondcolor,
            strokeWidth: 2,
          ),
        );
        print("Added polygon for region ${region.name} with points: $points");
      }
    }

    setState(() {
      _polygons = polygons;
      isLoading = false; // Set loading to false after regions are loaded
    });
  }

  Widget _buildGoogleMaps() {
    return GoogleMap(
      padding: EdgeInsets.only(bottom: 20.sp),
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: _currentMapPosition,
        zoom: 14.4746,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      polygons: _polygons,
      onCameraIdle: _onCameraIdle,
      myLocationEnabled: true,
      onCameraMove: (CameraPosition position) {
        setState(() {
          _currentMapPosition = position.target;
          latitude = _currentMapPosition.latitude;
          longitude = _currentMapPosition.longitude;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 852));
    return BlocListener<GetMethodCubit, GetMethodState>(
      listener: (context, state) {
        if (state is GetRegion) {
          print("Regions fetched successfully.");
          _loadPolygonsFromDatabase(state.regions);
          isLoading = false;
        } else if (state is Fail) {
          setState(() {
            isLoading = false; // Stop loading on error
          });
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("${state.message}"),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: MyColors.white,
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(right: 55),
            child: Container(
                height: 60.h,
                width: 280.w,
                child: isLoading // Show CircularProgressIndicator if loading
                    ? null
                    : _widgets.AppButton(() {
                        if (isInSelectedArea) {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: AddressScreen(
                              lat: latitude,
                              long: longitude,
                            ),
                            withNavBar: true,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Enter Your Details',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold),
                                ),
                                content: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Type something...',
                                    hintText: 'Enter text here',
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close dialog
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      String userInput = 'last';
                                      if (userInput.isNotEmpty) {
                                        // Perform actions with the userInput
                                        print('User Input: $userInput');
                                      }
                                      Navigator.of(context)
                                          .pop(); // Close dialog
                                    },
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(
                                          color: MyColors.Secondcolor),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }, 'Confirm', enabled: true)),
          ),
        ),
        appBar: AppBar(
          title: const Text("Set Delivery Location"),
          backgroundColor: MyColors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: MyColors.Secondcolor),
            onPressed: () {
              if (!isLoading)
                BlocProvider.of<GetMethodCubit>(context).GetProduct();
               
              context.pop();
            },
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(8.sp),
              child:
                  Icon(Icons.navigation_rounded, color: MyColors.Secondcolor),
            ),
          ],
        ),
        body: isLoading // Show CircularProgressIndicator if loading
            ? Center(child: CircularGifIndicator())
            : Stack(
                children: [
                  _buildGoogleMaps(),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 37),
                      child: Icon(Icons.location_pin,
                          size: 50.0,
                          color: isInSelectedArea
                              ? MyColors.Secondcolor
                              : Colors.red),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
