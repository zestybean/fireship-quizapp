import 'package:flutter/material.dart';
import 'package:quizapp_fireship/shared/bottom_nav.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('about'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('About this app...'),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
