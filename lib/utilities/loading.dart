import 'package:flutter/material.dart';

buildLoading(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: Image(
            image: AssetImage('lib/assets/images/cara_moniz_gif1.gif'),
          ),
        );
      });
}


// CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//           )