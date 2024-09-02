import 'package:anbobtak/besnese_logic/get_method/get_method_cubit.dart';
import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/presntation_lyar/screens/HomeScreen.dart';
import 'package:anbobtak/presntation_lyar/screens/MyorderScreen.dart';
import 'package:anbobtak/presntation_lyar/screens/ProfileScreen.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class NavigationBars extends StatefulWidget {
  const NavigationBars({super.key, required this.name});
  final String? name;
  @override
  State<NavigationBars> createState() => _NavigationBarsState();
}

class _NavigationBarsState extends State<NavigationBars> {
  @override
  void didChangeDependencies() {
    // BlocProvider.of<GetMethodCubit>(context).emitGetAllCourseOfTeacher();
    super.didChangeDependencies();
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        activeColorPrimary: MyColors.Secondcolor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.delivery_dining_sharp),
        activeColorPrimary: MyColors.Secondcolor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        activeColorPrimary: MyColors.Secondcolor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  PersistentTabController _controller = PersistentTabController();
  List<Widget> _screens() {
    return [
      HomeScreen(
        name: widget.name,
      ),
      MyOrderScreen(),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    print('${widget.name}');
    return MaterialApp(
      home: Scaffold(
        body: PersistentTabView(
          screens: _screens(),
          context,
          confineToSafeArea: true,
          controller: _controller,
          items: _navBarItems(),
          navBarStyle: NavBarStyle.style6,
          backgroundColor: MyColors.white,
          hideNavigationBarWhenKeyboardAppears: true,
          popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
        ),
      ),
    );
  }
}
