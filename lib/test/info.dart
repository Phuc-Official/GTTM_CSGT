import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NFCContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nfcData = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('NFC Content'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(nfcData),
        ),
      ),
    );
  }
}