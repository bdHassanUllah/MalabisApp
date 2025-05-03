import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:malabis_app/data/model/cart_model.dart';
import 'package:malabis_app/views/summaryscreen/summary.dart';
import 'package:url_launcher/url_launcher.dart';

class InvoiceScreen extends StatelessWidget {
  final List<CartModel> cartItems;

  const InvoiceScreen({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    final invoiceDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final invoiceNumber = 'INV-${DateTime.now().millisecondsSinceEpoch}';

    double subtotal = 0;
    double discountTotal = 0;

    for (var item in cartItems) {
      double totalPrice = (item.price ?? 0) * item.quantity;
      subtotal += totalPrice;

      if (item.discountedPrice != null && item.discountedPrice! > 0) {
        discountTotal += (item.price - item.discountedPrice!) * item.quantity;
      }
    }

    double finalTotal = subtotal - discountTotal;
    double discountGiven = subtotal - finalTotal;

    Future<void> _launchWhatsApp() async {
      final String invoiceDetails = '''
Invoice: $invoiceNumber
Date: $invoiceDate
Subtotal: Rs. ${subtotal.toStringAsFixed(2)}
Discount: Rs. ${discountGiven.toStringAsFixed(2)}
Total: Rs. ${finalTotal.toStringAsFixed(2)}

Items:
${cartItems.map((item) => "${item.name} - Quantity: ${item.quantity} - Rs. ${(item.discountedPrice != 0.0 ? item.discountedPrice : item.price) * item.quantity}").join('\n')}
''';

      final String phoneNumber = "923001234567"; // Use correct country code
      final Uri uri = Uri.parse('https://wa.me/$phoneNumber?text=${Uri.encodeComponent(invoiceDetails)}');

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch WhatsApp';
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Invoice'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Center(
                  child: Image.asset(
                    'lib/assets/images/signup.png',
                    height: 60,
                  ),
                ),
                const SizedBox(height: 30),

                Text('🧾 Invoice #$invoiceNumber',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text('Date: $invoiceDate', style: const TextStyle(fontSize: 14, color: Colors.grey)),

                const Divider(thickness: 1.5, height: 30),

                ...cartItems.map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  softWrap: true,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                                const SizedBox(height: 20),
                                Text('Quantity: ${item.quantity}',
                                    style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          Text(
                            'Rs. ${(item.discountedPrice != 0.0 ? item.discountedPrice : item.price) * item.quantity}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    )),

                const Divider(thickness: 1.5, height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Subtotal:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('Rs. ${subtotal.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),

                if (discountTotal > 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Discount:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      Text(
                        'Rs. ${discountGiven.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Rs. ${finalTotal.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 50),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SummaryScreen(cartItems: cartItems)),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Proceeding to payment...')),
                      );
                    },
                    child: const Text(
                      'Pay Now',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.phone, color: Colors.white),
                    label: const Text(
                      'Send Invoice via WhatsApp',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: _launchWhatsApp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
