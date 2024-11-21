import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  final int? id; // Address ID passed from previous screen

  CheckoutScreen({Key? key, this.id}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? paymentMethod = 'visa'; // Default payment method

  @override
  Widget build(BuildContext context) {
    // Dummy data for address based on ID
    final addressDetails = {
      1: {
        'title': 'Masaken Sheraton - Fairmont ...',
        'details': 'Building 2, tenth floor\nMob: 1104336893'
      },
      2: {
        'title': 'New Cairo - Fifth Settlement',
        'details': 'Villa 4, Ground floor\nMob: 1234567890'
      },
    };

    final selectedAddress = addressDetails[widget.id] ??
        {'title': 'Unknown Address', 'details': 'No details available'};

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context), // Navigate back
        ),
        title: Text('Checkout', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map Section
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/map_placeholder.png', // Replace with dynamic map
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  ListTile(
                    title: Text(selectedAddress['title']!),
                    subtitle: Text(selectedAddress['details']!),
                    trailing: TextButton(
                      onPressed: () {
                        // Logic to change address
                      },
                      child: Text('Change'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Payment Method Section
            Text('Pay with', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Column(
              children: [
                RadioListTile(
                  value: 'visa',
                  groupValue: paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value as String?;
                    });
                  },
                  title: Row(
                    children: [
                      Icon(Icons.credit_card, color: Colors.blue),
                      SizedBox(width: 10),
                      Text('Visa xxxx-5007'),
                    ],
                  ),
                ),
                RadioListTile(
                  value: 'mastercard',
                  groupValue: paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value as String?;
                    });
                  },
                  title: Row(
                    children: [
                      Icon(Icons.credit_card, color: Colors.red),
                      SizedBox(width: 10),
                      Text('MasterCard xxxx-6936'),
                    ],
                  ),
                ),
                RadioListTile(
                  value: 'cash',
                  groupValue: paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value as String?;
                    });
                  },
                  title: Row(
                    children: [
                      Icon(Icons.attach_money, color: Colors.green),
                      SizedBox(width: 10),
                      Text('Cash'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Payment Summary Section
            Text('Payment summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal', style: TextStyle(fontSize: 16)),
                Text('EGP 735.00', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery', style: TextStyle(fontSize: 16)),
                Text('EGP 70.00', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total amount', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('EGP 805.00', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            Spacer(),
            // Place Order Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Logic to place order
                  print('Order placed with payment method: $paymentMethod');
                },
                child: Text('Place Order', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
