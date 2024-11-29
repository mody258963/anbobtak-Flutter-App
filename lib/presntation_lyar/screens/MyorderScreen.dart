import 'package:anbobtak/besnese_logic/orderLiisting/order_cubit_cubit.dart';
import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/presntation_lyar/screens/OrderDetails.dart';
import 'package:anbobtak/web_servese/model/myOrder.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/widgets.dart';
import 'package:intl/intl.dart';

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
    BlocProvider.of<OrderCubitCubit>(context).GetOrder();
  }

  Widget _buildOrder() {
    return BlocBuilder<OrderCubitCubit, OrderCubitState>(
      builder: (context, state) {
        if (state is GetOrders) {
          final orderList = List.from(state.order)
            ..sort((a, b) => a.id.compareTo(b.id));

          return RefreshIndicator(
            color: MyColors.Secondcolor,
            onRefresh: () async {
              // Trigger your cubit or API call to refresh the orders
              await context.read<OrderCubitCubit>().GetOrder();
            },
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: orderList.length,
              physics:
                  AlwaysScrollableScrollPhysics(), // Ensures the list is scrollable even if items are few
              itemBuilder: (context, index) {
                final order = orderList[index];
                print(order.id);
                return _ContanerOrder(order);
              },
            ),
          );
        } else {
          return Center(
            child: Text('No orders available.'),
          );
        }
      },
    );
  }


String formatDateTime(DateTime? dateTime) {
  if (dateTime == null) return "N/A"; // Handle null case

  // Example: Format to "2024-11-23 01:04"
  return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
}


  Widget _ContanerOrder(order) {
  String formattedDateTime = formatDateTime(order.createdAt);// e.g., "2024-11-23T01:04:34.000000Z"
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
                Text(formattedDateTime, style: TextStyle(fontSize: 16)),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    order.status,
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
                    Text('Order ID: ${order.id}', style: TextStyle(fontSize: 16)),
                    Text('EGP ${order.total}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderDetails(order:order)));
                  },
                  child: Text(
                    'View details',
                    style: TextStyle(color: MyColors.Secondcolor),
                  ),
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
    ScreenUtil.init(context, designSize: const Size(360, 852));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.white,
        title: Text('Order'),
      ),
      backgroundColor: MyColors.white,
      body: _buildOrder(),
    );
  }
}
