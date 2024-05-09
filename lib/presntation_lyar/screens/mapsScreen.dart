import 'dart:async';

import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/costanse/pages.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Widgets _widgets = Widgets();
  LatLng _currentMapPosition = LatLng(31.7778542, 35.2342953);
  GoogleMapController? mapController;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    _widgets.requestLocationPermission();
  }

  void _onTap(LatLng position) {
    print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
  }

  void _onCameraIdle() {
    print(
        'Latitude: ${_currentMapPosition.latitude}, Longitude: ${_currentMapPosition.longitude}');
  }

  void _onCameraMove(CameraPosition position) {
    _currentMapPosition = position.target;
  }

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
      onCameraMove: _onCameraMove,
      onCameraIdle: _onCameraIdle,
      myLocationEnabled: true,
      onTap: _onTap,
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
      // Specify a custom transition to be used for
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
            padding:  EdgeInsets.only(right: width * 0.12, bottom: height * 0.01),
            child: Container(
                width: width * 0.75,
                height: height * 0.065,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.Secondcolor),
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: MapScreen(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    child: Text(
                      'Pay   EGP 100.50',
                      style: TextStyle(color: Colors.white),
                    ))),
          ),
          backgroundColor: MyColors.white,
          appBar: AppBar(
            backgroundColor: MyColors.white,
            leading: Icon(
              Icons.navigation_rounded,
              color: MyColors.Secondcolor,
            ),
            title: const Text(
              "Set Delivery Location",
              style: TextStyle(color: MyColors.Secondcolor),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(ModalRoute.withName(homescreen));
                  },
                  icon: Icon(
                    Icons.cancel_rounded,
                    color: MyColors.Secondcolor,
                  ))
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
