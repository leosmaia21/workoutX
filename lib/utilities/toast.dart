
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toast(String x){
Fluttertoast.showToast(
        msg: x,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
     }