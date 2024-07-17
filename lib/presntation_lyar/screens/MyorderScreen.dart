import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/presntation_lyar/screens/OrderDetails.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
Widgets _widgets = Widgets();

  Widget ContanerOrder() {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
   return Card(
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
    return MaterialApp(
      
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.white,
          title: Text('Order'),
        ),
        backgroundColor: MyColors.white,body: Center(
          child: Column(
            children: [       
              Container(height: height * 0.24,child: ContanerOrder())
            ],
          ),
        ),),
    );
  }
}