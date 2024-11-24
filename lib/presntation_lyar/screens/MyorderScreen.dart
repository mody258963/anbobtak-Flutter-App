import 'package:anbobtak/besnese_logic/get_method/get_method_cubit.dart';
import 'package:anbobtak/besnese_logic/get_method/get_method_state.dart';
import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/presntation_lyar/screens/OrderDetails.dart';
import 'package:anbobtak/web_servese/model/myOrder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/widgets.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
Widgets _widgets = Widgets();
  List<Map<String, dynamic>> orderDetals = [];

   @override
  void initState() {
    super.initState();
    // Fetch regions' polygons data from the database
    BlocProvider.of<GetMethodCubit>(context).GetOrder();
  }

Widget _buildOrder() {
  return BlocBuilder<GetMethodCubit, GetMethodState>(
    builder: (context, state) {
      if (state is GetOrders) {
        final orderList = state.order;
        print('Order list received: $state');

        if (orderList != null && orderList.isNotEmpty) {
          print('First order: ${orderList.first}');
          print('First order data: ${orderList.first.data}');

          orderDetals.clear(); // Clear previous data

          if (orderList.first.data.isNotEmpty) {
            final firstOrder = orderList.first.data.first;

            print('First order details: $firstOrder');
            print('First order ID: ${firstOrder.id}');
            print('First order createdAt: ${firstOrder.createdAt}');
            print('First order total: ${firstOrder.total}');
            print('First order address: ${firstOrder.address}');
            print('First order items: ${firstOrder.items}');

            if (mounted) {
              orderDetals.add({
                'id': firstOrder.id ?? 0,
                'created_at': firstOrder.createdAt?.toIso8601String() ?? 'N/A',
                'total': firstOrder.total ?? 0,
                'item_total': firstOrder.itemsTotal ?? 0,
                'status': firstOrder.status ?? 'N/A',
                'lat': firstOrder.address?.lat ?? 'N/A',
                'long': firstOrder.address?.long ?? 'N/A',
                'carrying_service': firstOrder.carryingService ?? 0,
                'tax': firstOrder.tax ?? 0,
                'fees': firstOrder.fees ?? 0,
                'discount': firstOrder.discount ?? 0,
              });
              print('Order details added: $orderDetals');
            }
          } else {
            print('Order data is empty.');
          }
        } else {
          print('Order list is empty or null.');
        }

        print('Processed orderDetals: $orderDetals');
      }

      return Container(); // Replace with your desired widget
    },
  );
}



  Widget ContanerOrder() {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
   return Card(
    shadowColor: Colors.black,
    color: Colors.white,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Jun 01 . 2:20am', style: TextStyle(fontSize: 16)),
                Spacer(),
               Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        'Deliver',
        style: TextStyle(
          color: Colors.grey[700],
          fontSize: 14,
        ),
      ),
    ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
      
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order ID: 12', style: TextStyle(fontSize: 16)),
                    Text('EGP 12.1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetails()));
                  },
                  child: Text('View details',style: TextStyle(color: MyColors.Secondcolor),),
                ),
           OutlinedButton(
      onPressed: () {
        // Add your onPressed code here!
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.blue),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 9),
      ),
      child: Text(
        'Report',
        style: TextStyle(
          color: Colors.black,
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

  @override
  Widget build(BuildContext context) {
      double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.white,
          title: Text('Order'),
        ),
        backgroundColor: MyColors.white,body: Center(
          child: Column(
            children: [       
              _buildOrder(),
              Container(height: height * 0.24,child: ContanerOrder())
            ],
          ),
        ),);
  }
}