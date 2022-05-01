import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Priv extends StatefulWidget {
  const Priv({Key? key}) : super(key: key);

  @override
  State<Priv> createState() => _Priv();
}

class _Priv extends State<Priv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade300,
        title: Text('Chat'),
      ),
    );
  }
}