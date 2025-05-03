import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Summary",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _buildSummaryRow("Subtotal", "Rs. 3,150"),
                    _buildSummaryRow("Delivery", "Rs. 400", subText: "Flat Rate"),
                    Divider(),
                    _buildSummaryRow("Total", "Rs. 3,598", bold: true),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildSectionTitle("Contact Information"),
              Text(
                "We'll use this email to send you details and updates about your order.",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 10),
              _buildTextField("Email Address"),
              SizedBox(height: 20),
              _buildSectionTitle("Shipping Address"),
              Text(
                "Enter the address where you want your order delivered.",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 10),
              _buildTextField("First Name"),
              _buildTextField("Last Name"),
              _buildTextField("Country/Region"),
              _buildTextField("Country/Region"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title, String amount, {String? subText, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
              if (subText != null) Text(subText, style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          Text(amount, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTextField(String hint) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }
}
