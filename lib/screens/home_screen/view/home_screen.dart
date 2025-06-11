import 'package:flutter/material.dart';
import 'package:refulgence/core/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppbar(size),
      body: _buildBody(size),
    );
  }

  _buildAppbar(Size size) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Home Screen',
        style: Constants.appBarTitleStyle(size),
      ),
    );
  }

  _buildBody(Size size) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
