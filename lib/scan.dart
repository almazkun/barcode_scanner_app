import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "";
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Code Scanner'),
        centerTitle: true,
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: RaisedButton(
                color: Colors.purple,
                textColor: Colors.white,
                splashColor: Colors.blueGrey,
                onPressed: scan,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.scanner, size: 40,),
                    SizedBox(width: 10,),
                    Column(
                      children: <Widget>[
                        Text('Camera Scan', style: TextStyle(fontSize: 20.0),),
                        SizedBox(height: 2,),
                        Text("Click here for camera scan")
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(barcode, textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    );
  }
  Future scan() async {
    try {
      String barcode = (await BarcodeScanner.scan()) as String;
      setState(() {
        this.barcode = barcode;
      });
    } on PlatformException catch(e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode = 'Camera permission in not granted';
        });
      } else {
        setState(() {
          this.barcode = 'Unknown Error: $e';
        });
      }
    } on FormatException {
      setState(() {
        this.barcode = 'null (User didn\'n scan anything)';
      });
    } catch (e) {
      setState(() {
        this.barcode = 'Unknown Error: $e';
      });
    }
  }
}

