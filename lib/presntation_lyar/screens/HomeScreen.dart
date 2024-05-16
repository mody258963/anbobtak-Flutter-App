import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/costanse/pages.dart';
import 'package:anbobtak/presntation_lyar/screens/mapsScreen.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widgets _widgets = Widgets();
  final List<String> items = List.generate(20, (index) => 'Item $index');
  Widget _GirdBuilder() {
    int conter = 0;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: FadeInUp(
        duration: Duration(milliseconds: 1500),
        child: GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: items.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 1.0,
                childAspectRatio:
                    ((width / 0.12) / (height - kToolbarHeight - 50) / 2.1)),
            itemBuilder: (context, index) {
              final allList = items[index];
              return _contaner(allList);
            }),
      ),
    );
  }

  Widget _contaner(allList) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int conter = 0;
    return GestureDetector(
      onTap: () async {},
      child: Container(
          margin: EdgeInsets.all(14.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: Container(
              height: height * 0.19,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MediaQuery.removePadding(
                    removeRight: true,
                    removeLeft: true,
                    context: context,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://github.com/mody258963/useer_app-not-clean-code-google-maps/blob/main/assets/gas.png?raw=true',
                        width: width * 0.235,
                        placeholder: (context, url) => _widgets
                            .buildCircularProgressIndicatorDialog(context),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.18,
                    width: width * 0.33,
                    child: _widgets.listTile('Gas Cylnder',
                        'Refilling a the gas cylinder.', context),
                  ),
                  Container(
                    height: height * 0.14,
                    width: width * 0.25,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: height * 0.02),
                                child: Text(
                                  'EGP',
                                  style: TextStyle(
                                      fontSize: width * 0.03,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: height * 0.012),
                                child: Text(
                                  '100.50',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.05),
                                ),
                              )
                            ],
                          ),
                        ),
                        Wrap(
                          spacing: 5.0,
                          runSpacing: 5.0,
                          direction: Axis.vertical,
                          children: [
                            Container(
                              height: height * 0.07,
                              width: width * 0.4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      setState(() {
                                        if (conter > 0) {
                                          conter--;
                                        }
                                      });
                                    },
                                  ),
                                  Text(
                                    '$conter',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        conter++;
                                      });
                                    },
                                  ),
                                  SizedBox(width: width * 0.14)
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: width * 0.80,
              height: height * 0.07,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.Secondcolor),
                  onPressed: () {
                    
    PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: MapScreen(),
        withNavBar: true, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );

               },
                  child: Text(
                    'Pay   EGP 100.50',
                    style: TextStyle(color: Colors.white),
                  ))),
        ),
        backgroundColor: MyColors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: FadeInUp(
                          duration: Duration(milliseconds: 1500),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.10,
                                right: width * 0.20,
                                left: width * 0.06),
                            child: _widgets.TitleText(
                                'Hi, Name form database', 30),
                          )),
                    ),
                    _GirdBuilder(),
                    Text('Your super cool Footer'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
