import 'dart:async';
import 'dart:ffi';

import 'package:anbobtak/besnese_logic/uploding_data/uploding_data_cubit.dart';
import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/costanse/pages.dart';
import 'package:anbobtak/presntation_lyar/screens/AddressScreen.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double? lat;
  double? long;
  Widgets _widgets = Widgets();
  LatLng _currentMapPosition = LatLng(30.092560466679437, 31.282181737999366);
  GoogleMapController? mapController;

  final List<LatLng> _polygons = const [
    // LatLng(29.986553176166016, 31.368548188503613),
    // LatLng(29.972331632561385, 31.366626907023097),
    // LatLng(29.957200094976344, 31.43142648958498),
    //     LatLng(29.957005294165747, 31.4491234702441),

    // LatLng(29.96665757548781, 31.46950279528975),
    // LatLng(29.945433862143442, 31.503439692154068),
    // LatLng(29.93269596428944, 31.526654051023183),
    // LatLng(29.957079, 31.536741),
    // LatLng(29.967275, 31.547741),
    // LatLng(30.004082, 31.529569),
    //     LatLng(30.018687918717433, 31.511628611178345),
    // LatLng(30.025142, 31.498537),
    // LatLng(30.025309, 31.457322),
    // LatLng(30.016156, 31.445518),
    // LatLng(30.016003, 31.401297),
    LatLng(30.092560466679437, 31.282181737999366),
    LatLng(30.092533509352425, 31.282456122119832),
    LatLng(30.09235017450115, 31.282442711075706),
    LatLng(30.092224856812248, 31.28210475276369),
  ];

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    _widgets.requestLocationPermission();
  }

  void _onCameraIdle() {
    lat = _currentMapPosition.latitude;
    long = _currentMapPosition.longitude;
    print('1Latitude: ${lat}, Longitude: ${long}');
  }

  // void _onCameraMove(CameraPosition position) {
  //   _currentMapPosition = position.target;
  // }

  Widget _buildGoogleMaps() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: _currentMapPosition,
        zoom: 14.4746,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      polygons: {
        Polygon(
            polygonId: PolygonId("1"),
            points: _polygons,
            fillColor: MyColors.skyblue.withOpacity(0.2),
            strokeWidth: 1)
      },
      onCameraIdle: _onCameraIdle,
      myLocationEnabled: true,
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used forseup
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding:
                EdgeInsets.only(right: width * 0.12, bottom: height * 0.013),
            child: Container(
                width: width * 0.75,
                height: height * 0.065,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.Secondcolor),
                    onPressed: () {
                      BlocProvider.of<UplodingDataCubit>(context)
                          .addLatLong(lat, long);
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: AddressScreen(lat: lat, long: long),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ))),
          ),
          backgroundColor: MyColors.white,
          appBar: AppBar(
            backgroundColor: MyColors.white,
            leading: Padding(
              padding: EdgeInsets.only(left: width * 0.01),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop(ModalRoute.withName(homescreen));
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
                highlightColor: Colors.transparent,
                color: MyColors.Secondcolor,
              ),
            ),
            title: const Text(
              "Set Delivery Location",
              style: TextStyle(color: MyColors.Secondcolor),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: width * 0.04),
                child: Icon(
                  Icons.navigation_rounded,
                  color: MyColors.Secondcolor,
                ),
              ),
            ],
          ),
          body: Stack(children: [
            _buildGoogleMaps(),
            Center(
              // This creates the fixed pin in the center of the map view
              child: Padding(
                padding: const EdgeInsets.only(bottom: 37),
                child: Icon(Icons.location_pin,
                    size: 50.0, color: MyColors.Secondcolor),
              ),
            ),
          ])),
    );
  }
}
