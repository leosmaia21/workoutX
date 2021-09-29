import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

buildLoading(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Image(
        image: AssetImage('lib/assets/images/cara_moniz_gif.gif'),
      );
    },
  );
}


// CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//           )